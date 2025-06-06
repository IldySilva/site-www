---
title: dart:io
description: Learn about the major features in Dart's dart:io library.
prevpage:
  url: /libraries/dart-convert
  title: dart:convert
nextpage:
  url: /interop/js-interop/
  title: dart:js_interop
---

<?code-excerpt plaster="none"?>

The [dart:io][] library provides APIs to deal with
files, directories, processes, sockets, WebSockets, and HTTP
clients and servers.

:::important
Only non-web [Flutter apps,]({{site.flutter}}) command-line scripts, 
and servers can import and use `dart:io`, not web apps.
:::

In general, the dart:io library implements and promotes an asynchronous
API. Synchronous methods can easily block an application, making it
difficult to scale. Therefore, most operations return results via Future
or Stream objects, a pattern common with modern server platforms such as
Node.js.

The few synchronous methods in the dart:io library are clearly marked
with a Sync suffix on the method name. Synchronous methods aren't covered here.

To use the dart:io library you must import it:

<?code-excerpt "misc/test/library_tour/io_test.dart (import)"?>
```dart
import 'dart:io';
```

## Files and directories

The I/O library enables command-line apps to read and write files and
browse directories. You have two choices for reading the contents of a
file: all at once, or streaming. Reading a file all at once requires
enough memory to store all the contents of the file. If the file is very
large or you want to process it while reading it, you should use a
Stream, as described in
[Streaming file contents](#streaming-file-contents).

### Reading a file as text

When reading a text file encoded using UTF-8, you can read the entire
file contents with `readAsString()`. When the individual lines are
important, you can use `readAsLines()`. In both cases, a Future object
is returned that provides the contents of the file as one or more
strings.

<?code-excerpt "misc/test/library_tour/io_test.dart (read-as-string)" replace="/\btest_data\///g"?>
```dart
void main() async {
  var config = File('config.txt');

  // Put the whole file in a single string.
  var stringContents = await config.readAsString();
  print('The file is ${stringContents.length} characters long.');

  // Put each line of the file into its own string.
  var lines = await config.readAsLines();
  print('The file is ${lines.length} lines long.');
}
```


### Reading a file as binary

The following code reads an entire file as bytes into a list of ints.
The call to `readAsBytes()` returns a Future, which provides the result
when it's available.

<?code-excerpt "misc/test/library_tour/io_test.dart (read-as-bytes)" replace="/\btest_data\///g"?>
```dart
void main() async {
  var config = File('config.txt');

  var contents = await config.readAsBytes();
  print('The file is ${contents.length} bytes long.');
}
```

### Handling errors

To capture errors so they don't result in uncaught exceptions, you can
register a `catchError` handler on the Future,
or (in an `async` function) use try-catch:

<?code-excerpt "misc/test/library_tour/io_test.dart (try-catch)" replace="/does-not-exist/config/g"?>
```dart
void main() async {
  var config = File('config.txt');
  try {
    var contents = await config.readAsString();
    print(contents);
  } catch (e) {
    print(e);
  }
}
```

### Streaming file contents

Use a Stream to read a file, a little at a time.
You can use either the [Stream API](/libraries/dart-async#stream)
or `await for`, part of Dart's
[asynchrony support.](/language/async)

<?code-excerpt "misc/test/library_tour/io_test.dart (read-from-stream)" replace="/_?test_\w*\/?//g"?>
```dart
import 'dart:io';
import 'dart:convert';

void main() async {
  var config = File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = utf8.decoder.bind(inputStream).transform(const LineSplitter());
  try {
    await for (final line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }
}
```

### Writing file contents

You can use an [IOSink][] to
write data to a file. Use the File `openWrite()` method to get an IOSink
that you can write to. The default mode, `FileMode.write`, completely
overwrites existing data in the file.

<?code-excerpt "misc/test/library_tour/io_test.dart (write-file)" replace="/\btest_data\///g"?>
```dart
var logFile = File('log.txt');
var sink = logFile.openWrite();
sink.write('FILE ACCESSED ${DateTime.now()}\n');
await sink.flush();
await sink.close();
```

To add to the end of the file, use the optional `mode` parameter to
specify `FileMode.append`:

<?code-excerpt "misc/test/library_tour/io_test.dart (append)" replace="/_?test_\w*\/?//g"?>
```dart
var sink = logFile.openWrite(mode: FileMode.append);
```

To write binary data, use `add(List<int> data)`.


### Listing files in a directory

Finding all files and subdirectories for a directory is an asynchronous
operation. The `list()` method returns a Stream that emits an object
when a file or directory is encountered.

<?code-excerpt "misc/test/library_tour/io_test.dart (list-dir)" replace="/\btest_data\b/tmp/g"?>
```dart
void main() async {
  var dir = Directory('tmp');

  try {
    var dirList = dir.list();
    await for (final FileSystemEntity f in dirList) {
      if (f is File) {
        print('Found file ${f.path}');
      } else if (f is Directory) {
        print('Found dir ${f.path}');
      }
    }
  } catch (e) {
    print(e.toString());
  }
}
```


### Other common functionality

The File and Directory classes contain other functionality, including
but not limited to:

- Creating a file or directory: `create()` in File and Directory
- Deleting a file or directory: `delete()` in File and Directory
- Getting the length of a file: `length()` in File
- Getting random access to a file: `open()` in File

Refer to the API docs for [File][] and [Directory][] for a full
list of methods.


## HTTP clients and servers

The dart:io library provides classes that command-line apps can use for
accessing HTTP resources, as well as running HTTP servers.

### HTTP server

The [HttpServer][] class
provides the low-level functionality for building web servers. You can
match request handlers, set headers, stream data, and more.

The following sample web server returns simple text information.
This server listens on port 8888 and address 127.0.0.1 (localhost),
responding to requests for the path `/dart`. For any other path,
the response is status code 404 (page not found).

<?code-excerpt "misc/lib/library_tour/io/http_server.dart (process-requests)" replace="/Future<\w+\W/void/g; /\b_//g"?>
```dart
void main() async {
  final requests = await HttpServer.bind('localhost', 8888);
  await for (final request in requests) {
    processRequest(request);
  }
}

void processRequest(HttpRequest request) {
  print('Got request for ${request.uri.path}');
  final response = request.response;
  if (request.uri.path == '/dart') {
    response
      ..headers.contentType = ContentType('text', 'plain')
      ..write('Hello from the server');
  } else {
    response.statusCode = HttpStatus.notFound;
  }
  response.close();
}
```

### HTTP client

You should avoid directly using `dart:io` to make HTTP requests.
The [HttpClient][] class in `dart:io` is platform-dependent
and tied to a single implementation.
Instead, use a higher-level library like
[`package:http`]({{site.pub-pkg}}/http).

The [Fetch data from the internet][] tutorial
explains how to make HTTP requests
using `package:http`.

## More information

This page showed how to use the major features of the [dart:io][] library.
Besides the APIs discussed in this section, the dart:io library also
provides APIs for [processes,][Process] [sockets,][Socket] and
[web sockets.][WebSocket]
For more information about server-side and command-line app development, see the
[server-side Dart overview.](/server)


[dart:io]: {{site.dart-api}}/dart-io/dart-io-library.html
[Directory]: {{site.dart-api}}/dart-io/Directory-class.html
[Fetch data from the internet]: /tutorials/server/fetch-data
[File]: {{site.dart-api}}/dart-io/File-class.html
[HttpClient]: {{site.dart-api}}/dart-io/HttpClient-class.html
[HttpRequest]: {{site.dart-api}}/dart-html/HttpRequest-class.html
[HttpServer]: {{site.dart-api}}/dart-io/HttpServer-class.html
[IOSink]: {{site.dart-api}}/dart-io/IOSink-class.html
[Process]: {{site.dart-api}}/dart-io/Process-class.html
[Socket]: {{site.dart-api}}/dart-io/Socket-class.html
[WebSocket]: {{site.dart-api}}/dart-io/WebSocket-class.html

// ignore_for_file:  unused_element, unused_local_variable, specify_nonobvious_property_types
// ignore_for_file: strict_raw_type, prefer_initializing_formals, use_super_parameters, dead_code
import 'dart:async';
import 'dart:io';
import 'dart:math';

typedef Func0<T> = T Function();
typedef Func1<S, T> = S Function(T _);

Func0<Future<void>> longRunningCalculation = () => Future.value();
Func0 somethingRisky = () {};
Func1 raiseAlarm = (_) {}, handle = (_) {};
Func1<bool, dynamic> canHandle = (_) => false, verifyResult = (_) => false;
T? somethingNullable<T>() => null;

class Thing {
  bool get isEnabled => true;
}

void miscDeclAnalyzedButNotTested() {
  {
    bool nonNullableBool = true;
    bool? nullableBool = somethingNullable<bool>();

    // #docregion non-null-boolean-expression
    if (nonNullableBool) {
      /* ... */
    }

    if (!nonNullableBool) {
      /* ... */
    }
    // #enddocregion non-null-boolean-expression

    // #docregion nullable-boolean-expression
    // If you want null to result in false:
    if (nullableBool ?? false) {
      /* ... */
    }

    // If you want null to result in false
    // and you want the variable to type promote:
    if (nullableBool != null && nullableBool) {
      /* ... */
    }
    // #enddocregion nullable-boolean-expression
  }

  {
    // #docregion adjacent-strings-literals
    raiseAlarm(
      'ERROR: Parts of the spaceship are on fire. Other '
      'parts are overrun by martians. Unclear which are which.',
    );
    // #enddocregion adjacent-strings-literals
  }

  (String name, int year, int birth) {
    // #docregion string-interpolation
    'Hello, $name! You are ${year - birth} years old.';
    // #enddocregion string-interpolation
  };

  (name, decade) {
    // #docregion string-interpolation-avoid-curly
    var greeting = 'Hi, $name! I love your ${decade}s costume.';
    // #enddocregion string-interpolation-avoid-curly
  };

  {
    // #docregion collection-literals
    var points = <Point>[];
    var addresses = <String, Address>{};
    var counts = <int>{};
    // #enddocregion collection-literals
  }

  {
    var command = 'c';
    var options = ['a'];
    var modeFlags = ['b'] as List<String>?;
    var filePaths = ['p'];
    String removeExtension(String path) => path;

    // #docregion spread-etc
    var arguments = [
      ...options,
      command,
      ...?modeFlags,
      for (var path in filePaths)
        if (path.endsWith('.dart')) path.replaceAll('.dart', '.js'),
    ];
    // #enddocregion spread-etc
  }

  (Iterable lunchBox, Iterable words) {
    // #docregion dont-use-length
    if (lunchBox.isEmpty) return 'so hungry...';
    if (words.isNotEmpty) return words.join(' ');
    // #enddocregion dont-use-length
    return 'foo';
  };

  {
    // #docregion cast-list
    var stuff = <dynamic>[1, 2];
    var ints = List<int>.from(stuff);
    // #enddocregion cast-list
  }

  {
    // #docregion cast-map
    var stuff = <dynamic>[1, 2];
    var reciprocals = stuff.map<double>((n) => (n as int) * 2);
    // #enddocregion cast-map
  }

  // #docregion cast-at-create
  List<int> singletonList(int value) {
    var list = <int>[];
    list.add(value);
    return list;
  }
  // #enddocregion cast-at-create

  // #docregion cast-iterate
  void printEvens(List<Object> objects) {
    // We happen to know the list only contains ints.
    for (final n in objects) {
      if ((n as int).isEven) print(n);
    }
  }
  // #enddocregion cast-iterate

  // #docregion cast-from
  int median(List<Object> objects) {
    // We happen to know the list only contains ints.
    var ints = List<int>.from(objects);
    ints.sort();
    return ints[ints.length ~/ 2];
  }
  // #enddocregion cast-from

  (Iterable people) {
    // #docregion avoid-for-each
    for (final person in people) {
      /*...*/
    }
    // #enddocregion avoid-for-each
    // #docregion forEach-over-func
    people.forEach(print);
    // #enddocregion forEach-over-func
  };

  {
    // #docregion func-decl
    void main() {
      void localFunction() {
        /*...*/
      }
    }

    // #enddocregion func-decl
  }

  (Iterable names) {
    // #docregion use-tear-off
    var charCodes = [68, 97, 114, 116];
    var buffer = StringBuffer();

    // Function:
    charCodes.forEach(print);

    // Method:
    charCodes.forEach(buffer.write);

    // Named constructor:
    var strings = charCodes.map(String.fromCharCode);

    // Unnamed constructor:
    var buffers = charCodes.map(StringBuffer.new);
    // #enddocregion use-tear-off
  };

  {
    // #docregion default-separator
    void insert(Object item, {int at = 0}) {
      /* ... */
    }
    // #enddocregion default-separator
  }

  {
    // #docregion default-value-null
    void error([String? message]) {
      stderr.write(message ?? '\n');
    }

    // #enddocregion default-value-null
  }

  {
    // #docregion null-aware-promote
    int measureMessage(String? message) {
      if (message != null && message.isNotEmpty) {
        // message is promoted to String.
        return message.length;
      }

      return 0;
    }

    // #enddocregion null-aware-promote
  }

  {
    // #docregion rethrow
    try {
      somethingRisky();
    } catch (e) {
      if (!canHandle(e)) rethrow;
      handle(e);
    }
    // #enddocregion rethrow
  }

  {
    // #docregion unnecessary-async
    Future<int> fastestBranch(Future<int> left, Future<int> right) {
      return Future.any([left, right]);
    }

    // #enddocregion unnecessary-async
  }

  {
    // ignore_for_file: only_throw_errors
    // #docregion async
    Future<void> usesAwait(Future<String> later) async {
      print(await later);
    }

    Future<void> asyncError() async {
      throw 'Error!';
    }

    Future<String> asyncValue() async => 'value';
    // #enddocregion async
  }

  {
    // #docregion avoid-completer
    Future<bool> fileContainsBear(String path) {
      return File(path).readAsString().then((contents) {
        return contents.contains('bear');
      });
    }

    // #enddocregion avoid-completer
  }

  // #docregion test-future-or
  Future<T> logValue<T>(FutureOr<T> value) async {
    if (value is Future<T>) {
      var result = await value;
      print(result);
      return result;
    } else {
      print(value);
      return value;
    }
  }
  // #enddocregion test-future-or

  {
    // #docregion avoid-completer-alt
    Future<bool> fileContainsBear(String path) async {
      var contents = await File(path).readAsString();
      return contents.contains('bear');
    }

    // #enddocregion avoid-completer-alt
  }

  {
    // #docregion no-const
    const primaryColors = [
      Color('red', [255, 0, 0]),
      Color('green', [0, 255, 0]),
      Color('blue', [0, 0, 255]),
    ];
    // #enddocregion no-const
  }
}

//----------------------------------------------------------------------------

class Address {}

class Animal {
  String name = '';
  bool isAquatic = false;
}

class Person {
  int zip = 12345;
}

class Color {
  const Color(String name, List<int> channels);
}

//----------------------------------------------------------------------------

class Player {
  bool get isActive => false;
}

class DownloadException implements Exception {}

class Team {
  Future<List<Player>> get roster => Future.value([]);
  Future<Team?> downloadTeam(String name) => Future.value(Team());
  dynamic get log => null;

  // #docregion async-await
  Future<int> countActivePlayers(String teamName) async {
    try {
      var team = await downloadTeam(teamName);
      if (team == null) return 0;

      var players = await team.roster;
      return players.where((player) => player.isActive).length;
    } on DownloadException catch (e, _) {
      log.error(e);
      return 0;
    }
  }

  // #enddocregion async-await
}

//----------------------------------------------------------------------------

class Item {
  int get price => 0;
}

// #docregion no-null-init
Item? bestDeal(List<Item> cart) {
  Item? bestItem;

  for (final item in cart) {
    if (bestItem == null || item.price < bestItem.price) {
      bestItem = item;
    }
  }

  return bestItem;
}
// #enddocregion no-null-init

//----------------------------------------------------------------------------

class Response {
  String get url => '';
  String get errorCode => '';
  String get reason => '';
}

// #docregion shadow-nullable-field, null-check-promo
class UploadException {
  final Response? response;

  UploadException([this.response]);

  @override
  String toString() {
    // #enddocregion shadow-nullable-field
    if (this.response case var response?) {
      return 'Could not complete upload to ${response.url} '
          '(error code ${response.errorCode}): ${response.reason}.';
    }
    // #enddocregion null-check-promo
    // #docregion shadow-nullable-field
    final response = this.response;
    if (response != null) {
      return 'Could not complete upload to ${response.url} '
          '(error code ${response.errorCode}): ${response.reason}.';
    }
    // #docregion null-check-promo
    return 'Could not upload (no response).';
  }
}
// #enddocregion shadow-nullable-field, null-check-promo

//----------------------------------------------------------------------------

// #docregion calc-vs-store
class Circle {
  double radius;

  Circle(this.radius);

  double get area => pi * radius * radius;
  double get circumference => pi * 2.0 * radius;
}
// #enddocregion calc-vs-store

//----------------------------------------------------------------------------

// #docregion dont-wrap-field
class Box {
  Object? contents;
}
// #enddocregion dont-wrap-field

//----------------------------------------------------------------------------

// #docregion final
class Box1 {
  final contents = [];
}
// #enddocregion final

//----------------------------------------------------------------------------

class Chest {
  List<String> get contents => [];
}

class Treasure {
  Treasure(Point where);

  void addAll(List<String> what) {}
}

class C {
  double left = 0.0, right = 0.0, top = 0.0, bottom = 0.0, minTime = 0.0;
  Point center = Point(0.0, 0.0);
  final Map<Chest, Treasure> _opened = {};

  // #docregion use-arrow
  double get area => (right - left) * (bottom - top);

  String capitalize(String name) =>
      '${name[0].toUpperCase()}${name.substring(1)}';
  // #enddocregion use-arrow

  // #docregion arrow-setter
  num get x => center.x;
  set x(num value) => center = Point(value, center.y);
  // #enddocregion arrow-setter

  // #docregion arrow-long
  Treasure? openChest(Chest chest, Point where) {
    if (_opened.containsKey(chest)) return null;

    var treasure = Treasure(where);
    treasure.addAll(chest.contents);
    _opened[chest] = treasure;
    return treasure;
  }

  // #enddocregion arrow-long
}

//----------------------------------------------------------------------------

// #docregion this-dot
class Box2 {
  Object? value;

  void clear() {
    update(null);
  }

  void update(Object? value) {
    this.value = value;
  }
}
// #enddocregion this-dot

//----------------------------------------------------------------------------

// #docregion this-dot-constructor
class ShadeOfGray {
  final int brightness;

  ShadeOfGray(int val) : brightness = val;

  ShadeOfGray.black() : this(0);

  // But now it will!
  ShadeOfGray.alsoBlack() : this.black();
}
// #enddocregion this-dot-constructor

//----------------------------------------------------------------------------

class BaseBox {
  BaseBox(_);
}

// #docregion param-dont-shadow-field-ctr-init
class Box3 extends BaseBox {
  Object? value;

  Box3(Object? value) : value = value, super(value);
}
// #enddocregion param-dont-shadow-field-ctr-init

//----------------------------------------------------------------------------

class Document {}

// #docregion field-init-at-decl
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}
// #enddocregion field-init-at-decl

//----------------------------------------------------------------------------

// #docregion field-init-as-param
class Point0 {
  double x, y;
  Point0(this.x, this.y);
}
// #enddocregion field-init-as-param

//----------------------------------------------------------------------------

// #docregion late-init-list
class Point1 {
  double x, y;
  Point1.polar(double theta, double radius)
    : x = cos(theta) * radius,
      y = sin(theta) * radius;
}
// #enddocregion late-init-list

//----------------------------------------------------------------------------

// #docregion semicolon-for-empty-body
class Point2 {
  double x, y;
  Point2(this.x, this.y);
}
// #enddocregion semicolon-for-empty-body

class Widget {}

class BuildContext {}

class Row extends Widget {
  Row({List<Widget> children = const []});
}

class RaisedButton extends Widget {
  RaisedButton({Widget? child});
}

class Text extends Widget {
  Text(String text);
}

// #docregion no-new
Widget build(BuildContext context) {
  return Row(
    children: [
      RaisedButton(child: Text('Increment')),
      Text('Click!'),
    ],
  );
}

// #enddocregion no-new

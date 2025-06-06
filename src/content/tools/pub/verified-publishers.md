---
title: Verified publishers
description: Learn what verified publishers are, and they're verified.
---

The pub.dev verified publisher badge <img src="/assets/img/verified-publisher.svg" class="text-icon" alt="pub.dev verified publisher logo"> 
lets you know that the pub.dev site 
verified the identity of the publisher of a package.
For example, [dart.dev]({{site.pub}}/publishers/dart.dev/)
is the verified publisher for packages that Google's Dart
team supports.

The badge appears in several places on pub.dev,
next to packages that verified publishers published:

  * Package search results
  * Package detail pages
  * Publisher profile pages
  * The pub.dev front page

Each publisher has a page with a list of
all packages belonging to that publisher,
plus additional details such as the publisher's contact email.
To visit the publisher page, click the publisher identity link
(for example, `dart.dev`) next to the verified publisher badge 
<img
class="text-icon"
  src="/assets/img/verified-publisher.svg" 
  alt="pub.dev verified publisher logo">.

## Verification process

To ensure that creating verified publishers is low cost and available to anyone,
pub.dev relies on DNS (domain name system) domains as an identification token.
We chose DNS verification because many package authors
already have a trusted domain and a homepage for that domain.
During the [publisher creation process][publishing page],
pub.dev verifies that the user creating the verified publisher has
admin access to the associated ["Domain Property"][domain-prop],
based on existing logic in the [Google Search Console.][search-console]

:::note
Domain name ownership is verified only once when a publisher is created. After that:

- Losing control of a domain does not cause the original publisher owner to lose access to the publisher.
- Acquiring a domain does not grant the new owner any rights to a publisher that was previously associated with it.
- Publisher ownership must be explicitly transferred by the current publisher owner.
:::

## Creating a verified publisher account

If you publish packages and want to create a new verified publisher,
see the instructions on the [publishing page][].

[domain-prop]: https://support.google.com/webmasters/answer/34592
[publishing page]: /tools/pub/publishing#create-verified-publisher
[search-console]: https://search.google.com/search-console/about

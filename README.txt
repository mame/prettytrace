= prettytrace

* http://github.com/mame/prettytrace/tree/master

== DESCRIPTION:

prettytrace detects and omits repetition of backtrace, which makes
backtrace shorter and smarter.

== FEATURES/PROBLEMS:


== SYNOPSIS:

$ ruby -rprettytrace -e 'def foo; foo; end; foo'
-e:1:in `foo': stack level too deep (SystemStackError)
        from -e:1:in `foo'
          from -e:1:in `foo'
          (repeat the above lines 8000 times)
        from -e:1:in `foo'
        from -e:1:in `<main>'

== REQUIREMENTS:

None

== INSTALL:

* gem install mame-prettytrace

== LICENSE:

Copyright (c) 2009 Yusuke Endoh <mame@tsg.ne.jp>
License: Ruby's

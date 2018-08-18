# Practical software construction

## Make small types

Don't have non-interacting basic types within the same class

## Add tiny unit checks for sanity

Ensure that the object can be constructed/destructed without error
Ensure that some basic sequences of operation occur as expected

## Add property tests

https://github.com/emil-e/rapidcheck

How to define an instance of `Arbitrary<T>` for each of your small classes

How to define `Arbitrary<T>` for your bigger composed classes

How to make useful checks, eg:
  * roundtrip encode/decode

## Add regression tests with real-world data

As bugs are discuvered, save a (minimal) input that triggered the bug. If you
are well-disciplined, do this first before attempting to fix the issue, in
which case running the test case becomes your build target while developing the
fix.

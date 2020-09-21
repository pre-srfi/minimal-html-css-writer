# SRFI nnn: Title

by Firstname Lastname, Another Person, Third Person

# Status

Early Draft

# Abstract

This SRFI supplies a minimal set of procedures to output web pages and
XML files from S-expressions.

# Issues

Which S-expression representation of CSS to use?

Should we indent the output?

Should output be UTF-8 or ASCII-only?

# Rationale

## Prior art (XML/HTML)

Oleg SXML

Racket sxml, txexpr

## Prior art (CSS)

css-expr

# Specification

## Supported SXML syntax

`(tag body ...)`

`(tag (@ (attribute1 value1) (attribute value2) ...) body ...)`

Comment syntax?

## Supported CSS syntax

## Library (XML/HTML)

(**write-html** _sxml_)

(**write-xml** _sxml_)

These procedures write XML-like languages.

Any element with an empty body is written as `<foo />`.

ASCII control characters and non-ASCII characters are written as
`#&xABCD;` escapes.

HTML output is prefixed with `<!doctype html>`.

XML output is prefixed with `<?xml version="1.0" encoding="us-ascii"?>`.

The output is not indented. An external tool like HTML Tidy can do
that.

## Library (CSS)

(**write-css** _css-expr_)

## Library (color)

(**color-name->rgb** _string_) -> _rgb_

Get the RGB value for a known CSS color name.

(**rgb->css-color** _rgb_) -> _string_

Turn an RGB color into a CSS string.

* Known color names are used when they match.
* `#xaabbcc` is turned into `#abc`.
* `#xabcdef` is turned into `#abcdef`.

(**rgb->hsl** _rgb_) -> _hsl_

(**hsl->rgb** _hsl_) -> _rgb_

Convert a color between RGB and HSL. HSL is easy to make brighter or
dimmer.

# Examples

example.scm

# Implementation

# Acknowledgements

# References

http://okmij.org/ftp/Scheme/SXML.html

# Copyright

Copyright (C) Firstname Lastname (20XY).

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# krop-patched [![Linux Build Status](https://img.shields.io/travis/com/phlummox/krop-patched.svg?label=Linux%20build)](https://travis-ci.com/phlummox/krop-patched)

A version of [arminstraub](https://github.com/arminstraub)'s
[*krop*](https://github.com/arminstraub/krop) PDF cropper, patched
to use [PyPDF4](https://github.com/claird/PyPDF4) instead of PyPDF2,
and with some minor fixes added.

It's packaged up as a UPX-compressed executable using
[PyInstaller](https://www.pyinstaller.org/), and a quick-and-dirty
Debian package is provided.

## Why?

Because PyPDF2 is apparently not being maintained,
PyPDF4 is only sporadically maintained, and both contain some
known [bugs](https://stackoverflow.com/questions/45978113/pypdf2-write-doesnt-work-on-some-pdf-files-python-3-5-1/52687771#52687771).

## Build prerequisites

Docker on Ubuntu or similar; `make`.

## Installing

```
$ git clone https://github.com/phlummox/krop-patched.git
$ cd krop-patched
$ make copy
$ sudo dpkg --install krop-0.5.1.deb
```



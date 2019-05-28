#!/bin/sh

BUILDDIR=.build
mkdir -p $BUILDDIR
cd $BUILDDIR
pandoc -t beamer -s ../slides.md -o slides.tex && pdflatex slides.tex
cd -
mv $BUILDDIR/slides.pdf .

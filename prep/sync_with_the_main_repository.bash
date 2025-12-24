#!/bin/bash

cd "$(dirname $0)/.."

MAINREPODIR="${HOME}/git/voronota/expansion_lt/"

rm -r "./cpp"
mkdir "./cpp"
cp -r \
  "${MAINREPODIR}/src/voronotalt" \
  "${MAINREPODIR}/src/voronotalt_cli" \
  "./cpp/"

rm -r "./voronotalt"
mkdir "./voronotalt"
cp "${MAINREPODIR}/swig/voronotalt/__init__.py" \
  "${MAINREPODIR}/swig/voronotalt/pandas_interface.py" \
  "${MAINREPODIR}/swig/voronotalt/biotite_interface.py" \
  "${MAINREPODIR}/swig/voronotalt/gemmi_interface.py" \
  "${MAINREPODIR}/swig/voronotalt/biopython_interface.py" \
  "./voronotalt/"

cp \
  "${MAINREPODIR}/swig/voronotalt.h" \
  "${MAINREPODIR}/swig/voronotalt_python.i" \
  "${MAINREPODIR}/swig/README.md" \
  "./"

rm -r "./tests/input"
cp -r \
  "${MAINREPODIR}/swig/tests/input" \
  "./tests/"

#!/bin/bash

cd "$(dirname $0)/.."

MAINREPODIR="${HOME}/git/voronota/expansion_lt/"

VERSIONID="$(cat ${MAINREPODIR}/latest_release_version.txt)"
SOURCE_PACKAGE_NAME="$(${MAINREPODIR}/package.bash print-name-and-exit)"
SOURCE_PACKAGE_FILE="${MAINREPODIR}/packages_for_release/${SOURCE_PACKAGE_NAME}.tar.gz"

if [ ! -s "$SOURCE_PACKAGE_FILE" ]
then
	SOURCE_PACKAGE_NAME="$(${MAINREPODIR}/package.bash)"
	SOURCE_PACKAGE_FILE="${MAINREPODIR}/packages_for_release/${SOURCE_PACKAGE_NAME}.tar.gz"
fi

mkdir -p ./tmp
cp "$SOURCE_PACKAGE_FILE" "./tmp/"
cd "./tmp"
tar -xf "$(basename ${SOURCE_PACKAGE_FILE})"
cd ..

SOURCE_PACKAGE_DIR="./tmp/${SOURCE_PACKAGE_NAME}"

rm -r "./cpp"
mkdir "./cpp"
cp -r \
  "${SOURCE_PACKAGE_DIR}/src/voronotalt" \
  "${SOURCE_PACKAGE_DIR}/src/voronotalt_cli" \
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

cat "./setup.py" \
| sed "s|version=\"\S\+\",|version=\"${VERSIONID}\",|" \
> "./tmp/setup.py"

mv "./tmp/setup.py" "./setup.py"
rm -r "./tmp"


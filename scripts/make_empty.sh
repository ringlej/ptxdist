#!/bin/bash

PERL=perl
PTXDIST=$PWD

EMPTY=../ptxdist-empty
COMMON=..

make_target() {
    SOURCE=$1
    DEST=$2

    REST_SOURCE=${SOURCE}
    REST_DEST=${DEST}

    L_SOURCE=''
    L_DEST=''

    while test "${L_SOURCE}" = "${L_DEST}"; do
	REST_SOURCE=$(echo ${REST_SOURCE} | ${PERL} -p -e 's:/+([^/]+)(/.*):\2:')
	REST_DEST=$(  echo ${REST_DEST}   | ${PERL} -p -e 's:/+([^/]+)(/.*):\2:')

	L_SOURCE=$(echo ${REST_SOURCE} | ${PERL} -p -e 's:/+([^/]+)(/.*):\1:')
	L_DEST=$(  echo ${REST_DEST}   | ${PERL} -p -e 's:/+([^/]+)(/.*):\1:')
    done

    echo -n ${REST_SOURCE} | ${PERL} -p -e 's:([^/])+/+:../:g; s:/([./]+)/.*:\1:'
    echo ${REST_DEST}
}

echo -n Working .

rm -rf ${EMPTY}
mkdir -p ${EMPTY}
EMPTY=$(cd ${EMPTY}; echo $PWD)

mkdir -p ${COMMON}
COMMON=$(cd ${COMMON}; echo $PWD)

cp -R ${PTXDIST}/* ${EMPTY}
find ${EMPTY} -name ".svn" -type d -print0 | xargs -0 -- rm -rf
find ${EMPTY} -name "*~*" -type f -print0 | xargs -0 -- rm -rf
find ${EMPTY} -name ".#*" -type f -print0 | xargs -0 -- rm -rf
  
for OBJ in \
    COPYING \
    CREDITS \
    ChangeLog \
    INSTALL \
    Makefile \
    README \
    SPECIFICATION \
    TODO \
    \
    config \
    misc \
    projects \
    rules \
    \
    Documentation/NEWPACKETHOWTO \
    Documentation/README \
    Documentation/manual/Makefile \
    Documentation/manual/PTXdist-Manual.tex \
    Documentation/manual/appendix \
    Documentation/manual/devel \
    Documentation/manual/figures \
    Documentation/manual/intro \
    Documentation/manual/user \
    \
    scripts/collect_sources.sh\
    scripts/compile-test \
    scripts/config.guess \
    scripts/cuckoo-test \
    scripts/cvs2cl \
    scripts/genhdimg \
    scripts/get_tool_versions.sh \
    scripts/make_empty.sh \
    scripts/makedeptree \
    scripts/mkprefix \
    scripts/settoolchain.sh \
    scritps/sysinclude_test \
    scripts/ptx-modifications \
    \
    ; do
  echo -n .
  if test -e ${PTXDIST}/${OBJ}; then
      rm -rf ${EMPTY}/${OBJ}
      TARGET=$(make_target ${EMPTY}/${OBJ} ${PTXDIST}/${OBJ})
      LINK=$(echo ${EMPTY}/${OBJ} | perl -p -e 's:(.*/).*:\1:')
      ln -sf ${TARGET} ${LINK}
  fi
done


for OBJ in \
    src \
    ; do
  echo -n .
  if test \! -d ${COMMON}/${OBJ}; then
      mkdir -p ${COMMON}/${OBJ}
  fi
  rm -rf ${EMPTY}/${OBJ}
  ln -sf ${COMMON}/${OBJ} ${EMPTY}
done

echo . finished!

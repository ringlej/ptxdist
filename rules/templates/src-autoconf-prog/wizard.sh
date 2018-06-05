#!/bin/bash

HERE=$(pwd)

NAME=$1
if [ -z "$NAME" ]; then
	echo -n "project name: "
	read NAME
fi
NAME_UP=$(echo $NAME | tr '[a-z-]' '[A-Z_]')

mv "@name@.c" "${NAME}.c"
NAME_NODASH=$(echo $NAME | tr '-' '_')

# prepare and instantiate the M4 macros
mkdir -v m4
tar -C "${2}/template-m4-macros" -cf - . | tar -C m4 -xvf -

mv m4/INSTALL .
mv m4/internal.h .

for i in \
	configure.ac \
	Makefile.am \
	${NAME}.c \
	INSTALL \
	internal.h \
; do
	sed -i -e "s/\@name\@/${NAME}/g" $i
	sed -i -e "s/\@namenodash\@/${NAME_NODASH}/g" $i
	sed -i -e "s/\@NAME\@/${NAME_UP}/g" $i
done


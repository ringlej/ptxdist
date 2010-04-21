#!/bin/bash

HERE=$(pwd)

NAME=$1
if [ -z "$NAME" ]; then
	echo -n "project name: "
	read NAME
fi
NAME_UP=$(echo $NAME | tr '[a-z-]' '[A-Z_]')
NAME_NODASH=$(echo $NAME | tr '-' '_')

mv "@name@.c" "${NAME}.c"
mv "lib@name@.c" "lib${NAME}.c"

for i in \
	configure.ac \
	Makefile.am \
	${NAME}.c \
	lib${NAME}.c \
; do
	sed -i -e "s/\@name\@/${NAME}/g" $i
	sed -i -e "s/\@namenodash\@/${NAME_NODASH}/g" $i
	sed -i -e "s/\@NAME\@/${NAME_UP}/g" $i
done


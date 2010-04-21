#!/bin/bash

HERE=$(pwd)

NAME=$1
if [ -z "$NAME" ]; then
	echo -n "project name: "
	read NAME
fi
NAME_UP=$(echo $NAME | tr '[a-z-]' '[A-Z_]')

mv "@name@.cpp" "${NAME}.cpp"
mv "@name@.pro" "${NAME}.pro"

for i in \
	${NAME}.pro \
	${NAME}.cpp \
; do
	sed -i -e "s/\@name\@/${NAME}/g" $i
	sed -i -e "s/\@NAME\@/${NAME_UP}/g" $i
done


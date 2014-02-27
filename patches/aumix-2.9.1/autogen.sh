#!/bin/bash

set -e

aclocal -Im4
autoconf -Im4
automake -f


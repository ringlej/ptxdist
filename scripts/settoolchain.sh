#!/bin/sh
# $Id: settoolchain.sh,v 1.1 2003/10/26 06:32:50 mkl Exp $
#
# Copyright (C) 2003 by Dan Kegel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Script to set up ptxdist to use a crosstool-generated toolchain
# You have to set TARGET and either PREFIX or both RESULT and TOOLCOMBO
# This should be part of crosstool...
#

# GNU target tuple
TARGET=mipsel-unknown-linux-gnu

# Directory stuff
RESULT=/opt/crosstool
TOOLCOMBO=gcc-3.2.3-glibc-2.2.3
PREFIX=$RESULT/$TARGET/$TOOLCOMBO

# Grumble.  Convert TARGET to internal ptxdist booleans.

case $TARGET in
	*arm*uclinux*) PTXARCH=ARM_NOMMU ;;
	*arm*)         PTXARCH=ARM ;;
	*i*86*)        PTXARCH=X86 ;;
	*pentium*)     PTXARCH=X86 ;;
	*powerpc*)     PTXARCH=PPC ;;
	*sparc*)       PTXARCH=SPARC ;;
	*mipsbe*)      PTXARCH=MIPS ; PTXSUBARCH=MIPS_ARCH_BE ;;
	*mips*)        PTXARCH=MIPS ; PTXSUBARCH=MIPS_ARCH_LE ;;
	*cris*)        PTXARCH=CRIS ;;
	*parisc*)      PTXARCH=PARISC ;;
	*sh*)          PTXARCH=SH ;;
	*) echo bad target $TARGET; exit 1 ;;
esac

echo PTXCONF_GNU_TARGET=\"$TARGET\" > .config.tmp
echo "PTXCONF_ARCH_$PTXARCH=y" >> .config.tmp
test x$PTXSUBARCH != x && echo "PTXCONF_$PTXSUBARCH=y" >> .config.tmp
echo PTXCONF_PREFIX=\"$PREFIX\" >> .config.tmp
echo PTXCONF_ROOT=\"$PREFIX/target\" >> .config.tmp
echo '# PTXCONF_BUILD_CROSSCHAIN is not set' >> .config.tmp

# need to set experimental to get some arches
echo "PTXCONF_EXP=y" >> .config.tmp
echo "PTXCONF_EXP_M=y" >> .config.tmp


egrep -v "PTXCONF_GNU_TARGET|PTXCONF_ARCH_|PTXCONF_PREFIX|PTXCONF_ROOT" .config >> .config.tmp

cp .config .config.bak
mv .config.tmp .config

# Now do a 'make oldconfig'

#!/bin/sh
# $Id: settoolchain.sh,v 1.8 2003/11/17 03:47:04 mkl Exp $
#
# Copyright (C) 2003 Ixia Communications, by Dan Kegel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# Script to set up ptxdist to use a crosstool-generated toolchain
# Must be run from main ptxdist directory.
#
# Example: TARGET=powerpc-405-linux-gnu PREFIX=/opt/blartfast sh scripts/settoolchain.sh

abort() {
	echo "$@"
	exec /bin/false
}

test -z "${TARGET}"           && abort "Please set TARGET to the Gnu target identifier (e.g. pentium-unknown-linux-gnu)"
test -z "${PREFIX}"           && abort "Please set PREFIX to where you want the toolchain installed."
test -f scripts/settoolchain.sh || abort "Please run from main ptxdist directory."

# Grumble.  Convert TARGET to internal ptxdist booleans.
# This is really fragile, and I probably missed a bunch of subarch flags. (dank)
#
# yes: arm le/be discrimination, but I added this  (mkl)
#      x86 also added (mkl)
#
# fixed mips (mkl)
# fixed help message (mkl)
#
case $TARGET in
        *-*-*-*) ;;
	*)       abort "Please use a canonical target name.  These always contain three dashes, e.g. mipsle-unknown-linux-gnu." ;;
esac

case $TARGET in
	*arm*uclinux*) PTXARCH=ARM_NOMMU ;;
	*armb*)        PTXARCH=ARM ; PTXSUBARCH=ARM_ARCH_BE;;
	*arm*)         PTXARCH=ARM ; PTXSUBARCH=ARM_ARCH_LE;;
	*i386*)        PTXARCH=X86 ; PTXSUBARCH=OPT_I386;;
	*i486*)        PTXARCH=X86 ; PTXSUBARCH=OPT_I486;;
	*i586*)        PTXARCH=X86 ; PTXSUBARCH=OPT_I586;;
	*i686*)        PTXARCH=X86 ; PTXSUBARCH=OPT_I686;;
	*pentium*)     PTXARCH=X86 ; PTXSUBARCH=OPT_I586;;
	*ppc*)         abort "Please use a target of powerpc-*-*-* rather than ppc-*" ;;
	*powerpc-405-*)  PTXARCH=PPC; PTXSUBARCH=OPT_PPC405;;
	*powerpc-750-*)  PTXARCH=PPC; PTXSUBARCH=OPT_PPC750;;
	*powerpc-7450-*) PTXARCH=PPC; PTXSUBARCH=OPT_PPC7450;;
	*powerpc*)     PTXARCH=PPC ; PTXSUBARCH=OPT_PPC;;
	*sparc*)       PTXARCH=SPARC ;;
	*mipsle*)      PTXARCH=MIPS ; PTXSUBARCH=MIPS_ARCH_LE ;;
	*mips*)        PTXARCH=MIPS ; PTXSUBARCH=MIPS_ARCH_BE ;;
	*cris*)        PTXARCH=CRIS ;;
	*parisc*)      PTXARCH=PARISC ;;
	*sh3*)         PTXARCH=SH ; PTXSUBARCH=SH_ARCH_SH3 ; PTXOPT=OPT_SH3 ;; 
	*sh4*)         PTXARCH=SH ; PTXSUBARCH=SH_ARCH_SH4 ; PTXOPT=OPT_SH4 ;;
	*sh*)          PTXARCH=SH ;;
	*)             abort "unrecognized target $TARGET"
esac

echo PTXCONF_GNU_TARGET=\"$TARGET\" > .config.tmp
echo "PTXCONF_ARCH_$PTXARCH=y" >> .config.tmp
test x$PTXSUBARCH != x && echo "PTXCONF_$PTXSUBARCH=y" >> .config.tmp
test x$PTXOPT != x && echo "PTXCONF_$PTXOPT=y" >> .config.tmp
echo PTXCONF_PREFIX=\"$PREFIX\" >> .config.tmp
echo PTXCONF_ROOT=\"$PREFIX/target\" >> .config.tmp
echo '# PTXCONF_BUILD_CROSSCHAIN is not set' >> .config.tmp

# need to set experimental to get some arches
echo "PTXCONF_EXP=y" >> .config.tmp
echo "PTXCONF_EXP_M=y" >> .config.tmp

egrep -v "PTXCONF_ARCH=|PTXCONF_ARCH_|PTXCONF_ARM|PTXCONF_GNU_TARGET|PTXCONF_OPT_|PTXCONF_PREFIX|PTXCONF_ROOT=|PTXCONF_SH_ARCH_|PTXCONF_TARGET_CONFIG_FILE" .config >> .config.tmp

test -f .config && cp .config .config.bak
mv .config.tmp .config

# Use 'make oldconfig' to propagate settings into variables we don't know about here
yes '' | make oldconfig

# sanity check: make sure gnu target was not changed (it gets set by target.in)
NEW_GNU_TARGET=`cat .config | grep PTXCONF_GNU_TARGET | sed 's/.*="//;s/".*//'`
test x$TARGET = x$NEW_GNU_TARGET || abort "make oldconfig mangled the target $TARGET into $NEW_GNU_TARGET; you may need to use a canonical target, or fix config/target.in"



#!/bin/sh
# $Id: settoolchain.sh,v 1.5 2003/10/31 11:49:16 mkl Exp $
#
# Copyright (C) 2003 Ixia Communications, by Dan Kegel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# Script to set up ptxdist to use a crosstool-generated toolchain
#
# Example: TARGET=powerpc-405-linux-gnu PREFIX=/opt/blartfast sh settoolchain.sh

abort() {
	echo $@
	exec /bin/false
}

test -z "${TARGET}"           && abort "Please set TARGET to the Gnu target identifier (e.g. pentium-unknown-linux-gnu)"
test -z "${PREFIX}"           && abort "Please set PREFIX to where you want the toolchain installed."

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
	*i586*)        PTXARCH=X86 ; PTXSUBARCH=OPT_I686;;
	*i*86*)        PTXARCH=X86 ; PTXSUBARCH=OPT_I386;;
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
	*sh*)          PTXARCH=SH ;;
	*)             abort "unrecognized target $TARGET"
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

egrep -v "PTXCONF_GNU_TARGET|PTXCONF_OPT_PPC|PTXCONF_ARCH_|PTXCONF_PREFIX|PTXCONF_ROOT" .config >> .config.tmp

cp .config .config.bak
mv .config.tmp .config

# Now do a 'make oldconfig', please...

# -*-makefile-*-
# $Id: Virtual.make,v 1.1 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

ifdef PTXCONF_GLIBC
DYNAMIC_LINKER 			= /lib/ld.so.1
endif
ifdef PTXCONF_UCLIBC
DYNAMIC_LINKER			= /lib/ld-uClibc.so.0
endif

virtual-xchain_install: $(STATEDIR)/virtual-xchain.install

ifdef PTXCONF_BUILD_CROSSCHAIN
virtual-xchain_install_deps	= $(STATEDIR)/xchain-gccstage2.install
endif 

$(STATEDIR)/virtual-xchain.install: $(virtual-xchain_install_deps)
	@$(call targetinfo, virtual-xchain.install)
	touch $@
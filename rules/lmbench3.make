# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LMBENCH) += lmbench

#
# Paths and names
#
LMBENCH_VERSION	:= 3
LMBENCH		:= LMbench$(LMBENCH_VERSION)
LMBENCH_SUFFIX	:= tgz
LMBENCH_URL	:= http://www.tux.org/pub/benchmarks/System/lmbench/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_SOURCE	:= $(SRCDIR)/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_DIR	:= $(BUILDDIR)/$(LMBENCH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LMBENCH_PATH	:= PATH=$(CROSS_PATH)
LMBENCH_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/lmbench.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/lmbench.compile:
	@$(call targetinfo)
	cd $(LMBENCH_DIR)/src && $(LMBENCH_PATH) $(MAKE) \
		CFLAGS="-O2" TARGET=linux MAKE=make \
		CC=$(PTXCONF_COMPILER_PREFIX)gcc O=. \
		OS=$(PTXCONF_GNU_TARGET) all $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lmbench.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lmbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lmbench)
	@$(call install_fixup, lmbench,PACKAGE,lmbench)
	@$(call install_fixup, lmbench,PRIORITY,optional)
	@$(call install_fixup, lmbench,VERSION,$(LMBENCH_VERSION))
	@$(call install_fixup, lmbench,SECTION,base)
	@$(call install_fixup, lmbench,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, lmbench,DEPENDS,)
	@$(call install_fixup, lmbench,DESCRIPTION,missing)

	@cd $(LMBENCH_DIR)/src; \
	for file in `find . -perm -u+x ! -type d`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, lmbench, 0, 0, $$PER, \
			$$file, \
			/usr/sbin/$$file) \
	done

	@$(call install_finish, lmbench)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lmbench_clean:
	rm -rf $(STATEDIR)/lmbench.*
	rm -rf $(PKGDIR)/lmbench_*
	rm -rf $(LMBENCH_DIR)

# vim: syntax=make

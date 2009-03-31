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
LMBENCH_VERSION	:= 3.0-a9
LMBENCH		:= lmbench-$(LMBENCH_VERSION)
LMBENCH_SUFFIX	:= tgz
LMBENCH_URL	:= $(PTXCONF_SETUP_SFMIRROR)/lmbench/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_SOURCE	:= $(SRCDIR)/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_DIR	:= $(BUILDDIR)/$(LMBENCH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LMBENCH_SOURCE):
	@$(call targetinfo)
	@$(call get, LMBENCH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LMBENCH_PATH	:= PATH=$(CROSS_PATH)
LMBENCH_ENV 	:= \
	$(CROSS_ENV) \
	OS=$(PTXCONF_GNU_TARGET) \
	MAKE=$(MAKE) \
	TARGET=linux

$(STATEDIR)/lmbench.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/lmbench.compile:
	@$(call targetinfo)
	cd $(LMBENCH_DIR) && $(LMBENCH_PATH) $(LMBENCH_ENV) $(LMBENCH_DIR)/scripts/build
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

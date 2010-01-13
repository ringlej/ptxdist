# -*-makefile-*-
#
# Copyright (C) 2009 by Markus Messmer <m.messmer@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPVGEN) += libpvgen

#
# Paths and names
#
LIBPVGEN_VERSION	:= 1.0.1
LIBPVGEN		:= libpvgen-$(LIBPVGEN_VERSION)
LIBPVGEN_SUFFIX		:= tar.gz
LIBPVGEN_URL		:= http://www.pengutronix.de/software/libpvgen/download/$(LIBPVGEN).$(LIBPVGEN_SUFFIX)
LIBPVGEN_SOURCE		:= $(SRCDIR)/$(LIBPVGEN).$(LIBPVGEN_SUFFIX)
LIBPVGEN_DIR		:= $(BUILDDIR)/$(LIBPVGEN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPVGEN_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPVGEN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libpvgen.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBPVGEN_DIR))
	@$(call extract, LIBPVGEN)
	@$(call patchin, LIBPVGEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPVGEN_PATH	:= PATH=$(CROSS_PATH)
LIBPVGEN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPVGEN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-objdictgen-path=$(SYSROOT)/usr/objdictgen

$(STATEDIR)/libpvgen.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBPVGEN_DIR)/config.cache)
	cd $(LIBPVGEN_DIR) && \
		$(LIBPVGEN_PATH) $(LIBPVGEN_ENV) \
		./configure $(LIBPVGEN_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libpvgen.compile:
	@$(call targetinfo)
	cd $(LIBPVGEN_DIR) && $(LIBPVGEN_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpvgen.install:
	@$(call targetinfo)
	@mkdir -p $(PTXCONF_SYSROOT_HOST)/usr/share/libpvgen
	@for file in confignode genpv_cfile libpvgen wago; do \
		ln -sf \
			$(PTXCONF_SYSROOT_TARGET)/usr/share/libpvgen/"$${file}.py" \
			$(PTXCONF_SYSROOT_HOST)/usr/share/libpvgen/"$${file}.py"; \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpvgen.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

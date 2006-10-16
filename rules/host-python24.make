# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON24) += host-python24

#
# Paths and names
#
HOST_PYTHON24		= $(PYTHON24)
HOST_PYTHON24_DIR	= $(HOST_BUILDDIR)/$(HOST_PYTHON24)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-python24_get: $(STATEDIR)/host-python24.get

$(STATEDIR)/host-python24.get: $(STATEDIR)/python24.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-python24_extract: $(STATEDIR)/host-python24.extract

$(STATEDIR)/host-python24.extract: $(host-python24_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PYTHON24_DIR))
	@$(call extract, PYTHON24, $(HOST_BUILDDIR))
	@$(call patchin, PYTHON24, $(HOST_PYTHON24_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-python24_prepare: $(STATEDIR)/host-python24.prepare

HOST_PYTHON24_PATH	:= PATH=$(HOST_PATH)
HOST_PYTHON24_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_PYTHON24_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-python24.prepare: $(host-python24_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_PYTHON24_DIR)/config.cache)
	cd $(HOST_PYTHON24_DIR) && \
		$(HOST_PYTHON24_PATH) $(HOST_PYTHON24_ENV) \
		./configure $(HOST_PYTHON24_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-python24_compile: $(STATEDIR)/host-python24.compile

$(STATEDIR)/host-python24.compile: $(host-python24_compile_deps_default)
	@$(call targetinfo, $@)
	# we use --prefix, so no destdir here
	( \
		export DESTDIR="/"; \
		cd $(HOST_PYTHON24_DIR) && \
			$(HOST_PYTHON24_ENV) \
			$(HOST_PYTHON24_PATH) \
			make; \
	)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-python24_install: $(STATEDIR)/host-python24.install

$(STATEDIR)/host-python24.install: $(host-python24_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_PYTHON24,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-python24_clean:
	rm -rf $(STATEDIR)/host-python24.*
	rm -rf $(HOST_PYTHON24_DIR)

# vim: syntax=make

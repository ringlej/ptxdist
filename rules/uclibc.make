# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003, 2004 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UCLIBC) += uclibc
ifdef PTXCONF_UCLIBC
DYNAMIC_LINKER	=  /lib/ld-uClibc.so.0
endif

UCLIBC = uClibc-$(UCLIBC_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

uclibc_get: $(STATEDIR)/uclibc.get

$(STATEDIR)/uclibc.get:
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

uclibc_extract: $(STATEDIR)/uclibc.extract

uclibc_extract_deps = $(STATEDIR)/uclibc.get

$(STATEDIR)/uclibc.extract: $(uclibc_extract_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

uclibc_prepare: $(STATEDIR)/uclibc.prepare

uclibc_prepare_deps =  $(STATEDIR)/uclibc.extract

$(STATEDIR)/uclibc.prepare: $(uclibc_prepare_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

uclibc_compile: $(STATEDIR)/uclibc.compile

uclibc_compile_deps = $(STATEDIR)/uclibc.prepare

$(STATEDIR)/uclibc.compile: $(uclibc_compile_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

uclibc_install: $(STATEDIR)/uclibc.install

$(STATEDIR)/uclibc.install: $(STATEDIR)/uclibc.compile
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

uclibc_targetinstall: $(STATEDIR)/uclibc.targetinstall

uclibc_targetinstall_deps = $(STATEDIR)/uclibc.install

$(STATEDIR)/uclibc.targetinstall: $(uclibc_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,uclibc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UCLIBC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_UCLIBC_INSTALL
	@$(call install_copy_toolchain_dl, /lib)
	@$(call install_copy_toolchain_lib, libc.so, /lib)
	# FIXME: add links	

ifdef PTXCONF_UCLIBC_CRYPT
	@$(call install_copy_toolchain_lib, libcrypt.so, /lib)
endif

ifdef PTXCONF_UCLIBC_DL
	@$(call install_copy_toolchain_lib, libdl.so, /lib)
endif

ifdef PTXCONF_UCLIBC_M
	@$(call install_copy_toolchain_lib, libm.so, /lib)
endif

ifdef PTXCONF_UCLIBC_NSL
	@$(call install_copy_toolchain_lib, libnsl.so, /lib)
endif

ifdef PTXCONF_UCLIBC_PTHREAD
	@$(call install_copy_toolchain_lib, libpthread.so, /lib)
ifdef PTXCONF_GDBSERVER
	@$(call install_copy_toolchain_lib, libthread_db.so, /lib)
endif
endif

ifdef PTXCONF_UCLIBC_RESOLV
	@$(call install_copy_toolchain_lib, libresolv.so, /lib)
endif

ifdef PTXCONF_UCLIBC_UTIL
	@$(call install_copy_toolchain_lib, libutil.so, /lib)
endif

endif
	@$(call install_finish)
	
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

uclibc_clean: 
	rm -rf $(STATEDIR)/uclibc.*
	rm -rf $(IMAGEDIR)/uclibc_*
	rm -rf $(UCLIBC_DIR)

# vim: syntax=make

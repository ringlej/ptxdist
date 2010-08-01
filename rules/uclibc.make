# -*-makefile-*-
#
# Copyright (C) 2003, 2004, 2008 by Marc Kleine-Budde <kleine-budde@gmx.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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

UCLIBC_VERSION	:= $(call remove_quotes,$(PTXCONF_UCLIBC_VERSION))

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/uclibc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, uclibc)
	@$(call install_fixup, uclibc,PRIORITY,optional)
	@$(call install_fixup, uclibc,SECTION,base)
	@$(call install_fixup, uclibc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, uclibc,DESCRIPTION,missing)

ifdef PTXCONF_UCLIBC
	@$(call install_copy_toolchain_dl, uclibc, /lib)
endif

ifdef PTXCONF_UCLIBC_C
	@$(call install_copy_toolchain_lib, uclibc, libc.so)
endif

ifdef PTXCONF_UCLIBC_CRYPT
	@$(call install_copy_toolchain_lib, uclibc, libcrypt.so)
endif

ifdef PTXCONF_UCLIBC_DL
	@$(call install_copy_toolchain_lib, uclibc, libdl.so)
endif

ifdef PTXCONF_UCLIBC_M
	@$(call install_copy_toolchain_lib, uclibc, libm.so)
endif

ifdef PTXCONF_UCLIBC_NSL
	@$(call install_copy_toolchain_lib, uclibc, libnsl.so)
endif

ifdef PTXCONF_UCLIBC_PTHREAD
	@$(call install_copy_toolchain_lib, uclibc, libpthread.so)
endif

ifdef PTXCONF_UCLIBC_THREAD_DB
	@$(call install_copy_toolchain_lib, uclibc, libthread_db.so)
endif

ifdef PTXCONF_UCLIBC_RESOLV
	@$(call install_copy_toolchain_lib, uclibc, libresolv.so)
endif

ifdef PTXCONF_UCLIBC_RT
	@$(call install_copy_toolchain_lib, uclibc, librt.so)
endif

ifdef PTXCONF_UCLIBC_UTIL
	@$(call install_copy_toolchain_lib, uclibc, libutil.so)
endif
	@$(call install_finish, uclibc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

uclibc_clean: 
	rm -rf $(STATEDIR)/uclibc.*
	rm -rf $(PKGDIR)/uclibc_*

# vim: syntax=make

#
# Copyright (C) 2007 by Ladislav Michl
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
PACKAGES-$(PTXCONF_UNZIP) += unzip

#
# Paths and names
# (unzip is packaged a bit unusual way, that's why two version variables exist)
#
UNZIP_VERSION	:= 5.52
UNZIP_AVERSION	:= 552
UNZIP_ARCHIVE	:= unzip$(UNZIP_AVERSION).tgz
UNZIP		:= unzip-$(UNZIP_VERSION)
UNZIP_URL	:= http://www.mirrorservice.org/sites/ftp.info-zip.org/pub/infozip/src/$(UNZIP_ARCHIVE)
UNZIP_SOURCE	:= $(SRCDIR)/$(UNZIP_ARCHIVE)
UNZIP_DIR	:= $(BUILDDIR)/$(UNZIP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UNZIP_SOURCE):
	@$(call targetinfo)
	@$(call get, UNZIP)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

UNZIP_PATH		:= PATH=$(CROSS_PATH)
UNZIP_MAKE_OPT		:= $(CROSS_ENV_CC) -f unix/Makefile generic

UNZIP_INSTALL_OPT	:= -f unix/Makefile prefix=$(UNZIP_PKGDIR)/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/unzip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, unzip)
	@$(call install_fixup, unzip,PACKAGE,unzip)
	@$(call install_fixup, unzip,PRIORITY,optional)
	@$(call install_fixup, unzip,VERSION,$(UNZIP_VERSION))
	@$(call install_fixup, unzip,SECTION,base)
	@$(call install_fixup, unzip,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, unzip,DEPENDS,)
	@$(call install_fixup, unzip,DESCRIPTION,missing)

ifdef PTXCONF_UNZIP_UNZIP
	@$(call install_copy, unzip, 0, 0, 0755, -, /usr/bin/unzip)
endif
ifdef PTXCONF_UNZIP_FUNZIP
	@$(call install_copy, unzip, 0, 0, 0755, -, /usr/bin/funzip)
endif
ifdef PTXCONF_UNZIP_UNZIPSFX
	@$(call install_copy, unzip, 0, 0, 0755, -, /usr/bin/unzipsfx)
endif

	@$(call install_finish, unzip)

	@$(call touch)

# vim: syntax=make

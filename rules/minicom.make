# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MINICOM) += minicom

#
# Paths and names
#
MINICOM_VERSION	:= 2.2
MINICOM		:= minicom-$(MINICOM_VERSION)
MINICOM_SUFFIX	:= tar.gz
MINICOM_URL	:= http://alioth.debian.org/frs/download.php/1806/$(MINICOM).$(MINICOM_SUFFIX)
MINICOM_SOURCE	:= $(SRCDIR)/$(MINICOM).$(MINICOM_SUFFIX)
MINICOM_DIR	:= $(BUILDDIR)/$(MINICOM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MINICOM_SOURCE):
	@$(call targetinfo)
	@$(call get, MINICOM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MINICOM_PATH	:= PATH=$(CROSS_PATH)
MINICOM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
MINICOM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--enable-socket \
	--disable-music

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/minicom.install:
	@$(call targetinfo)
	@$(call install, MINICOM)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/minicom.targetinstall:
	@$(call targetinfo)

	@$(call install_init, minicom)
	@$(call install_fixup, minicom,PACKAGE,minicom)
	@$(call install_fixup, minicom,PRIORITY,optional)
	@$(call install_fixup, minicom,VERSION,$(MINICOM_VERSION))
	@$(call install_fixup, minicom,SECTION,base)
	@$(call install_fixup, minicom,AUTHOR,"Carsten Schlote <c.schlote\@konzeptpark.de>")
	@$(call install_fixup, minicom,DEPENDS,)
	@$(call install_fixup, minicom,DESCRIPTION,missing)

	@$(call install_copy, minicom, 0, 0, 0755, $(MINICOM_DIR)/src/minicom, /usr/bin/minicom)
	@$(call install_copy, minicom, 0, 0, 0755, $(MINICOM_DIR)/src/runscript, /usr/bin/runscript)
	@$(call install_copy, minicom, 0, 0, 0755, $(MINICOM_DIR)/src/ascii-xfr, /usr/bin/ascii-xfr)

ifdef PTXCONF_MINICOM_ETC_MINIRC_DFL
	@$(call install_alternate, minicom, 0, 0, 0644, /etc/minirc.dfl, n)
endif

	@$(call install_finish, minicom)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

minicom_clean:
	rm -rf $(STATEDIR)/minicom.*
	rm -rf $(PKGDIR)/minicom_*
	rm -rf $(MINICOM_DIR)

# vim: syntax=make

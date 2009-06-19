# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_THTTPD) += thttpd

#
# Paths and names
#
THTTPD_VERSION	:= 2.25b
THTTPD		:= thttpd-$(THTTPD_VERSION)
THTTPD_SUFFIX	:= tar.gz
THTTPD_URL	:= http://www.acme.com/software/thttpd/$(THTTPD).$(THTTPD_SUFFIX)
THTTPD_SOURCE	:= $(SRCDIR)/$(THTTPD).$(THTTPD_SUFFIX)
THTTPD_DIR	:= $(BUILDDIR)/$(THTTPD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(THTTPD_SOURCE):
	@$(call targetinfo)
	@$(call get, THTTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

THTTPD_PATH	:=  PATH=$(CROSS_PATH)
THTTPD_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
THTTPD_AUTOCONF :=  $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/thttpd.compile:
	@$(call targetinfo)
	cd $(THTTPD_DIR) && $(THTTPD_PATH) $(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/thttpd.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/thttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  thttpd)
	@$(call install_fixup, thttpd,PACKAGE,thttpd)
	@$(call install_fixup, thttpd,PRIORITY,optional)
	@$(call install_fixup, thttpd,VERSION,$(THTTPD_VERSION))
	@$(call install_fixup, thttpd,SECTION,base)
	@$(call install_fixup, thttpd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, thttpd,DEPENDS,)
	@$(call install_fixup, thttpd,DESCRIPTION,missing)

	@$(call install_copy, thttpd, 0, 0, 0755, $(THTTPD_DIR)/thttpd, \
		/usr/sbin/thttpd)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_THTTPD_STARTSCRIPT
	@$(call install_alternative, thttpd, 0, 0, 0755, /etc/init.d/thttpd, n)
endif
endif

ifdef PTXCONF_THTTPD__GENERIC_SITE
	@$(call install_copy, thttpd, 12, 102, 0755, /var/www)
	@$(call install_copy, thttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/thttpd.html, \
		/var/www/index.html, n)
endif

ifdef PTXCONF_THTTPD__INSTALL_HTPASSWD
	@$(call install_copy, thttpd, 0, 0, 0755, \
		$(THTTPD_DIR)/extras/htpasswd, \
		/usr/sbin/htpasswd)
endif

	@$(call install_finish, thttpd)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

thttpd_clean:
	rm -rf $(STATEDIR)/thttpd.*
	rm -rf $(PKGDIR)/thttpd_*
	rm -rf $(THTTPD_DIR)

# vim: syntax=make

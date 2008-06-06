# -*-makefile-*-
# $Id: template 3691 2006-01-02 15:52:13Z rsc $
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
PACKAGES-$(PTXCONF_LIBMQUEUE) += libmqueue

#
# Paths and names
#
LIBMQUEUE_VERSION	:= 4.41
LIBMQUEUE		:= libmqueue-$(LIBMQUEUE_VERSION)
LIBMQUEUE_SUFFIX	:= tar.gz
LIBMQUEUE_URL		:= http://www.geocities.com/wronski12/posix_ipc/$(LIBMQUEUE).$(LIBMQUEUE_SUFFIX)
LIBMQUEUE_SOURCE	:= $(SRCDIR)/$(LIBMQUEUE).$(LIBMQUEUE_SUFFIX)
LIBMQUEUE_DIR		:= $(BUILDDIR)/$(LIBMQUEUE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMQUEUE_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMQUEUE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMQUEUE_PATH	:= PATH=$(CROSS_PATH)
LIBMQUEUE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMQUEUE_AUTOCONF :=  $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmqueue.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmqueue)
	@$(call install_fixup, libmqueue,PACKAGE,libmqueue)
	@$(call install_fixup, libmqueue,PRIORITY,optional)
	@$(call install_fixup, libmqueue,VERSION,$(LIBMQUEUE_VERSION))
	@$(call install_fixup, libmqueue,SECTION,base)
	@$(call install_fixup, libmqueue,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libmqueue,DEPENDS,)
	@$(call install_fixup, libmqueue,DESCRIPTION,missing)

	@$(call install_copy, libmqueue, 0, 0, 0644, \
		$(LIBMQUEUE_DIR)/src/.libs/libmqueue.so.4.0.41, \
		/usr/lib/libmqueue.so.4.0.41)

	@$(call install_link, libmqueue, libmqueue.so.4.0.41, /usr/lib/libmqueue.so.4)
	@$(call install_link, libmqueue, libmqueue.so.4.0.41, /usr/lib/libmqueue.so)

	@$(call install_finish, libmqueue)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmqueue_clean:
	rm -rf $(STATEDIR)/libmqueue.*
	rm -rf $(PKGDIR)/libmqueue_*
	rm -rf $(LIBMQUEUE_DIR)

# vim: syntax=make

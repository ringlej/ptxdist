# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMPEG2) += libmpeg2

#
# Paths and names
#
LIBMPEG2_VERSION	:= 0.5.1
LIBMPEG2		:= libmpeg2-$(LIBMPEG2_VERSION)
LIBMPEG2_SUFFIX		:= tar.gz
LIBMPEG2_URL		:= http://libmpeg2.sourceforge.net/files//$(LIBMPEG2).$(LIBMPEG2_SUFFIX)
LIBMPEG2_SOURCE		:= $(SRCDIR)/$(LIBMPEG2).$(LIBMPEG2_SUFFIX)
LIBMPEG2_DIR		:= $(BUILDDIR)/$(LIBMPEG2)
LIBMPEG2_LICENSE	:= GPLv3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMPEG2_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMPEG2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMPEG2_CONF_TOOL := autoconf
LIBMPEG2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-debug \
	--disable-accel-detect \
	--disable-sdl \
	--disable-warnings \
	--disable-gprof \
	--without-x 

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmpeg2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmpeg2)
	@$(call install_fixup, libmpeg2,PACKAGE,libmpeg2)
	@$(call install_fixup, libmpeg2,PRIORITY,optional)
	@$(call install_fixup, libmpeg2,VERSION,$(LIBMPEG2_VERSION))
	@$(call install_fixup, libmpeg2,SECTION,base)
	@$(call install_fixup, libmpeg2,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, libmpeg2,DEPENDS,)
	@$(call install_fixup, libmpeg2,DESCRIPTION,missing)

	@$(call install_copy, libmpeg2, 0, 0, 0644, -, \
		/usr/lib/libmpeg2.so.0.1.0)
	@$(call install_link, libmpeg2, libmpeg2.so.0.1.0, \
                /usr/lib/libmpeg2.so.0)
	@$(call install_link, libmpeg2, libmpeg2.so.0.1.0, \
                /usr/lib/libmpeg2.so)

	@$(call install_copy, libmpeg2, 0, 0, 0644, -, \
		/usr/lib/libmpeg2convert.so.0.0.0)
	@$(call install_link, libmpeg2, libmpeg2convert.so.0.0.0, \
                /usr/lib/libmpeg2convert.so.0)
	@$(call install_link, libmpeg2, libmpeg2convert.so.0.0.0, \
                /usr/lib/libmpeg2convert.so)

	@$(call install_finish, libmpeg2)

	@$(call touch)

# vim: syntax=make

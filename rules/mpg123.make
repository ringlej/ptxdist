# -*-makefile-*-
#
# Copyright (C) 2010 by Juergen Kilb
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MPG123) += mpg123

#
# Paths and names
#
MPG123_VERSION	:= 1.13.3
MPG123_MD5	:= b1f990ce76dcf2fdf9d53ac39fc6bc7e
MPG123		:= mpg123-$(MPG123_VERSION)
MPG123_SUFFIX	:= tar.bz2
MPG123_URL	:= http://www.mpg123.org/download/$(MPG123).$(MPG123_SUFFIX)
MPG123_SOURCE	:= $(SRCDIR)/$(MPG123).$(MPG123_SUFFIX)
MPG123_DIR	:= $(BUILDDIR)/$(MPG123)
MPG123_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MPG123_SOURCE):
	@$(call targetinfo)
	@$(call get, MPG123)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MPG123_CONF_TOOL	:= autoconf
MPG123_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--with-audio=alsa\
	--with-default-audio=alsa\
	--enable-modules=no
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mpg123.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mpg123)
	@$(call install_fixup, mpg123,PRIORITY,optional)
	@$(call install_fixup, mpg123,SECTION,base)
	@$(call install_fixup, mpg123,AUTHOR,"Juergen Kilb <J.Kilb@phytec.de>")
	@$(call install_fixup, mpg123,DESCRIPTION,missing)

	@$(call install_copy, mpg123, 0, 0, 0755, -, /usr/bin/mpg123)
	@$(call install_lib, mpg123, 0, 0, 0644, libmpg123)

	@$(call install_finish, mpg123)

	@$(call touch)

# vim: syntax=make

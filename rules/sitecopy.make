# -*-makefile-*-
#
# Copyright (C) 2011 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SITECOPY) += sitecopy

#
# Paths and names
#
SITECOPY_VERSION	:= 0.16.6
SITECOPY_MD5		:= b3aeb5a5f00af3db90b408e8c32a6c01
SITECOPY		:= sitecopy-$(SITECOPY_VERSION)
SITECOPY_SUFFIX		:= tar.gz
SITECOPY_URL		:= http://www.manyfish.co.uk/sitecopy/$(SITECOPY).$(SITECOPY_SUFFIX)
SITECOPY_SOURCE		:= $(SRCDIR)/$(SITECOPY).$(SITECOPY_SUFFIX)
SITECOPY_DIR		:= $(BUILDDIR)/$(SITECOPY)
SITECOPY_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SITECOPY_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-gnomefe \
	--enable-threadsafe-ssl=posix \
	--disable-nls \
	--enable-threads=posix \
	--disable-rpath \
	--without-pakchois \
	--without-socks \
	--without-gssapi

# m4/neon/neon.m4 uses uname to check for Darwin and adds some special compiler
# options in that case. sitecopy doesn't build host tools, so anything built
# is for the target. We can force the target operating system to Linux. That's simpler
# than fixing the m4/neon/neon.m4 and doesn't need autoreconf to run.
SITECOPY_CONF_ENV	:= \
	$(CROSS_ENV) \
	ne_cv_os_uname=Linux

ifdef PTXCONF_SITECOPY_SFTP
SITECOPY_AUTOCONF += --enable-sftp
else
SITECOPY_AUTOCONF += --disable-sftp
endif

ifdef PTXCONF_SITECOPY_RSH
SITECOPY_AUTOCONF += --enable-rsh
else
SITECOPY_AUTOCONF += --disable-rsh
endif

ifdef PTXCONF_SITECOPY_FTP
SITECOPY_AUTOCONF += --enable-ftp
else
SITECOPY_AUTOCONF += --disable-ftp
endif

ifdef PTXCONF_SITECOPY_WEBDAV
SITECOPY_AUTOCONF += --enable-webdav
else
SITECOPY_AUTOCONF += --disable-webdav
endif

ifdef PTXCONF_SITECOPY_XML_EXPAT
SITECOPY_AUTOCONF += --with-expat
endif

ifdef PTXCONF_SITECOPY_XML_LIBXML2
SITECOPY_AUTOCONF += --with-libxml2 
endif

ifdef PTXCONF_SITECOPY_OPENSSL
SITECOPY_AUTOCONF += --with-ssl=openssl
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sitecopy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sitecopy)
	@$(call install_fixup, sitecopy,PRIORITY,optional)
	@$(call install_fixup, sitecopy,SECTION,base)
	@$(call install_fixup, sitecopy,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, sitecopy,DESCRIPTION,missing)

	@$(call install_copy, sitecopy, 0, 0, 0755, -, /usr/bin/sitecopy)

	@$(call install_finish, sitecopy)

	@$(call touch)

# vim: syntax=make

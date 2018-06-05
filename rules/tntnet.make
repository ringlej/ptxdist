# -*-makefile-*-
#
# Copyright (C) 2014 by Bernhard Seßler <bernhard.sessler@corscience.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TNTNET) += tntnet

#
# Paths and names
#
TNTNET_VERSION	:= 2.2.1
TNTNET_MD5		:= febe799675c1b8b2f7259bad30cf6f23
TNTNET			:= tntnet-$(TNTNET_VERSION)
TNTNET_SUFFIX	:= tar.gz
TNTNET_URL		:= http://www.tntnet.org/download/$(TNTNET).$(TNTNET_SUFFIX)
TNTNET_SOURCE	:= $(SRCDIR)/$(TNTNET).$(TNTNET_SUFFIX)
TNTNET_DIR		:= $(BUILDDIR)/$(TNTNET)
TNTNET_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TNTNET_CONF_ENV		:= $(CROSS_ENV)
TNTNET_CONF_TOOL	:= autoconf
TNTNET_CONF_OPT		:= $(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-unittest \
	--disable-dependency-tracking \
	--with-sdk=no \
	--with-demos=no \
	--with-stressjob=no \
	--with-epoll=yes \
	--with-sendfile=yes

ifdef PTXCONF_TNTNET_SSL_NONE
TNTNET_CONF_OPT		+= --with-ssl=no
endif
ifdef PTXCONF_TNTNET_SSL_OPENSSL
TNTNET_CONF_OPT		+= --with-ssl=openssl
endif
ifdef PTXCONF_TNTNET_SSL_GNUTLS
TNTNET_CONF_OPT		+= --with-ssl=gnutls
endif

ifdef PTXCONF_TNTNET_SERVER
TNTNET_CONF_OPT		+= --with-server=yes
else
TNTNET_CONF_OPT		+= --with-server=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tntnet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tntnet)
	@$(call install_fixup, tntnet,PRIORITY,optional)
	@$(call install_fixup, tntnet,SECTION,base)
	@$(call install_fixup, tntnet,AUTHOR,"Bernhard Seßler <bernhard.sessler@corscience.de>")
	@$(call install_fixup, tntnet,DESCRIPTION,missing)

	@$(call install_lib, tntnet, 0, 0, 0644, libtntnet)

ifdef PTXCONF_TNTNET_SERVER
	@$(call install_copy, tntnet, 0, 0, 0755, -, /usr/bin/tntnet)
	@$(call install_lib, tntnet, 0, 0, 0644, tntnet/tntnet)
	@$(call install_alternative, tntnet, 0, 0, 0644, /etc/tntnet/tntnet.xml)
endif

	@$(call install_finish, tntnet)

	@$(call touch)

# vim: syntax=make

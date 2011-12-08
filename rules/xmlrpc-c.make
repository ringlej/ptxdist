# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XMLRPC_C) += xmlrpc-c

#
# Paths and names
#
XMLRPC_C_VERSION	:= 1.06.41
XMLRPC_C_MD5		:= 02c6b89b8ff911341b6b6d4a6c621ea9
XMLRPC_C		:= xmlrpc-c-$(XMLRPC_C_VERSION)
XMLRPC_C_SUFFIX		:= tgz
XMLRPC_C_URL		:= $(PTXCONF_SETUP_SFMIRROR)/xmlrpc-c/Xmlrpc-c%20Super%20Stable/$(XMLRPC_C_VERSION)/$(XMLRPC_C).$(XMLRPC_C_SUFFIX)
XMLRPC_C_SOURCE		:= $(SRCDIR)/$(XMLRPC_C).$(XMLRPC_C_SUFFIX)
XMLRPC_C_DIR		:= $(BUILDDIR)/$(XMLRPC_C)
XMLRPC_C_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XMLRPC_C_SOURCE):
	@$(call targetinfo)
	@$(call get, XMLRPC_C)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XMLRPC_C_CONF_TOOL := autoconf
XMLRPC_C_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-wininet-client \
	--disable-libwww-client \
	--without-libwww-ssl

ifdef PTXCONF_XMLRPC_C_CURL
XMLRPC_C_CONF_OPT += --enable-curl-client
else
XMLRPC_C_CONF_OPT += --disable-curl-client
endif

ifdef PTXCONF_XMLRPC_C_ABYSS_SERVER
XMLRPC_C_CONF_OPT += --enable-abyss-server
else
XMLRPC_C_CONF_OPT += --disable-abyss-server
endif

ifdef PTXCONF_XMLRPC_C_ABYSS_THREADS
XMLRPC_C_CONF_OPT += --enable-abyss-threads
else
XMLRPC_C_CONF_OPT += --disable-abyss-threads
endif

ifdef PTXCONF_XMLRPC_C_CGI_SERVER
XMLRPC_C_CONF_OPT += --enable-cgi-server
else
XMLRPC_C_CONF_OPT += --disable-cgi-server
endif

ifdef PTXCONF_XMLRPC_C_CPLUSPLUS
XMLRPC_C_CONF_OPT += --enable-cplusplus
else
XMLRPC_C_CONF_OPT += --disable-cplusplus
endif

ifdef PTXCONF_XMLRPC_C_LIBXML2
XMLRPC_C_CONF_OPT += --enable-libxml2-backend
else
XMLRPC_C_CONF_OPT += --disable-libxml2-backend
endif

XMLRPC_C_MAKE_OPT := \
	CADD=-fPIC \
	BUILDTOOL_CC=$(HOSTCC) \
	BUILDTOOL_CCLD=$(HOSTCC)

XMLRPC_C_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xmlrpc-c.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xmlrpc-c)
	@$(call install_fixup, xmlrpc-c,PRIORITY,optional)
	@$(call install_fixup, xmlrpc-c,SECTION,base)
	@$(call install_fixup, xmlrpc-c,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, xmlrpc-c,DESCRIPTION,missing)

	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc)
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_server)
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_server_abyss)

ifdef PTXCONF_XMLRPC_C_CPLUSPLUS
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc++)
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_server++)
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_server_abyss++)
endif

	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_util)

ifndef PTXCONF_XMLRPC_C_LIBXML2
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_xmlparse)
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_xmltok)
endif

ifdef PTXCONF_XMLRPC_C_CLIENT
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_client)

ifdef PTXCONF_XMLRPC_C_CPLUSPLUS
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_client++)
endif
endif

ifdef PTXCONF_XMLRPC_C_ABYSS_SERVER
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_abyss)
endif

ifdef PTXCONF_XMLRPC_C_CGI_SERVER
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_server_cgi)
endif

ifdef XMLRPC_C_CGI_SERVER
	@$(call install_lib, xmlrpc-c, 0, 0, 0644, libxmlrpc_server)
endif

	@$(call install_finish, xmlrpc-c)

	@$(call touch)

# vim: syntax=make

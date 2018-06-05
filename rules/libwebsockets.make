# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBWEBSOCKETS) += libwebsockets

#
# Paths and names
#
LIBWEBSOCKETS_VERSION	:= v1.7.9
LIBWEBSOCKETS_MD5	:= 7b3692ead5ae00fd0e1d56c080170f07
LIBWEBSOCKETS		:= libwebsockets-$(LIBWEBSOCKETS_VERSION)
LIBWEBSOCKETS_SUFFIX	:= tar.gz
LIBWEBSOCKETS_URL	:= https://github.com/warmcat/libwebsockets/archive/$(LIBWEBSOCKETS_VERSION).$(LIBWEBSOCKETS_SUFFIX)
LIBWEBSOCKETS_SOURCE	:= $(SRCDIR)/$(LIBWEBSOCKETS).$(LIBWEBSOCKETS_SUFFIX)
LIBWEBSOCKETS_DIR	:= $(BUILDDIR)/$(LIBWEBSOCKETS)
LIBWEBSOCKETS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

LIBWEBSOCKETS_CONF_TOOL	:= cmake
LIBWEBSOCKETS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DLWS_WITH_SSL=OFF \
	-DLWS_SSL_CLIENT_USE_OS_CA_CERTS=ON \
	-DLWS_USE_EXTERNAL_ZLIB=ON \
	-DLWS_USE_CYASSL=OFF \
	-DLWS_WITHOUT_BUILTIN_GETIFADDRS=OFF \
	-DLWS_WITHOUT_CLIENT=OFF \
	-DLWS_WITHOUT_SERVER=OFF \
	-DLWS_LINK_TESTAPPS_DYNAMIC=ON \
	-DLWS_WITHOUT_TESTAPPS=$(call ptx/ifdef, PTXCONF_LIBWEBSOCKETS_TESTS,OFF,ON) \
	-DLWS_WITHOUT_TEST_SERVER=$(call ptx/ifdef, PTXCONF_LIBWEBSOCKETS_TESTS,OFF,ON) \
	-DLWS_WITHOUT_TEST_SERVER_EXTPOLL=$(call ptx/ifdef, PTXCONF_LIBWEBSOCKETS_TESTS,OFF,ON) \
	-DLWS_WITHOUT_TEST_PING=$(call ptx/ifdef, PTXCONF_LIBWEBSOCKETS_TESTS,OFF,ON) \
	-DLWS_WITHOUT_TEST_CLIENT=$(call ptx/ifdef, PTXCONF_LIBWEBSOCKETS_TESTS,OFF,ON) \
	-DLWS_WITHOUT_TEST_FRAGGLE=$(call ptx/ifdef, PTXCONF_LIBWEBSOCKETS_TESTS,OFF,ON) \
	-DLWS_WITHOUT_DEBUG=ON \
	-DLWS_WITHOUT_EXTENSIONS=OFF \
	-DLWS_WITH_LATENCY=OFF \
	-DLWS_WITHOUT_DAEMONIZE=OFF \
	-DLWS_WITH_LIBEV=OFF \
	-DLWS_IPV6=$(call ptx/ifdef, PTXCONF_GLOBAL_IPV6,ON,OFF) \
	-DLWS_WITH_HTTP2=OFF


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libwebsockets.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libwebsockets)
	@$(call install_fixup, libwebsockets,PRIORITY,optional)
	@$(call install_fixup, libwebsockets,SECTION,base)
	@$(call install_fixup, libwebsockets,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libwebsockets,DESCRIPTION,missing)

	@$(call install_lib, libwebsockets, 0, 0, 0644, libwebsockets)
ifdef PTXCONF_LIBWEBSOCKETS_TESTS
	@$(call install_copy, libwebsockets, 0, 0, 0755, -, /usr/bin/libwebsockets-test-client)
	@$(call install_copy, libwebsockets, 0, 0, 0755, -, /usr/bin/libwebsockets-test-echo)
	@$(call install_copy, libwebsockets, 0, 0, 0755, -, /usr/bin/libwebsockets-test-fraggle)
	@$(call install_copy, libwebsockets, 0, 0, 0755, -, /usr/bin/libwebsockets-test-ping)
	@$(call install_copy, libwebsockets, 0, 0, 0755, -, /usr/bin/libwebsockets-test-server)
	@$(call install_copy, libwebsockets, 0, 0, 0755, -, /usr/bin/libwebsockets-test-server-extpoll)
	@$(call install_tree, libwebsockets, 0, 0, -, /usr/share/libwebsockets-test-server)
endif

	@$(call install_finish, libwebsockets)

	@$(call touch)


# vim: syntax=make

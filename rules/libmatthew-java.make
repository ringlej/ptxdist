# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMATTHEW_JAVA) += libmatthew-java

#
# Paths and names
#
LIBMATTHEW_JAVA_VERSION	:= 0.7.2
LIBMATTHEW_JAVA		:= libmatthew-java-$(LIBMATTHEW_JAVA_VERSION)
LIBMATTHEW_JAVA_SUFFIX	:= tar.gz
LIBMATTHEW_JAVA_URL	:= http://matthew.ath.cx/projects/java/$(LIBMATTHEW_JAVA).$(LIBMATTHEW_JAVA_SUFFIX)
LIBMATTHEW_JAVA_SOURCE	:= $(SRCDIR)/$(LIBMATTHEW_JAVA).$(LIBMATTHEW_JAVA_SUFFIX)
LIBMATTHEW_JAVA_DIR	:= $(BUILDDIR)/$(LIBMATTHEW_JAVA)
LIBMATTHEW_JAVA_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMATTHEW_JAVA_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LIBMATTHEW_JAVA_MAKEVARS := \
	$(CROSS_ENV_CC) \
	LDVER=GNU \
	JAVA_HOME=$(PTXCONF_SETUP_JAVA_SDK) \
	PREFIX=/usr \
	LIBDIR=/usr/lib \
	UNAME=Linux

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmatthew-java.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmatthew-java)
	@$(call install_fixup, libmatthew-java,PRIORITY,optional)
	@$(call install_fixup, libmatthew-java,SECTION,base)
	@$(call install_fixup, libmatthew-java,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, libmatthew-java,DESCRIPTION,"Useful JAVA applets")

ifdef PTXCONF_LIBMATTHEW_JAVA_CGI
	@$(call install_lib, libmatthew-java, 0, 0, 0644, libcgi-java)

	@$(call install_copy, libmatthew-java, 0, 0, 0644, \
		$(LIBMATTHEW_JAVA_PKGDIR)/usr/share/java/cgi-0.5.jar, \
		/usr/share/java/cgi.jar)
endif
ifdef PTXCONF_LIBMATTHEW_JAVA_DEBUG
	@$(call install_copy, libmatthew-java, 0, 0, 0644, \
		$(LIBMATTHEW_JAVA_PKGDIR)/usr/share/java/debug-disable-1.1.jar, \
		/usr/share/java/debug-disable.jar)

	@$(call install_copy, libmatthew-java, 0, 0, 0644, \
		$(LIBMATTHEW_JAVA_PKGDIR)/usr/share/java/debug-enable-1.1.jar, \
		/usr/share/java/debug-enable.jar)
endif
ifdef PTXCONF_LIBMATTHEW_JAVA_HEXDUMP
	@$(call install_copy, libmatthew-java, 0, 0, 0644, \
		$(LIBMATTHEW_JAVA_PKGDIR)/usr/share/java/hexdump-0.2.jar, \
		/usr/share/java/hexdump.jar)
endif
ifdef PTXCONF_LIBMATTHEW_JAVA_IO
	@$(call install_copy, libmatthew-java, 0, 0, 0644, \
		$(LIBMATTHEW_JAVA_PKGDIR)/usr/share/java/io-0.1.jar, \
		/usr/share/java/io.jar)
endif
ifdef PTXCONF_LIBMATTHEW_JAVA_UNIX_SOCKETS
	@$(call install_lib, libmatthew-java, 0, 0, 0644, libunix-java)

	@$(call install_copy, libmatthew-java, 0, 0, 0644, \
		$(LIBMATTHEW_JAVA_PKGDIR)/usr/share/java/unix-0.5.jar, \
		/usr/share/java/unix.jar)
endif
	@$(call install_finish, libmatthew-java)

	@$(call touch)

# vim: syntax=make

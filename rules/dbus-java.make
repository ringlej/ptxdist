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
PACKAGES-$(PTXCONF_DBUS_JAVA) += dbus-java

#
# Paths and names
#
DBUS_JAVA_VERSION	:= 2.7
DBUS_JAVA		:= dbus-java-$(DBUS_JAVA_VERSION)
DBUS_JAVA_SUFFIX	:= tar.gz
DBUS_JAVA_URL		:= http://dbus.freedesktop.org/releases/dbus-java/$(DBUS_JAVA).$(DBUS_JAVA_SUFFIX)
DBUS_JAVA_SOURCE	:= $(SRCDIR)/$(DBUS_JAVA).$(DBUS_JAVA_SUFFIX)
DBUS_JAVA_DIR		:= $(BUILDDIR)/$(DBUS_JAVA)
DBUS_JAVA_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DBUS_JAVA_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

DBUS_JAVA_MAKE_PAR := NO

DBUS_JAVA_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	JAVA_HOME=$(PTXCONF_SETUP_JAVA_SDK) \
	CLASSPATH=$(PTXCONF_SETUP_JAVA_SDK)/jre/lib \
	JAVAUNIXJARDIR=$(SYSROOT)/usr/share/java \
	JAVAUNIXLIBDIR=/usr/lib \
	PREFIX=/usr \
	JARPREFIX=/usr/share/java \
	LIBDIR=/usr/lib \
	bin

DBUS_JAVA_INSTALL_OPT := \
	$(CROSS_ENV_CC) \
	PREFIX=/usr \
	LIBDIR=/usr/lib \
	install-bin

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dbus-java.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dbus-java)
	@$(call install_fixup, dbus-java,PRIORITY,optional)
	@$(call install_fixup, dbus-java,SECTION,base)
	@$(call install_fixup, dbus-java,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, dbus-java,DESCRIPTION,"JAVA-DBUS binding")

ifdef PTXCONF_DBUS_JAVA_SCRIPTS
	@$(call install_copy, dbus-java, 0, 0, 0755, -, /usr/bin/CreateInterface)
	@$(call install_copy, dbus-java, 0, 0, 0755, -, /usr/bin/DBusCall)
	@$(call install_copy, dbus-java, 0, 0, 0755, -, /usr/bin/DBusDaemon)
	@$(call install_copy, dbus-java, 0, 0, 0755, -, /usr/bin/DBusViewer)
	@$(call install_copy, dbus-java, 0, 0, 0755, -, /usr/bin/ListDBus)
endif

	@$(call install_copy, dbus-java, 0, 0, 0644, \
		$(DBUS_JAVA_PKGDIR)/usr/share/java/dbus-2.7.jar, \
		/usr/share/java/dbus.jar)

	@$(call install_copy, dbus-java, 0, 0, 0644, \
		$(DBUS_JAVA_PKGDIR)/usr/share/java/dbus-bin-2.7.jar, \
		/usr/share/java/dbus-bin.jar)

	@$(call install_copy, dbus-java, 0, 0, 0644, \
		$(DBUS_JAVA_PKGDIR)/usr/share/java/dbus-viewer-2.7.jar, \
		/usr/share/java/dbus-viewer.jar)

	@$(call install_finish, dbus-java)

	@$(call touch)

# vim: syntax=make

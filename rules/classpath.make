# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_ARM64
PACKAGES-$(PTXCONF_CLASSPATH) += classpath
endif

#
# Paths and names
#
CLASSPATH_VERSION	:= 0.99
CLASSPATH_MD5		:= 0ae1571249172acd82488724a3b8acb4
CLASSPATH		:= classpath-$(CLASSPATH_VERSION)
CLASSPATH_SUFFIX	:= tar.gz
CLASSPATH_URL		:= $(call ptx/mirror, GNU, classpath/$(CLASSPATH).$(CLASSPATH_SUFFIX))
CLASSPATH_SOURCE	:= $(SRCDIR)/$(CLASSPATH).$(CLASSPATH_SUFFIX)
CLASSPATH_DIR		:= $(BUILDDIR)/$(CLASSPATH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CLASSPATH_PATH	:= PATH=$(CROSS_PATH)
CLASSPATH_ENV 	:= \
	$(CROSS_ENV) \
	JAVAC=$(PTXCONF_SETUP_JAVA_SDK)/bin/javac \
	JAVA=jamvm \
	CLASSPATH=$(PTXCONF_SETUP_JAVA_SDK)/jre/lib \
	ac_cv_lib_magic_magic_open=no \
	ac_cv_prog_java_works=yes \
	ac_cv_prog_javac_is_gcj=no

# JAVA must point to the java binary on the target, not on the host
# This is used by the scripts in tools/*

#
# autoconf
#
CLASSPATH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-option-checking \
	--disable-collections \
	--enable-jni \
	--enable-default-preferences-peer=file \
	--disable-gconf-peer \
	--disable-gstreamer-peer \
	--disable-Werror \
	--disable-xmlj \
	--disable-alsa \
	--disable-dssi \
	--disable-gtk-peer \
	--disable-qt-peer \
	--disable-plugin \
	--disable-gmp \
	--disable-gjdoc \
	--enable-regen-headers \
	--enable-regen-gjdoc-parser \
	--disable-tool-wrappers \
	--enable-static \
	--enable-shared \
	--disable-fast-install \
	--enable-libtool-lock \
	--disable-rpath \
	--disable-maintainer-mode \
	--disable-debug \
	--enable-load-library \
	--disable-java-lang-system-explicit-initialization \
	--disable-examples \
	--enable-tools \
	--enable-portable-native-sync \
	--disable-local-sockets \
	--with-gnu-ld \
	--with-pic \
	--without-x \
	--with-glibj=zip \
	--with-gjdoc=no \
	--without-libiconv-prefix

#
# FIXME:
#
# --enable-default-preferences-peer=<gconf|file|memory|FQCN>
# --enable-default-toolkit (?)
#   --with-native-libdir    sets the installation directory for native libraries
#                           default='${libdir}/${PACKAGE}'
#   --with-glibj-dir        sets the installation directory for glibj.zip
#                           default='${libdir}/${PACKAGE}'
#   --with-antlr-jar=file   Use ANTLR from the specified jar file
#   --with-tags[=TAGS]      include additional configurations [automatic]
#   --with-javah            specify path or name of a javah-like program
#   --with-vm-classes       specify path to VM override source files
#   --with-ecj-jar=ABS.PATH specify jar file containing the Eclipse Java
#                           Compiler
#   --with-jar=PATH         define to use a jar style tool
#   --with-jay=DIR|PATH     Regenerate the parsers with jay
#   --with-glibj-zip=ABS.PATH
#                           use prebuilt glibj.zip class library
#   --with-escher=ABS.PATH  specify path to escher dir or JAR for X peers
#

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/classpath.targetinstall:
	@$(call targetinfo)

	@$(call install_init, classpath)
	@$(call install_fixup, classpath,PRIORITY,optional)
	@$(call install_fixup, classpath,SECTION,base)
	@$(call install_fixup, classpath,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, classpath,DESCRIPTION,missing)


	@for i in \
		/usr/bin/grmid \
		/usr/bin/gjavah \
		/usr/bin/gtnameserv \
		/usr/bin/grmiregistry \
		/usr/bin/gjar \
		/usr/bin/gjarsigner \
		/usr/bin/grmic \
		/usr/bin/gnative2ascii \
		/usr/bin/gappletviewer \
		/usr/bin/gkeytool \
		/usr/bin/gserialver \
		/usr/bin/gorbd \
		;do \
		$(call install_copy, classpath, 0, 0, 0755, -, $$i); \
	done

	@$(call install_copy, classpath, 0, 0, 0644, -, /usr/share/classpath/glibj.zip)
	@$(call install_copy, classpath, 0, 0, 0644, -, /usr/share/classpath/tools.zip)

	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavautil)
	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavalangmanagement)
	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavaio)
	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavalang)
	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavanet)
	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavalangreflect)
	@$(call install_lib, classpath, 0, 0, 0644, classpath/libjavanio)

	@$(call install_link, classpath, libjavautil.so.0.0.0, /usr/lib/classpath/libjavautil.so)
	@$(call install_link, classpath, libjavalangmanagement.so.0.0.0, /usr/lib/classpath/libjavalangmanagement.so)
	@$(call install_link, classpath, libjavaio.so.0.0.0, /usr/lib/classpath/libjavaio.so)
	@$(call install_link, classpath, libjavalang.so.0.0.0, /usr/lib/classpath/libjavalang.so)
	@$(call install_link, classpath, libjavanet.so.0.0.0, /usr/lib/classpath/libjavanet.so)
	@$(call install_link, classpath, libjavalangreflect.so.0.0.0, /usr/lib/classpath/libjavalangreflect.so)
	@$(call install_link, classpath, libjavanio.so.0.0.0, /usr/lib/classpath/libjavanio.so)

	@$(call install_copy, classpath, 0, 0, 0644, -, /usr/lib/security/classpath.security)
	@$(call install_copy, classpath, 0, 0, 0644, -, /usr/lib/logging.properties)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, classpath, 0, 0, 0644, \
		/etc/prelink.conf.d/classpath)
endif

	@$(call install_finish, classpath)

	@$(call touch)

# vim: syntax=make

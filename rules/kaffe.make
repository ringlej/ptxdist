# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KAFFE) += kaffe

#
# Paths and names
#
KAFFE_VERSION	:= 1.1.7
KAFFE		:= kaffe-$(KAFFE_VERSION)
KAFFE_SUFFIX	:= tar.bz2
KAFFE_URL	:= ftp://ftp.kaffe.org/pub/kaffe/v1.1.x-development/$(KAFFE).$(KAFFE_SUFFIX)
KAFFE_SOURCE	:= $(SRCDIR)/$(KAFFE).$(KAFFE_SUFFIX)
KAFFE_DIR	:= $(BUILDDIR)/$(KAFFE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KAFFE_SOURCE):
	@$(call targetinfo)
	@$(call get, KAFFE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KAFFE_PATH	:= PATH=$(CROSS_PATH)
KAFFE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
KAFFE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-dssi \
	--disable-gtk-peer \
	--disable-native-awt \
	--disable-xawt-xi18n \
	--disable-esd \
	--disable-alsa \
	--without-esd \
	--without-alsa \
	--disable-sound

ifdef PTXCONF_KAFFE_JAVAC_ECJ
KAFFE_AUTOCONF += --with-ecj
endif

ifdef PTXCONF_KAFFE_JAVAC_JIKES
KAFFE_AUTOCONF += --with-jikes
endif

ifdef PTXCONF_KAFFE_ENGINE_INTERPRETER
KAFFE_AUTOCONF += --with-engine=intrp
endif

ifdef PTXCONF_KAFFE_ENGINE_JIT
KAFFE_AUTOCONF += --with-engine=jit
endif

ifdef PTXCONF_KAFFE_ENGINE_JIT3
KAFFE_AUTOCONF += --with-engine=jit3
endif

ifdef PTXCONF_KAFFE_STATIC
KAFFE_AUTOCONF += --with-staticlib \
		--with-staticbin \
		--with-staticvm
endif

ifdef PTXCONF_KAFFE_DEBUG
	KAFFE_AUTOCONF += --enable-debug
	KAFFE_ENV += CFLAGS=-O0
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kaffe.targetinstall:
	@$(call targetinfo)

	@$(call install_init, kaffe)
	@$(call install_fixup,kaffe,PACKAGE,kaffe)
	@$(call install_fixup,kaffe,PRIORITY,optional)
	@$(call install_fixup,kaffe,VERSION,$(KAFFE_VERSION))
	@$(call install_fixup,kaffe,SECTION,base)
	@$(call install_fixup,kaffe,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,kaffe,DEPENDS,)
	@$(call install_fixup,kaffe,DESCRIPTION,missing)

	@$(call install_copy, kaffe, 0, 0, 0755, -, /usr/jre/bin/java)
	@$(call install_copy, kaffe, 0, 0, 0755, -, /usr/bin/kaffe)
	@$(call install_copy, kaffe, 0, 0, 0755, -, /usr/jre/bin/kaffe-bin)
	@$(call install_copy, kaffe, 0, 0, 0755, -, /usr/jre/bin/rmiregistry)

	@$(call install_copy, kaffe, 0, 0, 0644, -, /usr/jre/lib/security/Kaffe.security)

	@$(call install_copy, kaffe, 0, 0, 0644, -, /usr/jre/lib/glibj.zip)
	@$(call install_copy, kaffe, 0, 0, 0644, -, /usr/jre/lib/gmpjavamath.jar)
	@$(call install_copy, kaffe, 0, 0, 0644, -, /usr/jre/lib/logging.properties)

	@for i in $(KAFFE_PKGDIR)/usr/jre/lib/$(PTXCONF_ARCH_STRING)/*.la; do \
		$(call install_copy, kaffe, 0, 0, 0755, $$i, /usr/jre/lib/$(PTXCONF_ARCH_STRING)/$$(basename $$i)); \
	done

ifndef PTXCONF_KAFFE_STATIC
	@for i in $(KAFFE_PKGDIR)/usr/jre/lib/$(PTXCONF_ARCH_STRING)/*.so; do \
		if [ -h "$$i" ]; then \
			$(call install_link, kaffe, $$(readlink $$i), /usr/jre/lib/$(PTXCONF_ARCH_STRING)/$$(basename $$i)); \
		elif [ -f "$$i" ]; then \
			$(call install_copy, kaffe, 0, 0, 0755, $$i, /usr/jre/lib/$(PTXCONF_ARCH_STRING)/$$(basename $$i)); \
		else \
			echo "unknown file type in $$i. aborting"; \
			exit 1; \
		fi; \
	done
endif

	@$(call install_finish,kaffe)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kaffe_clean:
	rm -rf $(STATEDIR)/kaffe.*
	rm -rf $(PKGDIR)/kaffe_*
	rm -rf $(KAFFE_DIR)

# vim: syntax=make

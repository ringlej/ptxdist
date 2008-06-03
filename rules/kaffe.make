# -*-makefile-*-
# $Id: template 5709 2006-06-09 13:55:00Z mkl $
#
# Copyright (C) 2006 by Sascha Hauer
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

kaffe_get: $(STATEDIR)/kaffe.get

$(STATEDIR)/kaffe.get: $(kaffe_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KAFFE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KAFFE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kaffe_extract: $(STATEDIR)/kaffe.extract

$(STATEDIR)/kaffe.extract: $(kaffe_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KAFFE_DIR))
	@$(call extract, KAFFE)
	@$(call patchin, KAFFE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kaffe_prepare: $(STATEDIR)/kaffe.prepare

KAFFE_PATH	:=  PATH=$(CROSS_PATH)
KAFFE_ENV 	:=  $(CROSS_ENV)

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

$(STATEDIR)/kaffe.prepare: $(kaffe_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KAFFE_DIR)/config.cache)
	cd $(KAFFE_DIR) && \
		$(KAFFE_PATH) $(KAFFE_ENV) \
		./configure $(KAFFE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kaffe_compile: $(STATEDIR)/kaffe.compile

$(STATEDIR)/kaffe.compile: $(kaffe_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(KAFFE_DIR) && $(KAFFE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kaffe_install: $(STATEDIR)/kaffe.install

$(STATEDIR)/kaffe.install: $(kaffe_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, KAFFE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kaffe_targetinstall: $(STATEDIR)/kaffe.targetinstall

$(STATEDIR)/kaffe.targetinstall: $(kaffe_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, kaffe)
	@$(call install_fixup,kaffe,PACKAGE,kaffe)
	@$(call install_fixup,kaffe,PRIORITY,optional)
	@$(call install_fixup,kaffe,VERSION,$(KAFFE_VERSION))
	@$(call install_fixup,kaffe,SECTION,base)
	@$(call install_fixup,kaffe,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,kaffe,DEPENDS,)
	@$(call install_fixup,kaffe,DESCRIPTION,missing)

	# Kaffe builds shared library files on install stage, so
	# install in a temporary directory and install_copy from there
	@cd $(KAFFE_DIR) && $(KAFFE_PATH) make $(KAFFE_ENV) \
		install DESTDIR=$(KAFFE_DIR)-tmp

	@$(call install_copy, kaffe, 0, 0, 0755, $(KAFFE_DIR)-tmp/usr/jre/bin/java, /usr/jre/bin/java)
	@$(call install_copy, kaffe, 0, 0, 0755, $(KAFFE_DIR)-tmp/usr/jre/bin/kaffe, /usr/bin/kaffe)
	@$(call install_copy, kaffe, 0, 0, 0755, $(KAFFE_DIR)-tmp/usr/jre/bin/kaffe-bin, /usr/jre/bin/kaffe-bin)
	@$(call install_copy, kaffe, 0, 0, 0755, $(KAFFE_DIR)-tmp/usr/jre/bin/rmiregistry, /usr/jre/bin/rmiregistry)

	@$(call install_copy, kaffe, 0, 0, 0644, $(KAFFE_DIR)-tmp/usr/jre/lib/security/Kaffe.security, /usr/jre/lib/security/Kaffe.security)

	@$(call install_copy, kaffe, 0, 0, 0644, $(KAFFE_DIR)-tmp/usr/jre/lib/glibj.zip, /usr/jre/lib/glibj.zip)
	@$(call install_copy, kaffe, 0, 0, 0644, $(KAFFE_DIR)-tmp/usr/jre/lib/gmpjavamath.jar, /usr/jre/lib/gmpjavamath.jar)
	@$(call install_copy, kaffe, 0, 0, 0644, $(KAFFE_DIR)-tmp/usr/jre/lib/logging.properties, /usr/jre/lib/logging.properties)

	@for i in $(KAFFE_DIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_STRING)/*.la; do \
		$(call install_copy, kaffe, 0, 0, 0755, $$i, /usr/jre/lib/$(PTXCONF_ARCH_STRING)/$$(basename $$i)); \
	done

ifndef PTXCONF_KAFFE_STATIC
	@for i in $(KAFFE_DIR)-tmp/usr/jre/lib/$(PTXCONF_ARCH_STRING)/*.so; do \
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

	@rm -rf $(KAFFE_DIR)-tmp

	@$(call install_finish,kaffe)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kaffe_clean:
	rm -rf $(STATEDIR)/kaffe.*
	rm -rf $(PKGDIR)/kaffe_*
	rm -rf $(KAFFE_DIR)

# vim: syntax=make

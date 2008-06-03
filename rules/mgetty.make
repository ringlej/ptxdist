# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MGETTY) += mgetty

#
# Paths and names
#
MGETTY_VERSION	= 1.1.30
MGETTY_DATE	= Dec16
MGETTY		= mgetty$(MGETTY_VERSION)
MGETTY_SUFFIX	= tar.gz
MGETTY_URL	= ftp://alpha.greenie.net/pub/mgetty/source/1.1/$(MGETTY)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_SOURCE	= $(SRCDIR)/$(MGETTY)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_DIR	= $(BUILDDIR)/mgetty-$(MGETTY_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mgetty_get: $(STATEDIR)/mgetty.get

$(STATEDIR)/mgetty.get: $(mgetty_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MGETTY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MGETTY)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mgetty_extract: $(STATEDIR)/mgetty.extract

$(STATEDIR)/mgetty.extract: $(mgetty_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MGETTY_DIR))
	@$(call extract, MGETTY)
	@$(call patchin, MGETTY, $(MGETTY_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mgetty_prepare: $(STATEDIR)/mgetty.prepare

MGETTY_PATH	=  PATH=$(CROSS_PATH)
MGETTY_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/mgetty.prepare: $(mgetty_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MGETTY_DIR)/config.cache)
	# FIXME: mgetty doesn't allow DESTDIR/SYSROOT mechanism
	cp $(PTXCONF_MGETTY_CONFIG) $(MGETTY_DIR)/policy.h
	for file in `find $(MGETTY_DIR) -name Makefile`; do \
		sed -i -e "s,^CFLAGS.*=.*,CFLAGS+=-DAUTO_PPP,g" $$file; \
		sed -i -e "s,^CC.*=.*,,g" $$file; \
		sed -i -e "s,^LDFLAGS.*=.*,,g" $$file; \
		sed -i -e "s,^LIBS.*=.*,,g" $$file; \
		sed -i -e "s,^prefix.*=.*,prefix=$(SYSROOT),g" $$file; \
	done
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mgetty_compile: $(STATEDIR)/mgetty.compile

$(STATEDIR)/mgetty.compile: $(mgetty_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MGETTY_DIR) && make mksed
	cd $(MGETTY_DIR) && $(MGETTY_PATH) $(MGETTY_ENV) make \
		bin-all mgetty.config login.config sendfax.config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mgetty_install: $(STATEDIR)/mgetty.install

$(STATEDIR)/mgetty.install: $(mgetty_install_deps_default)
	@$(call targetinfo, $@)
	# don't run make install - there's nothing to install and
	# mgetty's Makefile doesn't work for non-root
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mgetty_targetinstall: $(STATEDIR)/mgetty.targetinstall

$(STATEDIR)/mgetty.targetinstall: $(mgetty_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, mgetty)
	@$(call install_fixup, mgetty,PACKAGE,mgetty)
	@$(call install_fixup, mgetty,PRIORITY,optional)
	@$(call install_fixup, mgetty,VERSION,$(MGETTY_VERSION))
	@$(call install_fixup, mgetty,SECTION,base)
	@$(call install_fixup, mgetty,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mgetty,DEPENDS,)
	@$(call install_fixup, mgetty,DESCRIPTION,missing)

	@$(call install_copy, mgetty, 0, 0, 0700, $(MGETTY_DIR)/mgetty, /usr/sbin/mgetty)

ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, mgetty, 0, 0, 0600, $(MGETTY_DIR)/login.config, /etc/mgetty+sendfax/login.config, n)
	@$(call install_copy, mgetty, 0, 0, 0600, $(MGETTY_DIR)/mgetty.config, /etc/mgetty+sendfax/mgetty.config, n)
	@$(call install_copy, mgetty, 0, 0, 0600, $(MGETTY_DIR)/dialin.config, /etc/mgetty+sendfax/dialin.config, n)
endif
ifdef PTXCONF_MGETTY_CALLBACK
	@$(call install_copy, mgetty, 0, 0, 4755, $(MGETTY_DIR)/callback/callback, /usr/sbin/callback)
endif
ifdef PTXCONF_SENDFAX
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/sendfax, /usr/sbin/sendfax)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/g3/pbm2g3, /usr/bin/pbm2g3)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/g3/g3cat, /usr/bin/g3cat)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/g3/g32pbm, /usr/bin/g32pbm)
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, mgetty, 0, 0, 0644, $(MGETTY_DIR)/sendfax.config, /etc/mgetty+sendfax/sendfax.config, n)
endif
ifdef PTXCONF_SENDFAX_SPOOL
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/fax/faxspool, /usr/bin/faxspool, n)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/fax/faxrunq, /usr/bin/faxrunq, n)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/fax/faxq, /usr/bin/faxq, n)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/fax/faxrm, /usr/bin/faxrm, n)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/fax/faxrunqd, /usr/bin/faxrunqd, n)
	@$(call install_copy, mgetty, 0, 0, 0755, $(MGETTY_DIR)/fax/faxq-helper, /usr/lib/mgetty+sendfax/faxq-helper)
endif
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, mgetty, 0, 0, 0644, $(MGETTY_DIR)/faxrunq.config, /etc/mgetty+sendfax/faxrunq.config, n)
endif
endif
	@$(call install_finish, mgetty)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mgetty_clean:
	rm -rf $(STATEDIR)/mgetty.*
	rm -rf $(PKGDIR)/mgetty_*
	rm -rf $(MGETTY_DIR)

# vim: syntax=make

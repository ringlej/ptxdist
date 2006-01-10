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
MGETTY_URL	= ftp://ftp.leo.org/historic/comp/os/unix/networking/mgetty/$(MGETTY)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_SOURCE	= $(SRCDIR)/$(MGETTY)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_DIR	= $(BUILDDIR)/mgetty-$(MGETTY_VERSION)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mgetty_get: $(STATEDIR)/mgetty.get

mgetty_get_deps = $(MGETTY_SOURCE)

$(STATEDIR)/mgetty.get: $(mgetty_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MGETTY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MGETTY_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mgetty_extract: $(STATEDIR)/mgetty.extract

mgetty_extract_deps = $(STATEDIR)/mgetty.get

$(STATEDIR)/mgetty.extract: $(mgetty_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MGETTY_DIR))
	@$(call extract, $(MGETTY_SOURCE))
	@$(call patchin, $(MGETTY), $(MGETTY_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mgetty_prepare: $(STATEDIR)/mgetty.prepare

#
# dependencies
#
mgetty_prepare_deps = \
	$(STATEDIR)/mgetty.extract \
	$(STATEDIR)/virtual-xchain.install

MGETTY_PATH	=  PATH=$(CROSS_PATH)
MGETTY_ENV 	=  $(CROSS_ENV)
#MGETTY_ENV	+=

$(STATEDIR)/mgetty.prepare: $(mgetty_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MGETTY_DIR)/config.cache)
	cp $(PTXCONF_MGETTY_CONFIG) $(MGETTY_DIR)/policy.h
	find $(MGETTY_DIR) -name Makefile \
		-exec perl -i -p -e 's/^CFLAGS.*=.*/CFLAGS+=-DAUTO_PPP/ ;\
			s/^CC.*=.*// ;\
			s/^LDFLAGS.*=.*// ;\
			s/^LIBS.*=.*// ;\
			s/^prefix.*=.*/prefix=/' {} \;
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mgetty_compile: $(STATEDIR)/mgetty.compile

mgetty_compile_deps = $(STATEDIR)/mgetty.prepare

$(STATEDIR)/mgetty.compile: $(mgetty_compile_deps)
	@$(call targetinfo, $@)
	cd $(MGETTY_DIR) && make mksed
	cd $(MGETTY_DIR) && $(MGETTY_PATH) $(MGETTY_ENV) make \
		bin-all mgetty.config login.config sendfax.config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mgetty_install: $(STATEDIR)/mgetty.install

$(STATEDIR)/mgetty.install: $(STATEDIR)/mgetty.compile
	@$(call targetinfo, $@)
	@$(call install, MGETTY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mgetty_targetinstall: $(STATEDIR)/mgetty.targetinstall

mgetty_targetinstall_deps = $(STATEDIR)/mgetty.compile

$(STATEDIR)/mgetty.targetinstall: $(mgetty_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,mgetty)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(MGETTY_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0700, $(MGETTY_DIR)/mgetty, /usr/sbin/mgetty)
	
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, 0, 0, 0600, $(MGETTY_DIR)/login.config, /etc/mgetty+sendfax/login.config)
	@$(call install_copy, 0, 0, 0600, $(MGETTY_DIR)/mgetty.config, /etc/mgetty+sendfax/mgetty.config)
	@$(call install_copy, 0, 0, 0600, $(MGETTY_DIR)/dialin.config, /etc/mgetty+sendfax/dialin.config)
endif
ifdef PTXCONF_MGETTY_CALLBACK
	@$(call install_copy, 0, 0, 4755, $(MGETTY_DIR)/callback/callback, /usr/sbin/callback)
endif
ifdef PTXCONF_SENDFAX
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/sendfax, /usr/sbin/sendfax)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/g3/pbm2g3, /usr/bin/pbm2g3)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/g3/g3cat, /usr/bin/g3cat)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/g3/g32pbm, /usr/bin/g32pbm)
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, 0, 0, 0644, $(MGETTY_DIR)/sendfax.config, /etc/mgetty+sendfax/sendfax.config)
endif	
ifdef PTXCONF_SENDFAX_SPOOL
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/fax/faxspool, /usr/bin/faxspool)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/fax/faxrunq, /usr/bin/faxrunq)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/fax/faxq, /usr/bin/faxq)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/fax/faxrm, /usr/bin/faxrm)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/fax/faxrunqd, /usr/bin/faxrunqd)
	@$(call install_copy, 0, 0, 0755, $(MGETTY_DIR)/fax/faxq-helper, /usr/lib/mgetty+sendfax/faxq-helper)
endif
ifdef PTXCONF_MGETTY_INSTALL_CONFIG
	@$(call install_copy, 0, 0, 0644, $(MGETTY_DIR)/faxrunq.config, /etc/mgetty+sendfax/faxrunq.config)
endif
endif
	@$(call install_finish)
	
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mgetty_clean:
	rm -rf $(STATEDIR)/mgetty.*
	rm -rf $(IMAGEDIR)/mgetty_*
	rm -rf $(MGETTY_DIR)

# vim: syntax=make

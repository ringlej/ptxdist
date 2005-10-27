# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_BUSYBOX
PACKAGES += busybox
endif

#
# Paths and names
#
BUSYBOX_VERSION		= 1.00
BUSYBOX			= busybox-$(BUSYBOX_VERSION)
BUSYBOX_SUFFIX		= tar.bz2
BUSYBOX_URL		= http://www.busybox.net/downloads/$(BUSYBOX).$(BUSYBOX_SUFFIX)
BUSYBOX_SOURCE		= $(SRCDIR)/$(BUSYBOX).$(BUSYBOX_SUFFIX)
BUSYBOX_DIR		= $(BUILDDIR)/$(BUSYBOX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

busybox_get: $(STATEDIR)/busybox.get

busybox_get_deps = \
	$(BUSYBOX_SOURCE) \
	$(RULESDIR)/busybox.make

$(STATEDIR)/busybox.get: $(busybox_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(BUSYBOX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BUSYBOX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

busybox_extract: $(STATEDIR)/busybox.extract

busybox_extract_deps	=  $(STATEDIR)/busybox.get

$(STATEDIR)/busybox.extract: $(busybox_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BUSYBOX_DIR))
	@$(call extract, $(BUSYBOX_SOURCE))
	@$(call patchin, $(BUSYBOX))

#	# fix: turn off debugging in init.c
	perl -i -p -e 's/^#define DEBUG_INIT/#undef DEBUG_INIT/g' $(BUSYBOX_DIR)/init/init.c

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

busybox_prepare: $(STATEDIR)/busybox.prepare

BUSYBOX_PATH		=  PATH=$(CROSS_PATH)
BUSYBOX_ENV 		=  $(CROSS_ENV)

BUSYBOX_TARGET_LDFLAGS	=  $(call remove_quotes,$(TARGET_LDFLAGS))
ifdef PTXCONF_BB_CONFIG_STATIC                                                                                                        
BUSYBOX_TARGET_LDFLAGS	+= -static
endif                                                                                                                                 

BUSYBOX_MAKEVARS	=  CROSS=$(COMPILER_PREFIX)
BUSYBOX_MAKEVARS	+= HOSTCC=$(HOSTCC) 
BUSYBOX_MAKEVARS	+= EXTRA_CFLAGS='$(call remove_quotes,$(TARGET_CFLAGS))'
BUSYBOX_MAKEVARS	+= LDFLAGS='$(BUSYBOX_TARGET_LDFLAGS)'

#
# dependencies
#
busybox_prepare_deps	=  $(STATEDIR)/virtual-xchain.install
busybox_prepare_deps	+= $(STATEDIR)/virtual-libc.install
busybox_prepare_deps	+= $(STATEDIR)/busybox.extract

$(STATEDIR)/busybox.prepare: $(busybox_prepare_deps)
	@$(call targetinfo, $@)

#	FIXME: is this necessary?
	touch $(BUSYBOX_DIR)/busybox.links

	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) distclean $(BUSYBOX_MAKEVARS)
	grep -e PTXCONF_BB_ $(PTXDISTWORKSPACE)/.config > $(BUSYBOX_DIR)/.config
	perl -i -p -e 's/PTXCONF_BB_//g' $(BUSYBOX_DIR)/.config
	echo GCC_PREFIX=$(COMPILER_PREFIX)
	perl -i -p -e 's/^CROSS_COMPILER_PREFIX=.*$$/CROSS_COMPILER_PREFIX=\"$(COMPILER_PREFIX)\"/g' $(BUSYBOX_DIR)/.config
	yes "" | $(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) oldconfig $(BUSYBOX_MAKEVARS)
	$(BUSYBOX_PATH) make -C $(BUSYBOX_DIR) dep $(BUSYBOX_MAKEVARS)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

busybox_compile: $(STATEDIR)/busybox.compile

busybox_compile_deps =  $(STATEDIR)/busybox.prepare

$(STATEDIR)/busybox.compile: $(busybox_compile_deps)
	@$(call targetinfo, $@)
	cd $(BUSYBOX_DIR) && $(BUSYBOX_PATH) make $(BUSYBOX_MAKEVARS)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

busybox_install: $(STATEDIR)/busybox.install

$(STATEDIR)/busybox.install: $(STATEDIR)/busybox.compile
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

busybox_targetinstall: $(STATEDIR)/busybox.targetinstall

busybox_targetinstall_deps	=  $(STATEDIR)/busybox.compile

$(STATEDIR)/busybox.targetinstall: $(busybox_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,busybox)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(BUSYBOX_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	rm -f $(BUSYBOX_DIR)/busybox.links
	cd $(BUSYBOX_DIR) && $(MAKE) busybox.links

	@$(call install_copy, 0, 0, 1555, $(BUSYBOX_DIR)/busybox, /bin/busybox)
	for file in `cat $(BUSYBOX_DIR)/busybox.links`; do	\
		$(call install_link, /bin/busybox, $$file);	\
	done

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

busybox_clean:
	rm -rf $(STATEDIR)/busybox.*
	rm -rf $(BUSYBOX_DIR)

# vim: syntax=make

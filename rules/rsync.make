# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by wschmitt@envicomp.de
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_RSYNC
PACKAGES += rsync
endif

#
# Paths and names
#
RSYNC_VERSION	= 2.5.7
RSYNC		= rsync-$(RSYNC_VERSION)
RSYNC_SUFFIX	= tar.gz
RSYNC_URL	= http://samba.anu.edu.au/ftp/rsync/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_SOURCE	= $(SRCDIR)/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_DIR	= $(BUILDDIR)/$(RSYNC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rsync_get: $(STATEDIR)/rsync.get

rsync_get_deps	=  $(RSYNC_SOURCE)

$(STATEDIR)/rsync.get: $(rsync_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(RSYNC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(RSYNC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rsync_extract: $(STATEDIR)/rsync.extract

rsync_extract_deps	=  $(STATEDIR)/rsync.get

$(STATEDIR)/rsync.extract: $(rsync_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RSYNC_DIR))
	@$(call extract, $(RSYNC_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rsync_prepare: $(STATEDIR)/rsync.prepare

#
# dependencies
#
rsync_prepare_deps =  \
	$(STATEDIR)/rsync.extract \
	$(STATEDIR)/virtual-xchain.install

RSYNC_PATH	=  PATH=$(CROSS_PATH)
RSYNC_ENV 	=  rsync_cv_HAVE_GETTIMEOFDAY_TZ=yes $(CROSS_ENV)

#
# autoconf
#
RSYNC_AUTOCONF  =  $(CROSS_AUTOCONF)
RSYNC_AUTOCONF	+= --prefix=/usr
RSYNC_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)
RSYNC_AUTOCONF	+= --with-included-popt


$(STATEDIR)/rsync.prepare: $(rsync_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RSYNC_BUILDDIR))
	cd $(RSYNC_DIR) && \
		$(RSYNC_PATH) $(RSYNC_ENV) \
		./configure $(RSYNC_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rsync_compile: $(STATEDIR)/rsync.compile

rsync_compile_deps =  $(STATEDIR)/rsync.prepare

$(STATEDIR)/rsync.compile: $(rsync_compile_deps)
	@$(call targetinfo, $@)
	$(RSYNC_PATH) make -C $(RSYNC_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rsync_install: $(STATEDIR)/rsync.install

$(STATEDIR)/rsync.install: $(STATEDIR)/rsync.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rsync_targetinstall: $(STATEDIR)/rsync.targetinstall

rsync_targetinstall_deps	=  $(STATEDIR)/rsync.compile

$(STATEDIR)/rsync.targetinstall: $(rsync_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr/bin
	install $(RSYNC_DIR)/rsync $(ROOTDIR)/usr/bin/rsync
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/rsync
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rsync_clean:
	rm -rf $(STATEDIR)/rsync.*
	rm -rf $(RSYNC_DIR)

# vim: syntax=make

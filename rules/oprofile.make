# -*-makefile-*-
# $Id: oprofile.make,v 1.1 2003/08/26 13:03:52 bsp Exp $
#
# (c) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_OPROFILE
PACKAGES += oprofile
endif

#
# Paths and names
#
OPROFILE_VERSION	= 0.6
OPROFILE		= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		= tar.gz
OPROFILE_URL		= ftp://ftp.sourceforge.net/pub/sourceforge/oprofile/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_SOURCE		= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		= $(BUILDDIR)/$(OPROFILE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

oprofile_get: $(STATEDIR)/oprofile.get

oprofile_get_deps	=  $(OPROFILE_SOURCE)

$(STATEDIR)/oprofile.get: $(oprofile_get_deps)
	@$(call targetinfo, oprofile.get)
	touch $@

$(OPROFILE_SOURCE):
	@$(call targetinfo, $(OPROFILE_SOURCE))
	@$(call get, $(OPROFILE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

oprofile_extract: $(STATEDIR)/oprofile.extract

oprofile_extract_deps	=  $(STATEDIR)/oprofile.get

$(STATEDIR)/oprofile.extract: $(oprofile_extract_deps)
	@$(call targetinfo, oprofile.extract)
	@$(call clean, $(OPROFILE_DIR))
	@$(call extract, $(OPROFILE_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

oprofile_prepare: $(STATEDIR)/oprofile.prepare

#
# dependencies
#
oprofile_prepare_deps =  \
	$(STATEDIR)/oprofile.extract \
	$(STATEDIR)/popt.install \
	$(STATEDIR)/kernel.prepare \
	$(STATEDIR)/binutils.install

OPROFILE_PATH	=  PATH=$(CROSS_PATH)
OPROFILE_ENV 	=  $(CROSS_ENV)
#OPROFILE_ENV	+=


#
# autoconf
#
OPROFILE_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
OPROFILE_AUTOCONF	+= --build=$(GNU_HOST)
OPROFILE_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

OPROFILE_AUTOCONF	+= --with-linux=$(KERNEL_DIR)

$(STATEDIR)/oprofile.prepare: $(oprofile_prepare_deps)
	@$(call targetinfo, oprofile.prepare)
	@$(call clean, $(OPROFILE_BUILDDIR))
	cd $(OPROFILE_DIR) && \
		$(OPROFILE_PATH) $(OPROFILE_ENV) \
		./configure $(OPROFILE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

oprofile_compile: $(STATEDIR)/oprofile.compile

oprofile_compile_deps =  $(STATEDIR)/oprofile.prepare

$(STATEDIR)/oprofile.compile: $(oprofile_compile_deps)
	@$(call targetinfo, oprofile.compile)
	$(OPROFILE_PATH) $(OPROFILE_ENV) make -C $(OPROFILE_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

oprofile_install: $(STATEDIR)/oprofile.install

$(STATEDIR)/oprofile.install: $(STATEDIR)/oprofile.compile
	@$(call targetinfo, oprofile.install)
	$(OPROFILE_PATH) $(OPROFILE_ENV) make -C $(OPROFILE_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

oprofile_targetinstall: $(STATEDIR)/oprofile.targetinstall

oprofile_targetinstall_deps	=  $(STATEDIR)/oprofile.compile

$(STATEDIR)/oprofile.targetinstall: $(oprofile_targetinstall_deps)
	@$(call targetinfo, oprofile.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

oprofile_clean:
	rm -rf $(STATEDIR)/oprofile.*
	rm -rf $(OPROFILE_DIR)

# vim: syntax=make

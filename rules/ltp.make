# $Id$
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LTP
PACKAGES += ltp
endif

#
# Paths and names
#
LTP_VERSION	= 20050505
LTP		= ltp-full-$(LTP_VERSION)
LTP_SUFFIX	= tgz
LTP_URL		= http://mesh.dl.sourceforge.net/sourceforge/ltp/$(LTP).$(LTP_SUFFIX)
LTP_SOURCE	= $(SRCDIR)/$(LTP).$(LTP_SUFFIX)
LTP_DIR		= $(BUILDDIR)/$(LTP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp_get: $(STATEDIR)/ltp.get

ltp_get_deps = $(LTP_SOURCE)

$(STATEDIR)/ltp.get: $(ltp_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LTP))
	touch $@

$(LTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LTP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp_extract: $(STATEDIR)/ltp.extract

ltp_extract_deps = $(STATEDIR)/ltp.get

$(STATEDIR)/ltp.extract: $(ltp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LTP_DIR))
	@$(call extract, $(LTP_SOURCE))
	@$(call patchin, $(LTP))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp_prepare: $(STATEDIR)/ltp.prepare

#
# dependencies
#
ltp_prepare_deps = \
	$(STATEDIR)/ltp.extract \
	$(STATEDIR)/virtual-xchain.install

LTP_PATH	=  PATH=$(CROSS_PATH)
LTP_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/ltp.prepare: $(ltp_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp_compile: $(STATEDIR)/ltp.compile

ltp_compile_deps = $(STATEDIR)/ltp.prepare

$(STATEDIR)/ltp.compile: $(ltp_compile_deps)
	@$(call targetinfo, $@)

	cd $(LTP_DIR)/lib && $(LTP_ENV) $(LTP_PATH) make

ifdef PTXCONF_LTP_MISC_MATH_ABS
	cd $(LTP_DIR)/testcases/misc/math/abs && $(LTP_ENV) $(LTP_PATH) make
endif
ifdef PTXCONF_LTP_MISC_MATH_ATOF
	cd $(LTP_DIR)/testcases/misc/math/atof && $(LTP_ENV) $(LTP_PATH) make
endif
ifdef PTXCONF_LTP_MISC_MATH_FLOAT
	# FIXME: Generate data on host - right?
	(cd $(LTP_DIR)/testcases/misc/math/float/trigo;		\
		make CC=$(HOST_CC); 				\
		./gentrigo;					\
	)
endif

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp_install: $(STATEDIR)/ltp.install

$(STATEDIR)/ltp.install: $(STATEDIR)/ltp.compile
	@$(call targetinfo, $@)
	cd $(LTP_DIR) && $(LTP_ENV) $(LTP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp_targetinstall: $(STATEDIR)/ltp.targetinstall

ltp_targetinstall_deps = $(STATEDIR)/ltp.compile

$(STATEDIR)/ltp.targetinstall: $(ltp_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ltp)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LTP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(COREUTILS_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp_clean:
	rm -rf $(STATEDIR)/ltp.*
	rm -rf $(IMAGEDIR)/ltp_*
	rm -rf $(LTP_DIR)

# vim: syntax=make

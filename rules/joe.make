# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Oscar Peredo
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JOE) += joe

#
# Paths and names
#
JOE_VERSION	= 3.2
JOE		= joe-$(JOE_VERSION)
JOE_SUFFIX	= tar.gz
JOE_URL		= $(PTXCONF_SETUP_SFMIRROR)/joe-editor/$(JOE).$(JOE_SUFFIX)
JOE_SOURCE	= $(SRCDIR)/$(JOE).$(JOE_SUFFIX)
JOE_DIR		= $(BUILDDIR)/$(JOE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

joe_get: $(STATEDIR)/joe.get

joe_get_deps = $(JOE_SOURCE)

$(STATEDIR)/joe.get: $(joe_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(JOE))
	@$(call touch, $@)

$(JOE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(JOE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

joe_extract: $(STATEDIR)/joe.extract

joe_extract_deps = $(STATEDIR)/joe.get

$(STATEDIR)/joe.extract: $(joe_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(JOE_DIR))
	@$(call extract, $(JOE_SOURCE))
	@$(call patchin, $(JOE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

joe_prepare: $(STATEDIR)/joe.prepare

#
# dependencies
#
joe_prepare_deps =  $(STATEDIR)/joe.extract
joe_prepare_deps += $(STATEDIR)/virtual-xchain.install

JOE_PATH	=  PATH=$(CROSS_PATH)
JOE_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
JOE_AUTOCONF =  $(CROSS_AUTOCONF_USR)
# FIXME
JOE_AUTOCONF += --prefix=/

$(STATEDIR)/joe.prepare: $(joe_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(JOE_DIR)/config.cache)
	cd $(JOE_DIR) && \
		$(JOE_PATH) $(JOE_ENV) \
		./configure $(JOE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

joe_compile: $(STATEDIR)/joe.compile

joe_compile_deps = $(STATEDIR)/joe.prepare

$(STATEDIR)/joe.compile: $(joe_compile_deps)
	@$(call targetinfo, $@)
	cd $(JOE_DIR) && $(JOE_ENV) $(JOE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

joe_install: $(STATEDIR)/joe.install

$(STATEDIR)/joe.install: $(STATEDIR)/joe.compile
	@$(call targetinfo, $@)
	#@$(call install, JOE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

joe_targetinstall: $(STATEDIR)/joe.targetinstall

joe_targetinstall_deps = $(STATEDIR)/joe.compile

$(STATEDIR)/joe.targetinstall: $(joe_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,joe)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(JOE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Oscar Peredo <oscar\@exis.cl>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(JOE_DIR)/joe, /bin/joe)
	@$(call install_copy, 0, 0, 0755, $(JOE_DIR)/termidx, /bin/termidx)
	@$(call install_copy, 0, 0, 0755, /etc/joe) 
	@$(call install_copy, 0, 0, 0644, $(JOE_DIR)/joerc, /etc/joe/joerc,n)
	@$(call install_copy, 0, 0, 0755, /etc/joe/syntax)

	@for file in $(JOE_DIR)/syntax/*.jsf; do \
		destination=`basename $$file`; \
		echo "dst=$$destination"; \
		$(call install_copy, 0, 0, 0644, $$file, /etc/joe/syntax/$$destination, n); \
	done

	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

joe_clean:
	rm -rf $(STATEDIR)/joe.*
	rm -rf $(IMAGEDIR)/joe_*
	rm -rf $(JOE_DIR)

# vim: syntax=make

# -*-makefile-*-
# $Id: ntpclient.make$
#
#
# We provide this package
#
PACKAGES-$(PTXCONF_NTPCLIENT) += ntpclient

#
# Paths and names
#
NTPCLIENT_VERSION	= 2003_194
NTPCLIENT		= ntpclient
NTPCLIENT_SUFFIX	= tar.gz
NTPCLIENT_URL		= http://doolittle.icarus.com/ntpclient/$(NTPCLIENT)_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_SOURCE	= $(SRCDIR)/$(NTPCLIENT)_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_DIR		= $(BUILDDIR)/$(NTPCLIENT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ntpclient_get: $(STATEDIR)/ntpclient.get

$(STATEDIR)/ntpclient.get: $(ntpclient_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NTPCLIENT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NTPCLIENT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ntpclient_extract: $(STATEDIR)/ntpclient.extract

$(STATEDIR)/ntpclient.extract: $(ntpclient_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NTPCLIENT_DIR))
	@$(call extract, NTPCLIENT)
	@$(call patchin, NTPCLIENT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ntpclient_prepare: $(STATEDIR)/ntpclient.prepare

NTPCLIENT_PATH	=  PATH=$(CROSS_PATH)
NTPCLIENT_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/ntpclient.prepare: $(ntpclient_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ntpclient_compile: $(STATEDIR)/ntpclient.compile

$(STATEDIR)/ntpclient.compile: $(ntpclient_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NTPCLIENT_DIR) && $(NTPCLIENT_ENV) $(NTPCLIENT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ntpclient_install: $(STATEDIR)/ntpclient.install

$(STATEDIR)/ntpclient.install: $(ntpclient_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ntpclient_targetinstall: $(STATEDIR)/ntpclient.targetinstall

$(STATEDIR)/ntpclient.targetinstall: $(ntpclient_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call install_init, ntpclient)
	@$(call install_fixup, ntpclient,PACKAGE,ntpclient)
	@$(call install_fixup, ntpclient,PRIORITY,optional)
	@$(call install_fixup, ntpclient,VERSION,$(NTPCLIENT_VERSION))
	@$(call install_fixup, ntpclient,SECTION,base)
	@$(call install_fixup, ntpclient,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ntpclient,DEPENDS,)
	@$(call install_fixup, ntpclient,DESCRIPTION,missing)
	@$(call install_copy, ntpclient, 0, 0, 0755, $(NTPCLIENT_DIR)/ntpclient, /usr/sbin/ntpclient)
	@$(call install_finish, ntpclient)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ntpclient_clean:
	rm -rf $(STATEDIR)/ntpclient.*
	rm -rf $(IMAGEDIR)/ntpclient_*
	rm -rf $(NTPCLIENT_DIR)

# vim: syntax=make

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

ifdef PTXCONF_NTPCLIENT_BUILD_NTPCLIENT
NTPCLIENT_TARGETS += ntpclient
endif
ifdef PTXCONF_NTPCLIENT_BUILD_ADJTIMEX
NTPCLIENT_TARGETS += adjtimex
endif

$(STATEDIR)/ntpclient.compile: $(ntpclient_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NTPCLIENT_DIR) && $(NTPCLIENT_ENV) $(NTPCLIENT_PATH) make $(NTPCLIENT_TARGETS)
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

ifdef PTXCONF_NTPCLIENT_BUILD_NTPCLIENT
	@$(call install_copy, ntpclient, 0, 0, 0755, \
		$(NTPCLIENT_DIR)/ntpclient, /usr/sbin/ntpclient)
endif
ifdef PTXCONF_NTPCLIENT_BUILD_ADJTIMEX
	@$(call install_copy, ntpclient, 0, 0, 0755, \
		$(NTPCLIENT_DIR)/adjtimex, /sbin/adjtimex)
endif

	#
	# busybox init: start script
	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NTPCLIENT_STARTSCRIPT
	@$(call install_alternative, ntpclient, 0, 0, 0755, /etc/init.d/ntpclient, n)
ifneq ($(PTXCONF_NTPCLIENT_NTPSERVER_NAME),"")
	# replace the @HOST@ with name of NTP server
	@$(call install_replace, ntpclient, /etc/init.d/ntpclient, \
		@HOST@, \
		"$(PTXCONF_NTPCLIENT_NTPSERVER_NAME)" )
endif
endif
endif

	@$(call install_finish, ntpclient)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ntpclient_clean:
	rm -rf $(STATEDIR)/ntpclient.*
	rm -rf $(PKGDIR)/ntpclient_*
	rm -rf $(NTPCLIENT_DIR)

# vim: syntax=make

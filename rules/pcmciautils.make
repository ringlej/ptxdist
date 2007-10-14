# $Id: template 2680 2005-05-27 10:29:43Z rsc $
#
# Copyright (C) 2005 by Steven Scholz <steven.scholz@imc-berlin.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PCMCIAUTILS) += pcmciautils

#
# Paths and names
#
PCMCIAUTILS_VERSION	= 006
PCMCIAUTILS		= pcmciautils-$(PCMCIAUTILS_VERSION)
PCMCIAUTILS_SUFFIX	= tar.gz
PCMCIAUTILS_URL		= http://www.kernel.org/pub/linux/utils/kernel/pcmcia/$(PCMCIAUTILS).$(PCMCIAUTILS_SUFFIX)
PCMCIAUTILS_SOURCE	= $(SRCDIR)/$(PCMCIAUTILS).$(PCMCIAUTILS_SUFFIX)
PCMCIAUTILS_DIR		= $(BUILDDIR)/$(PCMCIAUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pcmciautils_get: $(STATEDIR)/pcmciautils.get

$(STATEDIR)/pcmciautils.get: $(pcmciautils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PCMCIAUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PCMCIAUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pcmciautils_extract: $(STATEDIR)/pcmciautils.extract

$(STATEDIR)/pcmciautils.extract: $(pcmciautils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PCMCIAUTILS_DIR))
	@$(call extract, PCMCIAUTILS)
	@$(call patchin, PCMCIAUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pcmciautils_prepare: $(STATEDIR)/pcmciautils.prepare

PCMCIAUTILS_PATH	=  PATH=$(CROSS_PATH)
PCMCIAUTILS_ENV 	=  $(CROSS_ENV)

# Get the latest revision of pcmciautils.
# If you have a static socket, open the file "Makefile" with an editor of your
# choice and modify the line which states STARTUP = true to STARTUP = false.
# see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/howto.html

PCMCIAUTILS_MAKEVARS :=  ARCH=$(PTXCONF_ARCH) \
	prefix=$(SYSROOT) \
	CROSS=$(COMPILER_PREFIX) \
	GCCINCDIR=$(SYSROOT)/usr/include

#PCMCIAUTILS_MAKEVARS	+= KERNEL_DIR=$(PTXCONF_KERNEL_DIR)

$(STATEDIR)/pcmciautils.prepare: $(pcmciautils_prepare_deps_default)
	@$(call targetinfo, $@)
ifndef PTXCONF_PCMCIAUTILS_STARTUP
	@perl -p -i -e 's/STARTUP = true/STARTUP = false/' $(PCMCIAUTILS_DIR)/Makefile
endif
	@perl -p -i -e 's/V=false/V=true/' $(PCMCIAUTILS_DIR)/Makefile
	#@$(call clean, $(PCMCIAUTILS_DIR)/config.cache)
	#cd $(PCMCIAUTILS_DIR) && \
	#	$(PCMCIAUTILS_PATH) $(PCMCIAUTILS_ENV) \
	#	./configure $(PCMCIAUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pcmciautils_compile: $(STATEDIR)/pcmciautils.compile

$(STATEDIR)/pcmciautils.compile: $(pcmciautils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PCMCIAUTILS_DIR) && $(PCMCIAUTILS_ENV) $(PCMCIAUTILS_PATH) make $(PCMCIAUTILS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pcmciautils_install: $(STATEDIR)/pcmciautils.install

$(STATEDIR)/pcmciautils.install: $(pcmciautils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pcmciautils_targetinstall: $(STATEDIR)/pcmciautils.targetinstall

$(STATEDIR)/pcmciautils.targetinstall: $(pcmciautils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pcmciautils)
	@$(call install_fixup, pcmciautils,PACKAGE,pcmciautils)
	@$(call install_fixup, pcmciautils,PRIORITY,optional)
	@$(call install_fixup, pcmciautils,VERSION,$(PCMCIAUTILS_VERSION))
	@$(call install_fixup, pcmciautils,SECTION,base)
	@$(call install_fixup, pcmciautils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, pcmciautils,DEPENDS,)
	@$(call install_fixup, pcmciautils,DESCRIPTION,missing)

	# install-tools
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/pccardctl, /sbin/pccardctl);
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/pcmcia-check-broken-cis, \
				/sbin/pcmcia-check-broken-cis);

	# install-hotplug
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/hotplug/pcmcia.agent, \
				/etc/hotplug/pcmcia.agent, n);
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/hotplug/pcmcia.rc, \
				/etc/hotplug/pcmcia.rc, n);

ifdef PTXCONF_PCMCIAUTILS_STARTUP
	# if STARTUP is disabled, we can skip a few things

	# install-config
	#$(INSTALL) -d $(DESTDIR)$(pcmciaconfdir)
	#$(INSTALL_DATA)  -D config/config.opts $(DESTDIR)$(pcmciaconfdir)/config.opts

	# install-socket-hotplug
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/hotplug/pcmcia_socket.agent, \
				/etc/hotplug/pcmcia_socket.agent, n);
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/hotplug/pcmcia_socket.rc, \
				/etc/hotplug/pcmcia_socket.rc, n);

	# install-socket-tools
	@$(call install_copy, pcmciautils, 0, 0, 0755, $(PCMCIAUTILS_DIR)/pcmcia-socket-startup, \
				/sbin/pcmcia-socket-startup);
endif

	@$(call install_finish, pcmciautils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pcmciautils_clean:
	rm -rf $(STATEDIR)/pcmciautils.*
	rm -rf $(IMAGEDIR)/pcmciautils_*
	rm -rf $(PCMCIAUTILS_DIR)

# vim: syntax=make

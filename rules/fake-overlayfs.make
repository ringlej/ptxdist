# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAKE_OVERLAYFS) += fake-overlayfs

# dummy version for xpkg
FAKE_OVERLAYFS_VERSION	:= 1.0

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/fake-overlayfs.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/fake-overlayfs.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/fake-overlayfs.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/fake-overlayfs.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fake-overlayfs.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_FAKE_OVERLAYFS_VAR
FAKE_OVERLAYFS_BASE_DIRS += /var
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_RUN
FAKE_OVERLAYFS_BASE_DIRS += /var/run
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_LIB
FAKE_OVERLAYFS_BASE_DIRS += /var/lib
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_TMP
FAKE_OVERLAYFS_BASE_DIRS += /var/tmp
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_CACHE
FAKE_OVERLAYFS_BASE_DIRS += /var/cache
endif

FAKE_OVERLAYFS_DIRS = $(call remove_quotes, $(PTXCONF_FAKE_OVERLAYFS_OTHER)):$(subst $(space),:,$(FAKE_OVERLAYFS_BASE_DIRS))


$(STATEDIR)/fake-overlayfs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fake-overlayfs)
	@$(call install_fixup,fake-overlayfs,PACKAGE,fake-overlayfs)
	@$(call install_fixup,fake-overlayfs,PRIORITY,optional)
	@$(call install_fixup,fake-overlayfs,VERSION,$(FAKE_OVERLAYFS_VERSION))
	@$(call install_fixup,fake-overlayfs,SECTION,base)
	@$(call install_fixup,fake-overlayfs,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,fake-overlayfs,DEPENDS,)
	@$(call install_fixup,fake-overlayfs,DESCRIPTION,missing)

	@$(call install_alternative, fake-overlayfs, 0, 0, 0755, \
		/etc/init.d/fake-overlayfs)
	@$(call install_replace, fake-overlayfs, /etc/init.d/fake-overlayfs, \
		@OVERLAY_DIRLIST@, $(FAKE_OVERLAYFS_DIRS))

	@$(call install_finish,fake-overlayfs)

	@$(call touch)

# vim: syntax=make

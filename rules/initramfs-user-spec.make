# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITRAMFS_USER_SPEC) += initramfs-user-spec

#
# Dummy to keep ipkg happy
#
INITRAMFS_USER_SPEC_VERSION	:= $(INITRAMFS_TOOLS_VERSION)

ifdef PTXCONF_INITRAMFS_USER_SPEC
$(STATEDIR)/klibc.targetinstall.post: $(STATEDIR)/initramfs-user-spec.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-user-spec.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-user-spec.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-user-spec.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-user-spec.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------
#

$(STATEDIR)/initramfs-user-spec.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-user-spec.targetinstall: $(STATEDIR)/klibc.targetinstall
	@$(call targetinfo)
#
# adding user specific files to the list last
# Note: files without a leading '/' get a prefix path of $(PTXDIST_WORKSPACE)/initramfs
#
	cat $(PTXDIST_WORKSPACE)/initramfs_spec | while read type target source rest; do	\
		if [ "$$type" == "file" ]; then							\
			if [ "$$(echo "$$source" | grep "^/")" == "" ]; then			\
				source=$(PTXDIST_WORKSPACE)/initramfs/$$source;			\
			fi;									\
		fi;										\
		echo "$$type $$target $$source $$rest" >> $(INITRAMFS_CONTROL);			\
	done

	@$(call touch)

# vim: syntax=make

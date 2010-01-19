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
PACKAGES-$(PTXCONF_KLIBC_USER_SPEC) += klibc-user-spec

#
# Dummy to keep ipkg happy
#
KLIBC_USER_SPEC_VERSION	:= $(KLIBC_VERSION)

ifdef PTXCONF_KLIBC_USER_SPEC
$(STATEDIR)/klibc.targetinstall.post: $(STATEDIR)/klibc-user-spec.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-user-spec.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-user-spec.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-user-spec.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-user-spec.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------
#

$(STATEDIR)/klibc-user-spec.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-user-spec.targetinstall: $(STATEDIR)/klibc.targetinstall
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
		echo "$$type $$target $$source $$rest" >> $(KLIBC_CONTROL);			\
	done

	@$(call touch)

# vim: syntax=make

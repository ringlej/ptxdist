# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BASE_PKGS) += base-pkgs

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/base-pkgs.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/base-pkgs.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/base-pkgs.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/base-pkgs.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/base-pkgs.install:
	@$(call targetinfo)
	@echo -e \
		"copying 'root', 'root-debug' from\n" \
		"'$(PTXDIST_BASE_PLATFORMDIR)'\n"
	@tar -c --exclude="./dev/*" \
		-C "$(PTXDIST_BASE_PLATFORMDIR)/root" . | \
		tar -x -C "$(ROOTDIR)" && \
		check_pipe_status
	@tar -c -C "$(PTXDIST_BASE_PLATFORMDIR)/root-debug" . | \
		tar -x --exclude="./dev/*" \
		-C "$(ROOTDIR_DEBUG)" && \
		check_pipe_status
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/base-pkgs.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

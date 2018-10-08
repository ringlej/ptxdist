# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/get-alternative = $(shell ptxd_get_alternative $(1) $(2) && echo $$ptxd_reply)
ptx/get_alternative = $(error ptx/get_alternative has been renamed to ptx/get-alternative)

#
# This must produce the same results as ptxd_in_path()
# Fallback to the shell implementation for the complex case
#
# Strip whitespaces introduced by the multiline macros
define ptx/in-path3
$(if $(strip $(1)),$(strip $(2)),$(strip $(3)))
endef
# fallback to shell if a relative path is found
define ptx/in-path2
$(call ptx/in-path3,
$(filter-out /%,$(3)),
$(shell p='$($(strip $(1)))' ptxd_in_path p $(2) && echo $$ptxd_reply),
$(firstword $(wildcard $(addsuffix /$(strip $(2)),$(3)))))
endef
# create a path ist from the variable with ':' separated paths
define ptx/in-path
$(call ptx/in-path2,$(1),$(2),$(subst :,$(ptx/def/space),$($(strip $(1)))))
endef

#
# This must produce the same results as ptxd_in_platformconfigdir()
#
# Strip whitespaces introduced by the multiline macro
define ptx/in-platformconfigdir2
$(or $(strip $(1)),$(or $(strip $(2)),$(strip $(3))))
endef
# absolute path / first existing path / path in PTXDIST_PLATFORMCONFIGDIR
define ptx/in-platformconfigdir
$(call ptx/in-platformconfigdir2,
$(filter /%,$(strip $(1))),
$(call ptx/in-path,PTXDIST_PATH_PLATFORMCONFIGDIR,$(1)),
$(PTXDIST_PLATFORMCONFIGDIR)/$(strip $(1)))
endef

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2002-2008 by The PTXdist Team - See CREDITS for Details
#

# make sure bash is used to execute commands from makefiles
SHELL=bash
export SHELL

# ----------------------------------------------------------------------------
# Some directory locations
# ----------------------------------------------------------------------------

include $(PTXDIST_TOPDIR)/scripts/ptxdist_vars.sh
include $(RULESDIR)/other/Definitions.make

# first, include the ptxconfig with packet definitions
-include $(PTXCONFIG)

# platformconfig comes after ptxconfig, so it is able to overwrite things
-include $(PLATFORMCONFIG)

# ----------------------------------------------------------------------------
# Include all rule files
# ----------------------------------------------------------------------------

all:
	@echo "ptxdist: error: please use ptxdist instead of calling make directly."
	@exit 1

include $(RULESDIR)/other/Namespace.make
include $(wildcard $(PRERULESDIR)/*.make)

ifneq ($(wildcard $(PROJECTPRERULESDIR)/*.make),)
include $(wildcard $(PROJECTPRERULESDIR)/*.make)
endif

include $(PACKAGE_DEP_PRE)
include $(RULESFILES_ALL_MAKE)
include $(PACKAGE_DEP_POST)

include $(PTX_MAP_ALL_MAKE)

PACKAGES		:= $(PACKAGES-y)	$(PACKAGES-m)
CROSS_PACKAGES		:= $(CROSS_PACKAGES-y)
HOST_PACKAGES		:= $(HOST_PACKAGES-y)

ALL_PACKAGES		:= \
	$(PACKAGES-)		$(PACKAGES-y)		$(PACKAGES-m) \
	$(CROSS_PACKAGES-)	$(CROSS_PACKAGES-y) \
	$(HOST_PACKAGES-)	$(HOST_PACKAGES) 

SELECTED_PACKAGES	:= \
	$(PACKAGES-y)		$(PACKAGES-m) \
	$(CROSS_PACKAGES-y) \
	$(HOST_PACKAGES-y)

ifneq ($(wildcard $(POSTRULESDIR)/*.make),)
include $(wildcard $(POSTRULESDIR)/*.make)
endif


# ----------------------------------------------------------------------------
# Misc other targets
# ----------------------------------------------------------------------------

print-%:
	@echo "$* is \"$($*)\""

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

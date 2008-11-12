# -*-makefile-*-
#
# Copyright (C) 2002-2008 by The PTXdist Team - See CREDITS for Details
#

# make sure bash is used to execute commands from makefiles
SHELL=bash
export SHELL

all:
	@echo "ptxdist: error: please use 'ptxdist' instead of calling make directly."
	@exit 1

# ----------------------------------------------------------------------------
# Some directory locations
# ----------------------------------------------------------------------------

include $(PTXDIST_TOPDIR)/scripts/ptxdist_vars.sh
include $(RULESDIR)/other/Definitions.make

-include $(PTXDIST_PTXCONFIG)
-include $(PTXDIST_PLATFORMCONFIG)

ifdef PTXDIST_PACKAGES_COLLECTION
include $(PTXDIST_PACKAGES_COLLECTION)
endif

# ----------------------------------------------------------------------------
# Include all rule files
# ----------------------------------------------------------------------------

include $(RULESDIR)/other/Namespace.make
include $(wildcard $(PRERULESDIR)/*.make)

ifneq ($(wildcard $(PROJECTPRERULESDIR)/*.make),)
include $(wildcard $(PROJECTPRERULESDIR)/*.make)
endif

#include $(PTX_DGEN_DEPS_PRE)
include $(PTX_DGEN_RULESFILES_MAKE)
include $(PTX_DGEN_DEPS_POST)

include $(PTX_MAP_ALL_MAKE)

#
# the extended format is:
# PACKAGES-<ARCH>-<LABEL>
#
# to keep it simple, just add the "-y-y" to "-y"
# (for "-m" and "--" accordingly)
#
PACKAGES-y	+= $(PACKAGES-y-y)
PACKAGES-m	+= $(PACKAGES-y-m)
PACKAGES-	+= $(PACKAGES-y-) $(PACKAGES--y) $(PACKAGES--m) $(PACKAGES--)

PACKAGES		:= $(PACKAGES-y)	$(PACKAGES-m)
PACKAGES_ALL		:= $(PACKAGES)
PACKAGES_BASE		:= $(PACKAGES-y)
CROSS_PACKAGES		:= $(CROSS_PACKAGES-y)	$(CROSS_PACKAGES-y-y)
HOST_PACKAGES		:= $(HOST_PACKAGES-y)	$(HOST_PACKAGES-y-y)

ALL_PACKAGES		:= \
	$(PACKAGES-)		$(PACKAGES-y)		$(PACKAGES-m) \
	$(CROSS_PACKAGES-)	$(CROSS_PACKAGES-y) \
	$(HOST_PACKAGES-)	$(HOST_PACKAGES-y) 

PACKAGES_SELECTED	:= \
	$(PACKAGES-y)		$(PACKAGES-m) \
	$(CROSS_PACKAGES-y) \
	$(HOST_PACKAGES-y)

ifneq ($(wildcard $(POSTRULESDIR)/*.make),)
include $(wildcard $(POSTRULESDIR)/*.make)
endif

ifneq ($(wildcard $(PROJECTPOSTRULESDIR)/*.make),)
include $(wildcard $(PROJECTPOSTRULESDIR)/*.make)
endif

# ----------------------------------------------------------------------------
# just the "print" target
# ----------------------------------------------------------------------------

print-%:
	@echo "$* is \"$($(*))\""

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

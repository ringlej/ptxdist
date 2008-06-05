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

#
# the extended format is:
# PACKAGES-<ARCH>-<LABEL>
#
# to keep it simple, just add the "-y-y" to "-y"
# (for "-m" and "-" accordingly)
#
PACKAGES-y	+= $(PACKAGES-y-y)
PACKAGES-m	+= $(PACKAGES-y-m)
PACKAGES-	+= $(PACKAGES-y-) $(PACKAGES--y) $(PACKAGES--m) $(PACKAGES--)

PACKAGES		:= $(PACKAGES-y)	$(PACKAGES-m)
CROSS_PACKAGES		:= $(CROSS_PACKAGES-y)	$(CROSS_PACKAGES-y-y)
HOST_PACKAGES		:= $(HOST_PACKAGES-y)	$(HOST_PACKAGES-y-y)

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

ifneq ($(wildcard $(PROJECTPOSTRULESDIR)/*.make),)
include $(wildcard $(PROJECTPOSTRULESDIR)/*.make)
endif

# ----------------------------------------------------------------------------
# Misc other targets
# ----------------------------------------------------------------------------

print-%:
	@echo "$* is \"$($(*))\""

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

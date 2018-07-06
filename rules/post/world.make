# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

DEP_OUTPUT	:= $(STATEDIR)/depend.out

### --- internal ---

# --- world ---
WORLD_PACKAGES_TARGET 	:= $(addprefix $(STATEDIR)/,$(addsuffix .targetinstall.post,$(PACKAGES)))
WORLD_PACKAGES_HOST	:= $(addprefix $(STATEDIR)/,$(addsuffix .install.post,$(HOST_PACKAGES)))
WORLD_PACKAGES_CROSS	:= $(addprefix $(STATEDIR)/,$(addsuffix .install.post,$(CROSS_PACKAGES)))

$(STATEDIR)/world.targetinstall: \
	$(WORLD_PACKAGES_TARGET) \
	$(WORLD_PACKAGES_HOST) \
	$(WORLD_PACKAGES_CROSS)
	@echo $(notdir $@) : $(notdir $^) >> $(DEP_OUTPUT)
	@$(call touch)

ifdef PTXCONF_ALLYES
WORLD_PACKAGES_LAZY	:= $(addprefix $(STATEDIR)/,$(addsuffix .install.post,$(LAZY_PACKAGES)))
$(STATEDIR)/world.targetinstall: $(WORLD_PACKAGES_LAZY)
endif

PHONY += world
world: $(STATEDIR)/world.targetinstall



### --- dependency graph generation ---

WORLD_DEP_TREE_PS	:= $(PTXDIST_PLATFORMDIR)/deptree.ps
WORLD_DEP_TREE_A4_PS	:= $(PTXDIST_PLATFORMDIR)/deptree-a4.ps

ifdef PTXCONF_SETUP_GEN_DEP_TREE
ifneq ($(shell which dot 2>/dev/null),)
world: $(WORLD_DEP_TREE_PS)
    ifneq ($(shell which poster 2>/dev/null),)
world: $(WORLD_DEP_TREE_A4_PS)
    endif
endif
endif

$(DEP_OUTPUT):
	@$(call touch)

$(WORLD_DEP_TREE_A4_PS): $(WORLD_DEP_TREE_PS)
	@echo "creating A4 version..."
	@poster -v -c 0\% -m A4 -o $@ $< > /dev/null 2>&1

$(WORLD_DEP_TREE_PS): $(DEP_OUTPUT) $(STATEDIR)/world.targetinstall
	@echo "creating dependency graph..."
	@sort $< | uniq | \
		$(SCRIPTSDIR)/makedeptree | dot -Tps > $@

# vim: syntax=make

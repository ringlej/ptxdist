# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
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
WORLD_PACKAGES_HOST	:= $(addprefix $(STATEDIR)/,$(addsuffix .install,$(HOST_PACKAGES)))
WORLD_PACKAGES_CROSS	:= $(addprefix $(STATEDIR)/,$(addsuffix .install,$(CROSS_PACKAGES)))

$(STATEDIR)/world.targetinstall: \
	$(WORLD_PACKAGES_TARGET) \
	$(WORLD_PACKAGES_HOST) \
	$(WORLD_PACKAGES_CROSS)
	@echo $@ : $^ | sed  -e 's:[^ ]*/\([^ ]\):\1:g' >> $(DEP_OUTPUT)
	@$(call touch)

world: $(STATEDIR)/world.targetinstall



### --- dependency graph generation ---

WORLD_DEP_TREE_PS	:= $(PTXDIST_PLATFORMDIR)/deptree.ps
WORLD_DEP_TREE_A4_PS	:= $(PTXDIST_PLATFORMDIR)/deptree-a4.ps

ifneq ($(shell which dot 2>/dev/null),)
world: $(WORLD_DEP_TREE_PS)
    ifneq ($(shell which poster 2>/dev/null),)
world: $(WORLD_DEP_TREE_A4_PS)
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



### --- for CROSS packages only ---

$(STATEDIR)/cross-%.prepare:
	@$(call targetinfo)
	$(call world/prepare/host, $(PTX_MAP_TO_PACKAGE_cross-$(*)))
	@$(call touch)

$(STATEDIR)/cross-%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_cross-$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_cross-$(*)), $(CROSS_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_cross-$(*)), $($(PTX_MAP_TO_PACKAGE_cross-$(*))_DIR))
	@$(call touch)

$(STATEDIR)/cross-%.install:
	@$(call targetinfo)
	@$(call install, $(PTX_MAP_TO_PACKAGE_cross-$(*)),,h)
	@$(call touch)



### --- for HOST packages only ---

$(STATEDIR)/host-%.prepare:
	@$(call targetinfo)
	$(call world/prepare/host, $(PTX_MAP_TO_PACKAGE_host-$(*)))
	@$(call touch)

$(STATEDIR)/host-%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_host-$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_host-$(*)), $(HOST_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_host-$(*)), $($(PTX_MAP_TO_PACKAGE_host-$(*))_DIR))
	@$(call touch)

$(STATEDIR)/host-%.install:
	@$(call targetinfo)
	@$(call install, $(PTX_MAP_TO_PACKAGE_host-$(*)),,h)
	@$(call touch)



### --- for target packages only ---

$(STATEDIR)/%.prepare:
	@$(call targetinfo)
	$(call world/prepare/target, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.install:
	@$(call targetinfo)
	@$(call install, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)



# --- for all pacakges ---

$(STATEDIR)/%.get:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_$(*)), $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call touch)

$(STATEDIR)/%.compile:
	@$(call targetinfo)
	$(call world/compile/simple, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.targetinstall.post:
	@$(call targetinfo)
	@$(call touch)


# vim600:set foldmethod=marker:
# vim600:set syntax=make:

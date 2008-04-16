# -*-makefile-*-

DEP_OUTPUT	:= $(STATEDIR)/depend.out

### --- internal ---

WORLD_DEP_TREE_PS	:= $(PTXDIST_PLATFORMDIR)/deptree.ps
WORLD_DEP_TREE_A4_PS	:= $(PTXDIST_PLATFORMDIR)/deptree-a4.ps

WORLD_PACKAGES_TARGETINSTALL 	:= $(addprefix $(STATEDIR)/,$(addsuffix .targetinstall.post,$(PACKAGES)))
WORLD_HOST_PACKAGES_INSTALL	:= $(addprefix $(STATEDIR)/,$(addsuffix .install,$(HOST_PACKAGES)))
WORLD_CROSS_PACKAGES_INSTALL	:= $(addprefix $(STATEDIR)/,$(addsuffix .install,$(CROSS_PACKAGES)))



### --- dependency graph generation ---

ifneq ($(shell which dot),)
world: $(WORLD_DEP_TREE_PS)
   ifneq ($(shell which poster),)
world: $(WORLD_DEP_TREE_A4_PS)
   endif #ifneq ($(shell which poster),)
endif #ifneq ($(shell which dot),)

$(DEP_OUTPUT):
	@$(call touch, $@)

$(WORLD_DEP_TREE_A4_PS): $(WORLD_DEP_TREE_PS)
	@echo "creating A4 version..."
	@poster -v -c 0\% -m A4 -o $@ $< > /dev/null 2>&1

$(WORLD_DEP_TREE_PS): $(DEP_OUTPUT)
	@echo "creating dependency graph..."
	@sort $< | uniq | \
		$(SCRIPTSDIR)/makedeptree | dot -Tps > $@

### --- world ---

$(STATEDIR)/%.get:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_PACKAGE_$(*))_DIR))
	@$(call extract, $(PTX_MAP_PACKAGE_$(*)))
	@$(call patchin, $(PTX_MAP_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.prepare:
	@$(call targetinfo)
	@$(call clean, $($($(PTX_MAP_PACKAGE_$(*))_DIR)/config.cache))
	$(call world/prepare/simple, $(PTX_MAP_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.compile:
	@$(call targetinfo)
	$(call world/compile/simple, $(PTX_MAP_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.install:
	@$(call targetinfo)
	@$(call install, $(PTX_MAP_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.targetinstall.post:
	@$(call targetinfo)
	@$(call touch)


$(STATEDIR)/world.targetinstall: $(WORLD_PACKAGES_TARGETINSTALL) \
	$(WORLD_HOST_PACKAGES_INSTALL) \
	$(WORLD_CROSS_PACKAGES_INSTALL)
	@echo $@ : $^ | sed  -e 's:[^ ]*/\([^ ]\):\1:g' >> $(DEP_OUTPUT)
	@$(call touch, $@)

world: $(STATEDIR)/world.targetinstall

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

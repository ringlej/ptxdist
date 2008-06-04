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

WORLD_DEP_TREE_PS		:= $(PTXDIST_PLATFORMDIR)/deptree.ps
WORLD_DEP_TREE_A4_PS		:= $(PTXDIST_PLATFORMDIR)/deptree-a4.ps

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

$(WORLD_DEP_TREE_PS): $(DEP_OUTPUT) $(STATEDIR)/world.targetinstall
	@echo "creating dependency graph..."
	@sort $< | uniq | \
		$(SCRIPTSDIR)/makedeptree | dot -Tps > $@


# --- variable definitions ---

$(STATEDIR)/%.prepare:			package=$(*)
$(STATEDIR)/%.install:			package=$(*)

$(STATEDIR)/cross-%.extract:		package=cross-$(*)
$(STATEDIR)/cross-%.prepare:		package=cross-$(*)
$(STATEDIR)/cross-%.install:		package=cross-$(*)

$(STATEDIR)/host-%.extract:		package=host-$(*)
$(STATEDIR)/host-%.prepare:		package=host-$(*)
$(STATEDIR)/host-%.install:		package=host-$(*)

$(STATEDIR)/%.get:			package=$(*)
$(STATEDIR)/%.extract:			package=$(*)
$(STATEDIR)/%.compile:			package=$(*)
$(STATEDIR)/%.targetinstall.post:	package=$(*)

$(STATEDIR)/%.get:			PACKAGE=$(PTX_MAP_TO_PACKAGE_$(package))
$(STATEDIR)/%.extract:			PACKAGE=$(PTX_MAP_TO_PACKAGE_$(package))
$(STATEDIR)/%.prepare:			PACKAGE=$(PTX_MAP_TO_PACKAGE_$(package))
$(STATEDIR)/%.compile:			PACKAGE=$(PTX_MAP_TO_PACKAGE_$(package))
$(STATEDIR)/%.install:			PACKAGE=$(PTX_MAP_TO_PACKAGE_$(package))
$(STATEDIR)/%.targetinstall.post:	PACKAGE=$(PTX_MAP_TO_PACKAGE_$(package))



### --- for CROSS packages only ---

$(STATEDIR)/cross-%.prepare:
	@$(call targetinfo)
	$(call world/prepare/host, $(PACKAGE))
	@$(call touch)


$(STATEDIR)/cross-%.install:
	@$(call targetinfo)
	@$(call install, $(PACKAGE),,h)
	@$(call touch)



### --- for HOST packages only ---

$(STATEDIR)/host-%.prepare:
	@$(call targetinfo)
	$(call world/prepare/host, $(PACKAGE))
	@$(call touch)


$(STATEDIR)/host-%.install:
	@$(call targetinfo)
	@$(call install, $(PACKAGE),,h)
	@$(call touch)



### --- for target packages only ---

$(STATEDIR)/%.prepare:
	@$(call targetinfo)
	$(call world/prepare/target, $(PACKAGE))
	@$(call touch)

$(STATEDIR)/%.install:
	@$(call targetinfo)
	@$(call install, $(PACKAGE))
	@$(call touch)



# --- for all pacakges ---

$(STATEDIR)/%.get:
	@$(call targetinfo)
	@$(call touch)


$(STATEDIR)/%.extract:			PACKAGE_BUILDDIR=$(BUILDDIR)
$(STATEDIR)/host-%.extract:		PACKAGE_BUILDDIR=$(HOST_BUILDDIR)
$(STATEDIR)/cross-%.extract:		PACKAGE_BUILDDIR=$(CROSS_BUILDDIR)

$(STATEDIR)/%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PACKAGE)_DIR))
	@$(call extract, $(PACKAGE), $(PACKAGE_BUILDDIR))
	@$(call patchin, $(PACKAGE), $($(PACKAGE)_DIR))
	@$(call touch)

$(STATEDIR)/%.compile:
	@$(call targetinfo)
	$(call world/compile/simple, $(PACKAGE))
	@$(call touch)

$(STATEDIR)/%.targetinstall.post:
	@$(call targetinfo)
	@$(call touch)


# --- world ---

$(STATEDIR)/world.targetinstall: $(WORLD_PACKAGES_TARGETINSTALL) \
	$(WORLD_HOST_PACKAGES_INSTALL) \
	$(WORLD_CROSS_PACKAGES_INSTALL)
	@echo $@ : $^ | sed  -e 's:[^ ]*/\([^ ]\):\1:g' >> $(DEP_OUTPUT)
	@$(call touch, $@)

world: $(STATEDIR)/world.targetinstall

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

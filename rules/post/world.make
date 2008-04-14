# -*-makefile-*-

DEP_OUTPUT	:= $(PTXDIST_PLATFORMDIR)/depend.out
DEP_TREE_PS	:= $(PTXDIST_PLATFORMDIR)/deptree.ps
DEP_TREE_A4_PS	:= $(PTXDIST_PLATFORMDIR)/deptree-a4.ps

WORLD_PACKAGES_TARGETINSTALL 	:= $(addsuffix _targetinstall,$(PACKAGES))
WORLD_HOST_PACKAGES_INSTALL	:= $(addsuffix _install,$(HOST_PACKAGES))
WORLD_CROSS_PACKAGES_INSTALL	:= $(addsuffix _install,$(CROSS_PACKAGES))

ifneq ($(shell which dot),)
world: $(DEP_TREE_PS)
   ifneq ($(shell which poster),)
world: $(DEP_TREE_A4_PS)
   endif #ifneq ($(shell which poster),)
endif #ifneq ($(shell which dot),)

$(DEP_TREE_A4_PS): $(DEP_TREE_PS)
	@echo "creating A4 version..."
	@poster -v -c 0\% -m A4 -o $@ $<

$(DEP_TREE_PS): $(DEP_OUTPUT)
	@echo "creating dependency graph..."
	@sort $< | uniq | \
		$(PTXDIST_TOPDIR)/scripts/makedeptree | dot -Tps > $@

world_packages: $(WORLD_PACKAGES_TARGETINSTALL) \
	$(WORLD_HOST_PACKAGES_INSTALL) \
	$(WORLD_CROSS_PACKAGES_INSTALL)
	@echo $@ : $^ | sed  -e 's/\([^ ]*\)_\([^_]*\)/\1.\2/g' >> $(DEP_OUTPUT)

world: world_packages

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

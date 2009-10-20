
autogen_dep = $(strip $(wildcard						\
	$(PROJECTPATCHDIR)/$(strip $(1))/generic/autogen.sh			\
	$(PROJECTPATCHDIR)/$(strip $(1))/autogen.sh				\
	$(PTXDIST_PLATFORMCONFIGDIR)/patches/$(strip $(1))/generic/autogen.sh	\
	$(PTXDIST_PLATFORMCONFIGDIR)/patches/$(strip $(1))/autogen.sh		\
	$(PATCHDIR)/$(strip $(1))/generic/autogen.sh				\
	$(PATCHDIR)/$(strip $(1))/autogen.sh))

$(STATEDIR)/autogen-tools:
	@$(call targetinfo)
	@$(call touch)


# vim: syntax=make

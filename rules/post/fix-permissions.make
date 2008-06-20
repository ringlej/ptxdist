# -*-makefile-*-

### --- internal ---

PTX_FIXPERM_RUN    := $(STATEDIR)/fix-$(PTXDIST_PACKAGES_COLLECTION)-permissions.run

ifdef PTXCONF_FIX_PERMISSIONS
world: $(PTX_FIXPERM_RUN)
endif

$(PTX_FIXPERM_RUN): $(PTX_PERMISSIONS) $(STATEDIR)/world.targetinstall
	@$(call targetinfo)
	@echo;										\
	echo;										\
	echo;										\
	echo;										\
	echo;										\
	echo;										\
	echo "creating devnodes, for the smooth nfsroot feeling" >&2;			\
	echo;										\
	echo;										\
	echo;										\
	echo;										\
	echo;										\
	echo;										\
	read -t 5 -p "(press enter to let sudo to that job)";				\
	if test $$? -eq 0; then								\
		for dir in "$(ROOTDIR)" "$(ROOTDIR_DEBUG)"; do				\
			sudo $(SCRIPTSDIR)/fix-permissions.sh -r "$${dir}" -p "$<";	\
			$(CHECK_PIPE_STATUS)						\
		done;									\
		$(call touch);								\
	else										\
		echo;									\
		echo "watch out for missing initial consoles...";			\
		echo;									\
	fi


# vim: syntax=make

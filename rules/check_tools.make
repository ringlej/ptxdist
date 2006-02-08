# -*-makefile-*-

check_tools_deps =  check_dirs
check_tools_deps += $(STATEDIR)/host-pkg-config-wrapper.install
ifdef $(PTXCONF_IMAGE_IPKG)
check_tools_deps += $(STATEDIR)/host-ipkg-utils.install
endif

check_tools: $(check_tools_deps)

	@echo "running check_tools..."
	
#	# check if some programs are available
	$(call check_prog_exists, sed)
	$(call check_prog_exists, awk)
	$(call check_prog_exists, perl)
	$(call check_prog_exists, wget)
	$(call check_prog_exists, pkg-config)
	
#	# check if some programs are installed in the right version
	$(call check_prog_version, wget, -V, 1\\\\.(9|1.?)\\\\.|1\\\\.9\\\\+cvs)

#	# check if we have a toplevel ptxconfig file
	$(call check_file_exists, $(PTXDIST_WORKSPACE)/ptxconfig)

#	# check if we have a project rules dir
	@if ! [ -d "$(PROJECTRULESDIR)" ]; then								\
		echo; 											\
		echo "You need a rules/ directory in your workspace. If your PTXdist project ";	\
		echo "is called 'foo' your projectdir is usually local_projects/foo, and I ";		\
		echo "expect your PROJECTRULESDIR to be local_projects/foo/rules."; 			\
		echo "check if this project does exist.";						\
		echo;											\
		exit 1; 										\
	fi

	

# -*-makefile-*-
check_tools: check_dirs

	@echo "running check_tools..."
	
#	# check if some programs are available
	$(call check_prog_exists, sed)
	$(call check_prog_exists, awk)
	$(call check_prog_exists, perl)
	$(call check_prog_exists, wget)
	
#	# check if some programs are installed in the right version
	$(call check_prog_version, wget, -V, 1\\\\.(9|1.?)\\\\.|1\\\\.9\\\\+cvs)

#	# check if we have a toplevel .config file
	$(call check_file_exists, $(PTXDIST_WORKSPACE)/.config)

#	# check if we have a project dir
	@if [ -z "$(PROJECTDIR)" ]; then								\
		echo; 											\
		echo "PROJECTDIR is empty. This usually means that you have"; 				\
		echo "set PTXCONF_PROJECT, but there is no .ptxconfig file "; 				\
		echo "in projects/some-project/\$$PTXCONF_PROJECT.ptxconfig.";				\
		echo "Please copy your .config file to that location."; 				\
		echo; 											\
		echo "Example: projects/foo/foo4711.ptxconfig if \$$PTXCONF_PROJECT is foo4711"; 	\
		echo; 											\
		exit 1; 										\
	fi

#	# check if we have a project rules dir
	@if ! [ -d "$(PROJECTRULESDIR)" ]; then								\
		echo; 											\
		echo "You need a rules/ directory in your PROJECTDIR. If your PTXdist project ";	\
		echo "is called 'foo' your projectdir is usually local_projects/foo, and I ";		\
		echo "expect your PROJECTRULESDIR to be local_projects/foo/rules."; 			\
		echo "check if this project does exist.";						\
		echo;											\
		exit 1; 										\
	fi

	

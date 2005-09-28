# -*-makefile-*-
check_tools:
	
	# create some directories
	mkdir -p $(BUILDDIR)
	mkdir -p $(STATEDIR)
	mkdir -p $(ROOTDIR)

	# check if some programs are available
	$(call check_prog_exists, sed)
	$(call check_prog_exists, awk)
	$(call check_prog_exists, perl)
	$(call check_prog_exists, wget)
	
	# check if some programs are installed in the right version
	$(call check_prog_version, wget, -V, 1\\\\.(9|1.?)\\\\.|1\\\\.9\\\\+cvs)

	# check if we have a toplevel .config file
	$(call check_file_exists, $(PTXDISTWORKSPACE)/.config)

	# check if we have a project dir
	@if [ -z "$(PROJECTDIR)" ]; then									\
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

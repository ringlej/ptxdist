check_tools:
	# check if some programs are available
	$(call check_prog_exists, sed)
	$(call check_prog_exists, awk)
	$(call check_prog_exists, perl)
	$(call check_prog_exists, wget)
	
	# check if some programs are installed in the right version
	$(call check_prog_version, wget, "1.9.1")

	# check if we have a toplevel .config file
	$(call check_file_exists, $(TOPDIR)/.config)

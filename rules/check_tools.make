check_tools:
	# check available
	$(call check_prog_exists, sed)
	$(call check_prog_exists, awk)
	$(call check_prog_exists, perl)
	$(call check_prog_exists, wget)
	
	# check version
	$(call check_prog_version, wget, "1.9.1")
# -*-makefile-*-
check_dirs:
	
	@echo "running check_dirs..."

#	# create some directories
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(CROSS_BUILDDIR)
	@mkdir -p $(HOST_BUILDDIR)
	@mkdir -p $(IMAGEDIR)
	@mkdir -p $(ROOTDIR)
	@mkdir -p $(STATEDIR)


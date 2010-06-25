# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# generate the list of source permission files
#
PERMISSION_FILES := $(foreach pkg, $(PACKAGES), $(wildcard $(STATEDIR)/$(pkg)*.perms))
ifdef PTXDIST_PROD_PLATFORMDIR
PERMISSION_FILES += $(wildcard $(PTXDIST_PROD_PLATFORMDIR)/state/*.perms)
endif

#
# list of all ipkgs being selected for the root image
# UGLY: Just these files have '_' substituted to '-'; the permission files above have NOT.
#	Consistency would be nicer, but when fixing, change for side-effects carefully!
IPKG_FILES := $(foreach pkg, $(PACKAGES), $(wildcard $(PKGDIR)/$(subst _,-,$(pkg))*.ipk))

ifdef PTXDIST_PROD_PLATFORMDIR
IPKG_FILES += $(wildcard $(PTXDIST_PROD_PLATFORMDIR)/packages/*.ipk)
endif

#
# create one file with all permissions from all permission source files
#
PHONY += $(image/permissions)
$(image/permissions): $(PERMISSION_FILES)
	@cat $^ > $@

#
# to extract the ipkgs we need a dummy config file
#
$(IMAGEDIR)/ipkg.conf:
	@echo -e "dest root /\narch $(PTXDIST_IPKG_ARCH_STRING) 10\narch all 1\narch noarch 1\n" > $@

#
# extract all current ipkgs into the working directory
#
PHONY += $(STATEDIR)/image_working_dir
$(STATEDIR)/image_working_dir: $(IPKG_FILES) $(image/permissions) $(IMAGEDIR)/ipkg.conf
	@rm -rf $(image/work_dir)
	@mkdir $(image/work_dir)
	@echo -n "Extracting ipkg packages into working directory..."
	@DESTDIR=$(image/work_dir) $(FAKEROOT) -- $(PTXCONF_SYSROOT_HOST)/bin/ipkg-cl -f $(IMAGEDIR)/ipkg.conf -o $(image/work_dir) install $(IPKG_FILES) 2>&1 >/dev/null
	@$(call touch, $@)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

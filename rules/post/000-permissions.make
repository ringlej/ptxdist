# -*-makefile-*-

PTX_PERMISSIONS := $(STATEDIR)/permissions

### --- internal ---

#
# FIXME: doesn't work on first run
#
#PTX_PERMISSIONS_FILES = $(foreach pkg,$(PACKAGES-y),$(wildcard $(STATEDIR)/$(pkg)*.perms))

#
# create one file with all permissions from all permission source files
#
$(PTX_PERMISSIONS): $(STATEDIR)/world.targetinstall
	@{								\
	if [ -n "$(PTXDIST_PROD_PLATFORMDIR)" ]; then			\
		cat $(PTXDIST_PROD_PLATFORMDIR)/state/*.perms;		\
	fi;								\
	cat $(STATEDIR)/*.perms;					\
	} > $@

# vim600:set foldmethod=marker:
# vim600:set syntax=make:

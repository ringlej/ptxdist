# -*-makefile-*-
PASSIVEFTP	= --passive-ftp
SUDO		= sudo
PTXUSER		= $(shell echo $$USER)
GNU_HOST	= $(shell uname -m)-linux
HOSTCC		= gcc
CROSSSTRIP	= $(PTXCONF_PREFIX)/bin/$(PTXCONF_GNU_TARGET)-strip
DOT		= dot
DEP_OUTPUT	= depend.out
DEP_TREE_PS	= deptree.ps

#
# some convenience functions
#

# FIXME: missing

targetinfo=echo ; \
echo `echo target: $(1) |sed -e "s/./-/g"` ; \
echo target: $(1) ; \
echo `echo target: $(1) |sed -e "s/./-/g"` ; \
echo ; \
echo $@ : $^ | sed -e "s@$(TOPDIR)@@g" -e "s@/src/@@g" -e "s@/state/@@g" >> $(DEP_OUTPUT)



# vim: syntax=make

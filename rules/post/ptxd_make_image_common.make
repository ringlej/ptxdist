# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

DOPERMISSIONS := '{	\
	if ($$1 == "f")	\
		printf("chmod %s \".%s\"; chown %s.%s \".%s\";\n", $$5, $$2, $$3, $$4, $$2);	\
	if ($$1 == "n")	\
		printf("mkdir -p \".`dirname \"%s\"`\"; mknod -m %s \".%s\" %s %s %s; chown %s.%s \".%s\";\n", $$2, $$5, $$2, $$6, $$7, $$8, $$3, $$4, $$2);}'

image/env = \
	$(call ptx/env) \
	PTXCONF_IPKG_IPKG_CONF_URL="$(call ptx/escape,$(call remove_quotes,$(PTXCONF_IPKG_IPKG_CONF_URL)))" \
	image_pkgs_selected_target="$(call ptx/escape,$(PACKAGES))" \
	\
	image_work_dir="$(call ptx/escape,$(image/work_dir))" \
	image_permissions="$(call ptx/escape,$(image/permissions))"

# vim: syntax=make

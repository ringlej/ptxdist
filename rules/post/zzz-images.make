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
# create all requested images and clean up when done
#
PHONY += images
images: world $(SEL_ROOTFS-y)
	@echo "Clean up temp working directory"
	@rm -rf \
		$(IMAGEDIR)/ipkg.conf \
		$(image/permissions) \
		$(STATEDIR)/image_working_dir \
		$(image/work_dir)

#
# trick to supress the message:
# "make: Nothing to be done for `images_world'."
#
PHONY += images_world_dep
images_world_dep:
	@true

images_world: $(STATEDIR)/world.targetinstall images_world_dep

# vim: syntax=make

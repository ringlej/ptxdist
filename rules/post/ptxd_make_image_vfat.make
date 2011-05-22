# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# image/vfat
#
# - $1	the image file name
# - $2	the image file size in bytes. Guessed if undefined.
# - $3	file with $src:$dst mappings for the image content
#
image/vfat = \
	$(call ptx/env) \
	image_vfat_file="$(1)" \
	image_vfat_size="$(2)" \
	image_vfat_map="$(3)" \
	ptxd_make_image_vfat

$(IMAGEDIR)/%.vfat: $(IMAGEDIR)/%.vfat.map
	@echo -n "Creating `basename $@` ..."
	@$(call image/vfat,$@,$($*_VFAT_SIZE),$<)
	@echo "done."

# vim: syntax=make

# -*-makefile-*-
#
# Copyright (C) 2011 by the Philippe Corbes <philippe.corbes@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_VDI)		+= $(IMAGEDIR)/hd.vdi

#
# image/vdi
#
# - $1	the .img image file name
# - $2	the .vdi image file name
#
image/vdi = \
	$(call image/env) \
	image_vdi_img="$(1)" \
	image_vdi_vdi="$(2)" \
	ptxd_make_image_vdi

$(IMAGEDIR)/%.vdi: $(IMAGEDIR)/%.img
	@echo "Creating `basename $@` ..."
	@$(call image/vdi,$<,$@)
	@echo "done."

# vim: syntax=make

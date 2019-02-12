.. _multi_image_platform:

Supporting Multiple Device Variants in one Platform
---------------------------------------------------

Many projects have to deal with more than just one hardware and software
configuration. There may be multiple hardware generations or variants with
different hardware and software features.

To simplify maintenance, it can be desirable to handle all variants in one
PTXdist platform. This can be achieved by creating new image rules for each
supported variant.

Providing a Bootloader for each Variant
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

What needs to be done here depends on the hardware and which bootloader is
used. For example, for **barebox** on i.MX6, images for all variants can be
generate from one build tree. In this case the default **barebox** packages
is sufficient.

If different builds are needed, then a new bootloader package for each
variant can be created. For **barebox** PTXdist provides a template to
simplify this. For other bootloaders more work is needed to create the
package rules manually. See :ref:`adding_new_packages` for more details one
how to create a new package.

.. note:: PTXdist looks in ``patches/$(<PKG>)`` for the patches. Symlinks
  can be uses to share the patch stack across multiple bootloader packages.

.. _multi_image_individual_root_filesystems:

Creating Individual Root-Filesystems for each Variant
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For each variant, a rootfs image can be created.  The ``image-genimage``
template for new packages can be used to create these images. See
:ref:`image_packages` for more details.

In this case, the important part is the ``<PKG>_PKGS`` variable.

There are two ways to mange the package list for the image:

1. Creating the package list manually

   Manually create the package list by listing package names or using **make**
   macros to manipulate the default package list ``$(PTX_PACKAGES_INSTALL)``.

   To add a single custom package, extra packages can be uses. An extra package
   is not added to ``$(PTX_PACKAGES_INSTALL)``. It is created by modifying the
   package rule like this:

   .. code-block:: make

     EXTRA_PACKAGES-$(PTXCONF_BOARD_A_EXTRA) += board-a-extra

   The resulting package is then added explicitly to on image:

   .. code-block:: make

     IMAGE_ROOT_BOARD_A_PKGS := $(PTX_PACKAGES_INSTALL) board-a-extra

   This is not recommended for larger changes to the packages list. Is is easy
   to break dependencies this way.

2. Use a collection config to create the package list

   To prepare for this, all packages that are not part of _all_ variants
   must be set 'M' in menuconfig.

   Then a new collection for the variant is created:

   .. code-block:: text

     $ touch configs/collectionconfig-board-a
     $ ptxdist ----collectionconfig=configs/collectionconfig-board-a menuconfig collection

   All extra packages for this variant are selected here. Then the
   collection config is configured for the image:

   .. code-block:: make

     IMAGE_ROOT_BOARD_A_PKGS := $(call ptx/collection, $(PTXDIST_WORKSPACE)/configs/collectionconfig-board-a)

   With a collection PTXdist will take care of all dependencies. This makes
   it easy to manage multiple root filesystems with significantly different
   package lists.

Putting it all Together
~~~~~~~~~~~~~~~~~~~~~~~

The final steps are highly hardware dependent. In some cases a bootloader
image and a rootfs are all that is needed.

To boot from SD-Card a disk image including bootloader, partition table and
rootfs is needed. The ``image-genimage`` template can be uses again to
create such an image for each variant.

.. note:: The genimage config files in ``config/images/`` are good examles
   when writing genimage for the new images.

Creating a Root Filesystem Image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After we have built the root filesystem content, we can make an image,
which can be flashed to the target system or copied on some kind of disk
media. To do so, we just run

::

    $ ptxdist images

PTXdist now extracts the content of priorly created *\*.ipk* packages to
a temporary directory and generates an image out of it. PTXdist supports
following image types:

- **hd.img:** contains bootloader, kernel and root files in an ext2
  partition. Mostly used for X86 target systems.

- **root.jffs2:** root files inside a jffs2 filesystem.

- **uRamdisk:** a u-boot loadable Ramdisk

- **initrd.gz:** a traditional initrd RAM disk to be used as initrdramfs
  by the kernel

- **root.ext2:** root files inside an ext2 filesystem.

- **root.squashfs:** root files inside a squashfs filesystem.

- **root.tgz:** root files inside a plain gzip compressed tar ball.

All these files can be found in ``|ptxdistPlatformDir|/images`` if enabled.

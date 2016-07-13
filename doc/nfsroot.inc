.. _nfsroot:

Using a userland NFS Server for the Target
------------------------------------------

To improve the development of software for a target system, it is very exhausting
changing files or settings at the target itself.

Or trying the application under development on the target again and again to see
if a feature works or a GUI looks nicer now or is more handy to control on a
small touchscreen display.

Using the *Network File System* (NFS) can improve the development speed by grades
in this case. Everything filesystem related is still happening on the development
host and each modification can be used at the target immediately.

Using PTXdist's built-in NFS Userland Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist can export the BSP's root filesystem by itself. Since a userspace
tool running as a regular user cannot open network ports below 1024, it uses
a different network port. The default is port **2049**. To make use of this
PTXdist feature, run inside the BSP at your development host:

::

    $ ptxdist nfsroot
    [...]
    Mount rootfs with nfsroot=/root,v3,tcp,port=2049,mountport=2049

At the target side a slighly different configuration must be used to work with
the userspace NFS server PTXdist provides instead of a regular kernel space
NFS server the Linux kernel provides. When starting PTXdist's ``nfsroot`` feature
it outputs the special command line we need to instruct the Linux kernel to
use this userland NFS server for its root filesystem to boot its userland from.

What is still to be considered here is the network confiuration. Refer the
kernel documentation about the capabilities of the ``ip=`` kernel command line
option and check, if we need to setup a special IP address at the target side
to reach the host running PTXdist and its *nfsroot* feature.

If we need a special IP address to setup, the kernel command line parameter to
use PTXdist's *nfsroot* feature, the parameter looks like this:

::

    nfsroot=<host-ip>:/root,v3,tcp,port=2049,mountport=2049

In the case we must replace the ``<host-ip>`` part of the line above with the
IP address of our host running PTXdist's *nfsroot* feature.

If we run a recent Barebox bootloader with *bootspec* support, booting a target
via network only is very easy. In the Barebox prompt just enter:

::

    barebox@target:/ boot nfs://<host-ip>:2049//root

In this case Barebox will mount the defined root filesysem via NFS, loads the
included bootspec file, read its information and continues to load the matching
kernel and maybe a matching device tree.

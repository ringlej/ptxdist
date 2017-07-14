Frequently Asked Questions (FAQ)
--------------------------------

Q: PTXdist does not support to generate some files in a way I need them. What can I do?
A: Everything PTXdist builds is controlled by “package rule files”,
which in fact are Makefiles (``rules/*.make``). If you modify such a
file you can change it’s behaviour in a way you need. It is generally
no good idea to modify the generic package rule files installed by
PTXdist, but it is always possible to copy one of them over into the
``rules/`` directory of a project. Package rule files in the project
will precede global rule files with the same name.

Q: My kernel build fails. But I cannot detect the correct position,
due to parallel building. How can I stop PTXdist to build in parallel?
A: Force PTXdist to stop building in parallel which looks somehow
like:

::

    $ ptxdist -j1 go

Q: I made my own rule file and now I get error messages like

::

    my_project/rules/test.make:30: *** unterminated call to function `call': missing `)'.  Stop.

But line 30 only contains ``@$(call targetinfo, $@)`` and it seems all
right. What does it mean?
A: Yes, this error message is confusing. But it usually only means
that you should check the following (!) lines for missing backslashes
(line separators).

Q: I got a message similar to “package <some name> is empty. not
generating.” What does it mean?
A: The ’ipkg’ tool was advised to generate a new ipkg-packet, but the
folder was empty. Sometime it means a typo in the package name when
the ``install_copy`` macro was called. Ensure all these macros are using
the same package name. Or did you disable a menuentry and now nothing
will be installed?

Q: How do I download all required packages at once?
A: Run this command prior the build:

::

    $ ptxdist make get

This starts to download all required packages in one run. It does
nothing if the archives are already present in the source path. (run
“PTXdist setup” first).

Q: I want to backup the source archives my PTXdist project relys on.
How can I find out what packages my project requires to build?
A: First build your PTXdist project completely and then run the
following command:

::

    $ ptxdist export_src <archive directory>

It copies all archives from where are your source archives stored to
<archive directory> which can be your backup media.

Q: To avoid building the OSELAS toolchain on each development host, I
copied it to another machine. But on this machine I cannot build any
BSP with this toolchain correctly. All applications on the target are
failing to start due to missing libraries.
A: This happens when the toolchain was copied without regarding to
retain links. There are archive programs around that convert links
into real files. When you are using such programs to create a
toolchain archive this toolchain will be broken after extracting it
again. Solution: Use archive programs that retain links as they are
(tar for example). Here an example for a broken toolchain:

::

    $ ll `find . -name "libcrypt*"`
    -rwxr-xr-x 1 mkl ptx 55K 2007-07-25 14:54 ./lib/libcrypt-2.5.so*
    -rwxr-xr-x 1 mkl ptx 55K 2007-07-25 14:54 ./lib/libcrypt.so.1*
    -rw-r--r-- 1 mkl ptx 63K 2007-07-25 14:54 ./usr/lib/libcrypt.a
    -rw-r--r-- 1 mkl ptx 64K 2007-07-25 14:54 ./usr/lib/libcrypt_p.a
    -rwxr-xr-x 1 mkl ptx 55K 2007-07-25 14:54 ./usr/lib/libcrypt.so*

And in contrast, this one is intact:

::

    $ ll `find . -name "libcrypt*"`
    -rwxr-xr-x 1 mkl ptx 55K 2007-11-03 13:30 ./lib/libcrypt-2.5.so*
    lrwxrwxrwx 1 mkl ptx  15 2008-02-20 14:52 ./lib/libcrypt.so.1 -> libcrypt-2.5.so*
    -rw-r--r-- 1 mkl ptx 63K 2007-11-03 13:30 ./usr/lib/libcrypt.a
    -rw-r--r-- 1 mkl ptx 64K 2007-11-03 13:30 ./usr/lib/libcrypt_p.a
    lrwxrwxrwx 1 mkl ptx  23 2008-02-20 14:52 ./usr/lib/libcrypt.so -> ../../lib/libcrypt.so.1*

Q: I followed the instructions how to integrate my own plain source
project into PTXdist. But when I try to build it, I get:

::

    extract: archive=/path/to/my/sources
    extract: dest=/path/to/my/project/build-target
    Unknown format, cannot extract!

But the path exists!
A: PTXdist interprets a ``file://`` (two slashes) in the URL as a
project related relative path. So it searches only in the current
project for the given path. Only ``file:///`` (three slashes) will
force PTXdist to use the path as an absolute one. This means:
``file://bla/blub`` will be used as ``./bla/blub`` and
``file:///friesel/frasel`` as ``/friesel/frasel``.

Q: I want to use more than one kernel revision in my BSP. How can I
avoid maintaining one ptxconfig per kernel?
A: One solution could be to include the kernel revision into the name
of the kernel config file. Instead of the default kernelconfig.target
name you should use ``kernelconfig-<revision>.target``. In the kernel
config file menu entry you should enter
``kernelconfig-$PTXCONF_KERNEL_VERSION.target``. Whenever you change
the linux kernel Version menu entry now, this will ensure using a
different kernel config file, too.

Q: I’m trying to use a JAVA based package in PTXdist. But compiling
fails badly. Does it ever work at Pengutronix?
A: This kind of packages only build correctly when an original SUN VM
SDK is used. Run PTXdist setup and point the Java SDK menu entry to
the installation path of your SUN JAVA SDK.

Q: I made a new project and everythings seems fine. But when I start my
target with the root filesystem generated by PTXdist, it fails with:

::

    cannot run '/etc/init.d/rcS': No such file or directory

A: The error message is confusing. But this script needs ``/bin/sh`` to
run. Most of the time this message occures when ``/bin/sh`` does not
exists. Did you enable it in your busybox configuration?

Q: I have created a path for my source archives and try to make PTXdist
use it. But whenever I run PTXdist now it fails with the following error
message:

::

    /usr/local/bin/ptxdist: archives: command not found

A: In this case the path was ``$HOME/source archives`` which includes a
whitespace in the name of the directory to store the source archives in.
Handling directory or filenames with whitespaces in applications isn’t
trivial and also PTXdist suffers all over the place from this issue. The
only solution is to avoid whitespaces in paths and filenames.

Q: I have adapted my own rule file’s targetinstall stage, but PTXdist
does not install the files. A: Check if the closing ``@$(call
install_finish, [...])`` is present at the end of the targetinsall stage.
If not, PTXdist will not complete this stage.

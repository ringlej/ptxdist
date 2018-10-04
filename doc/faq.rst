Frequently Asked Questions (FAQ)
--------------------------------

PTXdist does not support to generate some files in a way I need them. What can I do?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Answer:
  Everything PTXdist builds is controlled by “package rule files”,
  which in fact are Makefiles (``rules/*.make``). If you modify such a
  file you can change its behaviour in a way you need. It is generally
  not a good idea to modify the generic package rule files installed by
  PTXdist, but it is always possible to copy one of them over into the
  ``rules/`` directory of your project. Package rule files in the project
  will precede global rule files with the same name.

  Read the section :ref:`ptx_dev_manual` in the Developer’s Manual to get
  more information.

How can I stop PTXdist to build in parallel?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  My build fails, but I cannot detect the correct position due to parallel
  building.

Answer:
  Force PTXdist to stop building in parallel which looks somehow like::

      $ ptxdist -j1 go

I get errors like “unterminated call to function 'call': missing ')'”
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  I made my own rule file and now I get error messages like::

      my_project/rules/test.make:30: *** unterminated call to function `call': missing `)'.  Stop.

  But line 30 only contains ``@$(call targetinfo, $@)`` and it seems all
  right. What does it mean?

Answer:
  Yes, this error message is confusing. But it usually only means
  that you should check the following (!) lines for missing backslashes
  (line continuation).

I got a message similar to “package <name> is empty. not generating.” What does it mean?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Answer:
  The ``ipkg`` tool was advised to generate a new ipkg archive, but the
  folder was empty. Sometimes this is just a typo in the package name when
  the ``install_copy`` macro was called. Ensure all these macros are using
  the same package name. Or did you disable a menu entry and now nothing
  is installed?

How do I download all required packages at once?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Answer:
  Run this command prior the build::

      $ ptxdist make get

  This starts to download all required packages in one run. It does
  nothing if the archives are already present in the source path. Run
  ``ptxdist setup`` first to set up the desired source folder.

I want to backup all source archives for my BSP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  I want to backup the source archives my PTXdist project relies on.
  How can I find out what packages my project requires to build?

Answer:
  First build your PTXdist project completely and then run the
  following command::

      $ ptxdist export_src <archive directory>

  It copies all archives from where are your source archives stored to
  the path ``<archive directory>`` which can be on your backup media.

OSELAS toolchain fails to start due to missing libraries
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  To avoid building the OSELAS toolchain on each development host, I
  copied it to another machine. But on this machine I cannot build any
  BSP with this toolchain correctly. All applications on the target are
  failing to start due to missing libraries.

Answer:
  This happens when the toolchain was copied without regard to
  retaining symlinks. There are archive programs around that convert links
  into real files. When you are using such programs to create a
  toolchain archive this toolchain will be broken after extracting it
  again.
  
  Solution: Use archive programs that retain symlinks as they are
  (tar for example). Here is an example of a broken toolchain::

      $ ll `find . -name "libcrypt*"`
      -rwxr-xr-x 1 mkl ptx 55K 2007-07-25 14:54 ./lib/libcrypt-2.5.so*
      -rwxr-xr-x 1 mkl ptx 55K 2007-07-25 14:54 ./lib/libcrypt.so.1*
      -rw-r--r-- 1 mkl ptx 63K 2007-07-25 14:54 ./usr/lib/libcrypt.a
      -rw-r--r-- 1 mkl ptx 64K 2007-07-25 14:54 ./usr/lib/libcrypt_p.a
      -rwxr-xr-x 1 mkl ptx 55K 2007-07-25 14:54 ./usr/lib/libcrypt.so*

  And in contrast, this one is intact::

      $ ll `find . -name "libcrypt*"`
      -rwxr-xr-x 1 mkl ptx 55K 2007-11-03 13:30 ./lib/libcrypt-2.5.so*
      lrwxrwxrwx 1 mkl ptx  15 2008-02-20 14:52 ./lib/libcrypt.so.1 -> libcrypt-2.5.so*
      -rw-r--r-- 1 mkl ptx 63K 2007-11-03 13:30 ./usr/lib/libcrypt.a
      -rw-r--r-- 1 mkl ptx 64K 2007-11-03 13:30 ./usr/lib/libcrypt_p.a
      lrwxrwxrwx 1 mkl ptx  23 2008-02-20 14:52 ./usr/lib/libcrypt.so -> ../../lib/libcrypt.so.1*


PTXdist does not find my own sources: “Unknown format, cannot extract”
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  I followed the instructions how to integrate my own plain source
  project into PTXdist. But when I try to build it, I get::

    extract: archive=/path/to/my/sources
    extract: dest=/path/to/my/project/build-target
    Unknown format, cannot extract!

  But the path exists!

Answer:
  PTXdist interprets a ``file://`` (two slashes) in the URL as a
  project related relative path. So it searches only in the current
  project for the given path. Only ``file:///`` (three slashes) will
  force PTXdist to use the path as an absolute one. This means:
  ``file://bla/blub`` will be used as ``./bla/blub`` and
  ``file:///friesel/frasel`` as ``/friesel/frasel``.

Using more than one kernel version per BSP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  I want to use more than one kernel revision in my BSP. How can I
  avoid maintaining one platformconfig per kernel?

Answer:
  One solution could be to include the kernel revision into the name
  of the kernel config file. Instead of the default ``kernelconfig``
  name you could use ``kernelconfig-<revision>`` instead. In ``ptxdist
  menuconfig platform`` under *Linux kernel → patching & configuration*,
  change the entry *kernel config file* to something like
  ``kernelconfig-$PTXCONF_KERNEL_VERSION``.

Using Java packages
~~~~~~~~~~~~~~~~~~~
Question:
  I’m trying to use a Java based package in PTXdist. But compiling
  fails badly. Does it ever work at Pengutronix?

Answer:
  Some Java packages only build correctly when an original Oracle Java
  SDK is used on the host.
  Run ``ptxdist setup`` and point the *Java SDK* menu entry to
  the installation path of your Oracle Java SDK.

I get the error “cannot run '/etc/init.d/rcS': No such file or directory”
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  I made a new project and everything seems fine. But when I start my
  target with the root filesystem generated by PTXdist, it fails with::

      cannot run '/etc/init.d/rcS': No such file or directory

Answer:
  The error message is confusing. But this script needs ``/bin/sh`` to
  run. Most of the time this message occurs when ``/bin/sh`` does not
  exists. Did you enable it in your busybox configuration?

I get the error “ptxdist: archives: command not found”
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Question:
  I have set a path for my source archives in ``ptxdist setup``.
  But whenever I run PTXdist now it fails with the following error
  message::

      /usr/local/bin/ptxdist: archives: command not found

Answer:
  This happens if your source download path contains whitespace, e.g
  ``$HOME/source archives``.
  Handling directory or filenames with whitespaces in applications isn’t
  trivial and also PTXdist suffers all over the place from this issue. The
  only solution is to avoid whitespace in paths and filenames.

I have adapted my own rule file’s targetinstall stage, but PTXdist does not install the files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Answer:
  Check if the closing ``@$(call install_finish, [...])`` is present at
  the end of the *targetinstall* stage. If not, PTXdist will not complete
  this stage.

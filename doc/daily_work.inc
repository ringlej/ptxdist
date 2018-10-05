Using an External Kernel Source Tree
------------------------------------

This application note describes how to use an external kernel source
tree within a PTXdist project. In this case the external kernel source
tree is managed by GIT.

Cloning the Linux Kernel Source Tree
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this example we are using the officially Linux kernel development
tree.

.. code-block:: text

    jbe@octopus:~$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    [...]
    jbe@octopus:~$ ls -l
    [...]
    drwxr-xr-x 38 jbe  ptx 4096 2015-06-01 10:21 myprj
    drwxr-xr-x 25 jbe  ptx 4096 2015-06-01 10:42 linux
    [...]

Configuring the PTXdist Project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: assumption is here, the directory ``/myprj`` contains a valid PTXdist project.

To make PTXdist use of this kernel source tree, instead of an archive we
can simply create a link now:

.. code-block:: text

    jbe@octopus:~$ cd myprj
    jbe@octopus:~/myprj$ mkdir local_src
    jbe@octopus:~/myprj$ ptxdist local-src kernel ~/linux
    jbe@octopus:~/myprj$ ls -l local_src
    lrwxrwxrwx  1 jbe ptx   36 Nov 14 16:14 kernel.<platformname> -> /home/jbe/linux

.. note:: The ``<platformname>`` in the example above will be replaced by the name of your own platform.

PTXdist will handle it in the same way as a kernel part of the project.
Due to this, we must setup:

-  Some kind of kernel version

-  Kernel configuration

-  Image type used on our target architecture

-  If we want to build modules

-  Patches to be used (or not)

Lets setup these topics. We just add the kernel component to it.

.. code-block:: text

    jbe@octopus:~/myprj$ ptxdist platformconfig

We must enable the **Linux kernel** entry first, to enable kernel
building as part of the project. After enabling this entry, we must
enter it, and:

-  Setting up the **kernel version**

-  Setting up the **MD5 sum** of the corresponding archive

-  Selecting the correct image type in the entry **Image Type**.

-  Configuring the kernel within the menu entry **patching &
   configuration**.

   -  If no patches should be used on top of the selected kernel source
      tree, we keep the **patch series file** entry empty. As GIT should
      help us to create these patches for deployment, it should be kept
      empty on default in this first step.

   -  Select a name for the kernel configuration file and enter it into
      the **kernel config file** entry.

.. Important::
  Even if we do not intend to use a kernel archive, we must setup these
  entries with valid content, else PTXdist will fail. Also the archive
  must be present on the host, else PTXdist will start a download.

Now we can leave the menu and store the new setup. The only still
missing component is a valid kernel config file now. We can use one of
the default config files the Linux kernel supports as a starting point.
To do so, we copy one to the location, where PTXdist expects it in the
current project. In a multi platform project this location is the
platform directory usally in ``configs/<platform-directory>``. We must
store the file with a name selected in the platform setup menu (**kernel
config file**).

Work Flow
~~~~~~~~~

Now its up to ourself working on the GIT based kernel source tree and
using PTXdist to include the kernel into the root filesystem.

To configure the kernel source tree, we simply run:

.. code-block:: text

    jbe@octopus:~/myprj$ ptxdist kernelconfig

To build the kernel:

.. code-block:: text

    jbe@octopus:~/myprj$ ptxdist targetinstall kernel

To rebuild the kernel:

.. code-block:: text

    jbe@octopus:~/myprj$ ptxdist drop kernel compile
    jbe@octopus:~/myprj$ ptxdist targetinstall kernel

Discovering Runtime Dependencies
--------------------------------

Often it happens that an application on the target fails to run, because
one of its dependencies is not fulfilled. This section should give some
hints on how to discover these dependencies.

Dependencies on Shared Libraries
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Getting the missed shared library for example at run-time is something
easily done: The dynamic linker prints the missing library to the
console.

To check at build time if all other dependencies are present is easy,
too. The architecture specific ``readelf`` tool can help us here. It
comes with the OSELAS.Toolchain and is called via ``<target>-readelf``.

To test the ``foo`` binary from our new package ``FOO``, we simply run:

.. code-block:: text

    $ ./selected_toolchain/<target>-readelf -d platform-<platformname>/root/usr/bin/foo | grep NEEDED
     0x00000001 (NEEDED)                     Shared library: [libm.so.6]
     0x00000001 (NEEDED)                     Shared library: [libz.so.1]
     0x00000001 (NEEDED)                     Shared library: [libc.so.6]

We now can check if all of the listed libraries are present in the root
filesystem. This works for shared libraries, too. It is also a way to
check if various configurations of our package are working as expected
(e.g. disabling a feature should also remove the required dependency of
this feature).

Dependencies on other Resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes a binary fails to run due to missing files, directories or
device nodes. Often the error message (if any) which the binary creates
in this case is ambiguous. Here the ``strace`` tool can help us, namely
to observe the binary at run-time. ``strace`` shows all the system calls
the binary or its shared libraries are performing.

``strace`` is one of the target debugging tools which PTXdist provides
in its ``Debug Tools`` menu.

After adding strace to the root filesystem, we can use it and observe
our ``foo`` binary:

.. code-block:: text

    $ strace usr/bin/foo
    execve("/usr/bin/foo", ["/usr/bin/foo"], [/* 41 vars */]) = 0
    brk(0)                                  = 0x8e4b000
    access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
    open("/etc/ld.so.cache", O_RDONLY)      = 3
    fstat64(3, {st_mode=S_IFREG|0644, st_size=77488, ...}) = 0
    mmap2(NULL, 77488, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f87000
    close(3)                                = 0
    open("/lib//lib/libm-2.5.1.so", O_RDONLY) = 3
    read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p%\0\000"..., 512) = 512
    mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f86000
    fstat64(3, {st_mode=S_IFREG|0555, st_size=48272, ...}) = 0
    mmap2(NULL, 124824, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7f67000
    mmap2(0xb7f72000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb) = 0xb7f72000
    mmap2(0xb7f73000, 75672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f73000
    close(3)                                = 0
    open("/lib/libc.so.6", O_RDONLY)        = 3
    read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\332X\1"..., 512) = 512
    fstat64(3, {st_mode=S_IFREG|0755, st_size=1405859, ...}) = 0
    [...]

Occasionally the output of ``strace`` can be very long and the
interesting parts are lost. So, if we assume the binary tries to open a
nonexisting file, we can limit the output to all ``open`` system calls:

.. code-block:: text

    $ strace -e open usr/bin/foo
    open("/etc/ld.so.cache", O_RDONLY)      = 3
    open("/lib/libm-2.5.1.so", O_RDONLY) = 3
    open("/lib/libz.so.1.2.3", O_RDONLY) = 3
    open("/lib/libc.so.6", O_RDONLY)        = 3
    [...]
    open("/etc/foo.conf", O_RDONLY) = -1 ENOENT (No such file or directory)

The binary may fail due to a missing ``/etc/foo.conf``. This could be a
hint on what is going wrong (it might not be the final solution).

Debugging with CPU emulation
----------------------------

If we do not need some target related feature to run our application, we
can also debug it through a simple CPU emulation. Thanks to QEMU we can
run ELF binaries for other architectures than our build host is.

Running an Application made for a different Architecture
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist creates a fully working root filesystem with all run-time
components in ``root/``. Lets assume we made a PTXdist based project for
a CPU. Part of this project is our application ``myapp`` we are
currently working on. PTXdist builds the root filesystem and also
compiles our application. It also installs it to ``usr/bin/myapp`` in
the root filesystem.

With this preparation we can run it on our build host:

.. code-block:: text

    $ cd |ptxdistPlatformDir|/root
    |ptxdistPlatformDir|/root$ qemu-<architecture> -cpu <cpu-core> -L . usr/bin/myapp

This command will run the application ``usr/bin/myapp`` built for an
<cpu-core> CPU on the build host and is using all library compontents
from the current directory.

For the stdin and -out QEMU uses the regular mechanism of the build
host’s operating system. Using QEMU in this way let us simply check our
programs. There are also QEMU environments for other architectures
available.

Debugging an Application made for a different Architecture
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Debugging our application is also possible with QEMU. All we need are a
root filesystem with debug symbols available, QEMU and an architecture
aware debugger.

The root filesystem with debug symbols will be provided by PTXdist, the
architecture aware debugger comes with the OSELAS.Toolchain. Two
consoles are required for this debug session in this example. We start
the QEMU in the first console as:

.. code-block:: text

    $ cd ptxdistPlatformDir/root
    ptxdistPlatformDir/root$ qemu-<architecture> -g 1234 -cpu <cpu-core> -L . usr/bin/myapp

.. note:: PTXdist always builds a root filesystems ``root/``.
  It contains all components without debug 
  information (all binaries are in the same size as used later on on the
  real target). In addition, each directory that contains binaries also
  contains a ``.debug/`` directory. It contains a file with only the debug
  symbols for each binary. These files are ignored while running
  applications but GDB knows about it and will automatically load the debug
  files.

The added *-g 1234* parameter lets QEMU wait for a GDB connection to run
the application.

In the second console we start GDB with the correct architecture
support. This GDB comes with the same OSELAS.Toolchain that was also
used to build the project:

.. code-block:: text

    $ ./selected_toolchain/<target>-gdb --tui platform-<platformname>/root/usr/bin/myapp

This will run a *curses* based GDB. Not so easy to handle (we must enter
all the commands and cannot click with a mouse!), but very fast to take
a quick look at our application.

At first we tell GDB where to look for debug symbols. The correct
directory here is ``root/``.

.. code-block:: text

    (gdb) set solib-absolute-prefix platform-<platformname>/root

Next we connect this GDB to the waiting QEMU:

.. code-block:: text

    (gdb) target remote localhost:1234
    Remote debugging using localhost:1234
    [New Thread 1]
    0x40096a7c in _start () from root/lib/ld.so.1

As our application is already started, we can’t use the GDB command
``start`` to run it until it reaches ``main()``. We set a breakpoint
instead at ``main()`` and *continue* the application:

.. code-block:: text

    (gdb) break main
    Breakpoint 1 at 0x100024e8: file myapp.c, line 644.
    (gdb) continue
    Continuing.
    Breakpoint 1, main (argc=1, argv=0x4007f03c) at myapp.c:644

The top part of the running gdbtui console will always show us the
current source line. Due to the ``root/`` directory usage all
debug information for GDB is available.

Now we can step through our application by using the commands *step*,
*next*, *stepi*, *nexti*, *until* and so on.

.. note:: It might be impossible for GDB to find debug symbols for
  components like the main C run-time library. In this case they where
  stripped while building the toolchain. There is a switch in the
  OSELAS.Toolchain menu to keep the debug symbols also for the C run-time
  library. But be warned: This will enlarge the OSELAS.Toolchain
  installation on your harddisk! When the toolchain was built with the
  debug symbols kept, it will be also possible for GDB to debug C library
  functions our application calls (so it might worth the disk space).

Migration between Releases
--------------------------

To migrate an existing project from within one minor release to the next
one, we do the following step:

.. code-block:: text

    ~/my_bsp# ptxdist migrate

PTXdist will ask us for every new configuration entry what to do. We
must read and answer these questions carefully. At least we shouldn’t
answer blindly with ’Y’ all the time because this could lead into a
broken configuration. On the other hand, using ’N’ all to time is more
safer. We can still enable interesting new features later on.

Increasing Build Speed
----------------------

Modern host systems are providing more than one CPU core. To make use of
this additionally computing power recent applications should do their
work in parallel.

Using available CPU Cores
~~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist uses all available CPU cores when building a project by default.
But there are some exceptions:

-  the prepare stage of all autotools build system based packages can
   use only one CPU core. This is due to the fact, the running
   “configure” is a shell script.

-  some packages have a broken buildsystem regarding parallel build.
   These kind of packages build successfully only when building on one
   single CPU core.

-  creating the root filesystem images are also done on a single core
   only

Manually adjusting CPU Core usage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Manual adjustment of the parallel build behaviour is possible via
command line parameters.

``-ji<number>``
    this defines the number of CPU cores to build a package. The default
    is two times the available CPU cores.

``-je<number>``
    this defines the number of packages to be build in parallel. The
    default is one package at a time.

``-j<number>``
    this defines the number of CPU cores to be used at the same time. These
    cores will be used on a package base and file base.

``-l<number>``
    limit the system load to the given value.

.. Important:: using ``-ji`` and ``-je`` can overload the system
  immediatley. These settings are very hard.

A much softer setup is to just use the ``-j<number>`` parameter. This will run
up to ``<number>`` tasks at the same time which will be spread over everything
to do. This will create a system load which is much user friendly. Even the
filesystem load is smoother with this parameter.

Building in Background
~~~~~~~~~~~~~~~~~~~~~~

To build a project in background PTXdist can be ’niced’.

``-n[<number>]``
    run PTXdist and all of its child processes with the given
    nicelevel <number>. Without a nicelevel the default is 10.

Building Platforms in Parallel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Due to the fact that more than one platform can exist in a PTXdist
project, all these platforms can be built in parallel within the same
project directory. As they store their results into different platform
subdirectories, they will not conflict. Only PTXdist must be called
differently, because each call must be parametrized individually.

The used Platform Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: text

    $ ptxdist platform <some-platform-config>

This call will create the soft link ``selected_platformconfig`` to the
``<some-platform-config>`` in the project’s directory. After this call,
PTXdist uses this soft link as the default platform to build for.

It can be overwritten temporarily by the command line parameter
``--platformconfig=<different-platform-config>``.

The used Project Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: text

    $ ptxdist select <some-project-config>

This call will create the soft link ``selected_ptxconfig`` to the
``<some-project-config>`` in the project’s directory. After this call,
PTXdist uses this soft link as the default configuration to build the
project.

It can be overwritten temporarily by the command line parameter
``--ptxconfig=<different-project-config>``.

The used Toolchain to Build
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: text

    $ ptxdist toolchain <some-toolchain-path>

This call will create the soft link ``selected_toolchain`` to the
``<some-toolchain-path>`` in the project’s directory. After this call,
PTXdist uses this soft link as the default toolchain to build the
project with.

It can be overwritten temporarily by the command line parameter
``--toolchain=<different-toolchain-path>``.

By creating the soft links all further PTXdist commands will use these
as the default settings.

By using the three ``--platformconfig``, ``--ptxconfig`` and
``--toolchain`` parameters, we can switch (temporarily) to a completely
different setting. This feature we can use to build everything in one
project.

A few Examples
^^^^^^^^^^^^^^

The project contains two individual platforms, sharing the same
architecture and same project configuration.

.. code-block:: text

    $ ptxdist select <project-config>
    $ ptxdist toolchain <architecture-toolchain-path>
    $ ptxdist --platformconfig=<architecture-A> --quiet go &
    $ ptxdist --platformconfig=<architecture-B> go

The project contains two individual platforms, sharing the same project
configuration.

.. code-block:: text

    $ ptxdist select <project-config>
    $ ptxdist --platformconfig=<architecture-A> --toolchain=<architecture-A-toolchain-path> --quiet go &
    $ ptxdist --platformconfig=<architecture-B> --toolchain=<architecture-B-toolchain-path> go

The project contains two individual platforms, but they do not share
anything else.

.. code-block:: text

    $ ptxdist --select=<project-A-config> --platformconfig=<architecture-A> --toolchain=<architecture-A-toolchain-path> --quiet go &
    $ ptxdist --select=<project-B-config> --platformconfig=<architecture-B> --toolchain=<architecture-B-toolchain-path> go

Running one PTXdist in background and one in foreground would render the
console output unreadable. That is why the background PTXdist uses the
``--quiet`` parameter in the examples above. Its output is still
available in the logfile under the platform build directory tree.

By using more than one virtual console, both PTXdists can run with their
full output on the console.

Using a Distributed Compiler
----------------------------

To increase the build speed of a PTXdist project can be done by doing
more tasks in parallel. PTXdist itself uses all available CPU cores by
default, but is is limited to the local host. For further speedup a
distributed compilation can be used. This is the task of *ICECC* aka
*icecream*. With this feature a PTXdist project can make use of all
available hosts and their CPUs in a local network.

Setting-Up the Distributed Compiler
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

How to setup the distributed compiler can be found on the project’s
homepage at GITHUB:

https://github.com/icecc/icecream.

Read their ``README.md`` for further details.

.. Important:: as of July 2014 you need at least an *ICECC* in its version
  1.x. Older revisions are known to not work.

Enabling PTXdist for the Distributed Compiler
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since the 2014.07 release, PTXdist supports the usage of *ICECC* by
simply enabling a setup switch.

Run the PTXdist setup and navigate to the new *ICECC* menu entry:

.. code-block:: text

    $ ptxdist setup
       Developer Options   --->
          [*] use icecc
          (/usr/lib/icecc/icecc-create-env) icecc-create-env path

Maybe you must adapt the ``icecc-create-env path`` to the setting on
your host. Most of the time the default path should work.

How to use the Distributed Compiler with PTXdist
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist still uses two times the count of cores of the local CPU for
parallel tasks. But if a faster CPU in the net exists, *ICECC* will now
start to do all compile tasks on this/these faster CPU(s) instead of the
local CPU.

To really boost the build speed you must increase the tasks to be done
in parallel manually. Use the ``-ji<x>`` command line option to start
more tasks at the same time. This command line option just effects one
package to build at a time. To more increase the build speed use the
``-je<x>`` command line option as well. This will build also packages in
parallel.

A complete command line could look like this:

.. code-block:: text

    $ ptxdist go -ji64 -je8

This command line will run up to 64 tasks in parallel and builds 8
packages at the same time. Never worry again about your local host and
how slow it is. With the help of *ICECC* every host will be a high speed
development machine.

.. _devpkgs:

Using Pre-Built Archives
------------------------

PTXdist is a tool which creates all the required parts of a target's
filesystem to breathe life into it. And it creates these parts from any
kind of source files. If a PTXdist project consists of many packages the
build may take a huge amount of time.

For internal checks we have a so called “ALL-YES” PTXdist project. It
has - like the name suggests - all packages enabled which PTXdist
supports. To build this “ALL-YES” PTXdist project our build server needs
about 6 hours.

Introduction
~~~~~~~~~~~~

While developing a PTXdist project it is necessary to clean and
re-build everything from time to time to get a re-synced project result
which honors all changes made in the project. But since cleaning and
re-building everything from time to time is a very good test case for if
some adaptions are still missing or if everything is complete, it can be
a real time sink to do so.

To not lose developer's temper when doing such tests, PTXdist can keep
archives from the last run which includes all the files the package's
build system has installed while the PTXdist's *install* stage runs for
it.

The next time PTXdist shall build a package it can use the results from
the last run instead. This feature can drastically reduce the time to
re-build the whole project. But also, this PTXdist feature must be handled
with care and so it is not enabled and used as default.

This section describes how to make use of this PTXdist feature and what
pitfalls exist when doing so.

Creating Pre-Built Archives
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To make PTXdist create pre-built archives, enable this feature prior to a
build in the menu:

.. code-block:: text

    $ ptxdist menuconfig

        Project Name & Version --->
            [*] create pre-built archives

Now run a regular build of the whole project:

.. code-block:: text

    $ ptxdist go

When the build is finished, the directory ``packages`` contains
additional archive files with the name scheme ``*-dev.tar.gz``. These
files are the pre-built archives which PTXdist can use later on to
re-build the project.

Using Pre-Built Archives
~~~~~~~~~~~~~~~~~~~~~~~~

To make PTXdist use pre-built archives, enable this feature prior to a
build in the menu:

.. code-block:: text

    $ ptxdist menuconfig

        Project Name & Version --->
            [*] use pre-built archives
            (</some/path/to/the/archives>)

During the next build (e.g. ``ptxdist go``) PTXdist will look for a
specific package if its corresponding pre-built archive exists. If
it exists and the used hash value in the pre-built archive's
filename matches, PTXdist will skip all source archive handling
(extract, patch, compile and install) and just extract and use the
pre-built archive's content.

Sufficient conditions for safe application of pre-built archives are:

-  using one pre-built archive pool for one specific PTXdist project.

-  using a constant PTXdist version all the time.

-  using a constant OSELAS.Toolchain() version all the time.

-  no package with a pre-built archive in the project is under
   development.

The hash as a part of the pre-built archive's filename only reflects
the package's configuration made in the menu (``ptxdist menuconfig``).
If this package specific configuration changes, a new hash value will be
the result and PTXdist can select the matching pre-built archive.

This hash value change is an important fact, as many things outside and
inside the package can have a big impact of the binary result but
without a hash value change!

Please be careful when using the pre-built archives if you:

-  intend to switch to a different toolchain with the next build.

-  change the patch set applied to the corresponding package, e.g. the
   package is under development.

-  change the hard coded configure settings in the package's rule file,
   e.g. the package is under development.

-  intend to use one pre-built archive pool from different PTXdist
   projects.

-  change a global PTXdist configuration parameter (e.g. PTXCONF_GLOBAL_IPV6).

To consider all these precautions the generated pre-built archives are
not transferred automatically to where the next build expects them. This
must be done manually by the user of the PTXdist project. Doing so, we
can decide on a package by package basis if its pre-built archive should
be used or not.

If you are unsure if your modifications rendered some or all of your pre-built
archives invalid you can always delete and build them again to be on the safe
side.

Packages without Pre-Built Archives Support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Not all packages support pre-built archives. This is usually caused by
relocation problems or files outside the install directory are needed:

-  Some host packages are not relocatable and install directly into
   *sysroot-host*.

-  Linux kernel: it has an incomplete install stage, which results in
   an incomplete pre-built archive. Due to this, it cannot be used as a
   pre-built archive.

-  Barebox bootloader: it has an incomplete install stage, which results
   in an incomplete pre-built archive. Due to this, it cannot be used
   as a pre-built archive.

-  a few somehow broken packages that are all explicitely marked with a
   ``<packagename>_DEVPKG := NO`` in their corresponding rule file.

Workflow with Pre-Built Archives
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We are starting with an empty PTXdist project and enabling the pre-built
archive feature as mentioned in the previous section. After that
a regular build of the project can be made.

When the build is finished it's time to copy all the pre-built archives
of interest to where the next build will expect them.
The previous section mentions the step to enable their use. It also
allows to define a directory. The default path of this directory is made
from various other menu settings to ensure the pre-built archives of
the current PTXdist project do not conflict with pre-built archives of
different PTXdist projects. To get an idea of what the final path is, we
can ask PTXdist.

.. code-block:: text

    $ ptxdist print PTXCONF_PROJECT_DEVPKGDIR
    /home/jbe/OSELAS.BSP/Pengutronix/OSELAS.BSP-Pengutronix-Generic

If this directory does not exist, we can simply create it:

.. code-block:: text

    $ mkdir -p /home/jbe/OSELAS.BSP/Pengutronix/OSELAS.BSP-Pengutronix-Generic

Now it's time to copy the pre-built archives to this new directory. We
could simply copy all pre-built archives from the ``/packages``
directory. But we should keep in mind, if any of the related packages
are under development, we must omit their corresponding pre-built archives
in this step.

.. code-block:: text

    $ cp platform-<platformname>/packages/*-dev.tar.gz /home/jbe/OSELAS.BSP/Pengutronix/OSELAS.BSP-Pengutronix-Generic

Use Cases
~~~~~~~~~

Some major possible use cases are covered in this section:

-  speed up a re-build of one single project.

-  share pre-built archives between two platforms based on the same
   architecture.

-  increase reproducibility of binaries.

To simply speed up a re-build of the whole project (without development
on any of the used packages) we just can copy all ``*-dev.tar.gz``
archives after the first build to the location where PTXdist expects
them at the next build time.

If two platforms are sharing the same architecture it is possible to
share pre-built archives as well. The best way it can work is, if both
platforms are part of the same PTXdist project. They must also share the
same toolchain settings, patch series and rule files. If these
precautions are handled the whole project can be built for the first
platform and these pre-built archives can be used to build the project
for the second platform. This can reduce the required time to build the
second platform from hours to minutes.

Downloading Packages from the Web
---------------------------------

Sometimes it makes sense to get all required source archives at once.
For example prior to a shipment we want to also include all source
archives, to free the user from downloading it by him/herself.

PTXdist supports this requirement by the ``export_src`` parameter. It
collects all required source archives into one given single directory.
To do so, the current project must be set up correctly, e.g. the
``select`` and ``platform`` commands must be ran prior the
``export_src`` step.

If everything is set up correctly we can run the following commands to
get the full list of required archives to build the project again
without an internet connection.

.. code-block:: text

    $ mkdir my_archives
    $ ptxdist export_src my_archives

PTXdist will now collect all source archives to the ``my_archives/``
directory.

.. note:: If PTXdist is configured to share one source archive directory for
  all projects, this step will simply copy the source archives from the
  shared source archive directory. Otherwise PTXdist will start to
  download them from the world wide web.

.. _adding_src_autoconf_templates:

Creating Autotools based Packages
---------------------------------

Developing your own programs and libraries can be one of the required tasks to
support an embedded system. PTXdist comes with three autotoolized templates to
provide a comfortable buildsystem:

- a library package template
- an executable package template
- a program combined with a library package template

Some template components are shared between all three packages types and described
here, some other template componente are indvidual to each package type and
described later on.

Shared components
~~~~~~~~~~~~~~~~~

Some files and their content are used in all three packages types. Most of them
need your attention and some adaptions and thus listed here.

Licence related stuff
^^^^^^^^^^^^^^^^^^^^^

**COPYING**

You **must** think about the licence your package uses. The template file
``COPYING`` contains some links to GPL/LGPL license texts you can use. Replace
the ``COPYING's`` content by one of the listed licence files or a different
license. But do not omit this step. Never!

Refer https://www.gnu.org/licenses/license-list.html#SoftwareLicenses for a
large list of available licenses.

M4 macros
^^^^^^^^^

Autotool based buildsystems use M4 macros for their detection and configuring
features. Some of these M4 macros are generic and come with the autotools itself,
some other are project specific and must be shipped with your package. The
PTXdist autotoolized templates come with a few M4 macro files listed below:

.. code-block:: text

   $ tree m4/
   m4/
   |-- ptx.m4
   |-- attributes.m4
   |-- ax_code_coverage.m4
   |-- pkg.m4
   |-- ax_armv4_detection.m4
   |-- ax_armv5_detection.m4
   |-- ax_armv6_detection.m4
   |-- ax_armv7_detection.m4
   `-- ax_floating_point.m4

Note: these files contains M4 macros used in ``configure.ac``.

The ``ptx.m4`` file contains a list of tests, handy for many projects. They
end up into options of the final ``configure`` script. These options are mentioned
in the ``INSTALL`` file (see below). This file is used like some kind of library
to keep the ``configure.ac`` small. The ``configure.ac`` just call an M4 macro
from the ``ptx.m4`` file and all details are handled there.

The ``attributes.m4`` file contains various tests for compiler and linker options
and flags. They are used in the ``ptx.m4`` file.

The ``ax_code_coverage.m4`` file provides a comfortable way to add the coverage
feature to the buildsystem. It handles all the details how to parametrize the
compiler and linker correctly.

The ``pkg.m4`` must be shipped with a package which uses *pkg-config* to detect
the existance of external libraries and query details how to use them. If your
package doesn't use *pkg-config*, you can remove this file (and remove it from
the EXTRA_DIST variable in ``Makefile.am``).

The ``ax_armv*_detection.m4``/``ax_floating_point.m4`` files provide architecture
specific M4 macros. If your code doesn't depend on the architecture, you can
remove these files (don't forget to remove them from the EXTRA_DIST variable in
``Makefile.am`` in this case).

Note: if you use more non-generic M4 macros in your ``configure.ac`` file,
don't forget to add their source files to the ``m4/`` directory. This will
enable any user of your package to re-generate the autotools based files
without providing all dependencies by themself.

Hints for a User of your Package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**INSTALL**

Prepared with some information about the package you provide. Be kind to the
users of your package and write some sentences about basic features and usage
of your package, how to configure it and how to build it. It already lists
build-time options provided by the ``ptx.m4`` M4 macro file.

Build system related files
^^^^^^^^^^^^^^^^^^^^^^^^^^

**autogen.sh**

The autotools are using macro files which are easier to read for a
human. But to work with the autotools these macro files must be
converted into executabe shell code first. The ``autogen.sh`` script
does this job for us.

**configure.ac**

This is the first part of the autotools based build system. Its purpose
is to collect as much required information as possible about the target
to build the package for. This file is a macro file. It uses a bunch of
M4 macros to define the jobs to do. The autotools are complex and this
macro file should help you to create a useful and cross compile aware
``configure`` script everybody can use.

This macro file is full of examples and comments. Many M4 macros are
commented out and you can decide if you need them to detect special
features about the target.

Search for the “TODO” keyword and adapt the setting to your needs. After
that you should remove the “TODO” comments to not confuse any user later
on.

Hints about some shared M4 macros used in ``configure.ac``:

**AC_INIT**
    add the intended revision number (the second argument), an email
    address to report bugs and some web info about your package.

**AC_PREFIX_DEFAULT**
    most of the time you can remove this entry, because most users
    expect the default install path prefix is ``/usr/local`` which is
    always the default if not changed by this macro.

**CC_CHECK_CFLAGS / CC_CHECK_LDFLAGS**
    if you need special command line parameters given to the compiler or
    linker, don't add them unconditionally. Always test, if the tools
    can handle the parameter and fail gracefully if not. Use
    CC_CHECK_CFLAGS to check parameters for the compiler and
    CC_CHECK_LDFLAGS for the linker.

**AX_HARDWARE_FP / AX_DETECT_ARMV\***
    sometimes it is important to know for which architecture or CPU the
    current build is for and if it supports hard float or not. Please
    don't try to guess it. Ask the compiler instead. The M4
    AX_HARDWARE_FP and AX_DETECT_ARMV\* macros will help you.

**Makefile.am**

This is the second part of the autotools based build system. Its purpose is
to define what is to build, to install and to distribute.

**SUBDIR**
    if your project contains more than one sub-directory to build, add
    these directories here. Keep in mind, these directories are visited
    in this order (but never in parallel), so you must handle
    dependencies manually.

**\*_CPPFLAGS / \*_CFLAGS / \*_LIBADD / \*_LDADD**
    if your library has some optional external dependencies add them on
    demand (external libraries for example). Keep in mind to not mix
    CPPFLAGS and CFLAGS additions. And do not add these additions fixed
    to the \*_CPPFLAGS and \*_CFLAGS variables, let ``configure`` do it
    in a sane way. Never add libraries to the \*_LDFLAGS variable. Always add
    them to the \*_LIBADD variable (for a library) or \*_LDADD (for an executable)
    instead. This is important because the autotools forward all these variable
    based parameters in a specifc order to the tools (compiler and linker).

**EXTRA_DIST**
    Include here all files which must be part of the distribution and are not
    generated by the *autotools* itself and the buildsystem.

.. _adding_src_autoconf_lib:

Creating a Library Template
~~~~~~~~~~~~~~~~~~~~~~~~~~~

This template creates a library only package and can be done by the PTXdist's
*newpackage* option:

.. code-block:: text

    $ ptxdist newpackage src-autoconf-lib

    ptxdist: creating a new 'src-autoconf-lib' package:

    ptxdist: enter package name...........: foo
    ptxdist: enter version number.........: 1
    ptxdist: enter package author.........: Juergen Borleis <jbe@pengutronix.de>
    ptxdist: enter package section........: project_specific

    generating rules/foo.make
    generating rules/foo.in

    local_src/foo does not exist, create? [Y/n] Y
    ./
    ./configure.ac
    ./Makefile.am
    ./COPYING
    ./lib@name@.pc.in
    ./wizard.sh
    ./lib@name@.h
    ./@name@.c
    ./autogen.sh
    mkdir: created directory 'm4'
    ./
    ./ax_armv6_detection.m4
    ./ptx.m4
    ./internal.h
    ./pkg.m4
    ./ax_armv4_detection.m4
    ./ax_floating_point.m4
    ./INSTALL
    ./ax_armv5_detection.m4
    ./attributes.m4
    ./ax_armv7_detection.m4
    ./ax_code_coverage.m4

After this step the new directory ``local_src/foo`` exists and contains
various template files. All of these files are dedicated to be modified
by yourself.

The content of this directory is:

.. code-block:: text

    $ tree local_src/foo/
    local_src/foo/
    |-- COPYING
    |-- INSTALL
    |-- Makefile.am
    |-- autogen.sh
    |-- configure.ac
    |-- foo.c
    |-- internal.h
    |-- libfoo.h
    |-- libfoo.pc.in
    `-- m4/
        |-- ptx.m4
        |-- attributes.m4
        |-- ax_code_coverage.m4
        |-- pkg.m4
        |-- ax_armv4_detection.m4
        |-- ax_armv5_detection.m4
        |-- ax_armv6_detection.m4
        |-- ax_armv7_detection.m4
        `-- ax_floating_point.m4

Most files and their content are already described above. Some files
and their content are library specific:

Build system related files
^^^^^^^^^^^^^^^^^^^^^^^^^^

**configure.ac**

The shared part is already described above. For a library there are some
extensions:

**LT_CURRENT / LT_REVISION / LT_AGE**
    define the binary compatibility of your library. The rules how these
    numbers are defined are:

    -  library code was modified: ``LT_REVISION++``

    -  interfaces changed/added/removed: ``LT_CURRENT++`` and
       ``LT_REVISION = 0``

    -  interfaces added: ``LT_AGE++``

    -  interfaces removed: ``LT_AGE = 0``

    You must manually change these numbers whenever you change the code
    in your library prior a release.

**REQUIRES**
    to enrich the generated \*.pc file for easier dependency handling
    you should also fill the REQUIRES variable. Here you can define from
    the package management point of view the dependencies of your
    library. For example if your library depends on the *udev* library
    and requires a specific version of it, just add the string
    ``udev >= 1.0.0`` to the REQUIRES variable. Note: the listed
    packages must be space-separated.

**CONFLICTS**
    if your library conflicts with a different library, add this
    different library to the CONFLICTS variable (from the package
    management point of view).

**libfoo.pc.in**

This file gets installed to support the *pkg-config* tool for package
management. It contains some important information for users of your package
how to use your library and also handles its dependencies. Some TODOs in this
file need your attention:

**Name**
    A human-readable name for the library.

**Description**
    add a brief description of your library here

**Version**
    the main revision of the library. Will automatically replaced from
    your settings in ``configure.ac``.

**URL**
    where to find your library. Will automatically replaced from your
    settings in ``configure.ac``.

**Requires**
    space-separated list of modules your library itself depends on and managed
    by *pkg-config*. The listed modules gets honored for the static
    linking case and should not be given again in the *Libs.private*
    line. This line will be filled by the *REQUIRES* variable from the
    ``configure.ac``.

**Requires.private**
    space-separated list of modules your library itself depends on and managed
    by *pkg-config*. The listed modules gets honored for the static
    linking case and should not be given again in the *Libs.private*
    line. This line will be filled by the *REQUIRES* variable from the
    ``configure.ac``.

**Conflicts**
    list of packages your library conflicts with. Will automatically
    replaced from your CONFLICTS variable settings in ``configure.ac``.

**Libs**
    defines the linker command line content to use your library and link it
    against other applications or libraries

**Libs.private**
    defines the linker command line content to use your library and link it
    against other application or libraries **statically**. List only
    libraries here which are not managed by *pkg-config* (e.g. do not
    conflict with modules given in the *Requires*).
    This line will be filled by the *LIBS* variable from the
    ``configure.ac``.

**Cflags**
    required compile flags to make use of your library. Unfortunately
    you must mix CPPFLAGS and CFLAGS here which is a really bad idea.

It is not easy to fully automate the adaption of the pc file. At least
the lines *Requires*, *Requires.private* and *Libs.private* are hardly to fill
for packages which are highly configureable.

I nice and helpful description about this kind of configuration file can be
found here:

    https://people.freedesktop.org/~dbn/pkg-config-guide.html

Library related Files
^^^^^^^^^^^^^^^^^^^^^

**libfoo.h**

This file will be installed. It defines the API your library provides
and be used by other applications.

**internal.h**

This file will not be installed. It will be used only at build time of
your library.

**foo.c**

The main source file of your library. Keep in mind to mark all functions
with the DSO_VISIBLE macro you want to export. All other functions are
kept internaly and you cannot link against them from an external
application.

Note: debugging is hard when all internal functions are hidden. For this
case you should configure the library with the ``--disable-hide`` or with
``--enable-debug`` which includes switching off hiding functions.

.. _adding_src_autoconf_exec:

Creating an Executable Template
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creating an executable template works nearly the same like the example above
in :ref:`adding_src_autoconf_lib`. It just skips the library related stuff.

The command:

.. code-block:: text

    $ ptxdist newpackage src-autoconf-prog

Results into the following generated files:

.. code-block:: text

    $ tree local_src/foo
    |-- COPYING
    |-- INSTALL
    |-- Makefile.am
    |-- autogen.sh
    |-- configure.ac
    |-- foo.c
    |-- internal.h
    `-- m4/
        |-- ptx.m4
        |-- attributes.m4
        |-- ax_code_coverage.m4
        |-- pkg.m4
        |-- ax_armv4_detection.m4
        |-- ax_armv5_detection.m4
        |-- ax_armv6_detection.m4
        |-- ax_armv7_detection.m4
        `-- ax_floating_point.m4

Executable related Files
^^^^^^^^^^^^^^^^^^^^^^^^

**internal.h**

This file will not be installed. It will be used only at build time of
your executable.

**foo.c**

The main source file of your executable.

.. _adding_src_autoconf_exec_lib:

Creating an Executable with a Library Template
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creating a library and an executable which makes use of this library is a
combination of :ref:`adding_src_autoconf_lib` and :ref:`adding_src_autoconf_exec`.

The command:

.. code-block:: text

    $ ptxdist newpackage src-autoconf-proglib

Results into the following generated files:

.. code-block:: text

    $ tree local_src/foo
    |-- COPYING
    |-- INSTALL
    |-- Makefile.am
    |-- autogen.sh
    |-- configure.ac
    |-- internal.h
    |-- libfoo.c
    |-- libfoo.h
    |-- libfoo.pc.in
    |-- foo.c
    `-- m4/
        |-- ptx.m4
        |-- attributes.m4
        |-- ax_code_coverage.m4
        |-- pkg.m4
        |-- ax_armv4_detection.m4
        |-- ax_armv5_detection.m4
        |-- ax_armv6_detection.m4
        |-- ax_armv7_detection.m4
        `-- ax_floating_point.m4

The intended purpose of this template is a new tool, which has all its
features implemented in the library. And the executable is a shell command
frontend to provide the library's features to an interactive user.

The advantage of this approach is, the library's features can also be used by a
non-interactive user, e.g. a different application.

.. note:: If you intend to use the GPL license, think about using the LGPL
   license variant for the **library part** of your project.

.. important:: If you want to be able to move code from the executable (and GPL
   licensed) part into the library (and LGPL licensed) part later on, you
   should use the **LGPL license for both parts** from the beginning. Else
   you may cannot move source code in such a way, because it would require a
   license change for this specific piece of source code (to be pedantic!).

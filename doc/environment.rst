Getting a working Environment
=============================

Download Software Components
-----------------------------

In order to follow this manual, some software archives are needed. There
are several possibilities how to get these: either as part of an
evaluation board package or by downloading them from the Pengutronix web
site.

The central place for OSELAS related documentation is
http://www.ptxdist.org. This website provides
all required packages and documentation (at least for software
components which are available to the public).

In order to build |ptxdistBSPName|, the following source archives have to be available
on the development host:

 * ptxdist-|ptxdistVendorVersion|.tar.bz2
 * |ptxdistBSPName|.tar.bz2 (or a similar source)
 * ptxdist-|oselasTCNVendorptxdistversion|.tar.bz2
 * OSELAS.Toolchain-|oselasTCNVendorVersion|.tar.bz2

Main Parts of PTXdist
~~~~~~~~~~~~~~~~~~~~~

The most important software component which is necessary to build an
OSELAS.BSP() board support package is the ``ptxdist`` tool. So before
starting any work we’ll have to install PTXdist on the development host.

PTXdist consists of the following parts:

The ``ptxdist`` Program:
    ``ptxdist`` is installed on the development host during the
    installation process. ``ptxdist`` is called to trigger any action,
    like building a software packet, cleaning up the tree etc. Usually
    the ``ptxdist`` program is used in a *workspace* directory, which
    contains all project relevant files.

A Configuration System:
    The config system is used to customize a *configuration*, which
    contains information about which packages have to be built and which
    options are selected.

Patches:
    Due to the fact that some upstream packages are not bug free
    – especially with regard to cross compilation – it is often
    necessary to patch the original software. PTXdist contains a
    mechanism to automatically apply patches to packages. The patches
    are bundled into a separate archive. Nevertheless, they are
    necessary to build a working system.

Package Descriptions:
    For each software component there is a “recipe” file, specifying
    which actions have to be done to prepare and compile the software.
    Additionally, packages contain their configuration sniplet for the
    config system.

Toolchains:
    PTXdist does not come with a pre-built binary toolchain.
    Nevertheless, PTXdist itself is able to build toolchains, which are
    provided by the OSELAS.Toolchain() project.
    The different OSELAS toolchains can be found at
    https://www.pengutronix.de/en/software/toolchain.html.

    Refer to the section `Building a Toolchain`_ for more information.

Board Support Package:
    This is an optional component, mostly shipped aside with a piece of
    hardware. There are various BSPs available, some are generic, some
    are intended for a specific hardware.

Extracting the Sources
~~~~~~~~~~~~~~~~~~~~~~

.. important:: Do the following steps at best in your own home directory ($HOME).
  You need *root* permissions only in the ``make install`` step, and **nowhere**
  else.

To install PTXdist, the archive Pengutronix provides has to be
extracted:

ptxdist-|ptxdistVendorVersion|.tar.bz2
    The PTXdist software itself

The PTXdist archive has to be extracted into some temporary directory in
order to be built before the installation, for example the ``local/``
directory in the user’s home. If this directory does not exist, we have
to create it and change into it:

::

    $ cd
    $ mkdir local
    $ cd local

Next step is to extract the archive:

::

    $ tar -xjf ptxdist-|ptxdistVendorVersion|.tar.bz2

If everything goes well, we now have a ``ptxdist-|ptxdistVendorVersion|``
directory, so we can change into it:

::

    $ cd ptxdist-|ptxdistVendorVersion|
    $ ls -lF
    total 396
    -rw-r--r--   1 jbe ptx  18446 Apr 29 09:36 COPYING
    -rw-r--r--   1 jbe ptx   3933 Apr 29 09:36 CREDITS
    -rw-r--r--   1 jbe ptx     57 Apr 29 09:36 INSTALL
    -rw-r--r--   1 jbe ptx   4483 Apr 29 09:36 Makefile.in
    -rw-r--r--   1 jbe ptx   3501 Apr 29 09:36 README
    -rw-r--r--   1 jbe ptx   2324 Apr 29 09:36 README.devel
    -rwxr-xr-x   1 jbe ptx     28 Apr 29 09:36 autogen.sh*
    drwxr-xr-x   2 jbe ptx   4096 Apr 29 09:36 bin/
    drwxr-xr-x  16 jbe ptx   4096 Apr 29 09:36 config/
    -rwxr-xr-x   1 jbe ptx 214583 Apr 29 15:55 configure*
    -rw-r--r--   1 jbe ptx  12570 Apr 29 09:36 configure.ac
    drwxr-xr-x   4 jbe ptx   4096 Apr 29 09:36 doc/
    drwxr-xr-x   2 jbe ptx   4096 Jun 21 09:52 man/
    drwxr-xr-x 263 jbe ptx  12288 Apr 29 09:36 patches/
    drwxr-xr-x   2 jbe ptx   4096 Apr 29 09:36 platforms/
    drwxr-xr-x   4 jbe ptx   4096 Apr 29 09:36 plugins/
    drwxr-xr-x  11 jbe ptx   4096 Apr 29 09:36 projectroot/
    drwxr-xr-x   6 jbe ptx  69632 Apr 29 09:36 rules/
    drwxr-xr-x   9 jbe ptx   4096 Apr 29 09:36 scripts/
    drwxr-xr-x   2 jbe ptx   4096 Apr 29 09:36 tests/

Prerequisites
~~~~~~~~~~~~~

Before PTXdist can be installed it has to check if all necessary
programs are installed on the development host (e.g. external dependencies).
The ``configure`` script will stop if it discovers that something is missing.

The PTXdist installation is based on GNU autotools, so the first thing
to be done now is to configure the package:

::

    $ ./configure

This will check your system for required components PTXdist relies on.
If all required components are found, the output ends with:

::

    [...]
    checking whether Python development files are present... yes
    checking for patch... /usr/bin/patch
    checking whether /usr/bin/patch will work... yes

    configure: creating ./config.status
    config.status: creating Makefile

    ptxdist version |ptxdistVendorVersion| configured.
    Using '/usr/local' for installation prefix.

    Report bugs to ptxdist@pengutronix.de

Without further arguments, PTXdist is configured to be installed into
``/usr/local``, which is the standard location for user installed
programs. To change the installation path to anything non-standard, we
use the ``--prefix`` argument to the ``configure`` script. The
``--help`` option offers more information about what else can be changed
for the installation process.

The installation paths are configured in a way that several PTXdist
versions can be installed in parallel. So if an old version of PTXdist
is already installed, there is no need to remove it.

One of the most important tasks for the ``configure`` script is to find
out whether all the programs PTXdist depends on are already present on the
development host. The script will stop with an error message in case
something is missing. If this happens, the missing tools have to be
installed from the distribution befor re-running the ``configure``
script.

When the ``configure`` script is finished successfully, we can now run

::

    $ make

All program parts are being compiled, and if there are no errors, we can
now install PTXdist into it’s final location. In order to write to
``/usr/local``, this step has to be performed as user *root*:

::

    $ sudo make install
    [enter password]
    [...]

If we don’t have root access to the machine, it is also possible to
install PTXdist into some different directory with the ``--prefix`` option.
We need to take care that the ``bin/`` directory below the new
installation dir is added to our ``$PATH`` environment variable (for
example by exporting it in ``~/.bashrc``).

The installation is now done, so the temporary folder may now be
removed:

::

    $ cd ../../
    $ rm -fr local

Configuring PTXdist
~~~~~~~~~~~~~~~~~~~

When using PTXdist for the first time, some setup properties have to be
configured. Two settings are the most important ones: where to store the
source archives and whether a proxy must be used to gain access to the world
wide web.

Run PTXdist’s setup:

::

    $ ptxdist setup

Due to the fact that PTXdist is working with sources only, it needs
various source archives from the world wide web. If these archives are
not present on our host, PTXdist will download them on demand.

Proxy Setup
^^^^^^^^^^^

To do so, internet access is required. If this access is managed by a
proxy, PTXdist can be configured to use it: navigate to
entry *Proxies* and enter the required addresses and ports to access the
proxy in the form: ``<protocol>://<address>:<port>``


.. _source-arch-loc:

Source Archive Location
^^^^^^^^^^^^^^^^^^^^^^^

Whenever PTXdist downloads source archives, it stores these archives
locally in the project folder. This is the default behaviour. If we are working
with more than one PTXdist based project, every project would download
its own required archives in this case. To share all source archives
between all projects, PTXdist can be configured to share only one
archive directory for all projects it handles: navigate to menu entry
*Source Directory* and enter the path to the directory where PTXdist
should store archives to share between its projects.

Toolchains
----------

Before we can start building our first userland, we need a cross
toolchain. On Linux, toolchains are no monolithic beasts. Most parts of
what we need to cross compile code for the embedded target comes from
the *GNU Compiler Collection*, ``gcc``. The gcc package includes the
compiler frontend, ``gcc``, plus several backend tools (``cc1``, ``g++``, ``ld``
etc.) which actually perform the different stages of the compile
process. ``gcc`` does not contain the assembler, so we also need the
*GNU Binutils package* which provides lowlevel stuff.

Cross compilers and tools are usually named like the corresponding host
tool, but with a prefix – the *GNU target*. For example, the cross
compilers for ARM and powerpc may look like 
``arm-softfloat-linux-gnu-gcc`` or ``powerpc-unknown-linux-gnu-gcc``.

With these compiler frontends we can convert e.g. a C program into
binary code for specific machines. So for example if a C program is to
be compiled natively, it works like this:

::

    $ gcc test.c -o test

To build the same binary for the ARM architecture we have to use the
cross compiler instead of the native one:

::

    $ arm-softfloat-linux-gnu-gcc test.c -o test

Also part of what we consider to be the “toolchain” is the run-time
library (libc, dynamic linker). All programs running on the embedded
system are linked against the libc, which also offers the interface from
user space functions to the kernel.

The compiler and libc are very tightly coupled components: the second
stage compiler, which is used to build normal user space code, is being
built against the libc itself. For example, if the target does not
contain a hardware floating point unit, but the toolchain generates
floating point code, it will fail. This is also the case when the
toolchain builds code for i686 CPUs, but the target is i586.

So in order to make things working consistently it is necessary that the
run-time libc is identical with the libc that the compiler was built against.

PTXdist doesn’t contain a pre-built binary toolchain. Remember that it’s
not a distribution, but a development tool. But it can be used to build a
toolchain for our target. Building the toolchain usually has only to be
done once. It may be a good idea to do that over night, because it may
take several hours, depending on the target architecture and development
host power.

Using Existing Toolchains from Different Vendors
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If a toolchain from a different vendor than OSELAS is already installed
and is known to be working, building the toolchain with PTXdist
may be omitted.

The OSELAS.BSP() packages shipped for PTXdist have been tested
with the OSELAS.Toolchains() built with the same PTXdist version. So if
an external toolchain is being used which isn’t known to be stable, a
target may fail. Note that not all compiler versions and combinations
work properly in a cross environment.

Every OSELAS.BSP() checks for the OSELAS.Toolchain() it was
tested against, so using a toolchain from a different vendor than OSELAS
requires an additional step:

Open the OSELAS.BSP() menu with:

::

    $ ptxdist platformconfig

and navigate to *architecture* → *toolchain* →
*check for specific toolchain vendor*. Clear this entry to disable the
toolchain vendor check.

Toolchains from a different vendor must meet some preconditions:

-  it must be built with the configure option ``--with-sysroot``
   pointing to its own C libraries.

-  it should not support the *multilib* feature as this may confuse
   PTXdist as to which libraries are to be copied to the root filesystem

If we want to check whether our toolchain was built with the
``--with-sysroot`` option, we just run this simple command:

::

    $ mytoolchain-gcc -v 2>&1 | grep with-sysroot

If this command **does not** output anything, this toolchain was not
built with the ``--with-sysroot`` option and cannot be used with
PTXdist.

Using a Pre-Built Toolchain
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pengutronix also provides ready-to-use binary toolchains.
These toolchains are built from the OSELAS.Toolchain() bundle, so they
comply with all of Pengutronix’s board support packages and we can use
them instead of building our own.

The binary OSELAS toolchains are provided as *Debian Distribution
Packages*, but the contents of those packages are usable on
non-Debian distributions as well.

In order to install the OSELAS binary toolchains on a Debian based
system the following steps are required:

Add the Pengutronix Debian Archive
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To make the package repository known to the package manager, *apt*, we create a
new file named ``pengutronix.list`` in the directory
``/etc/apt/sources.list.d/``.
(The basename of this file isn’t important, but the extension ``.list`` is.)

The contents of this new file describe the Pengutronix server as an
available package source. It is defined via one text line:

::

    deb https://debian.pengutronix.de/debian/ sid main contrib non-free

.. note::
  If the directory ``/etc/apt/sources.list.d/`` does not exist, the
  text line mentioned above must be added to the file
  ``/etc/apt/sources.list`` instead.

The package manager must now update its packages list with the following
command:

::

    $ apt-get update

To avoid warnings about untrusted package sources we can install the
Pengutronix archive keyring with the following command:

::

    $ apt-get install pengutronix-archive-keyring

Install the Binary OSELAS Toolchain
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now everything is in place to install the binary OSELAS toolchain for
the board support package:

::

    $ apt-get install oselas.toolchain-|oselasTCNVendorVersion|-|ptxdistCompilerName|-<ptxdistCompilerVersion>

These package names are very long and hard to type without making typos.
An easier way is to ask the package manager for available toolchains and
just copy and paste the name.

::

    $ apt-cache search "oselas.toolchain-.*-|oselasTCNarch|.*|oselasTCNvariant|.*"
    oselas.toolchain-|oselasTCNVendorVersion|-|ptxdistCompilerName|-<ptxdistCompilerVersion>

The Binary OSELAS Toolchain Package for non-Debian Distributions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can also use the Debian packages for non-Debian Linux distributions.

The Debian packages can be found on our server at
http://debian.pengutronix.de/debian/pool/main/o/oselas.toolchain

Navigate to the path 
``| oselas.toolchain-|oselasTCNVendorVersion|-|ptxdistCompilerName|-|ptxdistCompilerVersion|/``
and download the package named
``| oselas.toolchain-|oselasTCNVendorVersion|-|ptxdistCompilerName|-|ptxdistCompilerVersion|\*.deb``

Package filenames for 32-bit host machines end with ``*_i386.deb``,
for 64-bit host machines the filenames end with ``*_amd64.deb``.

You can simply unpack the Debian packages with ``ar``::

    ar x | oselas.toolchain-|oselasTCNVendorVersion|-|ptxdistCompilerName|-|ptxdistCompilerVersion|\*.deb

This will create the files ``debian-binary``, ``control.tar.gz`` and
``data.tar.xz``.  Ignore the first two, and unpack ``data.tar.xz`` into your
root file system::

    $ sudo tar xf data.tar.xz -C /

The toolchain can now be found in
``/opt/OSELAS.Toolchain-|oselasTCNVendorVersion|/|ptxdistCompilerName|/|ptxdistCompilerVersion|/``.

Building a Toolchain
~~~~~~~~~~~~~~~~~~~~

If there is no different toolchain available yet, the next step is to build one
at least for the desired target architecture.

PTXdist handles toolchain building as a simple project, like all other
projects, too. So we can download the OSELAS.Toolchain() bundle and build
the required toolchain for the OSELAS.BSP() project.

Building any toolchain of the OSELAS.Toolchain-|oselasTCNVendorVersion| family is
tested with PTXdist-|oselasTCNVendorptxdistversion|.
Pengutronix recommends to use this specific PTXdist to build the
toolchain. So, it might be essential to install more than one PTXdist
revision to build the toolchain and later on the Board Support Package
if the latter one is made for a different PTXdist revision.

A PTXdist project generally allows building into some project defined
directory; all OSELAS.Toolchain() projects that come with PTXdist are
configured to use the standard installation paths mentioned below,
and install their result into /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|/.

Usually the ``/opt`` directory is not world writeable. So in order to
build our OSELAS.Toolchain() into that directory we need to use a root
account to change the permissions. PTXdist detects this case and asks
if we want to run ``sudo`` to do the job for us. Alternatively we can
enter:

::

   $ mkdir /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|
   $ chown <username> /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|
   $ chmod a+rwx /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|

We recommend to keep this installation path as PTXdist expects the
toolchains in ``/opt``. Whenever we go to select a platform in a
project, PTXdist tries to find the right toolchain from data read from
the platform configuration settings and a toolchain at ``/opt`` that
matches to these settings. But that’s for our convenience only. If we
decide to install the toolchains at a different location, we can still
use the *toolchain* parameter to define the toolchain to be used on a
per project base.

Building the OSELAS.Toolchain for |ptxdistBSPName|
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Do the following steps in your own home directory (``$HOME``). The final
OSELAS.Toolchain gets installed to ``opt/``, but must **never** be
compiled in the ``opt/`` directory. You will get many funny error
messages if you try to compile the OSELAS-Toolchain in ``opt/``.

To compile and install an OSELAS.Toolchain we have to extract the
OSELAS.Toolchain archive, change into the new folder, configure the
compiler in question and start the build.

The required compiler to build the board support package is

|oselasToolchainName|.ptxconfig

.. important:: Please ensure the ’current directory’ (the ``.`` entry) is not part of
  your PATH environment variable. PTXdist tries to sort out this entry,
  but might not be successful in doing so. Check by running
  ``ptxdist print PATH`` if the output still contains any kind of ’current
  directory’ as a component. If yes, remove it first.

So the steps to build this toolchain are:

::

    $ tar xf OSELAS.Toolchain-|oselasTCNVendorVersion|.tar.bz2
    $ cd OSELAS.Toolchain-|oselasTCNVendorVersion|
    $ ptxdist-|oselasTCNVendorptxdistversion| select ptxconfigs/|oselasToolchainName|.ptxconfig
    $ ptxdist-|oselasTCNVendorptxdistversion| go

At this stage we have to go to our boss and tell him that it’s probably
time to go home for the day. Even on reasonably fast machines the time
to build an OSELAS.Toolchain is something like around 30 minutes up to a
few hours.

Measured times on different machines:

+---------------------------------------------+--------------------------+
| Machine                                     | Build Time               |
+=============================================+==========================+
| Single Pentium 2.5 GHz, 2 GiB RAM           | about 2 hours            |
+---------------------------------------------+--------------------------+
| Turion ML-34, 2 GiB RAM                     | about 1 hour 30 minutes  |
+---------------------------------------------+--------------------------+
| Dual Athlon 2.1 GHz, 2 GiB RAM              | about 1 hour 20 minutes  |
+---------------------------------------------+--------------------------+
| Dual Quad-Core-Pentium 1.8 GHz, 8 GiB RAM   | about 25 minutes         |
+---------------------------------------------+--------------------------+
| 24 Xeon cores 2.54 GHz, 96 GiB RAM          | about 22 minutes         |
+---------------------------------------------+--------------------------+

Another possibility is to read the next chapters of this manual, to find
out how to start a new project.

When the OSELAS.Toolchain() project build is finished, PTXdist is ready
for prime time and we can continue with our first project.

Protecting the Toolchain
~~~~~~~~~~~~~~~~~~~~~~~~

All toolchain components are built with regular user permissions. In
order to avoid accidential changes in the toolchain, the files should be
set to read-only permissions after the installation has finished
successfully. It is also possible to set the file ownership to root.
This is an important step for reliability, so it is highly recommended.

Building additional Toolchains
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OSELAS.Toolchain- bundle comes with various predefined toolchains.
Refer the ``ptxconfigs/`` folder for other definitions. To build
additional toolchains we only have to clean our current toolchain
project, removing the current ``selected_ptxconfig`` link and creating a
new one.

::

    $ ptxdist clean
    $ rm selected_ptxconfig
    $ ptxdist select ptxconfigs/any_other_toolchain_def.ptxconfig
    $ ptxdist go

All toolchains will be installed side by side architecture dependent
into directory

| /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|/<architecture>

Different toolchains for the same architecture will be installed side by
side version dependent into directory

| /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|/<architecture>/<version>


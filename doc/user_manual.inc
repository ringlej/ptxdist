How does it work?
-----------------

PTXdist supports various aspects of the daily work to develop, deploy
and maintain an embedded Linux based project.

.. figure:: figures/project-handling.png
   :alt:  Objectives in a project
   :align: center
   :figwidth: 80 %

   Objectives in a project

The most important part is the development. For this project phase,
PTXdist provides features to ensure reproducibility and verifiability.

PTXdist’s perception of the world
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist works project centric. A PTXdist project contains all
information and files to populate any kind of target system with all
required software components.

-  Specific configuration for

   -  Bootloader

   -  Kernel

   -  Userland (root filesystem)

-  Adapted files (or generic ones) for run-time configuration

-  Patches for all kind of components (to fix bugs or improve features)

Some of these information or files are coming from the PTXdist base
installation (patches for example), but also can be part of the project
itself. By this way, PTXdist can be adapted to any kind of requirement.

Most users are fine with the information and files the PTXdist base
installation provides. Development of PTXdist is done in a way to find
default settings most user can work with. But advanced users can still
adapt it to their special needs.

As stated above, a PTXdist project consists of all required parts, some
of these parts are separated by design: PTXdist separates a platform
configuration from userland configuration (root filesystem). So,
platforms can share a common userland configuration, but use a specific
kernel configuration in their own platform configuration.

Collecting various platforms into one single project should help to
maintain such projects. But some platforms do need special userland
(think about graphic/non graphic platforms). To be able to also collect
this requirement into one single project, so called *collections* are
supported. With this feature, a user can configure a full featured main
userland, reduced via a collection by some components for a specific
platform where it makes no sense to build and ship them.

A different use case for collections could be the security of an
application. While the development is ongoing all kind of debugging and
logging helpers are part of the root filesystem. But the final
production root filesystem uses collections to omit all these helpers
and to reduce the risk of security vulnerability.

PTXdist can handle the following project variations:

-  one hardware platform, one userland configuration (common case)

-  one hardware platform, various userland configurations

-  various hardware platforms, one userland configuration (common case)

-  various hardware platforms, one userland configuration, various
   collections

-  various hardware platforms, various userland configuration

-  various hardware platforms, various userland configuration, various
   collections

PTXdist’s build process
~~~~~~~~~~~~~~~~~~~~~~~

When PTXdist is building one part (we call it a *package*) of the whole
project, it is divided into up to six stages:

.. FIXME: this figure is bogus. The ipkgs are created during targetinstall
.. .. figure:: figures/ptxbuild.png
..    :alt:  The build process
..    :align: center
..
..    The build process

**get**
    The package will be obtained from its source (downloaded from the
    web for example)

**extract**
    The package archive gets extracted and patched if a patch set for
    this package exists

**prepare**
    Many packages can be configured in various ways. If supported, this
    stage does the configuration in a way defined in the menu (project
    specific)

**compile**
    The package gets built.

**install**
    The package installs itself into a project local directory. This
    step is important at least for libraries (other packages may depend
    on)

**targetinstall**
    Relevant parts of the package will be used to build an IPKG archive
    and the root filesystem

For each single package, one so called *rule file* exists, describing
the steps to be done in each stage shown above (refer section
:ref:`rulefile` for further details).

Due to the *get* stage, PTXdist needs a working internet connection to
download an archive currently not existing on the development host. But
there are ways to prevent PTXdist from doing so (refer to section
:ref:`source-arch-loc`).

First steps with PTXdist
------------------------

PTXdist works as a console command tool. Everything we want PTXdist to
do, we have to enter as a command. But it’s always the same base
command:

::

    $ ptxdist <parameter>

To run different functions, this command must be extended by parameters
to define the function we want to run.

If we are unsure what parameter must be given to obtain a special
function, we run it with the parameter *help*.

::

    $ ptxdist help

This will output all possible parameters and subcommands and their
meaning.

As the list we see is very long, let’s explain the major parameters
usually needed for daily usage:

``menu``
    This starts a dialog based frontend for those who do not like typing
    commands. It will gain us access to the most common parameters to
    configure and build a PTXdist project.

``menuconfig``
    Starts the Kconfig based project configurator for the current
    selected userland configuration. This menu will give us access to
    various userland components that the root filesystem of our target
    should consist of.

``menuconfig platform``
    Starts the Kconfig based platform configurator. This menu lets us
    set up all target specific settings. Major parts are:

    -  Toolchain (architecture and revision)

    -  boot loader

    -  root filesystem image type

    -  Linux kernel (revision)

    Note: A PTXdist project can consist of more than one platform
    configuration at the same time.

``menuconfig kernel``
    Runs the standard Linux kernel Kconfig to configure the kernel for
    the current selected platform. To run this feature, the kernel must
    be already set up for this platform.

``menuconfig barebox``
    Runs the standard Barebox bootloader Kconfig to configure the bootloader for
    the current selected platform. To run this feature, the bootloader must
    be already set up for this platform.

``menuconfig collection``
    If multiple platforms are sharing one userland configuration,
    collections can define a subset of all selected packages for
    specific platforms. This is an advanced feature, rarely used.

``toolchain``
    Sets up the path to the toolchain used to compile the current
    selected platform. Without an additional parameter, PTXdist tries
    to guess the toolchain from platform settings. To be successful,
    PTXdist depends on the OSELAS.Toolchains installed to the ``/opt``
    directory.
    If PTXdist wasn’t able to autodetect the toolchain, an additional
    parameter can be given to provide the path to the compiler,
    assembler, linker and so on.

``select``
    Used to select the current userland configuration, which is only
    required if there is no ``selected_ptxconfig`` in the project’s main
    directory. This parameter needs the path to a valid ``ptxconfig``.
    It will generate a soft link called ``selected_ptxconfig`` in the
    project’s main directory.

``platform``
    Used to select the current platform configuration, which is only
    required if there is no ``selected_platformconfig`` in the project’s
    main directory. This parameter needs the path to a valid
    ``platformconfig``. It will generate a soft link called
    ``selected_platformconfig`` in the project’s main directory.

``collection``
    Used to select the current collection configuration, which is only
    required in special cases. This parameter needs the path to a valid
    ``collection``. It will generate a soft link called
    ``selected_collection`` in the project’s main directory. This is an
    advanced feature, rarely used.

``go``
    The mostly used command. This will start to build everything to get
    all the project defined software parts. Also used to rebuild a part
    after its configuration was changed.

``images``
    Used at the end of a build to create an image from all userland
    packages to deploy the target (its flash for example or its hard
    disk).

``setup``
    Mostly run once per PTXdist revision to set up global paths and the
    PTXdist behavior.

For a more complete description refer :ref:`ptxdist_parameter_reference`

All these commands depending on various files a PTXdist based project
provides. So, running the commands make only sense in directories that
contains a PTXdist based project. Otherwise PTXdist gets confused and
confuses the user with funny error messages.

To show the usage of some listed major subcommands, we are using a
generic PTXdist based project.

Extracting the Board Support Package
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to work with a PTXdist based project we have to extract the
archive first.

::

    $ tar -zxf |ptxdistBSPName|.tar.gz
    $ cd |ptxdistBSPName|

PTXdist is project centric, so now after changing into the new directory
we have access to all valid components.

::

  total 32
  -rw-r--r-- 1 jb users 1060 Jul  1 16:33 ChangeLog
  -rw-r--r-- 1 jb users  741 Jul  1 15:12 README
  drwxr-xr-x 5 jb users 4096 Jul  1 15:17 configs
  drwxr-xr-x 3 jb users 4096 Jul  1 16:51 documentation
  drwxr-xr-x 5 jb users 4096 Jul  1 15:12 local_src
  drwxr-xr-x 4 jb users 4096 Jul  1 15:12 patches
  drwxr-xr-x 5 jb users 4096 Jul  1 15:12 projectroot
  drwxr-xr-x 3 jb users 4096 Jul  1 15:12 rules

Notes about some of the files and directories listed above:

**ChangeLog**
    Here you can read what has changed in this release. Note: This file
    does not always exist.

**documentation**
    If this BSP is one of our OSELAS BSPs, this directory contains the
    Quickstart you are currently reading in.

**configs**
    A multiplatform BSP contains configurations for more than one
    target. This directory contains the respective platform
    configuration files.

**projectroot**
    Contains files and configuration for the target’s run-time. A running
    GNU/Linux system uses many text files for run-time configuration.
    Most of the time, the generic files from the PTXdist installation
    will fit the needs. But if not, customized files are located in this
    directory.

**rules**
    If something special is required to build the BSP for the target it
    is intended for, then this directory contains these additional
    rules.

**patches**
    If some special patches are required to build the BSP for this
    target, then this directory contains these patches on a per package
    basis.

**tests**
    Contains test scripts for automated target setup.

Next we will build the BSP to show some of PTXdist’s main features.

Selecting a Userland Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

First of all we have to select a userland configuration. This step
defines what kind of applications will be built for the hardware
platform. The |ptxdistBSPName| project comes
with a predefined configuration we select in the following step:

::

    $ ptxdist select configs/ptxconfig
    info: selected ptxconfig:
          'configs/ptxconfig'

Selecting a Hardware Platform
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before we can build this BSP, we need to select one of the possible
platforms to build for. In this case we want to build for the
|ptxdistPlatformName|:

::

    $ ptxdist platform configs/|ptxdistPlatformConfigDir|/platformconfig
    info: selected platformconfig:
          'configs/|ptxdistPlatformConfigDir|/platformconfig'

.. note:: If you have installed the OSELAS.Toolchain() at its default
  location, PTXdist should already have detected the proper toolchain
  while selecting the platform. In this case it will output:

::

    found and using toolchain:
    '/opt/OSELAS.Toolchain-|oselasTCNVendorVersion|/|ptxdistCompilerName|/|ptxdistCompilerVersion|/bin'

If it fails you can continue to select the toolchain manually as
mentioned in the next section. If this autodetection was successful, we
can omit the steps of the section and continue to build the BSP.

Selecting a Toolchain
~~~~~~~~~~~~~~~~~~~~~

If not automatically detected, the last step in selecting various
configurations is to select the toolchain to be used to build everything
for the target.

::

    $ ptxdist toolchain /opt/OSELAS.Toolchain-|oselasTCNVendorVersion|/|ptxdistCompilerName|/|ptxdistCompilerVersion|/bin

Building the Root Filesystem Content
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now everything is prepared for PTXdist to compile the BSP. Starting the
engines is simply done with:

::

    $ ptxdist go

PTXdist does now automatically find out from the ``selected_ptxconfig``
and ``selected_platformconfig`` files which packages belong to the
project and starts compiling their *targetinstall* stages (that one that
actually puts the compiled binaries into the root filesystem). While
doing this, PTXdist finds out about all the dependencies between the
packages and builds them in correct order.

What we Got Now
~~~~~~~~~~~~~~~

After building the project, we find even more sub directories in our
project.

``|ptxdistPlatformDir|/build-cross``
    Contains all packages sources compiled to run on the host and handle
    target architecture dependent things.

``|ptxdistPlatformDir|/build-host``
    Contains all packages sources compiled to run on the host and handle
    architecture independend things.

``|ptxdistPlatformDir|/build-target``
    Contains all package sources compiled for the target architecture.

``|ptxdistPlatformDir|/images``
    Generated files for the target can be found here: Kernel image and
    root filesystem image.

``|ptxdistPlatformDir|/packages``
    Location for all individual packages in ipk format.

``|ptxdistPlatformDir|/sysroot-target``
    Contains everything target architecture dependent (libraries, header
    files and so on).

``|ptxdistPlatformDir|/sysroot-cross``
    Contains everything that is host specific but must handle target
    architecture data.

``|ptxdistPlatformDir|/sysroot-host``
    Contains everything that is only host specific.

``|ptxdistPlatformDir|/root``
    Target’s root filesystem image. This directory can be mounted as
    an NFS root for example. Refer :ref:`nfsroot` for further details how to
    make use of it. In case of a debug session, this directory can be used
    by a modern GDB for its sysroot as well by using
    ``set sysroot </path/to/workspace>/|ptxdistPlatformDir|/root``:
    All binaries are stripped but all debug symbols are saved in special
    debug files in ``.debug`` sub-directories. GDB knows about this and
    will load these files automatically.

``|ptxdistPlatformDir|/state``
    Building every package is divided onto stages. And stages of one
    package can depend on stages of other packages. In order to handle
    this correctly, this directory contains timestamp files about
    finished stages.

And one important file in case of trouble:

``|ptxdistPlatformDir|/logfile``
    Every run of PTXdist will add its output to this file. If something
    fails, this file can help to find the cause.

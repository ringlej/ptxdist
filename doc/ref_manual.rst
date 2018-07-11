PTXdist Reference
=================

Variables Reference
-------------------

The following variables are provided by PTXdist to simplify creating
rule files. Every developer should use these variables in every single
line in the **rule file** to avoid any further adaption when external paths
are changed.

To get their content related to the current project, we can simply run
a:

::

    $ ptxdist print PTXDIST_TOPDIR
    /usr/local/lib/ptxdist-|ptxdistVendorVersion|

Replace the ``PTXDIST_TOPDIR`` with one of the other generic variables
PTXdist provides.

Global Variables
~~~~~~~~~~~~~~~~

``PTXDIST_TOPDIR``
  Points always to the installation directory of PTXdist.

``PTXDIST_WORKSPACE``
  Everything that references ``PTXDIST_WORKSPACE`` will use the active
  projects’s folder.

``PTXDIST_SYSROOT_CROSS``
  ``PTXDIST_SYSROOT_CROSS`` points to a directory tree all cross relevant
  executables, libraries and header files are installed to in the current
  project. All of the project’s packages built for the host to create data
  for the target are searching in this directory tree for their
  dependencies (executables, header and library files). Use
  ``$(PTXDIST_SYSROOT_CROSS)/bin`` to install executables,
  ``$(PTXDIST_SYSROOT_CROSS)/include`` for header files and
  ``$(PTXDIST_SYSROOT_CROSS)/lib`` for libraries.

``PTXDIST_SYSROOT_HOST``
  ``PTXDIST_SYSROOT_HOST`` points to a directory tree all host relevant
  executables, libraries and header files are installed to. All project’s
  packages built for the host are searching in this directory tree for
  their dependencies (executables, header and library files). Use
  ``$(PTXDIST_SYSROOT_HOST)/bin`` to install executables,
  ``$(PTXDIST_SYSROOT_HOST)/include`` for header files and
  ``$(PTXDIST_SYSROOT_HOST)/lib`` for libraries.

``PTXDIST_SYSROOT_TARGET``
  ``PTXDIST_SYSROOT_TARGET`` points to a directory tree all target
  relevant libraries and header files are installed to. All project’s
  packages built for the target are searching in this directory tree for
  their dependencies (header and library files). These files are for
  compile time only (for example to link a target executable against a
  target library), not for run-time! Use
  ``$(PTXDIST_SYSROOT_TARGET)/include`` for header files and
  ``$(PTXDIST_SYSROOT_TARGET)/lib`` for libraries.

Other useful variables:

``CROSS_PATH``
  Use to find cross tools. This path must be used to create anything that
  depends on the target’s architecture, but needs something running on the
  host to do the job. Examples:

  **Creating a UBI image from the target’s root filesystem**
      This will need a tool running on the host, but it will create data
      or code that runs on or is used on the target

  **Building a library for the target**
      If this library needs other resources to be built (other libraries)
      its ``configure`` finds the right information in this path.

``HOST_PATH``
  Used to find host tools. This path must be used to create anything that
  doesn't depend on the architecture.

``ROOTDIR``
  ``ROOTDIR`` points to the root of the target’s root filesystem in the
  current project. Used in very rare cases (to create strange packages
  based on data in target’s root filesystem for example).

``PTXCONF_PLATFORM``
  ``PTXCONF_PLATFORM`` expands to the name of the currently selected
  platform. This name is used in various file names and paths.

``PTXDIST_PLATFORMSUFFIX``
  ``PTXDIST_PLATFORMSUFFIX`` expands to the name of the currently selected
  platform, but with a leading dot. This is used in various files PTXdist
  should search for.

``PTXDIST_PLATFORMCONFIGDIR``
  ``PTXDIST_PLATFORMCONFIGDIR`` points to the directory tree of the
  currently selected platform. This path is used in various search
  functions.

``PTXDIST_PLATFORMDIR``
  ``PTXDIST_PLATFORMDIR`` points to the directory build tree of the
  currently selected platform.

Package Specific Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~

For the following variables ``<PKG>`` is a placeholder for the package
name. It is also the Kconfig symbol name (without the ``PTXCONF_`` prefix).

Package Definition
^^^^^^^^^^^^^^^^^^

``<PKG>``
  This is the name of the package including version. For most packages,
  this is the name of the source archive (without suffix) and the source
  directory. PTXdist will search for patches in a directory with this name.
  This is usually defined as ``<name>-$(<PKG>_VERSION)``. This variable is
  required for most packages. The only exception are packages that only
  install some files in the targetinstall stage (e.g. from projectroot/).

``<PKG>_VERSION``
  The version of the package. It is used as the version for the ipk
  packages. As such, it is required for all packages that create such
  packages. Most target packages fall in this category.

``<PKG>_MD5``
  The md5 checksum of the source archive. PTXdist calculates the checksum
  before extracting the archive and will abort if does not match. Upstream
  project occasionally change the content of an archive without releasing a
  new version. This check helps to ensure that all developers work with the
  same source code.

``<PKG>_SUFFIX``
  The archive suffix without the leading '.', e.g. 'tar.gz' or 'zip'. This
  is only used locally to define ``<PKG>_URL`` and ``<PKG>_SOURCE``.

``<PKG>_URL``
  This is the download URL for the source archive. It is a space separated
  list of URLs. PTXdist will try each URL until it finds one that works.
  There are two main reasons to provide more than one URL: 1. Additional
  mirror(s) in case the main location is unavailable. 2. Some projects move
  old versions into a separate directory when a new version is released.
  Providing both versions of the URL ensures that PTXdist still has a
  working URL after the next upstream release.

  URLs can have options. Options are appended to the URL separated by ';'.
  For normal downloads the following options are supported:

  ``no-check-certificate`` to indicate that SSL certificate checking should
  be disabled.

  ``no-proxy`` to disable any configured proxy.

  ``cookie:<value>`` to specify a cookie that should be sent.

  Files in the local filesystem can be addressed with ``file://`` URLs. In
  this case, the URL can also point to a directory. In this case
  ``<PKG>_DIR`` will be a symlink to the specified directory. 'lndir://'
  can be used to create a shadow copy instead. For locations inside the BSP
  the URL should use ``$(PTXDIST_WORKSPACE)`` to define the correct
  absolute path.

  If no source archive is available, PTXdist can get the source from
  revision control systems. 'git' and 'svn' are currently supported. Note
  that this cannot be used to follow a branch! PTXdist will create the
  archive defined ``<PKG>_SOURCE`` and use it if available.

  Git URLs must either start with 'git://' or end with '.git'. They have a
  mandatory ``tag=<tagname>`` option. Refer :ref:`gitSources` how to make use of
  it.

  Svn URLs must start with 'svn://'. They have a mandatory
  ``rev=r<number>`` option.

``<PKG>_SOURCE``
  The location of the downloaded source archive. There should be no reason
  to set this to anything other than
  ``$(SRCDIR)/$(<PKG>).$(<PKG>_SUFFIX)``.

  For local URLs (``file://`` or ``lndir://``) ``<PKG>_SOURCE`` must not be
  set.

``<PKG>_DIR``
  This is the directory where the source archive is extracted. In most
  cases this is set to ``$(BUILDDIR)/$(<PKG>)``. However, if two packages
  use the same source archive, then something else must be used to make
  sure that they use different directories. See the rules for 'gdb' and
  'gdbserver' for an example.

``<PKG>_LICENSE``
  The license of the package. The SPDX license identifiers should be used
  here. Use ``proprietary`` for proprietary packages and ``ignore`` for
  packages without their own license, e.g. meta packages or packages that
  only install files from ``projectroot/``.

``<PKG>_LICENSE_FILES``
  A space separated list of URLs of license text files. The URLs must be
  ``file://`` URLs relative to ``<PKG>_DIR``. Absolute URLs using
  ``$(PTXDIST_WORKSPACE)`` can be used in case the license text is missing
  in the upstream archive. Arguments are appended with ';' as separator.
  The ``md5=<md5sum>`` argument is mandatory. It defines the md5 checksum
  of the full license text. ``startline=<number>;endline=<number>`` can be
  used in case the specified file contains more than just the license text,
  e.g. if the license is in the header of a source file. For non ASCII or
  UTF-8 files the encoding can be specified with ``encoding=<enc>``.

For most packages the variables described above are undefined by default.
However, for cross and host packages these variables default to the value
of the corresponding target package if it exists.

``<PKG>_CONFIG``
  This variable specifies a configuration file of some kind for the
  packages. For packages with ``<PKG>_CONF_TOOL`` set to ``kconfig`` the
  variable must specify an absolute path to the kconfig file. For image
  packages that use genimage, PTXdist will look for
  ``config/images/$(<PKG>_CONFIG)`` in the BSP and PTXdist in the usual
  search order.

``<PKG>_STRIP_LEVEL``
  When PTXdist extracts source archives, it will create ``<PKG>_DIR``
  first and then extracts the archive there. If ``<PKG>_STRIP_LEVEL`` is
  set to 1 (the default) then PTXdist removes the first directory level
  defined inside the archive. For most packages that this is the same as
  just extracting the archive. However, this is useful for packages with
  badly named top-level directories or packages where the directory must be
  renamed to avoid collisions (e.g. gdbserver).

  The main use-case for ``<PKG>_STRIP_LEVEL`` is to set it to 0 for
  packages without a top-level directory.

  In theory ``<PKG>_STRIP_LEVEL`` could be set to 2 or more to remove more
  than one directory level.

``<PKG>_BUILD_OOT``
  If this is set to ``YES`` then PTXdist will build the package out of
  tree. This is only supported for autoconf, qmake and cmake packages. The
  default is ``YES`` for cmake packages and ``NO`` for everything else.
  It will use ``$(<PKG>_DIR)-build`` as build directory.

  This is especially useful for ``file://`` URLS that point to directories to
  keep the source tree free of build files.

``<PKG>_SUBDIR``
  This is a directory relative to ``<PKG>_DIR``. If set, all build
  operations are executed in this directory instead. By default
  ``<PKG>_SUBDIR`` is undefined so all operations are executed in the
  top-level directory.

Build Environment for all Stages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``<PKG>_PATH``
  This variable defines the PATH used by all build stages. It is evaluated
  as is, so it must start with ``PATH=``. If undefined, PTXdist will use
  ``PATH=$(CROSS_PATH)`` for target packages ``PATH=$(HOST_PATH)`` for host
  packages and ``PATH=$(HOST_CROSS_PATH)`` for cross packages. It must be
  set by packages that use the variable locally in the make file or if more
  directories are added, e.g. to
  ``PATH=$(PTXDIST_SYSROOT_CROSS)/bin/qt5:$(CROSS_PATH)`` for packages that
  use qmake from Qt5.

``<PKG>_CFLAGS``, ``<PKG>_CPPFLAGS``, ``<PKG>_LDFLAGS``
  Compiler, preprocessor and linker are never called directly in PTXdist.
  Instead, wrapper scripts are called that expand the command line before
  calling the actual tool. These variables can be used to influence these
  wrappers. The specified flags are added to the command line when
  appropriate. In most cases this it the preferred way to add additional
  flags. Adding them via environment variables or ``make`` arguments can
  have unexpected side effects, such as as overwriting existing defaults.

``<PKG>_WRAPPER_BLACKLIST``
  PTXdist has several options in the platformconfig that inject options in
  the compiler command line. This is used, for example, to add hardening
  options or change the debug options. This can occasionally cause problems
  for packages that use the compiler in certain ways, such as the Linux
  kernel or various bootloaders. With this variable a package can disable
  individual options by setting it to a space separated list of the
  corresponding Kconfig symbols (without the ``PTXCONF_`` prefix).

Prepare Stage
^^^^^^^^^^^^^

``<PKG>_CONF_ENV``
  The environment for the prepare stage. If undefined, PTXdist will use
  ``$(CROSS_ENV)`` for target packages, ``$(HOST_ENV)`` for host packages
  and ``$(HOST_CROSS_ENV)`` for cross packages. It must be set by packages
  that use the variable locally in the make file or if extra variables are
  added. In this case the definition should start with the default value.

``<PKG>_CONF_TOOL``
  This variable defines what tool is used to configure the package in the
  prepare stage. Possible values are:

   - ``NO`` to do nothing in the prepare stage.
   - ``autoconf`` for packages that use autoconf
   - ``qmake`` for qmake based packages. Note: the required Qt version must
     be selected.
   - ``cmake`` for cmake based packages. Note ``HOST_CMAKE`` must be
     selected to ensure, that cmake is available for configuration.
   - ``kconfig`` for kconfig based packages. Note ``<PKG>_CONFIG`` must be
     set as described above.
   - ``perl`` for perl modules.
   - ``python`` or ``python3`` for Python packages with a normal setup.py.

``<PKG>_CONF_OPT``
  This variable adds arguments to the command-line of the configuration
  tool. If undefined, PTXdist will use a default value that depends on the
  configuration tool of the package. This default value should also be used
  when adding additional options. The following defaults exist:

   - autoconf:
     ``$(CROSS_AUTOCONF_USR)``/``$(HOST_AUTOCONF)``/``$(HOST_CROSS_AUTOCONF)``
     for target/host/cross packages.
   - cmake: ``$(CROSS_CMAKE_USR)``/``$(HOST_CMAKE_OPT)`` for target/host
     packages. Cross packages cannot be built with cmake
   - qmake: ``$(CROSS_QMAKE_OPT)`` for host packages. Host and cross
     packages cannot be built with qmake.

  All other configuration tools have no default options. This variable is
  ignored for kconfig and python/python3.

Compile Stage
^^^^^^^^^^^^^

``<PKG>_MAKE_ENV``
  This variables defines additional environment variables for the compile
  stage. In most cases this variable remains undefined because all
  necessary defines are picked up in the prepare stage. For python/python3
  packages PTXdist will use the default value from ``<PKG>_CONF_ENV``.
  For packages without configuration tool this must be set correctly,
  usually based on the ``<PKG>_CONF_ENV`` default values.

``<PKG>_MAKE_OPT``
  This variables defines additional parameters to be forwarded to ``make`` in
  order to build the package. It defaults to nothing to let ``make`` traditionally
  build the first defined target.

``<PKG>_MAKE_PAR``
  This variables informs PTXdist, if this package can be built in parallel. Some
  (mostly very smart selfmade) buildsystems fail doing so. In this case this
  variable can be set to ``NO``. PTXdist will then build this package with one
  CPU only.

Install Stage
^^^^^^^^^^^^^

``<PKG>_INSTALL_OPT``
  This variable defaults to ``install`` which is used as a *target* for ``make``.
  It can be overwritten if the package needs a special target to install its
  results.

Targetinstall Stage
^^^^^^^^^^^^^^^^^^^

TBD

.. _image_packages:

Image Packages
^^^^^^^^^^^^^^

Image packages use a different set of variables. They have the same
``<PKG>`` and ``<PKG>_DIR`` variables as other packages, but the rest is
different.

``<PKG>_IMAGE``
  This is the filename of the image that is created by the rule. This is
  usually ``$(IMAGEDIR)/<image-file-name>``.

``<PKG>_FILES``
  This is a list of tar balls that are extracted to generate the content of
  the image. PTXdist will add the necessary dependencies to these files to
  recreate the image as needed. If a tar ball is created by another PTXdist
  package then this package should be selected in the menu file.

``<PKG>_PKGS``
  This is another mechanism to add files to the image. It can be uses
  instead of or in addition to ``<PKG>_FILES``. It must be set to a list of
  ptxdist packages (the lowercase name of the packages). PTXdist will add
  the necessary dependencies.

  Note that this will not ensure that the packages are enabled or that all
  all package dependencies are satisfied. ``$(PTX_PACKAGES_INSTALL)`` can
  be used to specify all enabled packages. Or ``$(call ptx/collection,
  $(PTXDIST_WORKSPACE)/configs/<collection-file-name>)`` can be uses to to
  specify the packages enabled by this collection. In both cases ``=`` must
  be uses instead of ``:=`` due to the makefile include order.

``<PKG>_CONFIG``
  ``genimage`` packages use this to specify the ``genimage`` configuration
  file. PTXdist will search for the specified file name in
  ``config/images/`` in the BSP, platform and PTXdist in the usual search
  order.

``<PKG>_NFSROOT``
  If this is set to ``YES`` then PTXdist will create a special nfsroot
  directory that contains only the files from the packages specified in
  ``<PKG>_PKGS``. This is useful if the normal nfsroot directory contains
  conflicting files from multiple images. The created nfsroot directory is
  ``<platform-dir>/nfsroot/<image-name>``.

``<PKG>_LABEL``
  This is a tar label to put on an image. This is supported by
  ``image-root-tgz`` and images created with the ``image-tgz`` template.

.. _reference_macros:

Rule File Macro Reference
-------------------------

Rules files in PTXdist are using macros to get things work. Its highly
recommended to use these macros instead of doing something by ourself. Using these
macros is portable and such easier to maintain in the case a project should be
upgraded to a more recent PTXdist version.

This chapter describes the predefined macros in PTXdist and their usage.

Whenever one of these macros installs something to the target's root filesystem,
it also accepts user and group IDs which are common in all filesystems Linux
supports. These IDs can be given as numerical values and as text strings.
In the case text strings are given PTXdist converts them into the
coresponding numerical value based on the BSP local files :file:`passwd` and :file:`group`.
If more than one file with these names are present in the BSP PTXdist follows
its regular rules which one it prefers.

Many paths shown here contains some parts in angle brackets. These have
special meanings in this document.

**<platform>**
  The name of a platform. Corresponds to the variable
  ``PTXCONF_PLATFORM``
**<platform-src>**
  The directory where the platform is defined. Corresponds to the variable
  ``PTXDIST_PLATFORMCONFIGDIR``
**<platform-dir>**
  Concatenated directory name with a leading *platform-* and the name of the
  selected platform name, e.g. <platform>. If the name of the currently active
  platform is *foo*, the final directory name is *platform-foo*.
  Corresponds to the variable ``PTXDIST_PLATFORMDIR``

.. note:: The list of supported macros is not complete yet.

targetinfo
~~~~~~~~~~

Usage:

.. code-block:: make

 $(call targetinfo)

Gives a feedback, what build *stage* is just started. Thats why it
should always be the first call for each *stage*. For the package
*foo* and the *compile stage* it will output:

.. code-block:: bash

 --------------------
 target: foo.compile
 --------------------

touch
~~~~~~

Usage:

.. code-block:: make

 $(call touch)

Gives a feedback, what build *stage* is just finished. Thats why it
should always be the last call for each *stage*. For the package
*foo* and the *compile stage* it will output:

.. code-block:: bash

 finished target foo.compile

clean
~~~~~

Usage:

.. code-block:: make

 $(call clean, <directory path>)

Removes the given directory ``<directory path>``

.. _install_copy:

install_copy
~~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_copy, <package>, <UID>, <GID>, <permission>, <source> [, <dest> [, <strip> ]])

Installs given file or directory into:

* the project's ``<platform-dir>/root/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

Some of the parameters have fixed meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID the file should use in the target's root filesystem
**<GID>**
  Group ID the file should use in the target's root filesystem
**<permission>**
  Permission (in an octal value) the file should use in the target's root filesystem

The remaining parameters vary with the use case:

The ``<source>`` parameter can be:

* a directory path that should be created in the target's root filesystem.
  In this case the <destination> must be omitted.
  The given path must always start with a ``/`` and means the root
  of the target's filesystem.
* an absolute path to a file that should be copied to the target's root
  filesystem. To avoid fixed paths, all packages are providing the
  <package> _DIR variable. So, this parameter in our
  *foo* example package can be a ``$(FOO_DIR)/foo``.
* a minus sign (``-``). PTXdist uses the <destination>
  parameter in this case to locate the file to copy from. This only works
  if the package uses the default *install* stage. Only in this
  case an additional folder in ``<platform-dir>/packages`` will
  be created for the package and its files. For our *foo* example
  package this directory is ``<platform-dir>/packages/foo-1.1.0``.

The ``<dest>`` parameter can be:

* omitted if a directory in target's root filesystem should be created.
  For this case the directory to be created is in the <source> parameter.
* an absolute path and filename with its root in target's root filesysem.
  It must start with a slash (``//``). If also the <source>
  parameter was given, the file can be renamed while copying.
  If the <source> parameter was given as a minus
  sign (``-``) the <destination> is also used to
  locate the source. For our *foo* example package if we give
  <destination> as ``/usr/bin/foo``, PTXdist
  copies the file ``<platform-dir>/packages/foo-1.1.0/usr/bin/foo``

The ``<strip>`` is a complete optional parameter to prevent
this macro from the regular stripping process it does on files. Most of the cases
stripping debug information from files is intended. But some kind of files getting
destroyed when this stripping happens to them. One example is a Linux kernel module.
If it gets stripped, it can't be loaded into the kernel anymore.

**full strip**
  fully strip the file while installing when this parameter is **y** or not
  given at all (default case).
**partially strip**
  only strips real debug information from the file when this parameter is
  **k**. Useful to keep Linux kernel module loadable at run-time
**no strip**
  preserve the file from being stripped when this parameter is one of the
  following: **0**, **n**, **no**, **N** or **NO**.

Due to the complexity of this macro, here are some usage examples:

Create a directory in the root filesystem:

.. code-block:: make

 $(call install_copy, foo, 0, 0, 0755, /home/user-foo)

Copy a file from the package build directory to the root filesystem:

.. code-block:: make

 $(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foo, /usr/bin/foo)

Copy a file from the package build directory to the root filesystem and rename
it:

.. code-block:: make

 $(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foo, /usr/bin/bar)

Copy a file from the package install directory to the root filesystem:

.. code-block:: make

 $(call install_copy, foo, 0, 0, 0755, -, /usr/bin/foo)

install_tree
~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_tree, <package>, <UID>, <GID>, <source dir>, <destination dir>)

Installs the whole directory tree with all files from the given directory into:

* the project's ``<platform-dir>/root/``
* an ipkg packet in the project's ``<platform-dir>/packages/``

Some of the parameters have fixed meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the UID from the source tree
**<GID>**
  Group ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the GID from the source tree
**<source dir>**
  This is the path to the tree of directories and files to be installed. It can
  be ``-`` to use the package directory of the current package instead
**<destination dir>**
  The basename of the to-be-installed tree in the root filesystem

Note: This installation macro

* uses the same permission flags in the destination dir as found
  in the source dir. This is valid for directories and regular files
* skips all directories with names like ``.svn``, ``.git``, ``.pc`` and
  ``CVS`` in the source directory

Examples:

Install the whole tree found in ``/home/jbe/foo`` to the root filesystem
at location ``/usr/share/bar``.

.. code-block:: make

 $(call install_tree, foo, 0, 0, /home/jbe/foo, /usr/share/bar)

Install all files from the tree found in the current package FOO to the root
filesystem at location ``/usr/share/bar``.

.. code-block:: make

 $(call install_tree, foo, 0, 0, -, /usr/share/bar)

If the current package is ``foo-1.0`` the base path for the directory tree
will be ``$(PKGDIR)/foo-1.0/usr/share/bar``.

install_alternative_tree
~~~~~~~~~~~~~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_alternative_tree, <package>, <UID>, <GID>, <destination dir>)

Installs the whole source directory tree with all files from the given directory into:

* the project's ``<platform-dir>/root/``
* an ipkg packet in the project's ``<platform-dir>/packages/``

The ``<destination dir>`` is used like in the ``install_alternative`` to let
PTXdist search in the same directories and order for the given directory.

Some of the parameters have fixed meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the UID from the source
**<GID>**
  Group ID the directories and files should use in the target's root
  filesystem or ``-`` to keep the GID from the source
**<destination dir>**
  The basename of the to-be-installed tree in the root filesystem

.. note:: This installation macro

  * uses the same permission flags in the destination dir as found in the source
    dir. This is valid for directories and regular files
  * skips all directories with names like ``.svn``, ``.git``, ``.pc`` and ``CVS``
    in the source directory

Examples:

Install the whole tree found in project's ``projectroot/usr/share/bar``
to the root filesystem at location ``/usr/share/bar``.

.. code-block:: make

 $(call install_alternative_tree, foo, 0, 0, /usr/share/bar)

To install nothing, use a symlink to ``/dev/null`` instead of the base
directory. See :ref:`install_alternative` for more details.

.. _install_alternative:

install_alternative
~~~~~~~~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_alternative, <package>, <UID>, <GID>, <permission>, <destination>)

Installs given files or directories into:

* the project's ``<platform-dir>/root/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

The base parameters and their meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID the file should use in the target's root filesystem
**<GID>**
  Group ID the file should use in the target's root filesystem
**<permission>**
  Permission (in an octal value) the file should use in the target's root filesystem

The parameter <destination> is meant as an absolute path
and filename in target's root filesystem. PTXdist searches for the source
of this file in:

* the local project
* in the used platform
* PTXdist's install path
* in the current package

As this search algorithm is complex, here an example for the file
``/etc/foo`` in package ``FOO``. PTXdist will search for this
file in the following order:

* project's directory ``projectroot.<platform>/etc/foo``
* project's directory ``projectroot/etc/foo.<platform>``
* platform's directory ``<platform-src>/projectroot/etc/foo.<platform>``
* project's directory ``projectroot/etc/foo``
* platform's directory ``<platform-src>/projectroot/etc/foo``
* ptxdist's directory ``projectroot/etc/foo``
* project's directory ``$(FOO_DIR)/etc/foo``

The generic rules are looking like the following:

* ``$(PTXDIST_WORKSPACE)/projectroot$(PTXDIST_PLATFORMSUFFIX)/etc/foo``
* ``$(PTXDIST_WORKSPACE)/projectroot/etc/foo$(PTXDIST_PLATFORMSUFFIX)``
* ``$(PTXDIST_PLATFORMCONFIGDIR)/projectroot/etc/foo$(PTXDIST_PLATFORMSUFFIX)``
* ``$(PTXDIST_WORKSPACE)/projectroot/etc/foo``
* ``$(PTXDIST_PLATFORMCONFIGDIR)/projectroot/etc/foo``
* ``$(PTXDIST_TOPDIR)/projectroot/etc/foo``
* ``$(FOO_DIR)/etc/foo``

Note: You can get the current values for the listed variables above via running
PTXdist with the ``print`` parameter:

.. code-block:: bash

 $ ptxdist print PTXDIST_PLATFORMSUFFIX

``install_alternative`` is used by upstream PTXdist packages to install
config files. In some rare use-cases the file should not be installed at
all. For example if the config file is generated at runtime or provided by
a special configuration package. This is possibly by creating a symlink to
``/dev/null`` instead of a file at one of the locations described above.
PTXdist skip installing the file if it detects such a symlink.

install_link
~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_link, <package>, <point to>, <where>)

Installs a symbolic link into:

* the project's ``<platform-dir>/root/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

The parameters and their meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<point to>**
  Path and name the link should point to. Note: This macro rejects absolute
  paths. If needed use relative paths instead.
**<where>**
  Path and name of the symbolic link.

A few usage examples.

Create a symbolic link as ``/usr/lib/libfoo.so`` pointing to
``libfoo.so.1.1.0`` in the same directory:

.. code-block:: make

 $(call install_link, foo, libfoo.so.1.1.0, /usr/lib/libfoo.so)

Create a symbolic link as ``/usr/bin/foo`` pointing to ``/bin/bar``:

.. code-block:: make

 $(call install_link, foo, ../../bin/bar, /usr/bin/foo)

.. _install_archive:

install_archive
~~~~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_archive, <package>, <UID>, <GID>, <archive> , <base path>)

Installs archives content into:

* the project's ``<platform-dir>/root/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

All parameters have fixed meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID all files and directory of the archive should use in the target's
  root filesystem. A ``-`` uses the file's/directory's UID in the archive
**<GID>**
  Group ID the files and directories should use in the target's root filesystem.
  A ``-`` uses the file's/directory's GID in the archive
**<archive>**
  Name of the archive to be used in this call. The given path and filename is
  used as is
**<base path>**
  Base path component in the root filesystem the archive should be extracted
  to. Can be just ``/`` for root.

install_glob
~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_glob, <package>, <UID>, <GID>, <source dir>, <destination dir>, <yglob>, <nglob>[, <strip>])

Installs parts of a directory tree with all files from the given directory
into:

* the project's ``<platform-dir>/root/``
* an ipkg packet in the project's ``<platform-dir>/packages/``

Some of the parameters have fixed meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the UID from the source tree
**<GID>**
  Group ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the GID from the source tree
**<source dir>**
  This is the path to the tree of directories and files to be installed. It can
  be ``-`` to use the package directory of the current package instead
**<destination dir>**
  The basename of the to-be-installed tree in the root filesystem
**<yglob>**
  A list of pathname patterns. All files or directories that match _any_
  pattern in the list are installed. Note: the patterns must match the
  whole absolute path, e.g. ``*/foo``. An empty list is equivalent to a
  pattern that matches all files.
**<nglob>**
  Like ``<yglob>`` but any matching files or directories will not be
  installed. For directories, this includes the whole contents of the
  directory.

Except for the pathname patterns, this command works like ``install_tree``.
The ``<yglob>`` and ``<nglob>`` patterns are combined: Only files that
match ``<yglob>`` and do not match ``<nglob>`` are installed.

Examples:

Install all shared libraries found in ``$(PKGDIR)/usr/lib/foo`` except
libbar.so

.. code-block:: make

 $(call install_glob, foo, 0, 0, -, /usr/lib/foo, *.so, */libbar.so)

install_lib
~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_lib, <package>, <UID>, <GID>, <permission>, <libname>)

Installs the shared library <libname> into the root filesystem.

* the project's ``<platform-dir>/root/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

The parameters and their meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<UID>**
  User ID the file should use in the target's root filesystem
**<GID>**
  Group ID the directories and files should use in the target's root filesystem
**<permission>**
  Permission (as an octal value) the library should use in the target's root
  filesystem (mostly 0644)
**<libname>**
  Basename of the library without any extension and path

The ``install_lib`` macro searches for the library at the most
common directories ``/lib`` and ``/usr/lib``. And it searches always
in the package's corresponding directory in ``<platform-dir>/packages/``.
It also handles all required links to make the library work at run-time.

An example.

Lets assume the package 'foo-1.0.0' has installed the library ``libfoo`` into
its ``<platform-dir>/packages/foo-1.0.0`` at:

* the lib: ``<platform-dir>/packages/foo-1.0.0/usr/lib/libfoo1.so.0.0.0``
* first link: ``<platform-dir>/packages/foo-1.0.0/usr/lib/libfoo1.so.0``
* second link: ``<platform-dir>/packages/foo-1.0.0/usr/lib/libfoo1.so``

To install this library and its corresponding links, the following line does the job:

.. code-block:: make

 $(call install_lib, foo, 0, 0, 0644, libfoo1)

Note: The package's install stage must be 'DESTDIR' aware to be able to make
it install its content into the corresponding packages directory (in our example
``<platform-dir>/packages/foo-1.0.0/`` here).

install_replace
~~~~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_replace, <package>, <filename>, <placeholder>, <value>)

Replace placeholder with value in a previously installed file.

The parameters and their meanings:

**<package>**
  Name of the IPKG/OPKG the macro should work on
**<filename>**
  Absolute filepath in target root filesystem
**<placeholder>**
  A string in the file which should be replaced. Usually some uppercase word
  surrounded by @ signs
**<value>**
  The value which should appear in the root filesystem instead of the
  placeholder, could be some PTXCONF variable

The ``install_replace`` macro can be used in targetinstall stage to adapt
some template and replace strings with content from menu variables or other
sources. For example look at the timezone you set in the ptxdist menu. An
``install_replace`` call in ``rules/timezone.make`` replaces the string
``@TIMEZONE@`` in the file ``/etc/timezone`` in root filesystem with the
content of the menu variable ``PTXCONF_TIMEZONE_LOCALTIME``. The file must
be installed with some other ``install_*`` command before
``install_replace`` can be used. A typical call would look like this:

.. code-block:: make

   $(STATEDIR)/timezone.targetinstall:
        ...
   	@$(call install_replace, timezone, /etc/timezone, @TIMEZONE@, \
   		$(PTXCONF_TIMEZONE_LOCALTIME))

.. _param_macros:

.. _ptxEndis:

ptx/endis
~~~~~~~~~

To convert the state (set/unset) of a variable into an ``enable/disable``
string use the ``ptx/endis`` macro.
If the given <variable> is set this macro expands to
the string ``enable``, if unset to ``disable`` instead.

Usage:

.. code-block:: none

 --$(call ptx/endis, <variable>)-<parameter>

An example:

.. code-block:: make

 FOO_CONF_OPT += --$(call ptx/endis,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: make

 FOO_CONF_OPT += --enable-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --disable-something (if FOO_VARIABLE is unset)

Refer :ref:`ptxDisen` for the opposite string expansion.

.. _ptxDisen:

ptx/disen
~~~~~~~~~

To convert the state (set/unset) of a variable into a ``disable/enable``
string use the ``ptx/disen`` macro.
If the given <variable> is set this macro expands to
the string ``disable``, if unset to ``enable`` instead.

Usage:

.. code-block:: none

 --$(call ptx/disen, <variable>)-<parameter>

An example:

.. code-block:: make

 FOO_CONF_OPT += --$(call ptx/disen,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: make

 FOO_CONF_OPT += --disable-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --enable-something (if FOO_VARIABLE is unset)

Refer :ref:`ptxEndis` for the opposite string expansion.

ptx/wwo
~~~~~~~

To convert the state (set/unset) of a variable into a ``with/without``
string use the ``ptx/wwo`` macro.
If the given <variable> is set this macro expands to
the string ``with``, if unset to ``without`` instead.

Usage:

.. code-block:: none

 --$(call ptx/wwo, <variable>)-<parameter>

An example:

.. code-block:: make

 FOO_CONF_OPT += --$(call ptx/wwo,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: make

 FOO_CONF_OPT += --with-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --without-something (if FOO_VARIABLE is unset)

ptx/ifdef
~~~~~~~~~

To convert the state (set/unset) of a variable into one of two strings use the
``ptx/ifdef`` macro.
If the given <variable> is set this macro expands to
the first given string, if unset to the second given string.

Usage:

.. code-block:: make

 --with-something=$(call ptx/ifdef, <variable>, <first-string>, <second-string)

An example:

.. code-block:: make

 FOO_CONF_OPT += --with-something=$(call ptx/ifdef,FOO_VARIABLE,/usr,none)

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: make

 FOO_CONF_OPT += --with-something=/usr (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --with-something=none (if FOO_VARIABLE is unset)

.. _rulefile:

Rule File Layout
----------------

Each rule file provides PTXdist with the required steps (in PTXdist called
*stages*) to be done on a per package base:

1. get
2. extract

   - extract.post

3. prepare
4. compile
5. install

   - install.post
   - install.pack

6. targetinstall

   - targetinstall.post

Default stage rules
~~~~~~~~~~~~~~~~~~~

As for most packages these steps can be done in a default way, PTXdist
provides generic rules for each package. If a package’s rule file does
not provide a specific stage rule, the default stage rule will be used
instead.

.. Important::
  Omitting one of the stage rules **does not mean** that PTXdist skips
  this stage!
  In this case the default stage rule is used instead.

get Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^

If the *get* stage is omitted, PTXdist runs instead:

.. code-block:: make

    $(STATEDIR)/@package@.get:
    		@$(call targetinfo)
    		@$(call touch)

Which means this step is skipped.

If the package is an archive that must be downloaded from the web, the
following rule must exist in this case:

.. code-block:: make

    $(@package@_SOURCE):
    		@$(call targetinfo)
		@$(call get, @package@)

extract Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^

If the *extract* stage is omitted, PTXdist runs instead:

.. code-block:: make

    $(STATEDIR)/@package@.extract:
    		@$(call targetinfo)
		@$(call clean, $(@package@_DIR))
		@$(call extract, @package@)
		@$(call patchin, @package@)
    		@$(call touch)

Which means a current existing directory of this package will be
removed, the archive gets freshly extracted again and (if corresponding
patches are found) patched.

extract.post Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is an optional stage, mainly used to somehow prepare a package for the
next *prepare* stage step. This stage can be used to generate a ``configure``
script out of an autotoolized ``configure.ac`` file for example. This separation
from the *extract* stage is useful to be able to extract a package for a quick
look into the sources without the need to build all the autotools first. The
autotoolized PTXdist templates makes use of this feature. Refer
:ref:`adding_src_autoconf_templates` for further details.

prepare Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^

If the *prepare* stage is omitted, PTXdist runs a default stage rule
depending on some variable settings.

If the package’s rule file defines ``@package@_CONF_TOOL`` to ``NO``,
this stage is simply skipped.

All rules files shall create the ``@package@_CONF_ENV`` variable and
define it at least to ``$(CROSS_ENV)`` if the prepare stage is used.

If the package’s rule file defines ``@package@_CONF_TOOL`` to
``autoconf`` (``FOO_CONF_TOOL = autoconf`` for our *foo* example),
PTXdist treats this package as an autotoolized package and runs:

.. code-block:: make

    $(STATEDIR)/@package@.prepare:
    		@$(call targetinfo)
		@$(call clean, $(@package@_DIR)/config.cache)
		@cd $(@package@_DIR)/$(@package@_SUBDIR) && \
			$(@package@_PATH) $(@package@_CONF_ENV) \
			./configure $(@package@_CONF_OPT)
    		@$(call touch)

The ``@package@_CONF_OPT`` should at least be defined to
``$(CROSS_AUTOCONF_USR)`` or ``$(CROSS_AUTOCONF_ROOT)``.

If the package’s rule file defines ``@package@_CONF_TOOL`` to ``cmake``
(``FOO_CONF_TOOL = cmake`` for our *foo* example), PTXdist treats this
package as a *cmake* based package and runs:

.. code-block:: make

    $(STATEDIR)/@package@.prepare:
    		@$(call targetinfo)
		@cd $(@package@_DIR) && \
			$(@package@_PATH) $(@package@_CONF_ENV) \
			cmake $(@package@_CONF_OPT)
    		@$(call touch)

The ``@package@_CONF_OPT`` should at least be defined to
``$(CROSS_CMAKE_USR)`` or ``$(CROSS_CMAKE_ROOT)``.

If the package’s rule file defines ``@package@_CONF_TOOL`` to ``qmake``
(``FOO_CONF_TOOL = qmake`` for our *foo* example), PTXdist treats this
package as a *qmake* based package and runs:

.. code-block:: make

    $(STATEDIR)/@package@.prepare:
    		@$(call targetinfo)
		@cd $(@package@_DIR) && \
			$(@package@_PATH) $(@package@_CONF_ENV) \
			qmake $(@package@_CONF_OPT)
    		@$(call touch)

The ``@package@_CONF_OPT`` should at least be defined to
``$(CROSS_QMAKE_OPT)``.

compile Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^

If the *compile* stage is omitted, PTXdist runs instead:

.. code-block:: make

    $(STATEDIR)/@package@.compile:
    		@$(call targetinfo)
		@cd $(@package@_DIR) && \
			$(@package@_PATH) $(@package@_MAKE_ENV) \
			$(MAKE) $(@package@_MAKE_OPT) $(@package@_MAKE_PAR)
    		@$(call touch)

If some additional variables should be added to the ``@package@_MAKE_ENV``,
always begin with the ``$(CROSS_ENV)`` and then add the additional
variables.

If the ``@package@_MAKE_OPT`` is intended for additional parameters to
be forwarded to ``make`` or to overwrite some settings from the
``@package@_MAKE_ENV``. If not defined in the rule file it defaults to
an empty string.

Note: ``@package@_MAKE_PAR`` can be defined to ``YES`` or ``NO`` to
control if the package can be built in parallel.

install Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^

If the *install* stage is omitted, PTXdist runs instead:

.. code-block:: make

    $(STATEDIR)/@package@.install:
    		@$(call targetinfo)
		@cd $(@package@_DIR) && \
			$(@package@_PATH) $(@package@_MAKE_ENV) \
			$(MAKE) $(@package@_INSTALL_OPT)
    		@$(call touch)

Note: ``@package@_INSTALL_OPT`` is always defined to ``install`` if not
otherwise specified. This value can be replaced by a package’s rule file
definition.

install.post Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

TBD

install.pack Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

TBD

targetinstall Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is no default rule for a package’s *targetinstall* state. PTXdist
has no idea what is required on the target at run-time. This stage is up
to the developer only. Refer to section :ref:`reference_macros`
for further info on how to select files to be included in the target’s
root filesystem.

targetinstall.post Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

TBD

Skipping a Stage
~~~~~~~~~~~~~~~~

For the case that a specific stage should be really skipped, an empty rule must
be provided:

.. code-block:: make

    $(STATEDIR)/@package@.<stage_to_skip>:
    		@$(call targetinfo)
    		@$(call touch)

Replace the <stage_to_skip> by ``get``, ``extract``, ``prepare``,
``compile``, ``install`` or ``targetinstall``.

.. _ptxdist_parameter_reference:

PTXdist parameter reference
---------------------------

PTXdist is a command line tool, which is basicly called as:

.. code-block:: bash

    $  ptxdist <action [args]> [options]

.. include:: ref_parameter.inc

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

.. parsed-literal::

    $ ptxdist print PTXDIST_TOPDIR
    /usr/local/lib/ptxdist-\ |release|

Replace the ``PTXDIST_TOPDIR`` with one of the other generic variables
PTXdist provides.

PTXDIST_TOPDIR
~~~~~~~~~~~~~~~

Points always to the installation directory of PTXdist.

PTXDIST_WORKSPACE
~~~~~~~~~~~~~~~~~~

Everything that references ``PTXDIST_WORKSPACE`` will use the active
projects’s folder.

PTXDIST_SYSROOT_CROSS
~~~~~~~~~~~~~~~~~~~~~~~

``PTXDIST_SYSROOT_CROSS`` points to a directory tree all cross relevant
executables, libraries and header files are installed to in the current
project. All of the project’s packages built for the host to create data
for the target are searching in this directory tree for their
dependencies (executables, header and library files). Use
``$(PTXDIST_SYSROOT_CROSS)/bin`` to install executables,
``$(PTXDIST_SYSROOT_CROSS)/include`` for header files and
``$(PTXDIST_SYSROOT_CROSS)/lib`` for libraries.

PTXDIST_SYSROOT_HOST
~~~~~~~~~~~~~~~~~~~~~~

``PTXDIST_SYSROOT_HOST`` points to a directory tree all host relevant
executables, libraries and header files are installed to. All project’s
packages built for the host are searching in this directory tree for
their dependencies (executables, header and library files). Use
``$(PTXDIST_SYSROOT_HOST)/bin`` to install executables,
``$(PTXDIST_SYSROOT_HOST)/include`` for header files and
``$(PTXDIST_SYSROOT_HOST)/lib`` for libraries.

PTXDIST_SYSROOT_TARGET
~~~~~~~~~~~~~~~~~~~~~~~~

``PTXDIST_SYSROOT_TARGET`` points to a directory tree all target
relevant libraries and header files are installed to. All project’s
packages built for the target are searching in this directory tree for
their dependencies (header and library files). These files are for
compile time only (for example to link a target executable against a
target library), not for runtime! Use
``$(PTXDIST_SYSROOT_TARGET)/include`` for header files and
``$(PTXDIST_SYSROOT_TARGET)/lib`` for libraries.

Other useful variables:

CROSS_PATH
~~~~~~~~~~~

Use to find cross tools. This path must be used to create anything that
depends on the target’s architecture, but needs something running on the
host to do the job. Examples:

**Creating a UBI image from the target’s root filesystem**
    This will need a tool running on the host, but it will create data
    or code that runs on or is used on the target

**Building a library for the target**
    If this library needs other resources to be built (other libraries)
    its ``configure`` finds the right information in this path.

HOST_PATH
~~~~~~~~~~

Used to find host tools. This path must be used to create anything that
not depends on the architecture.

ROOTDIR
~~~~~~~

``ROOTDIR`` points to the root of the target’s root filesystem in the
current project. Used in very rare cases (to create strange packages
based on data in target’s root filesystem for example).

PTXCONF_PLATFORM
~~~~~~~~~~~~~~~~~

``PTXCONF_PLATFORM`` expands to the name of the currently selected
platform. This name is used in various file names and paths.

PTXDIST_PLATFORMSUFFIX
~~~~~~~~~~~~~~~~~~~~~~~

``PTXDIST_PLATFORMSUFFIX`` expands to the name of the currently selected
platform, but with a leading dot. This is used in various files PTXdist
should search for.

PTXDIST_PLATFORMCONFIGDIR
~~~~~~~~~~~~~~~~~~~~~~~~~~

``PTXDIST_PLATFORMCONFIGDIR`` points to the directory tree of the
currently selected platform. This path is used in various search
functions.

PTXDIST_PLATFORMDIR
~~~~~~~~~~~~~~~~~~~~

``PTXDIST_PLATFORMDIR`` points to the directory build tree of the
currently selected platform.

.. _reference_macros:

Rule File Macro Reference
-------------------------

Rules files in PTXdist are using macros to get things work. Its highly
recommended to use these macros instead to do something by ourself. Using the
macros is portable and such easier to maintain in the case a project should be
upgraded to a more recent PTXdist version.

This chapter describes the predefined macros in PTXdist and their usage.

Whenever one of the macros installs something to the target's root filesystem,
it also accepts user and group IDs which are common in all filesystems Linux
supports. These IDs can be given as numerical values and as text strings.
In the case text strings are given PTXdist converts them into the
coresponding numerical value based on the BSP local files :file:`passwd` and :file:`group`.
If more than one file with these names are present in the BSP PTXdist follows
its regular rules which one it prefers.

Many paths shown here contains some parts in angle brackets. These have
special meanings in this document.

<platform>
  The name of a platform.
<platform-src>
  The directory where the platform is defined
<platform-dir>
  Concatenated directory name with a leading *platform-* and the name of the
  selected platform name, e.g. <platform>. If the name of the currently active
  platform is *foo*, the final directory name is *platform-foo*.


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
------

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
* the project's ``<platform-dir>/root-debug/``
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
* the project's ``<platform-dir>/root-debug/``
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
* the project's ``<platform-dir>/root-debug/``
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

install_alternative
~~~~~~~~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_alternative, <package>, <UID>, <GID>, <permission>, <destination>)

Installs given files or directories into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
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
* platform's directory ``<platform-src>/projectroot/etc/foo``
* project's directory ``projectroot/etc/foo``
* ptxdist's directory ``generic/etc/foo``
* project's directory ``$(FOO_DIR)/etc/foo``

The generic rules are looking like the following:

* ``$(PTXDIST_WORKSPACE)/projectroot.$(PTXDIST_PLATFORMSUFFIX)/etc/foo``
* ``$(PTXDIST_WORKSPACE)/projectroot/etc/foo$(PTXDIST_PLATFORMSUFFIX)``
* ``$(PTXDIST_PLATFORMCONFIGDIR)/projectroot/etc/foo``
* ``$(PTXDIST_WORKSPACE)/projectroot/etc/foo``
* ``$(PTXDIST_TOPDIR)/generic/etc/foo``
* ``$(FOO_DIR)/etc/foo``

Note: You can get the current values for the listed variables above via running
PTXdist with the ``print`` parameter:

.. code-block:: bash

 $ ptxdist print PTXDIST_PLATFORMSUFFIX

install_link
~~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_link, <package>, <point to>, <where>)

Installs a symbolic link into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
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
* the project's ``<platform-dir>/root-debug/``
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

install_lib
~~~~~~~~~~~

Usage:

.. code-block:: make

 $(call install_lib, <package>, <UID>, <GID>, <permission>, <libname>)

Installs the shared library <libname> into the root filesystem.

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
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
It also handles all required links to make the library work at runtime.

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


.. _param_macros:

ptx/endis
~~~~~~~~~

To convert the state (set/unset) of a variable into an ``enable/disable``
string use the ``ptx/endis`` macro.
If the given <variable> is set this macro expands to
the string ``enable``, if unset to ``disable`` instead.

Usage:

.. code-block:: make

 --$(call ptx/endis, <variable>)-<parameter>

An example:

.. code-block:: make

 FOO_CONF_OPT += --$(call ptx/endis,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: make

 FOO_CONF_OPT += --enable-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --disable-something (if FOO_VARIABLE is unset)

Refer ``ptx/disen`` for the opposite string expansion.

ptx/disen
~~~~~~~~~

To convert the state (set/unset) of a variable into a ``disable/enable``
string use the ``ptx/disen`` macro.
If the given <variable> is set this macro expands to
the string ``disable``, if unset to ``enable`` instead.

Usage:

.. code-block:: make

 --$(call ptx/disen, <variable>)-<parameter>

An example:

.. code-block:: make

 FOO_CONF_OPT += --$(call ptx/disen,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: make

 FOO_CONF_OPT += --disable-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --enable-something (if FOO_VARIABLE is unset)

Refer ``ptx/endis`` for the opposite string expansion.

ptx/wwo
~~~~~~~

To convert the state (set/unset) of a variable into a ``with/without``
string use the ``ptx/wwo`` macro.
If the given <variable> is set this macro expands to
the string ``with``, if unset to ``without`` instead.

Usage:

.. code-block:: make

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

Rule file layout
----------------

Each rule file provides PTXdist with the required steps to be done on a
per package base:

-  get

-  extract

-  prepare

-  compile

-  install

-  targetinstall

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

If the ``@package@_MAKE_ENV`` is not defined, it defaults to
``$(CROSS_ENV)``. If some additional variables should be added to the
``@package@_MAKE_ENV``, always begin with the ``$(CROSS_ENV)`` and then
add the additional variables.

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

targetinstall Stage Default Rule
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is no default rule for a package’s *targetinstall* state. PTXdist
has no idea what is required on the target at run-time. This stage is up
to the developer only. Refer to section :ref:`reference_macros`
for further info on how to select files to be included in the target’s
root filesystem.

Skipping a Stage
~~~~~~~~~~~~~~~~

For the case that a specific stage should be skipped, an empty rule must
be provided:

.. code-block:: make

    $(STATEDIR)/@package@.<stage_to_skip>:
    		@$(call targetinfo)
    		@$(call touch)

Replace the <stage_to_skip> by ``get``, ``extract``, ``prepare``,
``compile``, ``install`` or ``targetinstall``.

PTXdist parameter reference
---------------------------

PTXdist is a command line tool, which is basicly called as:

.. code-block:: bash

    $  ptxdist <action [args]> [options]

Setup and Project Actions
~~~~~~~~~~~~~~~~~~~~~~~~~

``menu``
  this will start a menu front-end to control some of
  PTXdist’s features in a menu based convenient way. This menu handles the
  actions *menuconfig*, *platformconfig*, *kernel* config, *select*,
  *platform*, *boardsetup*, *setup*, *go* and *images*.

``select <config>``
  this action will select a user land
  configuration. This step is only required in projects, where no
  ``selected_ptxconfig`` file is present. The <config> argument must point
  to a valid user land configuration file. PTXdist provides this feature
  to enable the user to maintain more than one user land configuration in
  the same project.

``platform <config>``
  this action will select a platform
  configuration. This step is only required in projects, where no
  ``selected_platform`` file is present. The <config> argument must point
  to a valid platform configuration file. PTXdist provides this feature to
  enable the user to maintain more than one platform in one project.

``setup``
  PTXdist uses some global settings, independent from the
  project it is working on. These settings belong to users preferences or
  simply some network settings to permit PTXdist to download required
  packages.

``boardsetup``
  PTXdist based projects can provide information to
  setup and configure the target automatically. This action let the user
  setup the environment specific settings like the network IP address and
  so on.

``projects``
  if the generic projects coming in a separate archive
  are installed, this actions lists the projects a user can clone for its
  own work.

``clone <from> <to>``
  this action clones an existing project from
  the ``projects`` list into a new directory. The <from>argument must be a
  name gotten from ``ptxdist projects`` command, the <to>argument is the
  new project (and directory) name, created in the current directory.

``menuconfig``
  start the menu to configure the project’s root
  filesystem. This is in respect to user land only. Its the main menu to
  select applications and libraries, the root filesystem of the target
  should consist of.

``menuconfig platform``
  this action starts the menu to configure
  platform’s settings. As these are architecture and target specific
  settings it configures the toolchain, the kernel and a bootloader (but
  no user land components). Due to a project can support more than one
  platform, this will configure the currently selected platform. The short
  form for this action is ``platformconfig``.

``menuconfig kernel``
  start the menu to configure the platform’s
  kernel. As a project can support more than one platform, this will
  configure the currently selected platform. The short form for this
  action is ``kernelconfig``.

``menuconfig barebox``
  this action starts the configure menu for
  the selected bootloader. It depends on the platform settings which
  bootloader is enabled and to be used as an argument to the
  ``menuconfig`` action parameter. Due to a project can support more than
  one platform, this will configure the bootloader of the currently
  selected platform.

Build Actions
~~~~~~~~~~~~~

``go``
  this action will build all enabled packages in the current
  project configurations (platform and user land). It will also rebuild
  reconfigured packages if any or build additional packages if they where
  enabled meanwhile. If enables this step also builds the kernel and
  bootloader image.

``images``
  most of the time this is the last step to get the
  required files and/or images for the target. It creates filesystems or
  device images to be used in conjunction with the target’s filesystem
  media. The result can be found in the ``images/`` directory of the
  project or the platform directory.

Clean Actions
~~~~~~~~~~~~~

``clean``
  the ``clean`` action will remove all generated files
  while the last ``go`` run: all build, packages and root filesystem
  directories. Only the selected configuration files are left untouched.
  This is a way to start a fresh build cycle.

``clean root``
  this action will only clean the root filesystem
  directories. All the build directories are left untouched. Using this
  action will re-generate all ipkg/opkg archives from the already built
  packages and also the root filesystem directories in the next ``go``
  action. The ``clean root`` and ``go`` action is useful, if the
  *targetinstall* stage for all packages should run again.

``clean <package>``
  this action will only clean the dedicated
  <package>. It will remove its build directory and all installed files
  from the corresponding sysroot directory.

``distclean``
  the ``distclean`` action will remove all files that
  are not part of the main project. It removes all generated files and
  directories like the ``clean`` action and also the created links in any
  ``platform`` and/or ``select`` action.


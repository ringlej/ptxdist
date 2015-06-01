.. index:: reference_macros

Rule File Macro Reference
=========================

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
----------

Usage:

.. code-block:: none

 $(call targetinfo)

Gives a feedback, what build *stage* is just started. Thats why it
should always be the first call for each *stage*. For the package
*foo* and the *compile stage* it will output:

.. code-block:: none

 --------------------
 target: foo.compile
 --------------------

touch
------

Usage:

.. code-block:: none

 $(call touch)

Gives a feedback, what build *stage* is just finished. Thats why it
should always be the last call for each *stage*. For the package
*foo* and the *compile stage* it will output:

.. code-block:: none

 finished target foo.compile

clean
-----

Usage:

.. code-block:: none

 $(call clean, <directory path>)

Removes the given directory ``<directory path>``

install_copy
-------------

Usage:

.. code-block:: none

 $(call install_copy, <package>, <UID>, <GID>, <permission>, <source> [, <dest> [, <strip> ]])

Installs given file or directory into:

* the project's ``<platform-dir>/root/``}
* the project's ``<platform-dir>/root-debug/``}
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``}

Some of the parameters have fixed meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<UID>
  User ID the file should use in the target's root filesystem
<GID>
  Group ID the file should use in the target's root filesystem
<permission>
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

full strip
  fully strip the file while installing when this parameter is **y** or not
  given at all (default case).
partially strip
  only strips real debug information from the file when this parameter is
  **k**. Useful to keep Linux kernel module loadable at run-time
no strip
  preserve the file from being stripped when this parameter is one of the
  following: **0**, **n**, **no**, **N** or **NO**.

Due to the complexity of this macro, here are some usage examples:

Create a directory in the root filesystem:

.. code-block:: none

 $(call install_copy, foo, 0, 0, 0755, /home/user-foo)

Copy a file from the package build directory to the root filesystem:

.. code-block:: none

 $(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foo, /usr/bin/foo)

Copy a file from the package build directory to the root filesystem and rename
it:

.. code-block:: none

 $(call install_copy, foo, 0, 0, 0755, $(FOO_DIR)/foo, /usr/bin/bar)

Copy a file from the package install directory to the root filesystem:

.. code-block:: none

 $(call install_copy, foo, 0, 0, 0755, -, /usr/bin/foo)

install_tree
------------

Usage:

.. code-block:: none

 $(call install_tree, <package>, <UID>, <GID>, <source dir>, <destination dir>)

Installs the whole directory tree with all files from the given directory into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
* an ipkg packet in the project's ``<platform-dir>/packages/``

Some of the parameters have fixed meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<UID>
  User ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the UID from the source tree
<GID>
  Group ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the GID from the source tree
<source dir>
  This is the path to the tree of directories and files to be installed. It can
  be ``-`` to use the package directory of the current package instead
<destination dir>
  The basename of the to-be-installed tree in the root filesystem

Note: This installation macro

* uses the same permission flags in the destination dir as found
  in the source dir. This is valid for directories and regular files
* skips all directories with names like ``.svn``, ``.git``, ``.pc`` and
  ``CVS`` in the source directory

Examples:

Install the whole tree found in ``/home/jbe/foo`` to the root filesystem
at location ``/usr/share/bar``.

.. code-block:: none

 $(call install_tree, foo, 0, 0, /home/jbe/foo, /usr/share/bar)

Install all files from the tree found in the current package FOO to the root
filesystem at location ``/usr/share/bar``.

.. code-block:: none

 $(call install_tree, foo, 0, 0, -, /usr/share/bar)

If the current package is ``foo-1.0`` the base path for the directory tree
will be ``$(PKGDIR)/foo-1.0/usr/share/bar``.

install_alternative_tree
------------------------

Usage:

.. code-block:: none

 $(call install_alternative_tree, <package>, <UID>, <GID>, <destination dir>)

Installs the whole source directory tree with all files from the given directory into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
* an ipkg packet in the project's ``<platform-dir>/packages/``

The ``<destination dir>`` is used like in the ``install_alternative`` to let
PTXdist search in the same directories and order for the given directory.

Some of the parameters have fixed meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<UID>
  User ID the directories and files should use in the target's root filesystem
  or ``-`` to keep the UID from the source
<GID>
  Group ID the directories and files should use in the target's root
  filesystem or ``-`` to keep the GID from the source
<destination dir>
  The basename of the to-be-installed tree in the root filesystem

Note: This installation macro

* uses the same permission flags in the destination dir as found in the source
  dir. This is valid for directories and regular files
* skips all directories with names like ``.svn``, ``.git``, ``.pc`` and ``CVS``
  in the source directory

Examples:

Install the whole tree found in project's ``projectroot/usr/share/bar``
to the root filesystem at location ``/usr/share/bar``.

.. code-block:: none

 $(call install_alternative_tree, foo, 0, 0, /usr/share/bar)

install_alternative
-------------------

Usage:

.. code-block:: none

 $(call install_alternative, <package>, <UID>, <GID>, <permission>, <destination>)

Installs given files or directories into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

The base parameters and their meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<UID>
  User ID the file should use in the target's root filesystem
<GID>
  Group ID the file should use in the target's root filesystem
<permission>
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

.. code-block:: none

 $ ptxdist print PTXDIST_PLATFORMSUFFIX

install_link
------------

Usage:

.. code-block:: none

 $(call install_link, <package>, <point to>, <where>)

Installs a symbolic link into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

The parameters and their meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<point to>
  Path and name the link should point to. Note: This macro rejects absolute
  paths. If needed use relative paths instead.
<where>
  Path and name of the symbolic link.

A few usage examples.

Create a symbolic link as ``/usr/lib/libfoo.so`` pointing to
``libfoo.so.1.1.0`` in the same directory:

.. code-block:: none

 $(call install_link, foo, libfoo.so.1.1.0, /usr/lib/libfoo.so)

Create a symbolic link as ``/usr/bin/foo`` pointing to ``/bin/bar``:

.. code-block:: none

 $(call install_link, foo, ../../bin/bar, /usr/bin/foo)

install_archive
---------------

Usage:

.. code-block:: none

 $(call install_archive, <package>, <UID>, <GID>, <archive> , <base path>)

Installs archives content into:

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

All parameters have fixed meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<UID>
  User ID all files and directory of the archive should use in the target's
  root filesystem. A ``-`` uses the file's/directory's UID in the archive
<GID>
  Group ID the files and directories should use in the target's root filesystem.
  A ``-`` uses the file's/directory's GID in the archive
<archive>
  Name of the archive to be used in this call. The given path and filename is
  used as is
<base path>
  Base path component in the root filesystem the archive should be extracted
  to. Can be just ``/`` for root.

install_lib
-----------

Usage:

.. code-block:: none

 $(call install_lib, <package>, <UID>, <GID>, <permission>, <libname>)

Installs the shared library <libname> into the root filesystem.

* the project's ``<platform-dir>/root/``
* the project's ``<platform-dir>/root-debug/``
* an ipkg/opkg packet in the project's ``<platform-dir>/packages/``

The parameters and their meanings:

<package>
  Name of the IPKG/OPKG the macro should work on
<UID>
  User ID the file should use in the target's root filesystem
<GID>
  Group ID the directories and files should use in the target's root filesystem
<permission>
  Permission (as an octal value) the library should use in the target's root
  filesystem (mostly 0644)
<libname>
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

.. code-block:: none

 $(call install_lib, foo, 0, 0, 0644, libfoo1)

Note: The package's install stage must be 'DESTDIR' aware to be able to make
it install its content into the corresponding packages directory (in our example
``<platform-dir>/packages/foo-1.0.0/`` here).

ptx/endis
---------

To convert the state (set/unset) of a variable into an ``enable/disable``
string use the ``ptx/endis`` macro.
If the given <variable> is set this macro expands to
the string ``enable``, if unset to ``disable`` instead.

Usage:

.. code-block:: none

 --$(call ptx/endis, <variable>)-<parameter>

An example:

.. code-block:: none

 FOO_CONF_OPT += --$(call ptx/endis,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: none

 FOO_CONF_OPT += --enable-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --disable-something (if FOO_VARIABLE is unset)

Refer ``ptx/disen`` for the opposite string expansion.

ptx/disen
---------

To convert the state (set/unset) of a variable into a ``disable/enable``
string use the ``ptx/disen`` macro.
If the given <variable> is set this macro expands to
the string ``disable``, if unset to ``enable`` instead.

Usage:

.. code-block:: none

 --$(call ptx/disen, <variable>)-<parameter>

An example:

.. code-block:: none

 FOO_CONF_OPT += --$(call ptx/disen,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: none

 FOO_CONF_OPT += --disable-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --enable-something (if FOO_VARIABLE is unset)

Refer ``ptx/endis`` for the opposite string expansion.

ptx/wwo
-------

To convert the state (set/unset) of a variable into a ``with/without``
string use the ``ptx/wwo`` macro.
If the given <variable> is set this macro expands to
the string ``with``, if unset to ``without`` instead.

Usage:

.. code-block:: none

 --$(call ptx/wwo, <variable>)-<parameter>

An example:

.. code-block:: none

 FOO_CONF_OPT += --$(call ptx/wwo,FOO_VARIABLE)-something

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: none

 FOO_CONF_OPT += --with-something (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --without-something (if FOO_VARIABLE is unset)

ptx/ifdef
---------

To convert the state (set/unset) of a variable into one of two strings use the
``ptx/ifdef`` macro.
If the given <variable> is set this macro expands to
the first given string, if unset to the second given string.

Usage:

.. code-block:: none

 --with-something=$(call ptx/ifdef, <variable>, <first-string>, <second-string)

An example:

.. code-block:: none

 FOO_CONF_OPT += --with-something=$(call ptx/ifdef,FOO_VARIABLE,/usr,none)

Depending on the state of FOO_VARIABLE this line results into

.. code-block:: none

 FOO_CONF_OPT += --with-something=/usr (if FOO_VARIABLE is set)
 FOO_CONF_OPT += --with-something=none (if FOO_VARIABLE is unset)

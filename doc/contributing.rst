Contributing to PTXdist
=======================

PTXdist Packages
----------------

While contributions to all parts of PTXdist are welcome, most contributions
concern individual packages. Here is a checklist of things to look out for
while creating or updating packages. These are not hard requirements but
there should be good reasons for different choices.

How to Contribute
~~~~~~~~~~~~~~~~~

Contributions should be sent as patches to the PTXdist mailing list. This
is usually done with ``git send-email``.

All patches must contain a descriptive subject and should, for all
non-obvious changes, contain a commit message describing what has changed
and why this is necessary.

All patches must contain the correct ``Signed-off-by:`` tag.

Package Builds should be Reproducible
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many packages autodetect which features are available. As a result, the
exact features of a package may depend on the build host and the build
order of the packages. To avoid this autodetection must be restricted as
much as possible.

For **autoconf** based packages, the first step is to specify all relevant
``configure`` options. The :ref:`configure_helper` scripts can help filter
out the unimportant options.

There are also cache variables that can be used to enforce the outcome of
autodetection if no option is available:

.. code-block:: make

  SOMEPKG_CONF_ENV := \
  	$(CROSS_ENV) \
  	ac_cv_broken_sem_getvalue=no

:ref:`configure_helper` also supports **meson**. Note that the prepare
stage for the package must be executed first.

The options for **cmake** packages must be checked manually. The best way
to do this is to read the cache file
``<platform-dir>/build-target/<package>-build/CMakeCache.txt``. It contains
all available options.

Packages Suboptions
~~~~~~~~~~~~~~~~~~~

Suboptions for PTXdist packages are useful to make parts of the package
optional. However, it is not always easy to decide what should be optional
and how to map the build system options to packages suboptions. Here are a
few guidelines to help with that.

-  Avoid unnecessary suboptions. When in doubt, use the package default or
   what other distributions use. If the creator of the package does not
   know what to choose then the user wont either.
-  Use suboptions to save disk space. If a feature adds extra dependencies
   or uses a lot of space then a suboptions is useful to save the disk
   space when the feature is not needed.
-  Try to create high-level options. Some packages have very low-level
   build options with very few useful combinations. Try to define
   high-level features or use-cases and define options for those.
-  Options for new use-cases can always be added later. It's perfectly
   acceptable to just disable some unused features when creating a new
   package. When they are needed, then a new option can be added.

Updating a Package to a new Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The most common contribution to PTXdist are new versions for existing
packages. This is usually quite simple, but there are a few things to keep
in mind:

-  New versions can have new build system options that should be used.
   :ref:`configure_helper` can be used to find the new options.
-  There may be patches for the old version. Make sure they are update as
   well or removed if they are no longer needed.

Misc
~~~~

For new Packages, the top-level option and any non-obvious suboption should
have a help text. The homepage of a package or the package description from
other distributions a usually a good inspiration.

The package templates to create new packages contain commented out default
sections. These are meant as a helper to simplify creating custom stages.
Any remaining default stages must be removed.

Helper Scripts
--------------

.. _configure_helper:

configure_helper.py
~~~~~~~~~~~~~~~~~~~

``configure_helper.py`` can be found in ``scripts/`` in the PTXdist source
tree. It should be used to determine which build system options should be
specified for a package. Currently, only **autoconf** and **meson** based
packages are supported.

It provides a diff between two lists of options. These list are generated
from the options specified in the package Makefile and from the source tree
of the package.

Both **autoconf** and **meson** provide several options that are rarely
needed. This tool contains a blacklist to filter out these options.

``configure_helper.py`` supports the following command-line options:

``-h, --help``
    Show the help message and exit

``-p <pgk>, --pkg <pgk>``
    The ptxdist package to check

``-o <old>, --old-src <old>``
    The old source directory

``-n <new>, --new-src <new>``
    The new source directory

``-s <only, --only-src <only``
    The only source directory

``--sort``
    Sort the options before comparing

There are several different ways to configure arguments:

.. code-block:: sh

  $ configure_helper.py --pkg <pkg>

This will compare the available configure arguments of the current version
with those specified in PTXdist

.. code-block:: sh

  $ configure_helper.py --only-src /path/to/src --pkg <pkg>

This will compare the available configure arguments of the specified source
with those specified in PTXdist

.. code-block:: sh

  $ configure_helper.py --old-src /path/to/old-src --pkg <pkg>
  $ configure_helper.py --new-src /path/to/new-src --pkg <pkg>

This will compare the available configure arguments of the current version
with those of the specified old/new version

.. code-block:: sh

  $ configure_helper.py --new-src /path/to/new-src --old-src /path/to/old-src

This will compare the available configure arguments of the old and new
versions.

If ``--pkg`` is used, then the script must be called in the BSP workspace.
The environment variable ``ptxdist`` can be used to specify the PTXdist
version to use.

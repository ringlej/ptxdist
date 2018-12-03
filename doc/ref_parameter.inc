Setup and Project Actions
~~~~~~~~~~~~~~~~~~~~~~~~~

``menu``
  this starts a dialog based frontend for those who do not like typing
  commands. It will gain us access to the most common parameters to
  configure and build a PTXdist project. This menu handles the
  actions *menuconfig*, *platformconfig*, *kernelconfig*, *select*,
  *platform*, *boardsetup*, *setup*, *go* and *images*.

``select <config>``
  this action will select a user land
  configuration. This step is only required in projects, where no
  ``selected_ptxconfig`` file is present. The <config> argument must point
  to a valid user land configuration file. PTXdist provides this feature
  to enable the user to maintain more than one user land configuration in
  the same project. The default location for the configuration file is
  ``configs/ptxconfig``. PTXdist will use this if no other configuration is
  selected.

``platform <config>``
  this action will select a platform
  configuration. This step is only required in projects, where no
  ``selected_platform`` file is present. The <config> argument must point
  to a valid platform configuration file. PTXdist provides this feature to
  enable the user to maintain more than one platform in one project.
  The default location for the configuration file is
  ``configs/*/platformconfig``. PTXdist will use it if the pattern matches
  exactly one file and no other configuration is selected.

``toolchain [<path>]``
  this action will select the toolchain to use. If no path is specified
  then PTXdist will guess which toolchain to use based on the settings in
  the platformconfig. Setting the toolchain is only required if PTXdist
  cannot find the toolchain automatically or if a different toolchain
  should be used.

``collection <config>``
  this action will select a collection configuration. This step is
  optional. The <config> argument must point to a valid collection
  configuration file.

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

``nconfig [<component>]``
  this action provides a slightly different user experience with the same
  functionality as ``menuconfig``. It can be used instead of ``menuconfig``
  for all the component described above.

``oldconfig [<component>]``, ``allmodconfig [<component>]``, ``allyesconfig [<component>]``, ``allnoconfig [<component>]``, ``randconfig [<component>]``
  this action will run the corresponding kconfig action for the specified
  component. ``oldconfig`` will prompt for all new options.
  ``allmodconfig``, ``allyesconfig`` and ``allnoconfig`` will set all
  options to 'm', 'y' or 'n' respectively. ``randconfig`` will randomize
  the options. The ``KCONFIG_ALLCONFIG`` and ``KCONFIG_SEED`` environment
  variables can be used as described in the Linux kernel documentation.

``migrate``
  migrate the configuration files from a previous PTXdist version. This
  will run ``oldconfig`` and ``oldconfig platform`` to prompt for all new
  options.

Build Actions
~~~~~~~~~~~~~

``go``
  this action will build all enabled packages in the current
  project configurations (platform and user land). It will also rebuild
  reconfigured packages if any or build additional packages if they where
  enabled meanwhile. If enables this step also builds the kernel and
  bootloader image.

``get``
  this action will download the sources for all packages. This is useful to
  download everything at once. Afterwards the packages can be built without
  internet access.

``urlcheck [<package>]``
  this action will check if the URL for the package (or all packages) still
  works. It does not download the whole file, so this is relatively fast,
  but may not be 100% correct in all cases.

``get <package>``, ``extract <package>``, ``prepare <package>``, ``compile <package>``, ``install <package>``, ``targetinstall <package>``
  this action will build the corresponding stage for the specified package
  including all previous stages and other dependencies. Multiple packages
  can be specified.

``drop <package>.<stage>``
  this action will 'drop' the specified stage without removing any other
  files. Subsequent actions will rebuild this stage. This is useful during
  development to rebuild a package without deleting the sources. Use
  ``clean <package>`` for a full rebuild of the package.

``images``
  most of the time this is the last step to get the
  required files and/or images for the target. It creates filesystems or
  device images to be used in conjunction with the target’s filesystem
  media. The result can be found in the ``images/`` directory of the
  project or the platform directory.

``image <image>``
  build the specified image. The file name in ``images/`` is used to
  identify the image. This is basically the same as ``images`` but builds
  just one image.

  Note: This is only supported for the images in the 'new image creation
  options' section of the platformconfig.

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
  from the corresponding sysroot directory. Multiple packages can be
  specified.

``distclean``
  the ``distclean`` action will remove all files that
  are not part of the main project. It removes all generated files and
  directories like the ``clean`` action and also the created links in any
  ``platform`` and/or ``select`` action.

Misc Actions
~~~~~~~~~~~~

``version``
  print out the PTXdist version.

``test <testname>``
  run tests

``newpackage <type>``
  create a new PTXdist package. For most package types, this will create
  <pkg>.make and <pkg>.in files in ``rules/``. Use ``newpackage help`` for a
  list of available package types.

``nfsroot``
  run a userspace NFS server and export the nfsroot (refer section
  :ref:`nfsroot` for further details).

``gdb``
  run the cross gdb from the toolchain. The sysroot and other search paths
  are configured to ensure that gdb finds all available debug files.

``package-info <pkg>``
  show some basic information about the package. This includes the version,
  URL and various paths and directories. The paths for menu and rule file
  are shown as well, to this can be used to verify that the correct version
  of these files are used.

.. _command_print:

``print <var>``
  print the contents of a variable. It will first look for a shell variable
  with the given name. If none exists, it will run make and look if a
  variable with the given name is known to 'make'.

``list-packages``
  print a list of all selected packages. This list does not include the
  host and cross tools.

``local-src <pkg> [<directory>]``
  overwrite a package source with a locally provided directory containing
  the source code. Not specifying the directory will undo the change.
  Relative paths are converted to absolute paths relative to the workspace.

``bash``
  enter a PTXdist environment bash shell.

``bash <cmd> [args...]``
  execute ``<cmd>`` in PTXdist environment.

``make <target>``
  build specified make target in PTXdist.

``export_src <target-dir>``
  export all source archives needed for this project to ``<target-dir>``.

``docs-html``
  build html documentation for a BSP. The output is written to 
  Documentation/html/index.html

Overwrite defaults
~~~~~~~~~~~~~~~~~~

These options can be used to overwrite some settings. They can be useful
when working with multiple configurations or platforms in a single project.

``--ptxconfig=<config>``
  use the specified ptxconfig file instead of the selected of default
  configuration file.

``--platformconfig=<config>``
  use specified platformconfig file instead of the selected of default
  configuration file.

``--collectionconfig=<config>``
  use specified collectionconfig file instead of the selected configuration
  file.

``--toolchain=<toolchain>``
  use specified toolchain instead of the selected or default toolchain.

``--force-download``
  allow downloading, even if disabled by setup

Options
~~~~~~~

``--force``, ``-f``
  use this option to overwrite various sanity checks. Only use this option
  if you really know what you are doing.

``--debug``, ``-d``
  print out additional info (like make decisions)

``--quiet``, ``-q``
  suppress output, show only stderr

``--verbose``, ``-v``
  be more verbose, print command before execute them

``--output-sync``, ``--no-output-sync``
  enable or disable output synchronization. By default output
  synchronization is only enabled for quiet builds. Output synchronization
  is implemented by the ``make`` ``--output-sync`` option. For building
  packages in parallel, ``--output-sync=recurse`` is used. For individual
  ``make`` commands in the build stages ``--output-sync=target`` is used.
  This means, that the output for each individual make target and each
  build stage is grouped together.

  Note: If output synchronization is enabled then the output for each build
  stage is collected by make and won't be visible until the build stage is
  completed. As a result, there will be long periods of time with no
  visible progress.

``--progress``
  show some progress information in the form of completed/total build
  stages. This is only shown if quiet is enabled as well. Note, that this
  adds some extra overhead at the beginning, so it will take some time
  until the first build stage starts.

``--j-intern=<n>``, ``-ji<n>``
  set number of parallel jobs within packages. PTXdist will use this
  number for example when calling ``make`` during the compile stage.
  The default is 2x the number of CPUs.

``--j-extern=<n>``, ``-je<n>``
  set number of packages built in parallel. The default is 1.
  Use ``-j`` instead of this. It has the same goal and performs better.

``-j[<n>]``
  set the global number of parallel jobs. This is basically a more
  intelligent combination of ``-je`` and ``-ji``. A single package rarely
  uses all the available CPUs. Usually only the compile stage can use more than
  one CPU and even then there are often idle CPUs. With the global job
  pool, tasks from multiple packages can be executed in parallel without
  overloading the system.

  Note: Because of the parallel execution, the output is chaotic and not
  very useful. Use this in combination with ``-q`` and only to speed up
  building for project that are known to build without errors.

``--load-average=<n>``, ``-l<n>``
  try to limit load to <n>. This is used for the equivalent ``make``
  option.

``--nice=<n>``, ``-n<n>``
  run with reduced scheduling priority (i.e. nice). The default is 10.

``--dirty``
  avoid rebuilding packages. By default, if a package is rebuild then all
  packages that depend on it are also rebuild. This happens because
  PTXdist cannot know if rebuilding is necessary. With this option the
  depending packages will not be rebuild. Also, changes to config options,
  rule and menu file will not trigger a rebuild either.

  To trigger a rebuild, the relevant stage of a package must be dropped.

``--keep-going``, ``-k``
  keep going. Continue as much as possible after an error.

``--git``
  use git to apply patches

``--auto-version``
  automatically switch to the correct PTXdist version. This will look for
  the correct PTXdist version in the ptxconfig file and execute it if it
  does not match the current version.

``--virtualenv=<dir>``
  inlcude a Python Virtual Environment. The given path must contain a
  ``bin/activate`` shell script.

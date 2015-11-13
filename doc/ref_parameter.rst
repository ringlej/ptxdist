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


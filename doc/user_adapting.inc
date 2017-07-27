Adapting the |ptxdistBSPName| Project
---------------------------------------------------------------------------------------------------------------------------------------------------------------

Handling a fully prepared PTXdist project is easy. But everything is
fixed to the settings the developer selected. We now want to adapt the
project in a few simple settings.

Working with Kconfig
~~~~~~~~~~~~~~~~~~~~

Whenever we modify our project, PTXdist is using *Kconfig* to manipulate
the settings. *Kconfig* means *kernel configurator* and was mainly
developed to configure the Linux kernel itself. But it is easy to adapt,
to use and so popular that more and more projects are using *Kconfig*
for their purposes. PTXdist is one of them.

What is Kconfig
^^^^^^^^^^^^^^^

It is a user interface to select given resources in a convenient way.
The resources that we can select are given in simple text files. It uses
a powerful “language” in these text files to organize them in a
hierarchical manner, solves challenges like resource dependencies,
supports help and search features. PTXdist uses all of these features.
*Kconfig* supports a text based user interface by using the *ncurses*
library to manipulate the screen content and should work on nearly all
host systems.

Navigate in Kconfig menu (select, search, ...)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To navigate through the configuration tree, we are using the arrow keys.
Up and down navigates vertically in the menu entries. Right and left
navigates between *Select*, *Exit* and *Help* (in the bottom part of our
visual screen).

To enter one of the menus, we navigate to this entry to highlight it and
press the *Enter* key. To leave it, we select *Exit* and press the
*Enter* key again. There are shortcuts available, instead of pressing
the *Enter* key to enter a menu we also can press *alt-s* and to leave a
menu *alt-e*. Also an ESC double hit leaves any menu we are in.

To select a menu entry, we use the *Space* key. This will toggle the
selection. Or, to be more precise and faster, we use the key *y* to
select an entry, and key *n* to deselect it.

To get help for a specific menu topic, we navigate vertically to
highlight it and horizontally to select the *Help* entry. Then we can
press *Enter* to see the help.

To search for specific keywords, we press the */* key and enter a word.
Kconfig then lists all occurences of this word in all menus.

Meaning of visual feedbacks in Kconfig
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  | Submenus to enter are marked with a trailing ``--->``
   | Note: Some submenus are also marked with a leading bracket ``[ ]``.
     To enter them we first must select/enable them ``[*]``

-  Entries with a list of selectable alternatives are also marked with a
   trailing ``--->``

-  Entries we can select are marked with a leading empty bracket ``[ ]``

-  Entries that are already selected are marked with a leading filled
   bracket ``[*]``

-  Entries that are selected due to dependencies into other selected
   entries are marked with a leading ``-*-``

-  Some entries need a free text to enter, they are marked with leading
   brackets ``()`` and the free text in it

Adapting Userland Settings
~~~~~~~~~~~~~~~~~~~~~~~~~~

To do so, we run:

::

    $ ptxdist menuconfig

will show the following console output

.. figure:: figures/menuconfig_intro.png
   :alt:  Main userland configuration menu
   :align: center

   Main userland configuration menu

The main building blocks in the *userland configuration* menu are:

-  Host Options: Some parts of the project are build host relevant only.
   For example PTXdist can build the DDD debugger to debug applications
   running on the target.

-  Root Filesystem: Settings to arrange target’s root filesystem and to
   select the main C run-time library

-  Applications: Everything we like to run on our target.

At this point it could be useful to walk to the whole menus and their
submenus to get an idea about the amount of features and applications
PTXdist currently supports.

Note: don't forget to save your changes prior leaving this menu.

Adapting Platform Settings
~~~~~~~~~~~~~~~~~~~~~~~~~~

To do so, we run:

::

    $ ptxdist menuconfig platform

The main building blocks in the *platform configuration* menu are:

-  Architecture: Basic settings, like the main and sub architecture the
   target system uses, the toolchain to be used to build everything and
   some other architecture dependent settings.

-  Linux kernel: Which kernel revision and kernel configuration should
   be used

-  Bootloader: Which bootloader (if any) should be built in the project

-  The kind of image to populate a root filesystem into the target
   system

Note: don't forget to save your changes prior leaving this menu.

Adapting Linux Kernel Settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Just run the following command:

::

    $ ptxdist menuconfig kernel

Note: don't forget to save your changes prior leaving this menu.

Adapting Bootloader Settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Just run the following command:

::

    $ ptxdist menuconfig barebox

Note: don't forget to save your changes prior leaving this menu.

Making Changes Real
~~~~~~~~~~~~~~~~~~~

After a change in whatever menu the next build-run will compile
or re-compile the changed parts. Due to complex dependencies between these parts
PTXdist might compile or re-compile more than the changed part.

To apply the changes just run:

::

    $ ptxdist go

Note: If nothing was changed, ``ptxdist go`` also will do nothing.

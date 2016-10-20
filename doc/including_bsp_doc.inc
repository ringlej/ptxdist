Integrate project specific Documentaion into the Manual
-------------------------------------------------------

PTXdist supports the ability to integrate project specific documentation
into the final PTXdist manual. To do so, PTXdist handles file replacements and
additions, while generating the documentation.

File replacement is working in the same manner like for all other files in
a PTXdist based project: a local file with the same name superseds a global file
from PTXdist.

With this mechanism we can replace existing PTXdist documentation or add new one.

If we want to add a new global section to the manual we can copy the global
PTXdist ``doc/index.rst`` file into our local ``doc/`` directory and adapt it
accordingly.

To change or add things less intrusive we can do it on the various ``*.inc``
files in the PTXdist's ``doc/`` directory which define the content of the
sections.

For example to change the image createn section's content, we can copy the
global PTXdist ``doc/user_images.inc`` into our local ``doc/`` directory and
adapt it to the behaviour of our project.

In the generic documentation source many text uses variables instead of fixed
content. These variables are filled with values extracted from the current PTXdist
project prior building the final documentation. Since PTXdist projects are bound
to a defined PTXdist version and toolchain version, this kind of information is
extracted from the current settings and substituted in the documentation. This
behaviour ensures the documentaiton includes the project's exact definition to
external dependencies.

Refer the PTXdist file ``doc/conf.py`` for more information on variable
substitution. This PTXdist global file can be superseded by a local copy as well.

Requirements to build the Documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fonts:
   - *Liberation Sans/Liberation Sans Bold* or *DejaVu Sans/DejaVu Sans Bold*
     (for the "Portable Document Format", e.g. PDF)
   - *Inconsolata*, *DejaVu Sans Mono* or *Liberation Sans Mono*
     (for the "Portable Document Format", e.g. PDF)

Tools:
   - *Sphinx* version 1.3.4, better 1.4.2 (for all kind of document formats)
   - *Sphinx* theme from https://readthedocs.org/
   - *TeX Live 2016* (for the "Portable Document Format", e.g. PDF)

Building the Documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~

PTXdist comes with support to generate *HTML* or *Portable Document Format* based
documentation from the sources.

The command:

::

    $ ptxdist docs-html

will build the HTML based documentation into ``Documentation/html`` and the entry
file for this kind of documentation is ``Documentation/html/index.html``.

The command:

::

    $ ptxdist docs-latex

will build the Latex based documentation which results into the final
*Portable Document Format* document. This result can be found in
``Documentation/latex/``.

Both commands can be executed in the BSP or the toplevel PTXdist directory
to create the BSP specific or generic documentation respectively.

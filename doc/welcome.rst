Welcome to the Embedded World
=============================

First Steps in the Embedded World
---------------------------------

Once upon in time, programming embedded systems was easy: all a
developer needed when he wanted to start a new product was a good
toolchain, consisting of

- a compiler

- maybe an assembler

- probably an EPROM burning device

and things could start. After some more or less short time, every
register of the CPU was known, a variety of library routines had been
developed and our brave developer was able to do his project with the
more and more well-known system. The controllers had legacy interfaces
like RS232, i2c or SPI which connected them to the outside world and the
main difference between the controllers available on the market was the
number of GPIO pins, UARTs and memory resources.

Things have changed. Hardware manufacturers have weakened the border
between deeply embedded microcontrollers – headless devices with just a
few pins and very limited computing power – and full blown
microprocessors. System structures became much more complicated: where
our good old controllers have had just some interrupts with some small
interrupt service routines, we today need complicated generic interrupt
infrastructures, suitable for generic software frameworks. Where we’ve
had some linearly mapped flash ROM and some data RAM we today have
multi-stage-pipeline architectures, memory management units, virtual
address spaces, on-chip-memory, caches and other complicated units,
which is not exactly what the embedded system developer wants program
every other day.

Entering embedded operating systems. Although there are still some
processors out there (like the popular ARM7TDMI based SoCs) which can be
programmed the good old non-operating-system way with reasonable effort,
it in fact is becoming more and more difficult. On the other hand,
legacy I/O interfaces like RS232 are increasingly often replaced by
modern plug-and-play aware communication channels: USB, FireWire
(IEEE1394), Ethernet & friends are more and more directly being
integrated into today’s microcontroller hardware. Whereas some of these
interfaces can “somehow” be handled the old controller-style way of
writing software, the developer following this way will not be able to
address the security and performance issues which come up with the
modern network accessible devices.

During the last years, more and more of the small-scale companies which
developed little embedded operating systems have been pushed out of the
market. Nearly no small company is able to support all the different
interfaces, communication stacks, development tools and security issues
out there. New interfaces and -variants (like USB On-the-Go) are
developed faster than operating system developers can supply the
software for them. The result is a consolidation of the market: today we
see that, besides niche products, probably only the largest commercial
embedded operating system suppliers will survive that development.

Only the largest commercial...? There is one exception: when the same
situation came up in the “mainstream” computer market at the beginning
of the 1990es, people started to develop an alternative to the large
commercial operating systems: Linux. Linux did never start with a
ready-to-use solution: people had a problem, searched for a solution but
didn’t find one. Then they started to develop one themselves, often
several people did this in parallel, and in a huge community based
evolution mechanism the best solutions found their way into the Linux
kernel, which over the time formed one of the most reliable and
performant kernels available today. This “develop-and-evolute” mechanism
has shown its effectiveness over and over again in the server and
desktop market of today.

From Server to Embedded
-----------------------

The fact that for most technical problems that might occur it may be
possible to find somebody on the internet who has already worked on the
same or another very similar problem, was one of the major forces behind
the success story of Embedded Linux.

Studies have shown that more than 70% of the embedded developers are not
satisfied with a black-box operating system: they want to adapt it to
their needs, to their special hardware situation (which most times is
Just Different than anything available). Embedded projects are even more
variegated than desktop- or server projects, due to the fact that there
exist so many different embedded processors with lots of peripherals out
there.

Linux has evolved from an i386 only operating system to a kernel running
on nearly every modern 32 bit processor available today: x86, PowerPC,
ARM, MIPS, m68k, cris, Super-H etc. The kernel supplies a hardware
abstraction layer which lets our brave embedded developer once again
concentrate on his very special problem, not on handling negligibilities
like memory management.

But Linux is only half of the story. Besides the kernel, a Linux based
embedded system consists of a “userland”: a filesystem, containing all
the small tools which form a small Unix system. Only the combination of
the kernel and a Userland let’s the developer run “normal” processes on
his x86 development machine as well as on his embedded target.

Linux = Embedded Linux
----------------------

Whereas the mainstream developers were always able to use normal Linux
distributions like SuSE, RedHat, Mandrake or Debian as a base for their
applications, things are different for embedded systems.

Due to the restricted resources these systems normally have,
distributions have to be small and should only contain those things that
are needed for the application. Today’s mainstream distributions cannot
be installed in less than 100 MiB without major loss of functionality.
Even Debian, probably today the most customizable mainstream
distribution, cannot be shrunk below this mark without for example
losing the packet management, which is an essential feature of using a
distribution at all.

- Additionally, source code for industrial systems has to be

- auditable and

- reproducible.

Embedded developers usually want to know what’s in their systems – be it
that they have to support their software for a long time span (something
like 10-15 years are usual product lifetimes in automation applications)
or that they have such a special scenario that they have to maintain
their integrated source of their Userland themselves.

.. centered:: **Entering PTXdist.**



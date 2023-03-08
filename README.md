
# Table of Contents

1.  [Build](#orge6914a7)
2.  [Running](#org4cd8365)

This is the most versatile way I found to have a system that doesn't move with
the changes to my ArchLinux workstation (compiler, glibc, etc.), while at the
same time being able to create new environments and to install new packages with
Spack.


<a id="orge6914a7"></a>

# Build

    sudo -E apptainer build dev_envs.sif dev_envs.def

(this is very quick to create, and if I add new environments to the Spack
overlay, we can just modify it quickly and add references to those new environments)

    ./create_spack_overlay.sh

(this just creates a persistent overlay, tied to /spack, writable by `angelv`,
so that I can have a complete Spack installation. The variables SPACK<sub>ROOT</sub>,
SPACK<sub>USER</sub><sub>CONFIG</sub><sub>PATH</sub>, SPACK<sub>USER</sub><sub>CACHE</sub><sub>PATH</sub> (see .def) guarantee that this
Spack installation is independent of my host Spack installation)      

    apptainer shell --overlay spack.img dev_envs.sif
    Apptainer>  . inside_appt.sh

(this installs the spack environments, based on the .yaml files. See the %help
section in the .def file for instructions on how to use it).

-   Built on `[2023-03-07 Tue]`:
    -   Ubuntu 22.04
    -   Apptainer 1.1.5
    -   Spack 0.19.1
    -   gcc: 10.4.0 ; 9.5.0
    -   Notes, when building there are errors for both environments about python
        installation [Bus error (core dumped)], but it seems OK if I install it with
        just -j 1


<a id="org4cd8365"></a>

# Running

Just run `envs/gcc_9_5_0.sh` or `envs/gcc_10_4_0.sh` and we end up in one of
these environments, where we can actually add other software if we want, since
the overlay is writable by my regular user.


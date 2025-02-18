# Install Singularity

You will need a **Linux system** to run SingularityCE natively. Options for using SingularityCE on Mac and Windows machines, along with alternate Linux installation options, are discussed in the [installation section of the admin guide](https://sylabs.io/guides/4.1/admin-guide/installation.html).

If you have an existing version of SingularityCE installed from source, which you wish to upgrade or remove / uninstall, see the [installation section of the admin guide](https://sylabs.io/guides/4.1/admin-guide/installation.html).

For further information, read the [SingularityCE User Guide](https://docs.sylabs.io/guides/latest/user-guide/index.html).

# Prerequisites

## Install system dependencies
You must first install development tools and libraries to your host.

On Debian-based systems, including Ubuntu:
```
sudo apt-get update
sudo apt-get install -y \
    autoconf \
    automake \
    cryptsetup \
    fuse2fs \
    git \
    fuse \
    libfuse-dev \
    libglib2.0-dev \
    libseccomp-dev \
    libtool \
    pkg-config \
    runc \
    squashfs-tools \
    squashfs-tools-ng \
    uidmap \
    wget \
    zlib1g-dev
```

## Install C compiler

1. Update Ubuntu package list
To update the package list, use the following command:
```
sudo apt-get update
```

2. Install GCC on Ubuntu
We now install GCC with the following command.
```
sudo apt-get install -y gcc build-essential
```
If GCC is already installed on your system, the command will list the version installed.

You have installed also GCC with the build-essential package. This will install GCC as well as other popular packages such as make, which is often used with GCC to automate the compilation process of bigger software.

## Install Go
SingularityCE is written in **Go**, and may require a newer version of Go than is available in the repositories of your distribution. We recommend installing the latest version of Go from the official binaries (https://golang.org/dl/)

```
export VERSION=1.22.1 OS=linux ARCH=amd64 && \
  cd /tmp && \
  wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
  sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
  rm go$VERSION.$OS-$ARCH.tar.gz
```

Set the Environment variable PATH to point to Go:
```
echo 'export PATH=/usr/local/go/bin:${PATH}' >> ~/.bashrc
source ~/.bashrc
```

## Download SingularityCE from a release
You can download SingularityCE from one of the releases. To see a full list, visit the GitHub release page (https://github.com/sylabs/singularity/releases).

After deciding on a release to install, you can run the following commands to proceed with the installation.
```
mkdir -p ${HOME}/softwares && \
cd ${HOME}/softwares && \
export VERSION=4.1.2 && \
  wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz
  tar -xzf singularity-ce-${VERSION}.tar.gz && \
  cd singularity-ce-${VERSION}
```

## Compile the SingularityCE source code
Now you are ready to build SingularityCE. Dependencies will be automatically downloaded. You can build SingularityCE using the following commands:
```
./mconfig && \
  make -C builddir && \
  sudo make -C builddir install
```


## Using singularity run from within the Docker container
**It is strongly recommended that you don't use the Docker container for running Singularity images**, only for creating them, since the Singularity command runs within the container as the root user.

<!--

However, for the purposes of this simple example, and potentially for testing/debugging purposes it is useful to know how to run a Singularity container within the Docker Singularity container. You may recall from the Running a container from the image section in the previous episode that we used the --contain switch with the singularity command. If you don’t use this switch, it is likely that you will get an error relating to /etc/localtime similar to the following:
```
WARNING: skipping mount of /etc/localtime: no such file or directory
FATAL:   container creation failed: mount /etc/localtime->/etc/localtime error: while mounting /etc/localtime: mount source /etc/localtime doesn't exist
```

This occurs because the /etc/localtime file that provides timezone configuration is not present within the Docker container. If you want to use the Docker container to test that your newly created image runs, you can use the --contain switch, or you can open a shell in the Docker container and add a timezone configuration as described in the Alpine Linux documentation:

```
sudo apt-get install tzdata
sudo cp /usr/share/zoneinfo/Europe/Madrid /etc/localtime
```
The singularity run command should now work successfully without needing to use --contain. Bear in mind that once you exit the Docker Singularity container shell and shutdown the container, this configuration will not persist.

-->

# References

For further information, read the [SingularityCE User Guide](https://docs.sylabs.io/guides/latest/user-guide/index.html).

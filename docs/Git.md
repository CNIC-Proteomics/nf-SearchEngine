# Install Git

## Linux and Unix distribution

It is easiest to install Git on Linux using the preferred package manager of your Linux distribution.

### Debian/Ubuntu

For the latest stable version for your release of Debian/Ubuntu.

To update the package list, use the following command:
```
sudo apt-get update
```

We now install git with the following command:
```
sudo apt-get install -y git
```

## References

For further information, read the [Git documentation](https://git-scm.com/downloads).


# Install Git-LFS (Git Large File Storage)

## Installing on Linux using packagecloud (Debian)

[packagecloud](https://packagecloud.io) hosts [`git-lfs` packages](https://packagecloud.io/github/git-lfs) for popular Linux distributions with apt/deb and yum/rpm based package-managers.  Installing from packagecloud is reasonably straightforward and involves two steps:

### 1. Adding the packagecloud repository

packagecloud provides scripts to automate the process of configuring the package repository on your system, importing signing-keys etc.
These scripts must be run sudo root, and you should review them first.

apt/deb repos:
```
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
```

### 2. Installing packages

With the packagecloud repository configured for your system, you can install Git LFS:

```
sudo apt-get install -y git-lfs
```

## References

For further information, read the [Git-LFS documentation](https://github.com/git-lfs/git-lfs/blob/main/INSTALLING.md).

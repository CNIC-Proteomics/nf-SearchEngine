# Install Nextflow

## Check Prerequisites

Make sure Java 11 or later is installed on your computer by using the command:
```
java -version
```

### Debian/Ubuntu distribution

If not installed, use one of the following commands to install it (for Debian/Ubuntu distribution):
```
sudo apt install openjdk-21-jre-headless
```
<!-- or
```
sudo apt install openjdk-19-jre-headless
``` -->

### Unix (MacOS) distribution

To install a specific version of Java on macOS using brew, you need to ensure that Homebrew is installed and then follow these steps to check for and install the desired version of Java.

- Run this command to check if Homebrew is installed:
```
brew --version
```
- If it’s not installed, you can install it with:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install the Java (openJDK 21):
```
brew install openjdk@21
```


## Set Up

Installing Nextflow is straightforward. Follow these steps:

1. Enter this command in your terminal:
```
mkdir -p ~/bin && \
cd ~/bin && \
curl -s https://get.nextflow.io | bash
```
(This creates a `nextflow` file in a bin folder in your home directory.)


2. Set the environment variable `PATH` to point to `~/bin`:
```
echo 'export PATH=~/bin:$PATH' >> ~/.bashrc && \
source ~/.bashrc
```

## References

For further information, read the [Nextflow documentation](https://www.nextflow.io/docs/latest/index.html).

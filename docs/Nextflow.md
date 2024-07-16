# Install Nextflow

## Check Prerequisites

Make sure Java 11 or later is installed on your computer by using the command:
```
java -version
```

If not installed, use one of the following commands to install it (for Ubuntu distribution):
```
sudo apt install openjdk-21-jre-headless
```
or
```
sudo apt install openjdk-19-jre-headless
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

### References

For further information, read the [Nextflow documentation](https://www.nextflow.io/docs/latest/index.html).

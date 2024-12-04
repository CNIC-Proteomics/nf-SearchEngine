# Commit huge files

**Requirements:** Download and install the Git command line extension. Once downloaded and installed, set up Git LFS for your user account by running:
```
git lfs install
```
You only need to run this once per user account.

1. Track the file:

In each Git repository where you want to use Git LFS, select the file types you'd like Git LFS to manage (or directly edit your .gitattributes). You can configure additional file extensions at anytime.
```
git lfs track backends/search_engine/MSFragger-4.1.zip
```

2. Add the changes in gitattributes:

Now make sure .gitattributes is tracked:
```
git add .gitattributes
```
Note that defining the file types Git LFS should track will not, by itself, convert any pre-existing files to Git LFS, such as files on other branches or in your prior commit history. To do that, use the git lfs migrate(1) command, which has a range of options designed to suit various potential use cases.

3. Add/Commit/Push the new huge file:

There is no step three. Just commit and push to GitHub as you normally would; for instance, if your current branch is named main:
```
git add backends/search_engine/MSFragger-4.1.zip
git commit -m "Add new MSFragger release"
git push origin main
```

# Build in Singularity

Building containers from SingularityCE definition files
Create a symbolic link
```
sudo singularity  build  search_engine_0.1.2.sif  search_engine.def
ln -s search_engine_0.1.2.sif search_engine.sif
```

Building container in sandbox from SingularityCE definition files
```
sudo  singularity  build  --sandbox  /tmp/search_engine    search_engine.def
```

You can build into the same sandbox container multiple times (though the results may be unpredictable, and under most circumstances, it would be preferable to delete your container and start from scratch):
```
sudo singularity  build  --update  --sandbox  /tmp/search_engine  search_engine.def
```


In this case, we're running singularity build with sudo because installing software with apt-get, as in the %post section, requires the root privileges.

By default, when you run SingularityCE, you are the same user inside the container as on the host machine. Using sudo on the host, to acquire root privileges, ensures we can use apt-get as root inside the container.

Using a fake root (for non-admin users)
```
singularity build --fakeroot search_engine_0.1.2.sif search_engine.def
```


# Interacting with images: Shell
The shell command allows you to spawn a new shell within your container and interact with it as though it were a virtual machine.

```
singularity shell search_engine_0.1.2.sif
```

Enable to write in folder container (sandbox)
```
sudo singularity shell --writable /tmp/search_engine
```

Enable to write in file container
```
sudo singularity shell --writable-tmpfs search_engine_0.1.2.sif
```

Bind disk
```
singularity shell --bind /mnt/tierra:/mnt/tierra search_engine_0.1.2.sif
```

# Singularity Hub

## How to generate a new keypair

Open a command line and check for your generated keys:
```
singularity keys list
```

If you already have a generated key just skip the next step and go to the third one, to obtain your key's fingerprint. Otherwise, if you need to generate a key just run:
```
singularity keys newpair
```

In order to obtain the fingerprint from the key you just created, list again your keys:
```
singularity keys list
This will list the keys you have created. In this list, you will find your key's fingerprint next to "F:", for example:
0) U: John Doe (my key) <johndoe@sylabs.io>
C: 2018-08-21 20:14:39 +0200 CEST
F: D87FE3AF5C1F063FCBCC9B02F812842B5EEE5934
L: 4096
```

Copy your fingerprint ( e.g. from the previous example the fingerprint would be D87FE3AF5C1F063FCBCC9B02F812842B5EEE5934 ) and then add it to your keystore by doing:
```
singularity keys push <Your key's fingerprint>
```

From the previous example it would be:
```
singularity keys push D87FE3AF5C1F063FCBCC9B02F812842B5EEE5934
```

## Login and Push image

Login to Singularity Hub
```
singularity remote login
```

Sign your image locally using Singularity CLI.
```
singularity sign search_engine_0.1.2.sif
No OpenPGP signing keys found, autogenerate? [Y/n]
Enter your name (e.g., John Doe) : John Doe
Enter your email address (e.g., john.doe@example.com) : john.doe@example.com
Enter optional comment (e.g., development keys) : demo
Generating Entity and OpenPGP Key Pair... Done
Enter encryption passphrase :
```

Verifying an image is quite easy, just run the verify command within your terminal.
```
singularity verify search_engine_0.1.2.sif
Verifying image: image.sif
Data integrity checked, authentic and signed by:
John Doe <john.doe@example.com>, KeyID 284972D6D4FC6713
```

Push image
```
singularity push search_engine_0.1.2.sif library://proteomicscnic/next-launcher/search_engine:0.1.2
```




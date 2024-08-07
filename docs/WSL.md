# How to install WSL2 (Windows Subsystem for Linux 2) on Windows 10

To install WSL with a specific distro on Windows 10, use these steps:

1. **Open Start**.

2. **Search for Command Prompt, right-click the top result, and select the Run as administrator option**.

3. **Type the following command to view a list of available WSL distros to install on Windows 10 and press Enter**:
```
wsl --list --online

	The following is a list of valid distributions that can be installed.
	Install using 'wsl.exe --install <Distro>'.

	NAME                                   FRIENDLY NAME
	Ubuntu                                 Ubuntu
	Debian                                 Debian GNU/Linux
	kali-linux                             Kali Linux Rolling
	Ubuntu-18.04                           Ubuntu 18.04 LTS
	Ubuntu-20.04                           Ubuntu 20.04 LTS
	Ubuntu-22.04                           Ubuntu 22.04 LTS
	Ubuntu-24.04                           Ubuntu 24.04 LTS
	OracleLinux_7_9                        Oracle Linux 7.9
	OracleLinux_8_7                        Oracle Linux 8.7
	OracleLinux_9_1                        Oracle Linux 9.1
	openSUSE-Leap-15.5                     openSUSE Leap 15.5
	SUSE-Linux-Enterprise-Server-15-SP4    SUSE Linux Enterprise Server 15 SP4
	SUSE-Linux-Enterprise-15-SP5           SUSE Linux Enterprise 15 SP5
	openSUSE-Tumbleweed                    openSUSE Tumbleweed
```
Quick note: At the time of this writing, you can install Ubuntu, Debian, Kali Linux, openSUSE, and SUSE Linux Enterprise Server.

4. **Install the Ubuntu 22.04 from the Windows Store**.

For this case, we recomend the **Ubuntu-22.04** distribution. Type the following command to install the WSL with a specific distro on Windows 10 and press Enter:
```
wsl --install -d Ubuntu-22.04
```

5. **Update the WSL to WSL 2 (Optional)**

If you have WSL 1, you can update it to WSL 2.

To check which version you have, execute the following command:
```
wsl --list --verbose
```

Alternatively, to check the WSL status, use:
```
wsl --status
```
You should see a message including "Default Version 2," which verifies that the default version has been set correctly.

To set the version to 2, enter the following command:
```
wsl --set-version Ubuntu-22.04 2
```
Wait for the "Conversion complete" or "This distribution is already the requested version" message in the terminal.

Again, execute the following command to check the current version:
```
wsl --list --verbose
```
You should see a message including "NAME Ubuntu VERSION 2," which verifies that the version has been set correctly.



### References

For further information, read the [Microsoft documentation](https://learn.microsoft.com/en-us/windows/wsl/install).

<!--
https://pureinfotech.com/install-windows-subsystem-linux-2-windows-10/#install_wsl_command_2004_windows10
https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#1-overview
https://linuxconfig.org/ubuntu-22-04-on-wsl-windows-subsystem-for-linux
https://superuser.com/questions/1746633/update-the-windows-subsystem-for-linux-wsl-to-wsl-2
-->




## Increase the Memory Usage Limit in WSL2

If you need to increase the memory usage limit in WSL2, you can follow these steps:

1. **Check the Current Memory**

You can check how much memory and swap space are allocated to WSL using the `free` command from within a WSL distribution:

```
free -h --giga
```

2. **Create .wslconfig**

Refer to the Microsoft documentation on configuration settings for **.wslconfig** if you need help with this step. Below is the configuration I'm currently using for my machine, as I don't have a lot of RAM to work with:

Create or edit the file at `"C:\Users\YourUsername\.wslconfig"` and add the following lines:

```
[wsl2]
memory=100GB
```

3. **Restart WSL**

You can either close out of WSL manually and wait a few seconds for it to fully shut down, or you can launch Command Prompt or PowerShell and run the following command to forcibly shut down all WSL distributions:

```
wsl --shutdown
```

4. **Verify That WSL Respects .wslconfig**

Finally, run the `free` command again to verify that WSL respects your specified resource limits:

```
free -h --giga
```

<!-- 

### References

https://www.aleksandrhovhannisyan.com/blog/limiting-memory-usage-in-wsl-2/

-->
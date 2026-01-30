# Setup microk8s on Windows with Hyper-V and Ubuntu Server 22.04 LTS

## Install Hyper-V and Windows Subsystem for Linux (WSL) if not already installed:

You need to execute the following command for checking the status of Hyper-V and WSL features:

```powershell
Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
```

If Hyper-V is not enabled, you can enable it with the following command:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

After restarting your computer, you can run the Hyper-V Manager from the Start menu. And create a new virtual switch
for networking using the real network adapter of your computer. Open the Virtual Switch Manager from the Actions panel,
create a new External virtual switch, and select the network adapter you want to use. And check the option "Allow
operating system to share this network adapter".

## Download ubuntu server ISO
Download the Ubuntu Server 22.04 LTS ISO from the official website:
https://ubuntu.com/download/server

## Create a new virtual machine
Open Hyper-V Manager and create a new virtual machine with the following settings:
- Generation: Generation 2
- Memory: 8192 MB
- Network: Select the virtual switch you created earlier
- Virtual hard disk: 50 GB or more
- Installation options: Install an operating system from a bootable image file, and select the Ubuntu Server ISO you downloaded earlier

After save the configuration, go to edit the configuration and:
- set the number of CPU cores to 4 or more.
- under security uncheck "Enable Secure Boot".

## Disable Swap to avoid microk8s issues
After installing Ubuntu Server, you need to disable swap to avoid microk8s issues. 

Check if swap is enabled by running the following command:
```bash
swapon --show
```

Then disable it, you can do this by running the following commands:
```bash
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g'
```

After that, you can verify that swap is disabled by running the `swapon --show` command again. And reboot the machine.

```bash
sudo reboot
```
# Setup Rasberry Pi 4 Model B with touch screen for Kiosk mode

## Install Android in Raspberry Pi 4 Model B

For that we're going to use the [LineageOS](https://lineageos.org/) project, which is an open-source operating system
for smartphones and tablets, based on the Android mobile platform. For that wer going to use konstakang's builds of
LineageOS for Raspberry Pi 4 Model B available at [KonstaKANG/lineageos-rpi4](https://konstakang.com/devices/rpi4/).

Once downloaded we need the balenaEtcher tool to flash the image into a microSD card. You can download it from
[balenaEtcher](https://www.balena.io/etcher/) or using scoop

```bash
scoop install etcher
```

Then you have extend the size of the data parition using a software in my case the parition magic community edition.

## Install MindTheGapps

Use the recommened version of MindTheGapps for LineageOS in the KonstaKANG page. In this case the information is the
entry for my
release [LineageOS 23.0 (Android 16)](https://konstakang.com/devices/rpi4/LineageOS23/).

Enable the advanced restart ooptions to reboot into recovery mode, select the USB storage in which you have saved the
MindTheGapps zip and install it.



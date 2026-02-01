## Mounting calibre library via smb

To mount a calibre library via SMB in Calibre-Web, you can follow execute this commands:

```bash
mount_smbfs //<user>@1<nas_ip>/books/<your-library> <hostpath-path>/calibre-library/<your-library>
```
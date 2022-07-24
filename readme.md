For me in the future

### Steps
0. Proxmox install
   https://www.proxmox.com/en/
1. TrueNas Scale
   https://www.truenas.com/download-truenas-scale/

   ```
   List disk by ID
   ls -l /dev/disk/by-id/
   
   Pass DISK to VM
   qm set 100 -scsi1 /dev/disk/by-id/ata-ST6000NM0044_XXX
   qm set 100 -scsi2 /dev/disk/by-id/ata-ST6000NM0044_XXX
   ```

2. Run proxmox/build-ubuntu-cloud-images.sh
   Resize disk, configure IP


### Notes

Create user for Terraform on Proxmox
https://registry.terraform.io/providers/Telmate/proxmox/latest/docs

```
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user add terraform-prov@pve --password <password>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```

### Helpful links

https://pve.proxmox.com/wiki/Linux_Container - how to download lxc template

https://tteck.github.io/Proxmox/

https://registry.terraform.io/modules/sdhibit/cloud-init-vm/proxmox/latest/examples/ubuntu_single_vm
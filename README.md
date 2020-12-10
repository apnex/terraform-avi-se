## `terraform-avi-se'
Terraform module for AVI Service Engine depoyment on VMware Cloud on AWS (VMC)  
Create a new directory containing the following `main.tf` and `terraform.tfvars` files  
Adjust parameters as required  

#### `terraform.tfvars`
```
vsphere_user     = "cloudadmin@vmc.local"
vsphere_password = "cloudadmin-password"
vsphere_server   = "vcenter.x.x.x.x.vmwarevmc.com"
```

#### `main.tf`
```
terraform {
	required_providers {
		vsphere = "= 1.23.0"
	}
}
provider "vsphere" {
	user                 = var.vsphere_user
	password             = var.vsphere_password
	vsphere_server       = var.vsphere_server
	allow_unverified_ssl = true
}

module "avi-se" {
	### module source
	source			= "github.com/apnex/terraform-avi-se"

	### vsphere variables
	datacenter		= "SDDC-Datacenter"
	datastore		= "WorkloadDatastore"
	host			= "10.2.2.4"
	resourcepool		= "AO-Demo"
	network-mgmt		= "ao-mgmt"
	network-data		= "ao-data"

	## avi variables
	remote_ovf_url		= "http://172.21.10.2:9000/iso/avi-se.ova"
	se-hostname		= "ao-avi-se-01"
	AVICNTRL		= "172.21.10.109"
	AVICNTRL_AUTHTOKEN	= "cloud-auth-token"
	AVICNTRL_CLUSTERUUID	= "cloud-cluster-uuid"

	## leave empty string if using DHCP
	mgmt-ip			= ""
	mgmt-mask		= ""
	default-gw		= ""
	DNS			= ""
}
```

data "vsphere_datacenter" "datacenter" {
	name          = var.datacenter
}

data "vsphere_resource_pool" "pool" {
	name          = var.resourcepool
	datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
	name          = var.host
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
	name          = var.datastore
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "se-mgmt" {
	name          = var.network-mgmt
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "se-data" {
	name          = var.network-data
	datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "avi-se" {
	name             = var.se_hostname
	resource_pool_id = data.vsphere_resource_pool.pool.id
	datastore_id     = data.vsphere_datastore.datastore.id
	datacenter_id    = data.vsphere_datacenter.dc.id
	host_system_id   = data.vsphere_host.host.id
	wait_for_guest_net_timeout = 0
	wait_for_guest_ip_timeout  = 0
 
	ovf_deploy {
		#local_ovf_path		= var.local_ovf_path
		remote_ovf_url		= var.remote_ovf_url
		disk_provisioning	= "thin"
		ovf_network_map		= {
			"Management"		= data.vsphere_network.se-mgmt.id
			"Data Network 1"	= data.vsphere_network.se-data.id
			"Data Network 2"	= data.vsphere_network.se-data.id
			"Data Network 3"	= data.vsphere_network.se-data.id
			"Data Network 4"	= data.vsphere_network.se-data.id
			"Data Network 5"	= data.vsphere_network.se-data.id
			"Data Network 6"	= data.vsphere_network.se-data.id
			"Data Network 7"	= data.vsphere_network.se-data.id
			"Data Network 8"	= data.vsphere_network.se-data.id
			"Data Network 9"	= data.vsphere_network.se-data.id
		}
	}
 
	vapp {
		properties = {
			"AVICNTRL"		= var.AVICNTRL,
			"AVICNTRL_AUTHTOKEN"	= var.AVICNTRL_AUTHTOKEN,
			"AVICNTRL_CLUSTERUUID"	= var.AVICNTRL_CLUSTERUUID,
			"AVISETYPE"		= "NETWORK_ADMIN",
			"mgmt-ip"		= var.mgmt-ip,
			"mgmt-mask"		= var.mgmt-mask,
			"default-gw"		= var.default-gw,
			"DNS"			= var.DNS,
			"sysadmin-public-key"	= ""
		}
	}

}

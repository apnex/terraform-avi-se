### vsphere variables
variable "datacenter" {}
variable "datastore" {}
variable "resourcepool" {}
variable "host" {}
variable "network-mgmt" {}
variable "network-data" {}

### avi se variables
variable "remote_ovf_url" {}
variable "se-hostname" {}
variable "AVICNTRL" {}
variable "AVICNTRL_AUTHTOKEN" {}
variable "AVICNTRL_CLUSTERUUID" {}
variable "AVISETYPE" {
	default = "NETWORK_ADMIN"
}
variable "mgmt-ip" {
	default = ""
}
variable "mgmt-mask" {
	default = ""
}
variable "default-gw" {
	default = ""
}
variable "DNS" {
	default = ""
}
variable "sysadmin-public-key" {
	default = ""
}

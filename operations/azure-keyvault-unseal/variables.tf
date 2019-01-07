variable "public_key" {
  default = ""
}

variable "tenant_id" {
    default = ""
}

variable "subscription_id" {
    default = ""
}

variable "client_id" {
    default = ""
}

variable "client_secret" {
    default = ""
}

variable "location" {
    description = "Azure location where the Key Vault resource to be created"
    default = "eastus"
}

variable "environment" {
    default = "Test"
}

variable "vm_name" {
    description = "Name for the provisioned VM"
    default = "azure-auth-demo-vm"
}

variable "vault_url" {
    description = "Vault binary download link"
    default = "https://releases.hashicorp.com/vault/1.0.1/vault_1.0.1_linux_amd64.zip"
}

variable "resource_group_name" {
    default = "vault-demo-azure-auth"
}

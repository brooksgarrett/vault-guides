output "service_identity_principal_id" {
    value = "${azurerm_user_assigned_identity.tfe.principal_id}"
}

output "key_vault_name" {
    value = "${azurerm_key_vault.tfe.name}"
}

output "key_name" {
  value = "${azurerm_key_vault_key.test.name}"
}

output "ip" {
    value = "${azurerm_public_ip.tf_publicip.ip_address}"
}

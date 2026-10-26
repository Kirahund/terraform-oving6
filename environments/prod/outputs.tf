output "resource_group_name" { value = azurerm_resource_group.main.name }
output "vnet_name" { value = module.stack.vnet_name }
output "subnet_id" { value = module.stack.subnet_id }

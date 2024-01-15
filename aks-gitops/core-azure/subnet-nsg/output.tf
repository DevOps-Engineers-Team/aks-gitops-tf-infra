output "subnet_name" {
    value = module.subnet_nsg.subnet_name
}

output "nsg_id" {
    value = module.subnet_nsg.nsg_id
}

output "subnet_id" {
    value = module.subnet_nsg.subnet_id
}

#

output "app_gw_fe_subnet_name" {
    value = module.app_gw_fe.subnet_name
}

output "app_gw_fe_nsg_id" {
    value = module.app_gw_fe.nsg_id
}

output "app_gw_fe_subnet_id" {
    value = module.app_gw_fe.subnet_id
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-network"
  address_space       = var.address_space
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
}


resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-sub-network"
  resource_group_name  = var.azure_resource_group_name
  address_prefixes     = var.address_prefixes
  virtual_network_name = azurerm_virtual_network.vnet.name
  depends_on           = [azurerm_virtual_network.vnet]
}


resource "azurerm_network_security_group" "security_group" {
  name                = "${var.prefix}-security-group"
  resource_group_name = var.azure_resource_group_name
  location            = var.azure_resource_group_location
  dynamic "security_rule" {
    for_each = var.security_rule
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

}

# resource "azurerm_public_ip" "public_ip" {
#   name                = var.azurerm_public_ip_name
#   location            = var.azure_resource_group_location
#   resource_group_name = var.azure_resource_group_name
#   allocation_method   = var.public_ip_allocation_method
#   sku                 = var.public_ip_sku
# }

resource "azurerm_public_ip" "public_ips" {
  for_each            = toset(var.public_ip_names)
  name                = each.value
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_network_interface" "nic" {
  for_each            = toset(var.public_ip_names)
  name                = "${var.azurerm_network_interface_name}-${each.key}"
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
  ip_configuration {
    name                          = var.azurerm_network_interface_ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.azurerm_network_interface_ip_configuration_private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.public_ips[each.key].id
  }
  depends_on = [azurerm_public_ip.public_ips, azurerm_subnet.subnet]
}

resource "azurerm_network_interface_security_group_association" "nic_security_group" {
  for_each                  = azurerm_network_interface.nic # Use the map directly here
  network_interface_id      = each.value.id
  network_security_group_id = azurerm_network_security_group.security_group.id
  depends_on                = [azurerm_network_security_group.security_group, azurerm_network_interface.nic]
}


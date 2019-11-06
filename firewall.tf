resource "azurerm_firewall" "main" {
  name                = "${var.environment}-${var.location}-fw"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = var.aks_config[0]
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.main[0].id
  }

  tags = var.common_tags
}


resource "null_resource" "azcli" {
  provisioner "local-exec" {
    command = "pip install --pre azure-cli --extra-index-url https://azurecliprod.blob.core.windows.net/edge"
  }
}

resource "null_resource" "ip_config" {
  count = length(var.aks_config) > 1 ? length(var.aks_config) : 0

  provisioner "local-exec" {
    command = "az network firewall ip-config create --firewall-name ${azurerm_firewall.main.name} --name ${var.aks_config[1]} --public-ip-address ${azurerm_public_ip.main[1].id} --resource-group ${var.rg_name} --vnet-name ${var.vnet_name}"
  }

  depends_on = [azurerm_firewall.main, null_resource.azcli]
}
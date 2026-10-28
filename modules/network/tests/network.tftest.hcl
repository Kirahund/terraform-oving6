mock_provider "azurerm" {}

variables {
  project             = "demo"
  location            = "norwayeast"
  resource_group_name = "rg-demo"
}

run "test_cidr" {
  command = plan

  assert {
    condition = (
      contains(azurerm_virtual_network.main.address_space, "10.10.0.0/16") &&
      contains(azurerm_subnet.main.address_prefixes, "10.10.1.0/24") &&
      contains(azurerm_subnet.data.address_prefixes, "10.10.2.0/24")
    )
    error_message = "CIDR-adressene er feil."
  }
}


run "test_navn" {
  command = plan

  assert {
    condition = (
      azurerm_subnet.main.name == "demo-subnet" &&
      azurerm_subnet.data.name == "demo-data-subnet"
    )
    error_message = "Ressursnavnene er feil."
  }
}

run "test_ugyldig_project" {
  command = plan

  variables {
    project = "UGYLDIG PROSJEKT!"
  }

  expect_failures = [
    var.project
  ]
}

run "test_ssh" {
  command = plan

  assert {
    condition = !(
      azurerm_network_security_rule.ssh.access == "Allow" &&
      azurerm_network_security_rule.ssh.direction == "Inbound" &&
      contains(["22", "*"], azurerm_network_security_rule.ssh.destination_port_range) &&
      contains(["*", "0.0.0.0/0", "Internet"], azurerm_network_security_rule.ssh.source_address_prefix)
    )
    error_message = "SSH-port 22 skal ikke være åpen mot hele internett."
  }
}
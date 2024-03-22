param vm_name string = 'vm-ebsv5-nvme'
param vnet_name string = 'vm-ebsv5-nvme-vnet'
param location string = 'westus3'
param addressPrefix string = '10.2.0.0/24'
param adminUsername string = 'ttadmin'
@allowed([
  '1'
  '2'
  '3'
])
param availabilityZone string = '1'
@secure()
param adminPassword string
@allowed([
  'Standard_E32bs_v5'
  'Standard_E64bs_v5'
])
param vmSize string = 'Standard_E64bs_v5'
param deployBastion bool = true

var resourceToken = toLower(uniqueString(subscription().id, resourceGroup().name, location))
var nic_name = '${vm_name}-nic'
var bastionHostName = 'bastion${resourceToken}'
var bastionPublicIpName = '${bastionHostName}-pip'
var identityName = 'mi${resourceToken}'
var rbacRoles = [
  '9980e02c-c2be-4d73-94e8-173b1dc7cf3c' // VM Contributor - https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles/compute#virtual-machine-contributor
]

resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vm_name
  location: location
  dependsOn: [
    disk0
    disk1
    disk2
    disk3
    disk4
    disk5
  ]
  identity: {
    type: 'SystemAssigned'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${vm_name}_OsDisk'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        deleteOption: 'Delete'
      }
      dataDisks: [
        {
          lun: 0
          name: 'disk0'
          createOption:  'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            id: resourceId('Microsoft.Compute/disks', 'disk0')
          }
          deleteOption: 'Detach'
          toBeDetached: false
        }
        {
          lun: 1
          name: 'disk1'
          createOption:  'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            id: resourceId('Microsoft.Compute/disks', 'disk1')
          }
          deleteOption: 'Detach'
          toBeDetached: false
        }
        {
          lun: 2
          name: 'disk2'
          createOption:  'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            id: resourceId('Microsoft.Compute/disks', 'disk2')
          }
          deleteOption: 'Detach'
          toBeDetached: false
        }
        {
          lun: 3
          name: 'disk3'
          createOption:  'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            id: resourceId('Microsoft.Compute/disks', 'disk3')
          }
          deleteOption: 'Detach'
          toBeDetached: false
        }
        {
          lun: 4
          name: 'disk4'
          createOption:  'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            id: resourceId('Microsoft.Compute/disks', 'disk4')
          }
          deleteOption: 'Detach'
          toBeDetached: false
        }
        {
          lun: 5
          name: 'disk5'
          createOption:  'Attach'
          caching: 'None'
          writeAcceleratorEnabled: false
          managedDisk: {
            id: resourceId('Microsoft.Compute/disks', 'disk5')
          }
          deleteOption: 'Detach'
          toBeDetached: false
        }
      ]
      diskControllerType: 'NVMe'
    }
    osProfile: {
      computerName: vm_name
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        enableVMAgentPlatformUpdates: false
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    licenseType: 'Windows_Server'
  }
}

resource disk0 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'disk0'
  location: location
  sku: {
    name: 'PremiumV2_LRS'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    creationData: {
      createOption: 'Empty'
      logicalSectorSize: 4096
    }
    diskSizeGB: 1024
    diskIOPSReadWrite: 80000
    diskMBpsReadWrite: 1200
    diskIOPSReadOnly: 3000
    diskMBpsReadOnly: 125
  }
}

resource disk1 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'disk1'
  location: location
  sku: {
    name: 'PremiumV2_LRS'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    creationData: {
      createOption: 'Empty'
      logicalSectorSize: 4096
    }
    diskSizeGB: 1024
    diskIOPSReadWrite: 80000
    diskMBpsReadWrite: 1200
    diskIOPSReadOnly: 3000
    diskMBpsReadOnly: 125
  }
}

resource disk2 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'disk2'
  location: location
  sku: {
    name: 'PremiumV2_LRS'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    creationData: {
      createOption: 'Empty'
      logicalSectorSize: 4096
    }
    diskSizeGB: 1024
    diskIOPSReadWrite: 80000
    diskMBpsReadWrite: 1200
    diskIOPSReadOnly: 3000
    diskMBpsReadOnly: 125
  }
}

resource disk3 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'disk3'
  location: location
  sku: {
    name: 'PremiumV2_LRS'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    creationData: {
      createOption: 'Empty'
      logicalSectorSize: 4096
    }
    diskSizeGB: 1024
    diskIOPSReadWrite: 80000
    diskMBpsReadWrite: 1200
    diskIOPSReadOnly: 3000
    diskMBpsReadOnly: 125
  }
}

resource disk4 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'disk4'
  location: location
  sku: {
    name: 'PremiumV2_LRS'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    creationData: {
      createOption: 'Empty'
      logicalSectorSize: 4096
    }
    diskSizeGB: 1024
    diskIOPSReadWrite: 80000
    diskMBpsReadWrite: 1200
    diskIOPSReadOnly: 3000
    diskMBpsReadOnly: 125
  }
}

resource disk5 'Microsoft.Compute/disks@2023-10-02' = {
  name: 'disk5'
  location: location
  sku: {
    name: 'PremiumV2_LRS'
  }
  zones: [
    availabilityZone
  ]
  properties: {
    creationData: {
      createOption: 'Empty'
      logicalSectorSize: 4096
    }
    diskSizeGB: 1024
    diskIOPSReadWrite: 80000
    diskMBpsReadWrite: 1200
    diskIOPSReadOnly: 3000
    diskMBpsReadOnly: 125
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'ComputeSubnet'
        properties: {
          addressPrefix: cidrSubnet(addressPrefix, 26, 0)
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: cidrSubnet(addressPrefix, 26, 1)
          networkSecurityGroup: {
            id: bastionNsg.id
          }
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: nic_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableAcceleratedNetworking: true
    enableIPForwarding: false
  }
}

resource bastionPublicIp 'Microsoft.Network/publicIPAddresses@2023-04-01' = if (deployBastion) {
  name: bastionPublicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: bastionPublicIpName
    }
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2023-04-01' = if (deployBastion) {
  name: bastionHostName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    ipConfigurations: [
      {
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/AzureBastionSubnet'
          }
          publicIPAddress: {
            id: bastionPublicIp.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
        name: 'ipconfig1'
      }
    ]
    enableTunneling: true
  }
}

resource bastionNsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: 'AzureBastionSubnet-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHttpsInBound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'Internet'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowGatewayManagerInBound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'GatewayManager'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowLoadBalancerInBound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'AzureLoadBalancer'
          destinationPortRange: '443'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowBastionHostCommunicationInBound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationPortRanges: [
            '8080'
            '5701'
          ]
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 130
          direction: 'Inbound'
        }
      }
      {
        name: 'DenyAllInBound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 1000
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowSshRdpOutBound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRanges: [
            '22'
            '3389'
          ]
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 100
          direction: 'Outbound'
        }
      }
      {
        name: 'AllowAzureCloudCommunicationOutBound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationPortRange: '443'
          destinationAddressPrefix: 'AzureCloud'
          access: 'Allow'
          priority: 110
          direction: 'Outbound'
        }
      }
      {
        name: 'AllowBastionHostCommunicationOutBound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationPortRanges: [
            '8080'
            '5701'
          ]
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 120
          direction: 'Outbound'
        }
      }
      {
        name: 'AllowGetSessionInformationOutBound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          destinationPortRanges: [
            '80'
            '443'
          ]
          access: 'Allow'
          priority: 130
          direction: 'Outbound'
        }
      }
      {
        name: 'DenyAllOutBound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 1000
          direction: 'Outbound'
        }
      }
    ]
  }
}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: identityName
  location: location
}

resource identityRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for role in rbacRoles: {
  name: guid(vm.id, role, identity.id)
  scope: resourceGroup()
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', role)
    principalId: identity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}]

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'configure-storage'
  kind: 'AzurePowerShell'
  // chinaeast2 is the only region in China that supports deployment scripts
  location: startsWith(location, 'china') ? 'chinaeast2' : location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identity.id}': {}
    }
  }
  dependsOn: [
    identityRoleAssignments
  ]
  properties: {
    azPowerShellVersion: '8.0'
    retentionInterval: 'PT1H'
    environmentVariables: [
      {
        name: 'vmName'
        value: vm.name
      }
      {
        name: 'rgName'
        value: resourceGroup().name
      }
      {
        name: 'azLocation'
        value: startsWith(location, 'china') ? 'chinaeast2' : location
      }
    ]
    scriptContent: loadTextContent('./scripts/configure-storage.ps1')
  }
}

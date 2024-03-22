### Deploy via the Azure Portal

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMSBrett%2Fnvmetest%2Fmaster%2Fmain.json)

### Deploy using the Azure CLI

```bash
#!/bin/bash
az deployment group create --template-file ./main.bicep --parameters ./main.bicepparam --resource-group 'nvme_test'
```

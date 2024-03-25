[string]$vmName = $env:vmName
[string]$rgName = $env:rgName
[string]$azLocation = $env:azLocation
[string]$commandName = "ConfigureDisks"

if ([string]::IsNullOrEmpty($vmName) ){
    Write-Output "vmName name is not provided"
    throw "vmName name is not provided"
}

if ([string]::IsNullOrEmpty($rgName)){
    Write-Output "rgName is not provided"
    throw "rgName is not provided"
}

if ([string]::IsNullOrEmpty($azLocation)){
    Write-Output "azLocation is not provided"
    throw "azLocation is not provided"
}

$scriptToRun = '$physicaldisks = Get-StorageSubsystem -FriendlyName "Windows Storage*" | Get-PhysicalDisk -CanPool $true | Sort-Object -Property "DeviceId"; New-StoragePool -FriendlyName "data" -StorageSubSystemFriendlyName "Windows Storage*" -PhysicalDisks $physicaldisks[0..3] | New-VirtualDisk -FriendlyName "data" -UseMaximumSize -ResiliencySettingName Simple | Initialize-Disk -PassThru | New-Partition -DriveLetter "E" -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "data" -Confirm:$false; New-StoragePool -FriendlyName "logs" -StorageSubSystemFriendlyName "Windows Storage*" -PhysicalDisks $physicaldisks[4..5] | New-VirtualDisk -FriendlyName "logs" -UseMaximumSize -ResiliencySettingName Simple | Initialize-Disk -PassThru | New-Partition -DriveLetter "F" -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "logs" -Confirm:$false'

Write-Output 'Running script to configure storage'
Write-Output 'Remove existing run command with the same name - if it exists'
Remove-AzVMRunCommand -ResourceGroupName $rgName -VMName $vmName -RunCommandName $commandName
Write-Output 'Create new run command'
Set-AzVMRunCommand -ResourceGroupName $rgName -VMName $vmName -Location $azLocation -RunCommandName $commandName -SourceScript $scriptToRun
Write-Output 'Get status of the command'
Get-AzVMRunCommand -ResourceGroupName $rgName -VMName $vmName -RunCommandName $commandName -Expand InstanceView
Write-Output 'Done'
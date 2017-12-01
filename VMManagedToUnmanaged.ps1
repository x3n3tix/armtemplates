param(
    [parameter(mandatory)][string] $subscription, # Name of subscription to load
    [parameter(mandatory)][string] $resourceGroup, # Name of Resource Group of the existing managed disk
    [parameter(mandatory)][string] $diskName, # Name of the existing managed disk
    [parameter(mandatory)][string] $storageAccount, # Name of the storage account to store the vhd
    [parameter(mandatory)][string] $destBlob # Name of the final unmanaged VHD blob (should end in .vhd)
)

Login-AzureRmAccount -ErrorAction Stop
Select-AzureRmSubscription -SubscriptionName $subscription -ErrorAction Stop

$storageAccountKey = Read-Host "Enter Storage Account Access Key" -AsSecureString
$destContainer = "vhds" # Can be changed if needed but should generally be left at 'vhds'

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($storageAccountKey)
$plainStorageAccountKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

if(!($storageAccountKey -eq $null)){
    $sas = Grant-AzureRmDiskAccess -ResourceGroupName $resourceGroup -DiskName $diskName -DurationInSecond 3600 -Access Read -Verbose -ErrorAction Stop
    $destContext = New-AzureStorageContext –StorageAccountName $storageAccount -StorageAccountKey $plainStorageAccountKey -Verbose -ErrorAction Stop
    $blobcopy=Start-AzureStorageBlobCopy -AbsoluteUri $sas.AccessSAS -DestContainer $destContainer -DestContext $destContext -DestBlob $destBlob -Verbose -ErrorAction Stop
}else {
    Write-Host "No key provided." -ForegroundColor Red
}
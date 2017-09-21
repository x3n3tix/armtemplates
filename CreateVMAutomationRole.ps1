## Create Virtual Machine Automation role ##

param(
    [parameter(Mandatory=$true)][string] $subscriptionName
)
Login-AzureRmAccount -ErrorAction Stop
$subscriptionId = (Get-AzureRmSubscription -SubscriptionName $subscriptionName).Id

$role = Get-AzureRmRoleDefinition -Name "Virtual Machine Contributor"
$role.Id = $null
$role.Name = "Virtual Machine Automation"
$role.Description = "Can monitor, start, and stop virtual machines."
$role.Actions.RemoveRange(0,$role.Actions.Count)
$role.Actions.Add("Microsoft.Compute/*/read")
$role.Actions.Add("Microsoft.Compute/virtualMachines/start/action")
$role.Actions.Add("Microsoft.Compute/virtualMachines/restart/action")
$role.Actions.Add("Microsoft.Compute/virtualMachines/powerOff/action")
$role.Actions.Add("Microsoft.Compute/virtualMachines/deallocate/action")
$role.Actions.Add("Microsoft.Network/*/read")
$role.Actions.Add("Microsoft.Storage/*/read")
$role.Actions.Add("Microsoft.Authorization/*/read")
$role.Actions.Add("Microsoft.Resources/subscriptions/resourceGroups/read")
$role.Actions.Add("Microsoft.Resources/subscriptions/resourceGroups/resources/read")
$role.AssignableScopes.Clear()
$role.AssignableScopes.Add("/subscriptions/$($subscriptionId)")

New-AzureRmRoleDefinition -Role $role

Get-AzureRmRoleDefinition -Name "Virtual Machine Automation"

Write-Host "Virtual Machine Automation role created`n" -ForegroundColor Cyan
Read-Host "Press Enter to exit"
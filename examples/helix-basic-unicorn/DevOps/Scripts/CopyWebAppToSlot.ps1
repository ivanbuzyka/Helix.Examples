param(	[string] $WebAppName = "webappname",    
	[string] $AppServicePlan = "webapp-hostingplan-name",
    [string] $ResourceGroupName = "resourcegroupname",
	# Default source slot name is "Production"
	[string] $SourceSlotName = "Production",
	[string] $TargetSlotName = "targetslotname"
    )
	
	Write-Host "Copying $SourceSlotName webap app slot to $TargetSlotName slot"
	Write-Host "Removing $TargetSlotName if it exists"
	Remove-AzureRMWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $TargetSlotName -ErrorAction SilentlyContinue -Force

	$SourceSlot = Get-AzureRMWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SourceSlotName
	New-AzureRMWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName -AppServicePlan $AppServicePlan -SourceWebApp $SourceSlot

	Write-Host "Copying complete"
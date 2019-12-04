param(	[string] $ResourceGroupName = "resourcegroupname",	
	[string] $WebAppName = "webappname",
	[string] $SlotName = "slotname",
	[string] $ConnectionStringName = "connectionstringname",	
	[string] $SqlServerName = "somesqlservername.database.windows.net",
	[string] $DbName = "databasename",
	[string] $DbUserName = "dbusername",
	[string] $DbPassword = "dbpassword"
    )
	
	Write-Host "Setting connection string for "

	$composedConnectionString = "Encrypt=True;TrustServerCertificate=False;Data Source=$SqlServerName,1433;Initial Catalog=$DbName;User Id=$DbUserName;Password=$DbPassword;"

	# DEBUG: Write-Host "Composed connection string: $composedConnectionString"

	$webApp = Get-AzureRmWebAppSlot -ResourceGroupName $ResourceGroupName -Name $WebAppName -Slot $SlotName
	
	$connStringsList = $webApp.SiteConfig.ConnectionStrings	
	$hashItems = New-Object System.Collections.HashTable

	ForEach ($keyValuePair in $connStringsList) {
		$setting =  @{Type=$keyValuePair.Type.ToString();Value=$keyValuePair.ConnectionString.ToString()}
		$hashItems[$keyValuePair.Name] = $setting
	}

	$hashItems[$ConnectionStringName] = @{Type="SQLAzure";Value=$composedConnectionString}
	
	Write-Host "ConnectionStrings list:"
	$hashItems | Format-Table -AutoSize

	Set-AzureRmWebAppSlot -ConnectionStrings $hashItems -Name $WebAppName -Slot $SlotName -ResourceGroupName $ResourceGroupName
	#Set-AzureRmWebAppSlotConfigName -ResourceGroupName $ResourceGroupName -Name $WebAppName -AppSettingNames @($settingName)
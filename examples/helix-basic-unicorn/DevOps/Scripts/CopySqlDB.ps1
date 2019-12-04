param(	[string] $ResourceGroupName = "rgname",	
	[string] $SqlServerName = "sqlservername",
	[string] $SqlDbName = "masterdbname",
	[string] $SqlDbCopyName = "masterdbcopyname"
    )
	
	Write-Host "Copying Production DBs"
	Write-Host "Removing old copies if they exists"

	Remove-AzureRmSqlDatabase -DatabaseName $SqlDbCopyName `
	-ServerName $SqlServerName `
	-ResourceGroupName $ResourceGroupName `
	-Force `
	-ErrorAction SilentlyContinue


	New-AzureRMSqlDatabaseCopy -ResourceGroupName $ResourceGroupName `
	-ServerName $SqlServerName `
	-DatabaseName $SqlDbName `
	-CopyResourceGroupName $ResourceGroupName `
    -CopyServerName $SqlServerName `
	-CopyDatabaseName $SqlDbCopyName
	
	Write-Host "Copying complete"
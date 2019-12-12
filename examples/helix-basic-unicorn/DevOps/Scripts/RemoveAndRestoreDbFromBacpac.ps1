param(	[string] $ResourceGroupName = "resourcegroupname",	
	[string] $SqlServerName = "sqlservername",
	[string] $SqlDbName = "sqldbname",
    [string] $StorageUri = "uri-to-bacpac-blob-in-storageaccount", # example: https://ibudevops1.blob.core.windows.net/databases/92-xm-master.bacpac
    [string] $StorageKey = "storage-account-key", # example $StorageKey = "Fdm7WMvbqKSXBhD+40NzGoeIw6TCeB4Ei02f8Vp5n7UtfAvK3EpZfpveAurDVbwxOXF1W8Nlc7vwuD1P0/8JwQ=="
    [string] $SqlAdminUserName = "adminusername",
    [securestring] $SqlAdminPassword = "adminpassword"
    )
	
	Write-Host "Restoring $SqlDbName DB from BACPAC file"
	Write-Host "Removing old copies if they exists"

$StorageKeyType = "StorageAccessKey"

#$password = ConvertTo-SecureString "Sitecore12345!" -AsPlainText -Force

### Remove existing DB
Write-Host "Removing $SqlDbName.."
Remove-AzSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $SqlServerName -DatabaseName $SqlDbName -Force

### Import database from BACPAC, use the same name
Write-Host "Re-creating $SqlDbName from $StorageUri BACPAC file"
$importRequest = New-AzSqlDatabaseImport -ResourceGroupName $ResourceGroupName `
                                          -ServerName $SqlServerName `
                                          -DatabaseName $SqlDbName `
                                          -StorageKeytype $StorageKeyType `
                                          -StorageKey $StorageKey `
                                          -StorageUri $StorageUri `
                                          -AdministratorLogin $SqlAdminUserName `
                                          -AdministratorLoginPassword $SqlAdminPassword `
                                          -Edition Standard  `
                                          -ServiceObjectiveName S0 `
                                          -DatabaseMaxSizeBytes "21474836480"

While ((Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink).Status -eq "InProgress")
{
    Start-Sleep -Seconds 10   
}


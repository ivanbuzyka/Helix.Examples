param(	[string] $ResourceGroupName = "resourcegroupname",	
	[string] $SqlServerName = "sqlservername",
	[string] $SqlDbName = "sqldbname",
    [string] $StorageUri = "uri-to-bacpac-blob-in-storageaccount", # example: https://ibudevops1.blob.core.windows.net/databases/92-xm-master.bacpac
    [string] $StorageKey = "storage-account-key", # example $StorageKey = "Fdm7WMvbqKSXBhD+40NzGoeIw6TCeB4Ei02f8Vp5n7UtfAvK3EpZfpveAurDVbwxOXF1W8Nlc7vwuD1P0/8JwQ=="
    [string] $SqlAdminUserName = "adminusername",
    [securestring] $SqlAdminPassword = "adminpassword"
    )
	
	Write-Host "Exporting $SqlDbName to BACPAC file"	

$StorageKeyType = "StorageAccessKey"

$exportRequest = New-AzureRmSqlDatabaseExport -ResourceGroupName $ResourceGroupName `
                            -ServerName $SqlServerName `
                            -DatabaseName $SqlDbName `
                            -StorageKeyType $StorageKeyType `
                            -StorageKey $StorageKey `
                            -StorageUri $StorageUri `
                            -AdministratorLogin $SqlAdminUserName `
                            -AdministratorLoginPassword $SqlAdminPassword


$exportStatus = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink
[Console]::Write("Exporting")
while ($exportStatus.Status -eq "InProgress")
{
    Start-Sleep -s 10
    $exportStatus = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink
    [Console]::Write(".")
}
[Console]::WriteLine("")
$exportStatus
param(	[string] $ResourceGroupName = "rgname",	
	[string] $WebAppName = "webappname",
	[string] $StorageAccountSasUrl = "https://ibudevops1.blob.core.windows.net/webapps?st=2019-12-03T10%3A23%3A00Z&se=2020-12-05T10%3A23%3A00Z&sp=racwdl&sv=2018-03-28&sr=c&sig=pgfGlLQRvN0sJtEnQbcAbSKdKEQLOLZ9nSzmn0%2BzObc%3D",
	[string] $BackupName = "backupname"
    )
	
	Write-Host "Restoring $WebAppName from $StorageAccountSasUrl..."
	Restore-AzWebAppBackup -ResourceGroupName $ResourceGroupName -Name $WebAppName -StorageAccountUrl $StorageAccountSasUrl -BlobName $BackupName -Overwrite
	
	Write-Host "Backup restoring scheduled..."
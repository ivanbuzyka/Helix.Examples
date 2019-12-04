param(	[string] $ResourceGroupName = "rgname",	
	[string] $WebAppName = "webappname",
	[string] $StorageAccountSasUrl = "https://ibudevops1.blob.core.windows.net/webapps?st=2019-12-03T10%3A23%3A00Z&se=2020-12-05T10%3A23%3A00Z&sp=racwdl&sv=2018-03-28&sr=c&sig=pgfGlLQRvN0sJtEnQbcAbSKdKEQLOLZ9nSzmn0%2BzObc%3D",
	[string] $BackupName = "backupname"
    )
	
	Write-Host "Creating backup of the $WebAppName to $StorageAccountSasUrl"
	New-AzureRmWebAppBackup -ResourceGroupName $ResourceGroupName -Name $WebAppName -StorageAccountUrl $StorageAccountSasUrl -BackupName $BackupName
	
	Write-Host "Backup scheduled..."
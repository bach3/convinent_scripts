function global:Install-App-Msi([string] $uri) {
	if ([string]::IsNullOrEmpty($uri)) {
		Write-Error -Message "Invalid Uri" -ErrorAction Stop
		return 1603
	}

	if (-Not (Get-Command("msiexec.exe"))) {
		Write-Error -Message "msiexec.exe is not installed." -ErrorAction Stop
		return 1603
	}

	[string] $filePath = Join-Path $Env:Temp ([Guid]::NewGuid().ToString() + ".msi")
	Invoke-WebRequest -Uri $uri -OutFile $filePath -UseBasicParsing
	if ((-not (Test-Path $filePath)) -or ((Get-Item $filePath).Length -eq 0)) {
		return 1603
	}
	[System.Diagnostics.Process] $process = Start-Process `
		-FilePath "msiexec.exe" `
		-ArgumentList "/i `"$filePath`" /passive /norestart" `
		-NoNewWindow `
		-PassThru `
		-Wait
	Remove-Item $filePath

	return $process.ExitCode
}

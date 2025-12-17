function File-BackUp {

    param (
        [string]$Source = (Join-Path $env:USERPROFILE "Desktop\Audit Logs"),
        [string]$Backup = (Join-Path $env:USERPROFILE "Desktop\Logs_Backup")
    )

    if (-not (Test-Path -Path $Source)) {
        Write-Error "Source directory does not exist: $Source"
        return
    }

    if (-not (Test-Path -Path $Backup)) {
        New-Item -Path $Backup -ItemType Directory | Out-Null
    }

    $files = Get-ChildItem -Path $Source -File

    if ($files.Count -eq 0) {
        Write-Warning "No files found in source directory"
        return
    }

    try {
        $files | Copy-Item -Destination $Backup -Force -ErrorAction Stop
        Write-Output "Backup completed successfully"
    }
    catch {
        Write-Error "Backup failed: $_"
    }
}

 

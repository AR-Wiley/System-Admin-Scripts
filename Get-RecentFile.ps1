function Get-RecentFile {

    param (
        [string]$directoryPath = "C:\",
        [string]$fileExtension = "*.txt"
    )

    if(-not(Test-Path -Path $directoryPath)){
        Write-Host "Directory Path does not exist"
        return
    }

    $fileErrorLog = Join-Path $env:TEMP "file_error_log.txt"

    if(-not(Test-Path -Path $fileErrorLog)){
        try{
            New-Item -Path $fileErrorLog -ItemType File
        } catch {
            Write-Host "An error occurred: $($_.Exception.Message)"
        }       
    }

    $newestFile = Get-ChildItem -Path $directoryPath -Filter $fileExtension -Recurse -ErrorAction SilentlyContinue 2> $fileErrorLog
    $sortedFiles = $newestFile | Sort-Object LastWriteTime -Descending

    $startDate = (Get-Date).AddDays(-1)
    $endDate = Get-Date

    try {
        $lastFile = $newestFile | Select-Object -First 1
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }

    try{
        $LastDay = $newestFile | Where-Object { $_.LastWriteTime -gt $startDate -and $_.LastWriteTime -lt $endDate }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }

    $lastFile | Select-Object LastWriteTime, Length, Name, FullName
    $LastDay  | Select-Object LastWriteTime, Length, Name, FullName

}

 
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as Administrator."
    return 
} else {
    Write-Host "Running as Administrator."
}


$target_folders = @("C:\ABCLOG", "C:\ABCLOG2", "C:\XYZLOG", "C:\XYZLOG2")


function Purge-EmptyDirectories {

    $target_folders | ForEach-Object {

                
        if (-not(Test-Path $_)) {
             Write-Host "$_ does not exist"
             continue
        }
        
        Get-ChildItem -Path $_ -Recurse | Where-Object { (Get-ChildItem $_.FullName).Count -eq 0 } | Remove-Item -Force -ErrorAction SilentlyContinue

    }    
  
}

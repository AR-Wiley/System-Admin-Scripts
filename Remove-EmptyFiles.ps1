function Remove-EmptyFiles {

    $logPath = Join-Path $env:USERPROFILE "Desktop\Logs"
    $csvDir  = Join-Path $env:USERPROFILE "Desktop\CsvData"
    $csvFile = Join-Path $csvDir "FileReport.csv"

    if (!(Test-Path $csvDir)) {
        New-Item -Path $csvDir -ItemType Directory | Out-Null
    }

    $files = Get-ChildItem -Path $logPath -File

    $emptyFiles    = $files | Where-Object Length -eq 0
    $nonEmptyFiles = $files | Where-Object Length -gt 0

    # Export report
    $files |
        Select-Object Name, Length, LastWriteTime |
        Export-Csv -Path $csvFile -NoTypeInformation

    $htmlEmpty    = $emptyFiles    | Select Name | ConvertTo-Html -Fragment
    $htmlNonEmpty = $nonEmptyFiles | Select Name, Length | ConvertTo-Html -Fragment

    # Remove empty files
    $emptyFiles | Remove-Item -Force

    $body = @"
<html>
<body>
<p><strong>Empty files removed:</strong></p>
$htmlEmpty
<p><strong>Files remaining:</strong></p>
$htmlNonEmpty
</body>
</html>
"@

    $mailParams = @{
        To          = "recipient@example.com"
        From        = "sender@example.com"
        Subject     = "Report on File Data"
        Body        = $body
        BodyAsHtml  = $true
        SmtpServer  = "smtp.example.com"
    }

    Send-MailMessage @mailParams
}
# Wireshark needed for packet capture?



# Needs message analyzer installed!
# Get it here: https://www.microsoft.com/en-us/download/confirmation.aspx?id=44226

Import-Module 'C:\Program Files\Microsoft Message Analyzer\PowerShell\PEF\PEF.psd1'

$s = New-PefTraceSession -Path "C:usersYongdocumentsOutFile.Cap" -SaveOnStop

$s | Add-PefMessageProvider -Provider "C:usersYongdocumentsInput.etl"

$s | Start-PefTraceSession
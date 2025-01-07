# Script to create registry keys and values

# Define the first registry key and value
$keyPath1 = "HKCU:\Software\Microsoft\Office\16.0\Common"
$valueName1 = "PrivacyDialogsDisabled"
$valueData1 = 1

# Define the second registry key and value
$keyPath2 = "HKCU:\Software\Policies\Microsoft\Office\16.0\Common"
$valueName2 = "PrivacyDialogsDisabled"
$valueData2 = 1

# Function to create the registry key and set the value
function Set-RegistryValue {
    param (
        [string]$KeyPath,
        [string]$ValueName,
        [int]$ValueData
    )
    # Check if the key exists, if not create it
    if (-not (Test-Path $KeyPath)) {
        New-Item -Path $KeyPath -Force | Out-Null
    }
    # Set the registry value
    Set-ItemProperty -Path $KeyPath -Name $ValueName -Value $ValueData
    Write-Host "Set $ValueName to $ValueData in $KeyPath"
}

# Apply the registry changes
Set-RegistryValue -KeyPath $keyPath1 -ValueName $valueName1 -ValueData $valueData1
Set-RegistryValue -KeyPath $keyPath2 -ValueName $valueName2 -ValueData $valueData2

Write-Host "Registry keys and values have been successfully created."

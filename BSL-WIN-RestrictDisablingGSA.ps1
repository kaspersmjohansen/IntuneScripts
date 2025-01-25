# This script checks and ensures the "RestrictNonPrivilegedUsers" registry value 
# exists and is set to 1 under "HKLM:\Software\Microsoft\Global Secure Access Client".
# 
# Purpose:
# This ensures that non-privileged users cannot disable the Global Secure Access (GSA) client, 
# maintaining security by preventing unauthorized changes to its configuration.
#
# Functionality:
# 1. If the registry key does not exist, it creates the key and sets the value to 1.
# 2. If the registry key exists:
#    - It checks if the "RestrictNonPrivilegedUsers" value is set to 1.
#    - If the value is not set to 1, it updates the value to 1.
# 3. Logs all actions and exits with:
#    - Exit code 0: No remediation needed, the value was already set to 1.
#    - Exit code 1: Remediation performed (value created or updated).
# 4. Catches and logs any errors encountered during execution.
#
# Author: Mike van den Brandt
# Date: 25-01-2025

# Get the value of the "RestrictNonPrivilegedUsers" registry key for GSA Client
$RegistryPath = "HKLM:\Software\Microsoft\Global Secure Access Client"
$ValueName = "RestrictNonPrivilegedUsers"

try {
    # Check if the registry key exists
    if (Test-Path $RegistryPath) {
        $Value = Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction Stop
        if ($Value.$ValueName -eq 1) {
            Write-Host "The value of the $ValueName registry key is set to 1. Exiting script."
            Exit 0
        } else {
            Write-Host "The value of the $ValueName registry key is not set to 1. Running Remediation."
            Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value 1
            Write-Host "The value of the $ValueName registry key has been set to 1."
            Exit 1
        }
    } else {
        Write-Host "The registry path does not exist. Creating path and setting value."
        New-Item -Path $RegistryPath -Force | Out-Null
        New-ItemProperty -Path $RegistryPath -Name $ValueName -Value 1 -PropertyType DWORD -Force | Out-Null
        Write-Host "The value of the $ValueName registry key has been created and set to 1."
        Exit 1
    }
} catch {
    Write-Error "An error occurred: $_"
    Exit 1
}

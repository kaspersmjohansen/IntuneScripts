# Pad naar de registerlocatie
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"

# Naam van de sleutel en de waarde
$RegName = "DisabledComponents"
$RegType = "DWORD"
$RegValue = 0x20

# Controleer of de registerpad bestaat
if (-not (Test-Path $RegPath)) {
    Write-Error "Registerpad $RegPath bestaat niet."
    exit 1
}

# Probeer de sleutel te schrijven
try {
    Set-ItemProperty -Path $RegPath -Name $RegName -Value $RegValue -Type $RegType
    Write-Host "Registerwaarde succesvol ingesteld: $RegName = $RegValue"
} catch {
    Write-Error "Fout bij het instellen van de registerwaarde: $_"
}

while ($true) {
    $establishedConnections = Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' }
    $establishedCount = $establishedConnections | Measure-Object | Select-Object -ExpandProperty Count
    Write-Output "Number of established TCP connections: $establishedCount"
    Start-Sleep -Seconds 5
}

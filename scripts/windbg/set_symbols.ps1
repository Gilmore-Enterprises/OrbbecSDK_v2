# Sets up _NT_SYMBOL_PATH for crash analysis of OrbbecSDK
$localSymbols = @(
    # TODO: adjust these paths to your actual build output
    "D:\Projects\OrbbecSDK_v2\build\symbols",
    "D:\Projects\OrbbecSDK_v2\out\x64\Release",
    "D:\Projects\OrbbecSDK_v2\out\x64\Debug"
) | Where-Object { Test-Path $_ }

$msSymbols = "SRV*c:\symbols*https://msdl.microsoft.com/download/symbols"

# Prefer local symbols first, then MS symbols
$parts = @()
foreach ($p in $localSymbols) { $parts += "SRV*$p" }
$parts += $msSymbols

$symbolPath = [string]::Join(";", $parts)
[Environment]::SetEnvironmentVariable("_NT_SYMBOL_PATH", $symbolPath, "User")

Write-Host "_NT_SYMBOL_PATH set to:" -ForegroundColor Cyan
Write-Host $symbolPath

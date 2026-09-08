[CmdletBinding()]
param(
    [string]$From = 'mc1.21.1-6.0.8',
    [string]$To = 'mc1.21.1-6.0.10',
    [string]$OutputPath = ''
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
if (-not $OutputPath) {
    $OutputPath = Join-Path $repoRoot 'porting/upstream-delta.csv'
}

function Invoke-GitRead {
    param([string[]]$GitArguments)
    $result = & git -C $repoRoot @GitArguments
    if ($LASTEXITCODE -ne 0) { throw "git failed: $($GitArguments -join ' ')" }
    return $result
}

$fromCommit = Invoke-GitRead @('rev-parse', '--verify', "$From^{commit}")
$toCommit = Invoke-GitRead @('rev-parse', '--verify', "$To^{commit}")
$commits = Invoke-GitRead @('log', '--reverse', '--no-merges', '--format=%H%x09%s', "$fromCommit..$toCommit")
$rows = foreach ($line in $commits) {
    $parts = $line -split "`t", 2
    $files = @(Invoke-GitRead @('diff-tree', '--no-commit-id', '--name-only', '-r', $parts[0]))
    [pscustomobject]@{
        commit = $parts[0]
        subject = $parts[1]
        status = 'needs-review'
        files = $files -join ';'
    }
}
New-Item -ItemType Directory -Force (Split-Path -Parent $OutputPath) | Out-Null
$rows | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding utf8
Write-Output "Exported $($rows.Count) non-merge commits from $fromCommit to $toCommit."
Write-Output 'This inventory is not a proof of missing changes: check Fabric backports and merge resolutions separately.'

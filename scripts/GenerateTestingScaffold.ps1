#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -Modules PSScriptAnalyzer, Microsoft.PowerShell.Management, Microsoft.PowerShell.Utility

using namespace System;
using namespace System.IO;
using namespace System.Collections.Generic;
using namespace System.Management.Automation;
using namespace System.Management.Automation.Language;


Set-StrictMode -Version 'Latest';

Import-Module 'PSScriptAnalyzer';
Import-Module 'Microsoft.PowerShell.Utility';
Import-Module 'Microsoft.PowerShell.Management';

[string] $script:rootRepoPath = Split-Path -Path $PSScriptRoot -Parent;
[string] $script:tests = "$($script:rootRepoPath)/tests";
[string] $script:source = "$($script:rootRepoPath)/src";


[List[string]] $cmds        = @();
[List[string]] $definitions = @();

[FileInfo[]] $scriptFiles = Get-ChildItem -Path $script:source -Filter '*.ps1' -Recurse -File;

foreach ($file in $scriptFiles) {
    [ScriptBlockAst] $content = [Parser]::ParseFile($file.FullName, [ref] $null, [ref] $null);
    [CommandAst[]] $commands = $content.FindAll({ $args[0] -is [CommandAst] }, $true);
    foreach ($command in $commands) {
        [string] $cmd = $command.GetCommandName();
        [void] $cmds.Add($cmd);
    }
}

$cmds | Sort-Object -Unique | ForEach-Object {
    [void] $definitions.Add("function $($_.Trim()) { }");
}

Invoke-Formatter -ScriptDefinition @"
#!/usr/bin/env pwsh
#Requires -Version 5

using namespace System;
using namespace System.Diagnostics.CodeAnalysis;

[SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Target = '*', Scope = 'function')]
param();

Set-StrictMode -Version 'Latest';

$($definitions | ForEach-Object { "$($_)$([Environment]::NewLine)" } | Sort-Object -Unique)

Export-ModuleMember -Function '*';
"@ | Out-File -FilePath "$($script:tests)/mocks/TestingStubs.psm1" -Force;
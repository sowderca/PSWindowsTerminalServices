#!/usr/bin/env pwsh
#Requires -Version 5

using namespace System;
using namespace System.IO;

Add-Type -Path (Resolve-Path -Path ([Path]::Combine($PSScriptRoot, 'win32', 'wtsapi.cs')));

[FileInfo[]] $commands = @(Get-ChildItem -Path ([Path]::Combine($PSScriptRoot, 'commands', '*.ps1')) -Recurse);

foreach ($import in @($commands)) {
    try {
        . "$($import.FullName)";
    } catch {
        Write-Error -Message "Unable to dot source $($import.FullName)" -Exception $PSItem;
    }
}
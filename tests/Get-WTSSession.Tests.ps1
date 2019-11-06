#!/usr/bin/env pwsh
#Requires -Version 5
#Requires -Modules Pester, Microsoft.PowerShell.Management

using namespace System;

Set-StrictMode -Version 'Latest';

Import-Module 'Pester';
Import-Module 'Microsoft.PowerShell.Management';

[string] $script:rootRepoPath = Split-Path -Path $PSScriptRoot -Parent;
[string] $script:tests = "$($script:rootRepoPath)/tests";
[string] $script:source = "$($script:rootRepoPath)/src";

Describe 'Get-WTSSession.Tests.ps1' {
    BeforeAll {
        Remove-Module -Name 'PSWindowsTerminalServices' -Force -ErrorAction 0;
        Remove-Module -Name 'TestingStubs' -Force -ErrorAction 0;

        Import-Module "$($script:tests)/mocks/TestingStubs.psm1" -DisableNameChecking -Global -Force;
        Import-Module "$($script:source)/PSWindowsTerminalServices.psd1" -DisableNameChecking -Global -Force;
    }
    InModuleScope 'PSWindowsTerminalServices' {
        Context 'Unit Tests' {
            Describe 'Get-WTSSession' { }
        }
    }
    AfterAll {
        Remove-Module -Name 'PSWindowsTerminalServices' -Force -ErrorAction 0;
        Remove-Module -Name 'TestingStubs' -Force -ErrorAction 0;
    }
}

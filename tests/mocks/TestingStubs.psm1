#!/usr/bin/env pwsh
#Requires -Version 5

using namespace System;
using namespace System.Diagnostics.CodeAnalysis;

[SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Target = '*', Scope = 'function')]
param();

Set-StrictMode -Version 'Latest';

function Add-Member { }
function New-Object { }
function New-TimeSpan { }
function Set-StrictMode { }
function Write-Error { }


Export-ModuleMember -Function '*';

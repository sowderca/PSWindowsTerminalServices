#Requires -Version 5

using namespace System;
using namespace System.Collections.Generic;
using namespace System.Runtime.InteropServices;

Set-StrictMode -Version 'Latest';

function Stop-WTSSession {
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param(
        [string] $ComputerName = [Environment]::MachineName,
        [int] $SessionId,
        [switch] $Wait
    );
    begin {
        [List[PSCustomObject]] $results = @();
    } process {
        [IntPtr] $handle  = [wtsapi]::WTSOpenServer($ComputerName);
        [bool] $loggedOff = [wtsapi]::WTSDisconnectSession($handle, $SessionId, $WaitForResponse.ToBool());
        [PSCustomObject] $result = [PSCustomObject] @{ LoggedOff  = $loggedOff; SessionId = $SessionId; };
        [void] $results.Add($result);
        [void] [wtsapi]::WTSCloseServer($handle);
        $handle = [IntPtr]::Zero;
    } end {
        return $results;
    }
}
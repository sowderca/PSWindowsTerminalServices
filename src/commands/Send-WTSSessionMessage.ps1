#Requires -Version 5

using namespace System;
using namespace System.Collections.Generic;
using namespace System.Runtime.InteropServices;

Set-StrictMode -Version 'Latest';

function Send-WTSSessionMessage {
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param(
        [string] $ComputerName = [Environment]::MachineName,
        [int] $SessionId,
        [string] $Title,
        [string] $Message,
        [int] $Timeout = 0,
        [switch] $WaitForResponse
    );
    begin {
        [List[PSCustomObject]] $results = @();
    } process {
        $response = $null;
        [IntPtr] $handle = [wtsapi]::WTSOpenServer($ComputerName);
        [void] [wtsapi]::WTSSendMessage($handle, $SessionId, $Title, $Title.Length, $Message, $Message.Length, 0, $Timeout, [ref] $response, $WaitForResponse.ToBool());
        [PSCustomObject] $result = [PSCustomObject] @{ Response  = $response; SessionId = $SessionId; };
        [void] $results.Add($result);
        [void] [wtsapi]::WTSCloseServer($handle);
        $handle = [IntPtr]::Zero;
    } end {
        return $results;
    }
}
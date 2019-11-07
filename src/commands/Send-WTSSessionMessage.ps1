#Requires -Version 5

using namespace System;
using namespace System.Collections.Generic;
using namespace System.Runtime.InteropServices;

Set-StrictMode -Version 'Latest';

function Send-WTSSessionMessage {
    [CmdletBinding()]
    [OutputType([PSCustomObject[]])]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Computer to send the message to')]
        [string] $ComputerName = [Environment]::MachineName,

        [Parameter(Mandatory = $true, HelpMessage = 'Session ID of the user to message')]
        [ValidateRange(0, [int]::MaxValue)]
        [int] $SessionId,

        [Parameter(Mandatory = $true, HelpMessage = 'Title of the message dialog box')]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        [Parameter(Mandatory = $true, HelpMessage = 'The message to send to the user')]
        [ValidateNotNullOrEmpty()]
        [string] $Message,

        [Parameter(Mandatory = $false, HelpMessage = 'Timeout threshold to wait on the user to respond')]
        [int] $Timeout = 0,

        [Parameter(Mandatory = $false, HelpMessage = 'Display the message until the user responds')]
        [switch] $WaitForResponse
    );
    begin {
        [List[PSCustomObject]] $results = @();
    } process {
        $response = $null;
        [IntPtr] $handle = [wtsapi]::WTSOpenServer($ComputerName);
        [void] [wtsapi]::WTSSendMessage($handle, $SessionId, $Title, $Title.Length, $Message, $Message.Length, 0, $Timeout, [ref] $response, $WaitForResponse.ToBool());
        [PSCustomObject] $result = [PSCustomObject] @{
            Response  = $response;
            SessionId = $SessionId;
        };
        [void] $results.Add($result);
        [void] [wtsapi]::WTSCloseServer($handle);
        $handle = [IntPtr]::Zero;
    } end {
        return $results.ToArray();
    }
}

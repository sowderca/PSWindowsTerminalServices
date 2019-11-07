#Requires -Version 5

using namespace System;
using namespace System.Collections.Generic;
using namespace System.Runtime.InteropServices;

Set-StrictMode -Version 'Latest';

function Get-WTSSession {
    [CmdletBinding()]
    [OutputType([ValueType[]])]
    param(
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Computers to fetch the sessions from')]
        [Alias('ComputerNames')]
        [string[]] $ComputerName = [Environment]::MachineName
    );
    begin {
        [long] $count              = 0;
        [IntPtr] $sessions         = 0;
        [IntPtr] $sessionMetadata  = 0;
        [long] $bytes              = 0;
        $wtsInfoEx                 = New-Object -TypeName 'WTSINFOEX';
        $wtsSessionInfo            = New-Object -TypeName 'WTS_SESSION_INFO';
        [int] $size                = [Marshal]::SizeOf([type] $wtsSessionInfo.GetType());
        [List[ValueType]] $results = @();
    } process {
        try {
            [IntPtr] $handle = [wtsapi]::WTSOpenServer($ComputerName);
            # If the function fails, it returns and invalid handle.
            [long] $val = [wtsapi]::WTSEnumerateSessions($handle, 0, 1, [ref] $sessions , [ref] $count);
            $err = [ComponentModel.Win32Exception] [Marshal]::GetLastWin32Error();
            if ($val -ne 0) {
                for ([int] $index = 0; $index -lt $count; $index++) {
                    $element = [Marshal]::PtrToStructure([long] $sessions + ($size * $index), [type] $wtsSessionInfo.GetType());
                    # session 0 is non-interactive (zero isolation)
                    if ($element -and $element.SessionID -ne 0 ) {
                        $val = [wtsapi]::WTSQuerySessionInformationW($handle, $element.SessionID, [WTS_INFO_CLASS]::WTSSessionInfoEx, [ref] $sessionMetadata, [ref] $bytes);
                        $err = [ComponentModel.Win32Exception] [Marshal]::GetLastWin32Error();
                        if ($val -and $sessionMetadata) {
                            $session = [Marshal]::PtrToStructure($sessionMetadata, [type] $wtsInfoEx.GetType());
                            if ($session -and $session.Data -and $session.Data.WTSInfoExLevel1.SessionState -ne [WTS_CONNECTSTATE_CLASS]::WTSListen -and $session.Data.WTSInfoExLevel1.SessionState -ne [WTS_CONNECTSTATE_CLASS]::WTSConnected) {
                                $wtsinfo = $session.Data.WTSInfoExLevel1;
                                [timespan] $idleTime = New-TimeSpan -End ([datetime]::FromFileTimeUtc($wtsinfo.CurrentTime)) -Start ([datetime]::FromFileTimeUtc($wtsinfo.LastInputTime))
                                Add-Member -InputObject $wtsinfo -Force -NotePropertyMembers @{
                                    'IdleTimeInSeconds' = $idleTime.TotalSeconds
                                    'IdleTimeInMinutes' = $idleTime.TotalMinutes
                                    'Computer'          = "$($ComputerName)"
                                    'LogonTime'         = [datetime]::FromFileTime($wtsinfo.LogonTime)
                                    'DisconnectTime'    = [datetime]::FromFileTime($wtsinfo.DisconnectTime)
                                    'LastInputTime'     = [datetime]::FromFileTime($wtsinfo.LastInputTime)
                                    'ConnectTime'       = [datetime]::FromFileTime($wtsinfo.ConnectTime)
                                    'CurrentTime'       = [datetime]::FromFileTime($wtsinfo.CurrentTime)
                                };
                                [void] $results.Add($wtsinfo);
                            }
                            [void] [wtsapi]::WTSFreeMemory($sessionMetadata);
                            $sessionMetadata = [IntPtr]::Zero;
                        } else {
                            throw "$($ComputerName): $err";
                        }
                    }
                }
            } else {
                throw "$($ComputerName): $err";
            }
            [void] [wtsapi]::WTSCloseServer($handle);
            $handle = [IntPtr]::Zero;
        } catch {
            Write-Error $_;
        } finally {
            if ($sessions -ne [IntPtr]::Zero) {
                [void] [wtsapi]::WTSFreeMemory($sessions);
                $sessions = [IntPtr]::Zero;
            }
        }
    } end {
        return $results.ToArray();
    }
}

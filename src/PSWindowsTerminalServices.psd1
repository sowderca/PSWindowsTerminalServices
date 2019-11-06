@{
    RootModule            = 'PSWindowsTerminalServices.psm1'
    ModuleVersion         = '1.0.0'
    GUID                  = 'b8bf3437-9ac7-48e3-8de9-2e15f0e25cc4'
    Author                = 'Cameron Sowder'
    Copyright             = '(c) Cameron Sowder. All Rights Reserved.'
    Description           = 'Powershell module for interacting with the WTS API via PInvoke'
    PowerShellVersion     = '6.0'
    ProcessorArchitecture = 'None'
    RequiredModules       = @()
    RequiredAssemblies    = @()
    ScriptsToProcess      = @()
    TypesToProcess        = @()
    FormatsToProcess      = @()
    NestedModules         = @()
    FunctionsToExport     = @(
        'Get-WTSSession',
        'Send-WTSSessionMessage',
        'Stop-WTSSession'
    )
    CmdletsToExport       = @()
    VariablesToExport     = @()
    AliasesToExport       = @()
    ModuleList            = @()
    FileList              = @(
        './PSWindowsTerminalServices.psm1',
        './commands/Get-WTSSession.ps1',
        './commands/Send-WTSSessionMessage.ps1',
        './commands/Stop-WTSSession.ps1',
        './win32/wtsapi.cs'
    )
    PrivateData           = @{
        PSData                     = @{
            Tags         = @()
            LicenseUri   = 'MIT'
            ProjectUri   = 'https://github.com/sowderca/PSWindowsTerminalServices'
            ReleaseNotes = ''
        }
    }
}
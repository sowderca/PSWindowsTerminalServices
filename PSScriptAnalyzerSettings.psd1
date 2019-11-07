@{
    IncludeRules        = @(
        '*'
    )
    IncludeDefaultRules = $true
    Severity            = @('Error', 'Warning', 'Information')
    Rules               = @{
        PSAlignAssignmentStatement                   = @{
            Enable         = $true
            CheckHashtable = $true
        }
        AvoidAssignmentToAutomaticVariable           = @{
            Enable = $true
        }
        AvoidDefaultValueForMandatoryParameter       = @{
            Enable = $true
        }
        AvoidDefaultValueSwitchParameter             = @{
            Enable = $true
        }
        AvoidGlobalAliases                           = @{
            Enable = $true
        }
        AvoidInvokingEmptyMembers                    = @{
            Enable = $true
        }
        AvoidNullOrEmptyHelpMessageAttribute         = @{
            Enable = $true
        }
        AvoidShouldContinueWithoutForce              = @{
            Enable = $true
        }
        AvoidTrailingWhitespace                      = @{
            Enable = $true
        }
        AvoidUsingCmdletAliases                      = @{
            Enable = $true
        }
        AvoidUsingComputerNameHardcoded              = @{
            Enable = $true
        }
        AvoidUsingConvertToSecureStringWithPlainText = @{
            Enable = $true
        }
        AvoidUsingDeprecatedManifestFields           = @{
            Enable = $true
        }
        AvoidUsingEmptyCatchBlock                    = @{
            Enable = $true
        }
        AvoidUsingInvokeExpression                   = @{
            Enable = $true
        }
        AvoidUsingPlainTextForPassword               = @{
            Enable = $true
        }
        AvoidUsingPositionalParameters               = @{
            Enable = $true
        }
        AvoidUsingUsernameAndPasswordParams          = @{
            Enable = $true
        }
        AvoidUsingWMICmdlet                          = @{
            Enable = $true
        }
        AvoidUsingWriteHost                          = @{
            Enable = $true
        }
        MisleadingBacktick                           = @{
            Enable = $true
        }
        MissingModuleManifestField                   = @{
            Enable = $true
        }
        PSPlaceCloseBrace                            = @{
            Enable             = $true
            NoEmptyLineBefore  = $true
            IgnoreOneLineBlock = $true
            NewLineAfter       = $false
        }
        PSPlaceOpenBrace                             = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $false
            IgnoreOneLineBlock = $true
        }
        PossibleIncorrectComparisonWithNull          = @{
            Enable = $true
        }
        PossibleIncorrectUsageOfAssignmentOperator   = @{
            Enable = $true
        }
        PossibleIncorrectUsageOfRedirectionOperator  = @{
            Enable = $true
        }
        PSProvideCommentHelp                         = @{
            Enable                  = $true
            ExportedOnly            = $false
            BlockComment            = $true
            VSCodeSnippetCorrection = $true
            Placement               = "before"
        }
        ReservedCmdletChar                           = @{
            Enable = $true
        }
        ReservedParams                               = @{
            Enable = $true
        }
        ShouldProcess                                = @{
            Enable = $true
        }
        UseApprovedVerbs                             = @{
            Enable = $true
        }
        UseBOMForUnicodeEncodedFile                  = @{
            Enable = $false
        }
        UseCmdletCorrectly                           = @{
            Enable = $true
        }
        UseCompatibleCommmands                       = @{
            Enable           = $true
            TargetedVersions = @(
                "7.0",
                "6.0",
                "5.1"
            )
        }
        PSUseConsistentIndentation                   = @{
            Enable              = $true
            IndentationSize     = 4
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
            Kind                = 'space'
        }
        PSUseConsistentWhitespace                    = @{
            Enable          = $true
            CheckInnerBrace = $true
            CheckOpenBrace  = $true
            CheckOpenParen  = $true
            CheckOperator   = $false
            CheckPipe       = $true
            CheckSeparator  = $true
        }
        UseCorrectCasing                             = @{
            Enable = $true
        }
        UseDeclaredVarsMoreThanAssignments           = @{
            Enable = $true
        }
        UseLiteralInitializerForHashtable            = @{
            Enable = $true
        }
        UseOutputTypeCorrectly                       = @{
            Enable = $true
        }
        UsePSCredentialType                          = @{
            Enable = $true
        }
        UseShouldProcessForStateChangingFunctions    = @{
            Enable = $true
        }
        UseSupportsShouldProcess                     = @{
            Enable = $true
        }
        UseToExportFieldsInManifest                  = @{
            Enable = $true
        }
        UseUTF8EncodingForHelpFile                   = @{
            Enable = $true
        }
    }
}

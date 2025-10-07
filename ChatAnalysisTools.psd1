@{
    RootModule = 'ChatAnalysisTools.psm1'
    ModuleVersion = '1.0.0'
    GUID = '12345678-1234-1234-1234-123456789012'
    Author = 'emblem.iO Development Team'
    CompanyName = 'emblem.iO'
    Copyright = '(c) 2025 emblem.iO. All rights reserved.'
    Description = 'Professional PowerShell module for VS Code chat history analysis and developer workflow correlation'
    PowerShellVersion = '5.1'
    
    # Functions to export from this module
    FunctionsToExport = @(
        'Invoke-ChatHistoryAnalysis',
        'Export-AnalysisReport', 
        'Get-WorkflowInsights',
        'Find-VSCodeChatHistory',
        'Test-ChatAnalysisEnvironment'
    )
    
    # Variables to export from this module
    VariablesToExport = @()
    
    # Aliases to export from this module
    AliasesToExport = @(
        'Analyze-Chats',
        'Get-ChatInsights'
    )
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module for discoverability
            Tags = @(
                'ChatAnalysis', 'VSCode', 'Copilot', 'AI', 'Development', 
                'Workflow', 'Git', 'Productivity', 'Analysis', 'Correlation'
            )
            
            # A URL to the license for this module
            LicenseUri = 'https://github.com/thisis-romar/chat-analysis-tools/blob/main/LICENSE'
            
            # A URL to the main website for this project
            ProjectUri = 'https://github.com/thisis-romar/chat-analysis-tools'
            
            # A URL to an icon representing this module
            # IconUri = ''
            
            # Release notes for this module
            ReleaseNotes = @'
Version 1.0.0
- Initial release of Chat Analysis Tools
- VS Code chat history parsing and analysis
- Git commit correlation functionality  
- Comprehensive workflow insights and reporting
- Multi-project analysis capabilities
- Professional PowerShell module structure
- Cross-platform compatibility (Windows, macOS, Linux)
'@
        }
    }
    
    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'
    
    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @()
    
    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @()
    
    # Script files (.ps1) that are run in the caller's environment prior to importing this module
    ScriptsToProcess = @()
    
    # Type files (.ps1xml) to be loaded when importing this module
    TypesToProcess = @()
    
    # Format files (.ps1xml) to be loaded when importing this module
    FormatsToProcess = @()
    
    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules = @()
    
    # Help Info URI of this module
    HelpInfoURI = 'https://github.com/thisis-romar/chat-analysis-tools/blob/main/docs/'
}
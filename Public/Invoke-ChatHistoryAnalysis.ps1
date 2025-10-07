function Invoke-ChatHistoryAnalysis {
    <#
    .SYNOPSIS
        Analyzes VS Code chat history and correlates with git commits
    
    .DESCRIPTION
        Professional tool for analyzing VS Code Copilot chat conversations and correlating
        them with git commit patterns to provide insights into AI-assisted development workflows.
    
    .PARAMETER ChatHistoryPath
        Optional path to VS Code chat history. If not provided, automatically discovers location.
    
    .PARAMETER OutputPath
        Path for analysis output file. Defaults to 'chat-analysis.json'.
    
    .PARAMETER IncludeGitCommits
        Include git commit correlation in the analysis.
    
    .PARAMETER ShowDetails
        Display detailed analysis information during processing.
    
    .PARAMETER CorrelationWindow
        Time window in minutes for correlating chats with commits (default: 30).
    
    .EXAMPLE
        Invoke-ChatHistoryAnalysis
        Basic chat history analysis with default settings.
    
    .EXAMPLE
        Invoke-ChatHistoryAnalysis -IncludeGitCommits -ShowDetails
        Detailed analysis including git commit correlation.
    
    .EXAMPLE
        Invoke-ChatHistoryAnalysis -ChatHistoryPath "C:\Custom\Path" -OutputPath "analysis.json"
        Analysis with custom input and output paths.
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ChatHistoryPath,
        
        [Parameter(Mandatory = $false)]
        [string]$OutputPath = "chat-analysis.json",
        
        [Parameter(Mandatory = $false)]
        [switch]$IncludeGitCommits,
        
        [Parameter(Mandatory = $false)]
        [switch]$ShowDetails,
        
        [Parameter(Mandatory = $false)]
        [int]$CorrelationWindow = 30
    )
    
    Write-Host "🔍 Chat Analysis Tools - Professional Workflow Analysis" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    
    try {
        # Call the core ChatHistoryParser with provided parameters
        $params = @{
            OutputPath = $OutputPath
        }
        
        if ($ChatHistoryPath) {
            $params.ChatHistoryPath = $ChatHistoryPath
        }
        
        if ($IncludeGitCommits) {
            $params.IncludeGitCommits = $true
        }
        
        if ($ShowDetails) {
            $params.ShowDetails = $true
        }
        
        # Execute the core parsing functionality
        & "$PSScriptRoot\..\Private\ChatHistoryParser.ps1" @params
        
        Write-Host "✅ Analysis completed successfully" -ForegroundColor Green
        Write-Host "📄 Output saved to: $OutputPath" -ForegroundColor Gray
        
        return Get-Content $OutputPath -Raw | ConvertFrom-Json
    }
    catch {
        Write-Error "❌ Chat analysis failed: $($_.Exception.Message)"
        throw
    }
}
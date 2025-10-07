# Quick Chat Analysis - WhatsApp Receipts Project
# Simple wrapper for easy access to chat history parser

# Quick analysis (basic)
function Analyze-Chats {
    .\tools\ChatHistoryParser.ps1 -OutputPath "chat-analysis.json"
}

# Detailed analysis with git commits
function Analyze-ChatsDetailed {
    .\tools\ChatHistoryParser.ps1 -IncludeGitCommits -Verbose -OutputPath "detailed-chat-analysis.json"
}

# Custom analysis with specific path
function Analyze-ChatsCustom {
    param(
        [string]$Path,
        [string]$Output = "custom-chat-analysis.json"
    )
    .\tools\ChatHistoryParser.ps1 -ChatHistoryPath $Path -IncludeGitCommits -OutputPath $Output -Verbose
}

# LLM Commit Attribution Analysis
function Analyze-LLMCommits {
    .\tools\LLMCommitIdentifier.ps1 -OutputPath "llm-attribution.json"
}

# Detailed LLM analysis with verbose output
function Analyze-LLMCommitsDetailed {
    .\tools\LLMCommitIdentifier.ps1 -Since "8 weeks ago" -ShowDetails -OutputPath "detailed-llm-attribution.json"
}

# Set AI author attribution (DANGEROUS - rewrites git history)
function Set-LLMAttribution {
    param([string]$Model = "Claude AI (copilot/claude-sonnet-4)")
    .\tools\LLMCommitIdentifier.ps1 -SetAIAuthor -LLMModel $Model -OutputPath "llm-attribution-updated.json"
}

# Correct git commit attribution using combined analysis
function Correct-GitAttribution {
    .\tools\CommitAttributionCorrector.ps1
}

# Apply attribution corrections (DANGEROUS - rewrites git history)
function Apply-GitAttribution {
    Write-Host "⚠️ WARNING: This will rewrite git history!" -ForegroundColor Red
    Read-Host "Press Enter to continue or Ctrl+C to cancel"
    .\tools\CommitAttributionCorrector.ps1 -DryRun:$false
}

# Display usage help
function Show-ChatAnalysisHelp {
    Write-Host "=== WhatsApp Receipts - Chat Analysis Tools ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Available Commands:" -ForegroundColor Yellow
    Write-Host "  Analyze-Chats           - Quick chat history analysis"
    Write-Host "  Analyze-ChatsDetailed   - Detailed analysis with git commits"
    Write-Host "  Analyze-ChatsCustom     - Custom analysis with specific path"
    Write-Host "  Analyze-LLMCommits      - Identify AI-assisted commits"
    Write-Host "  Analyze-LLMCommitsDetailed - Detailed LLM commit analysis"
    Write-Host "  Set-LLMAttribution      - Set AI author attribution (DANGEROUS!)"
    Write-Host "  Correct-GitAttribution  - Analyze and preview commit corrections"
    Write-Host "  Apply-GitAttribution    - Apply commit attribution corrections (DANGEROUS!)"
    Write-Host "  Show-ChatAnalysisHelp   - Show this help"
    Write-Host ""
    Write-Host "Direct Tool Usage:" -ForegroundColor Yellow
    Write-Host "  .\tools\ChatHistoryParser.ps1 [parameters]"
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Cyan
    Write-Host "  -ChatHistoryPath  - Specific path to search for chat files"
    Write-Host "  -OutputPath       - Where to save analysis results"
    Write-Host "  -IncludeGitCommits - Include git commit analysis"
    Write-Host "  -Verbose          - Show detailed processing information"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor White
    Write-Host "  Analyze-Chats"
    Write-Host "  Analyze-ChatsDetailed"
    Write-Host '  Analyze-ChatsCustom -Path "C:\Users\YourName\AppData\Roaming\Code"'
    Write-Host ""
}

# Show help on import
Show-ChatAnalysisHelp
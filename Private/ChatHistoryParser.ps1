# WhatsApp Receipts Project - Chat History Parser
# This tool parses VS Code Copilot chat history and analyzes git commits
# Created for the WhatsApp receipts processing system project

param(
    [Parameter(Mandatory = $false)]
    [string]$ChatHistoryPath,
    
    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "chat-analysis.json",
    
    [Parameter(Mandatory = $false)]
    [switch]$IncludeGitCommits,
    
    [Parameter(Mandatory = $false)]
    [switch]$ShowDetails
)

# Function to find VS Code chat history
function Find-VSCodeChatHistory {
    $possiblePaths = @(
        "$env:APPDATA\Code\User\workspaceStorage",
        "$env:APPDATA\Code\CachedExtensions",
        "$env:APPDATA\Code\logs",
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\resources\app\extensions\github.copilot-chat"
    )
    
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            Write-Host "Searching in: $path" -ForegroundColor Cyan
            $chatFiles = Get-ChildItem -Path $path -Recurse -Include "*.json", "*.log", "*chat*" -ErrorAction SilentlyContinue
            if ($chatFiles) {
                return $chatFiles
            }
        }
    }
    return $null
}

# Function to parse chat conversations
function Parse-ChatConversations {
    param([array]$ChatFiles)
    
    $conversations = @()
    
    foreach ($file in $ChatFiles) {
        if ($ShowDetails) {
            Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
        }
        
        try {
            if ($file.Extension -eq ".json") {
                $content = Get-Content $file.FullName -Raw | ConvertFrom-Json
                
                # Extract conversation data based on typical VS Code chat structure
                if ($content.messages -or $content.conversations) {
                    $conversations += @{
                        Source    = $file.FullName
                        Timestamp = $file.LastWriteTime
                        Content   = $content
                        Type      = "JSON"
                    }
                }
            }
            elseif ($file.Extension -eq ".log") {
                $logContent = Get-Content $file.FullName
                if ($logContent -match "copilot|chat|conversation") {
                    $conversations += @{
                        Source    = $file.FullName
                        Timestamp = $file.LastWriteTime
                        Content   = $logContent
                        Type      = "LOG"
                    }
                }
            }
        }
        catch {
            if ($ShowDetails) {
                Write-Warning "Could not parse $($file.Name): $($_.Exception.Message)"
            }
        }
    }
    
    return $conversations
}

# Function to get git commit history
function Get-GitCommitHistory {
    if (-not (Test-Path ".git")) {
        Write-Warning "Not in a git repository"
        return @()
    }
    
    try {
        $commits = git log --oneline --since="1 week ago" --pretty=format:'{"hash":"%H","short":"%h","message":"%s","author":"%an","date":"%ad"}' --date=iso
        $commitObjects = @()
        
        foreach ($commit in $commits) {
            if ($commit.Trim()) {
                try {
                    $commitObj = $commit | ConvertFrom-Json
                    $commitObjects += $commitObj
                }
                catch {
                    # Skip malformed commit entries
                }
            }
        }
        
        return $commitObjects
    }
    catch {
        Write-Warning "Could not retrieve git history: $($_.Exception.Message)"
        return @()
    }
}

# Function to analyze patterns
function Analyze-Patterns {
    param(
        [array]$Conversations,
        [array]$Commits
    )
    
    $analysis = @{
        TotalConversations  = $Conversations.Count
        TotalCommits        = $Commits.Count
        ConversationsByType = @{}
        CommonTopics        = @()
        TimeRange           = @{}
        Recommendations     = @()
    }
    
    # Analyze conversation types
    $jsonCount = ($Conversations | Where-Object { $_.Type -eq "JSON" }).Count
    $logCount = ($Conversations | Where-Object { $_.Type -eq "LOG" }).Count
    
    $analysis.ConversationsByType = @{
        JSON = $jsonCount
        LOG  = $logCount
    }
    
    # Analyze time range
    if ($Conversations.Count -gt 0) {
        $timestamps = $Conversations | ForEach-Object { $_.Timestamp }
        $analysis.TimeRange = @{
            Earliest = ($timestamps | Measure-Object -Minimum).Minimum
            Latest   = ($timestamps | Measure-Object -Maximum).Maximum
        }
    }
    
    # Generate recommendations
    $analysis.Recommendations = @(
        "Found $($Conversations.Count) chat-related files",
        "Found $($Commits.Count) recent git commits",
        "Consider correlating chat timestamps with commit times for workflow analysis"
    )
    
    return $analysis
}

# Main execution
Write-Host "=== WhatsApp Receipts Project - Chat History Parser ===" -ForegroundColor Green
Write-Host "Starting chat history analysis..." -ForegroundColor Cyan

# Find chat history files
if ($ChatHistoryPath -and (Test-Path $ChatHistoryPath)) {
    $chatFiles = Get-ChildItem -Path $ChatHistoryPath -Recurse -Include "*.json", "*.log"
}
else {
    Write-Host "Searching for VS Code chat history files..." -ForegroundColor Yellow
    $chatFiles = Find-VSCodeChatHistory
}

if (-not $chatFiles) {
    Write-Warning "No chat history files found. Try specifying a path with -ChatHistoryPath"
    exit 1
}

Write-Host "Found $($chatFiles.Count) potential chat files" -ForegroundColor Green

# Parse conversations
$conversations = Parse-ChatConversations -ChatFiles $chatFiles

# Get git commits if requested
$commits = @()
if ($IncludeGitCommits) {
    Write-Host "Analyzing git commit history..." -ForegroundColor Yellow
    $commits = Get-GitCommitHistory
}

# Perform analysis
$analysis = Analyze-Patterns -Conversations $conversations -Commits $commits

# Create output object
$output = @{
    GeneratedAt   = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    ProjectPath   = (Get-Location).Path
    Analysis      = $analysis
    Conversations = $conversations
    Commits       = $commits
    Tools         = @{
        Parser  = "ChatHistoryParser.ps1"
        Version = "1.0"
        Project = "WhatsApp Receipts Processing System"
    }
}

# Save results
try {
    $output | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputPath -Encoding UTF8
    Write-Host "Analysis saved to: $OutputPath" -ForegroundColor Green
}
catch {
    Write-Error "Could not save output: $($_.Exception.Message)"
    exit 1
}

# Display summary
Write-Host "`n=== ANALYSIS SUMMARY ===" -ForegroundColor Green
Write-Host "Chat Conversations Found: $($conversations.Count)" -ForegroundColor White
Write-Host "Git Commits Found: $($commits.Count)" -ForegroundColor White
Write-Host "Output File: $OutputPath" -ForegroundColor White

if ($ShowDetails) {
    Write-Host "`nDetailed Analysis:" -ForegroundColor Yellow
    $analysis | ConvertTo-Json -Depth 3 | Write-Host
}

Write-Host "`nChat history analysis complete!" -ForegroundColor Green
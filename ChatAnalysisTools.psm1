# Chat Analysis Tools PowerShell Module
# Professional VS Code chat history analysis and workflow correlation

# Get public and private function definition files
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

# Import all functions
foreach ($import in @($Public + $Private)) {
    try {
        Write-Verbose "Importing $($import.FullName)"
        . $import.FullName
    }
    catch {
        Write-Error "Failed to import function $($import.FullName): $_"
    }
}

# Export public functions
if ($Public) {
    Export-ModuleMember -Function $Public.BaseName
}

# Set up module variables
$ModuleRoot = $PSScriptRoot
$ModuleVersion = (Import-PowerShellDataFile -Path "$PSScriptRoot\ChatAnalysisTools.psd1").ModuleVersion

# Module initialization
Write-Verbose "Chat Analysis Tools v$ModuleVersion loaded successfully"
Write-Verbose "Module root: $ModuleRoot"

# Set up aliases for backward compatibility and convenience
New-Alias -Name 'Analyze-Chats' -Value 'Invoke-ChatHistoryAnalysis' -Force -ErrorAction SilentlyContinue
New-Alias -Name 'Get-ChatInsights' -Value 'Get-WorkflowInsights' -Force -ErrorAction SilentlyContinue

# Export aliases
Export-ModuleMember -Alias @('Analyze-Chats', 'Get-ChatInsights')

# Module cleanup on removal
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Write-Verbose "Chat Analysis Tools module removed"
}
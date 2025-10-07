# Chat Analysis Tools

Professional PowerShell module for VS Code chat history analysis and developer workflow correlation.

## Overview

Chat Analysis Tools provides comprehensive capabilities for analyzing VS Code Copilot chat histories and correlating them with git commit patterns, helping teams understand and optimize their AI-assisted development workflows.

## Features

- **VS Code Chat History Parsing**: Extract and analyze conversations from VS Code Copilot
- **Git Commit Correlation**: Link chat conversations with corresponding code commits  
- **Workflow Analysis**: Identify patterns in AI-assisted development processes
- **Comprehensive Reporting**: Generate detailed analysis reports in JSON and HTML formats
- **Multi-Project Support**: Analyze workflows across multiple repositories and projects

## Quick Start

### Installation

```powershell
# Install from PowerShell Gallery (recommended)
Install-Module ChatAnalysisTools

# Or clone directly for development
git clone https://github.com/thisis-romar/chat-analysis-tools.git
Import-Module .\ChatAnalysisTools.psd1
```

### Basic Usage

```powershell
# Basic chat history analysis
Invoke-ChatHistoryAnalysis

# Detailed analysis with git correlation
Invoke-ChatHistoryAnalysis -IncludeGitCommits -ShowDetails

# Custom analysis with specific paths
Invoke-ChatHistoryAnalysis -ChatHistoryPath "C:\Custom\Path" -OutputPath "analysis.json"
```

## Core Components

### ChatHistoryParser
- Extracts conversations from VS Code Copilot chat storage
- Parses conversation metadata and content
- Identifies AI interaction patterns

### WorkflowCorrelation  
- Correlates chat timestamps with git commit times
- Analyzes development velocity and AI assistance patterns
- Generates workflow optimization recommendations

### ReportingEngine
- Creates comprehensive analysis reports
- Supports JSON and HTML output formats
- Provides visual charts and metrics

## Use Cases

### Individual Developers
- **Productivity Analysis**: Understand how AI assistance affects your coding velocity
- **Learning Patterns**: Identify areas where AI helps most effectively
- **Time Management**: Correlate chat activity with productive coding sessions

### Development Teams
- **Workflow Optimization**: Analyze team-wide AI assistance patterns
- **Best Practices**: Identify most effective AI interaction approaches
- **Training Insights**: Understand how different team members utilize AI tools

### Project Managers
- **Velocity Tracking**: Monitor AI-assisted development progress
- **Resource Planning**: Understand AI tool impact on project timelines  
- **ROI Analysis**: Measure effectiveness of AI development tools

## Advanced Features

### Multi-Repository Analysis
```powershell
# Analyze multiple projects
$projects = @("project1", "project2", "project3")
Invoke-MultiProjectAnalysis -ProjectPaths $projects
```

### Custom Correlation Rules
```powershell
# Define custom correlation timeframes
Invoke-ChatHistoryAnalysis -CorrelationWindow 30 -MinutesThreshold 15
```

### Export and Integration
```powershell
# Export to various formats
Export-AnalysisReport -Format HTML -OutputPath "report.html"
Export-AnalysisReport -Format CSV -OutputPath "data.csv"
```

## Requirements

- **PowerShell**: 5.1 or later (PowerShell Core 6+ recommended)
- **VS Code**: With GitHub Copilot extension
- **Git**: For commit correlation functionality
- **Permissions**: Read access to VS Code user data directories

## Architecture

```
ChatAnalysisTools/
├── ChatAnalysisTools.psd1          # Module manifest
├── ChatAnalysisTools.psm1          # Main module file
├── Public/                         # Public functions
│   ├── Invoke-ChatHistoryAnalysis.ps1
│   ├── Export-AnalysisReport.ps1
│   └── Get-WorkflowInsights.ps1
├── Private/                        # Internal functions
│   ├── Find-VSCodeChatHistory.ps1
│   ├── Parse-ChatContent.ps1
│   ├── Correlate-WithGitCommits.ps1
│   └── Generate-AnalysisReport.ps1
├── docs/                          # Documentation
│   ├── API.md
│   └── Configuration.md
├── examples/                      # Usage examples
│   ├── basic-analysis.ps1
│   └── advanced-workflow.ps1
└── tests/                        # Unit tests
    └── ChatAnalysisTools.Tests.ps1
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup
```powershell
# Clone the repository
git clone https://github.com/thisis-romar/chat-analysis-tools.git
cd chat-analysis-tools

# Import for development
Import-Module .\ChatAnalysisTools.psd1 -Force

# Run tests
Invoke-Pester -Path .\tests\
```

## Related Projects

- **[AI Attribution Tools](https://github.com/thisis-romar/ai-attribution-tools)**: AI-assisted commit attribution analysis
- **[Developer Environment Tools](https://github.com/thisis-romar/developer-environment-tools)**: Development environment automation

## License

MIT License - see [LICENSE](LICENSE) for details.

## Support

- **Issues**: [GitHub Issues](https://github.com/thisis-romar/chat-analysis-tools/issues)
- **Documentation**: [docs/](docs/) folder
- **Examples**: [examples/](examples/) folder

---

**Professional chat history analysis for AI-assisted development workflows.**
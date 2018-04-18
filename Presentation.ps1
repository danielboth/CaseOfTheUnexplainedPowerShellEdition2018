# Case of the Unexplained
Import-Module "$ENV:CaseOfTheUnexplainedPath\CaseOfTheUnexplained.psd1" -Force

# Start easy
Open-Case -Name ImportCsv


# Class not found
Open-Case -Name OutOfScope


# Why is that value updated?
Open-Case -Name VariableScope


# All the fun with PSDrive
Open-Case -Name PSDrivePathNotFound


# How a switch was silently killed
Open-Case -Name ConfiguringSwitch


# Progress slows you down (a lot!)
Open-Case -Name SlowProgress


# The error handling (hell)
Open-Case -Name ErrorActionSilentlyContinueIgnored


# Who ever had a failing scheduled task?
Open-Case -Name FailingScheduledTask


# PowerShell writing PowerShell
Open-Case -Name AutoGeneratingCode


# The case of the ignored brakepoint
Open-Case -Name IgnoredBreakpoint
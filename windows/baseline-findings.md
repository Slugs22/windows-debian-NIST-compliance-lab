\# Windows 11 Baseline Assessment



\## System Info

* OS: Windows 11 Enterprise
* Build: 26100
* Assessment Date: 2026-11-14
* Benchmark: Microsoft Security Compliance Toolkit v25H2





\## Pre-Hardening State

* No Group Policy settings configured (registry.pol = 8 bytes)
* Default Windows audit policy in place
* Default security template settings in place
* No hardening Applied



\## Baseline LGPO Backup

Captured with LGPO.exe /b to C:\\LGPOBackup

Contains: registry.pol, audit.csv, GptTmpl.inf

## Post-Hardening State - 2026-11-14
- Baseline-LocalInstall.ps1 run with - Win11NonDomainJoined switch
- All 8 GPOs applied successfully via LGPO.exe
- Security privileges now restricted even for admin accounts
- SeSecurityPrivilege, SeBackupPrivilege and others now Disabled
- This confirms the baseline hardening was applied successfully

## GPOs Applied
- MSFT Internet Explorer 11 - Computer
- MSFT Internet Explorer 11 - User
- MSFT Windows 11 25H2 - BitLocker
- MSFT Windows 11 25H2 - Computer
- MSFT Windows 11 25H2 - Credential Guard
- MSFT Windows 11 25H2 - Defender Antivirus
- MSFT Windows 11 25H2 - Domain Security
- MSFT Windows 11 25H2 - User
- DeltaForNonDomainJoined.inf (backs out domain-only restrictions)


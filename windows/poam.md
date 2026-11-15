# Windows 11 - Plan of Action and Milestones (POA&M)

## Overview
This document tracks open findings from the Windows 11 NIST compliance assessment.
Each finding includes  a risk rating, reason it cannot be remediated, compensating controls, and a remediation plan.

## Open Findings

### POA&M-Win-001
- *8Control:** SC-28 - Protection of Information at Rest
- **Finding:** BitLocker Drive Encryption not configured
- **Severity:** High
- **Reason:** Bitlocker cannot be meaningfully enabled on a VirtualBox VM because the virtual disk is already protected by the host machine's encryption.
TPM chip is not available in a VirtualBox VM environment.
- **Compensating Controls:**
	- Host machine encryption protects the virtual disk at rest
	- VM is isolated from the netowrk
	- Access to the VM requires host machine authentication
- **Residual Risk:** Low - host encryption provides equivalent protection in this lab environment
- **Remediation Plan:** In a production environement, enabled Bitolocker with a TPM 2.0 on physical hardware. This would satisgy SC-28.
- **Target Date:** None - Lab environment

## Resolved Finsings

### AC-7 - Account Lockout Threshold
- **Original Finding:** Lockout threshold set to 10
- **Resolution:** Manually set to 5 via command line net accounts /lockoutthreshold:5
- **Date Resolved:** 2026-11-15
- **Verification:** verify.ps1 confirms PASS
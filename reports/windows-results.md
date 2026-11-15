# Windows 11 Compliance Assessment Report

## Executive Summary
A Windows 11 Enterprise VM was hardened against the Microsoft Security Compliance Toolkit v25H2 baseline, which maps to NIST SP 800-53 controls.
The assessment resulted in 7 of 8 controls passing verification. The one remaining open finding is a known VM environment limitation documented in the POA&M.

## Environment
- OS: Windows 11 Enterprise Build 26100
- VM: Oracle VirtualBox
- Benchmark: Microsoft Security Compliance Toolkit v25H2
- Assessment Date: 2026-11-15
- Assessor: Self-assessed lab environment

## Methodology
1. Captured prehardening LGPO baseline
2. Applied Microsoft Security Compliance Toolkit v25H2 baseline using Baseline-LocalInstall.ps1 with -Win11NonDomainJoined switch
3. Ran PowerShell verification script checkling 8 NIST SP 800-53 controls
4. Documented findings and remediated where possible
5. Documented remaining exceptions in POA&M

## Results Summary
- Total Controls Assessed: 8
- Pass: 7 (87.5%)
- Fail: 1 (12.5%)
- Manual Review Required: 0

## Detailed Results

| Control | Name | Result | Notes |
|---------|------|--------|-------|
| AC-2 | Guest Account Disabled | PASS | Verified disabled |
| AC-7 | Account Lockout Threshold | PASS | Set to 5 after remediation |
| AU-2 | Audit Logon Events | PASS | Success and Failure enabled |
| CM-7 | AutoPlay Disabled | PASS | Registry value 255 confirmed |
| IA-5 | Minimum Password Length | PASS | Set to 14 characters |
| SC-5 | Windows Firewall | PASS | All profiles enabled |
| SC-28 | BitLovker Encryption | FAIL | VM limitation - see POA&M |
| SI-3 | Windows Defender | PASS | Real-time protection enabled |

## Key Findings

### Hardening Observations
The Microsoft Security Baseline significantly restricted system privileges after application.
Even administrator accounts had most privileges set to Disabled, demostrating the abseline working as intended.
UAC token separation was enforced, reuiring explicit admin elevation for sensitive operations.

## Open Finding
BitLocker encryption cannot be configured on a VirtualBox VM due to the absence of a TPM chip.
This is doumented in the POA&M with compensating controls.
In a production environment this would be remediated by enabling BitLocker on physical hardware with TPM 2.0.

## Limitations
- Assessment covers 8 key NIST controls, not the full 800-53 control set
- Windows 11 Home lacks Group Policy Editor - Enterprise edition used instead
- VM environment limits cerrtain hardware-dependent controls
- Standalone non-domain-joined configuration limits some domain controls

## Conclusion
The WIndows 11 Enterprise VM demonstrates strong baseline secuirty posture with 87.5% of assessed controls passing.
The Microsoft Security Compliance Toolkit v25H2 baseline was successfully applied and verified.
The one open finding is a known VM environment limitation with documented compensating controls.
# Methodology

## Overview
This lab follows a structure assess-harden-reassess workflow modeled after real-world compliance processes used in governement and enterprise environments


## Tools Used

### Windows 11 Enterprise
- Microsoft Security Compliance TOolkit (SCT)
- Policy Analyzer
- Powershell for registry-based hardening

### Debian 13
- OpenSCAP
- ComplianceAsCode / SCAP Security Guide
- Bash for hardening automation

## Workflow

### Phase 1 - Baseline
1. Take VM snapshot before any changes
2. Run initial compliance scan
3. Export and save baseline results
4. Document initial score and failed rules

### Phase 2 - Hardening
1. Apply automated hardening where possible
2. Document every cahnge made
3. Note settings that cannot be automated
4. Note settings skipped and why

### Phase 3 - Reassessment
1. Run compliance scan again after hardening
2. Compare results against baseline
3. Document improvements
4. Investigate remaining failures

### Phase 4 - Documentation
1. Record all Open findings with POA&M
2. Documetn Not Applicable findings with justification
3. Write comparison report
4. Document lessons learned

## Important Notes
- Automation does not equal compliance. Every automated fix is verified manually.
- A passing scan result is only as reliable as the tool that produced it.
- All exceptions are documented with business risk justification.
- Benchmarks are treated as the authority, not the scnaning tools.
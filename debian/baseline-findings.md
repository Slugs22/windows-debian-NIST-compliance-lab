# Debian 13 Baseline Assessment

## System Info
- OS: Debian 13 "Trixie"
- Assessment Date: 2026-11-15
- Benchmark: SCAP Security Guide (SSG) for Debian 12 applied to Debian 13
- Tool: OpenSCAP 1.4.2

## Tooling Gap Documentation
No official SCAP content exists for Debian 13 at time of assessment.
The Debian 12 SSG content (ssg-debian12-oval.xml) was used as the
closest available reference. This is a known limitation documented
in docs/exceptions.md.

The XCCDF profile scan returned all rules as notapplicable because
the CPE platform check could not match Debian 13 against the Debian 12
content. The OVAL-only scan was used instead, bypassing the platform
check and producing meaningful results.

## Baseline Scan Results (OVAL)
- Total Rules Evaluated: 673
- True (Passing): 255 (37.9%)
- False (Failing): 370 (55.0%)
- Error: 48 (7.1%)

## Key Failing Areas (Pre-Hardening)
- Password policy settings (pam_pwquality, minlen, complexity)
- Account lockout settings (pam_faillock)
- SSH hardening settings
- Audit subsystem not installed
- Separate partitions not configured

## Notes
- Separate partition findings are VM environment limitations
- Full results saved to scan-results/baseline-oval-summary.txt

# Windows & Debian NIST Compliance Lab

## Overview
This lab demostrates security hardening and compliance assessment across two operating system environments: Windows 11 Enterprise and Debian 13. Each VM is independently hardened and assessed against an appropriate security benchmark.

## Benchmarks Used
- **Windows 11 Enterprise:** DISA STIG (via Microsoft Security Compliance Toolkit)
- **Debian 13:** CIS Benchmark for Debian Linuc (Debian 12 benchmark applied to Debian 12 with document gaps)

## Environement
- **Hypervisor:** Oracle Virtualbox
- **Host OS:** Windows
- **VM 1:** Windows 11 Enterprise
- **VM 2:** Debian 13 with XFCE desktop

## Known Limitations
- Windows 11 Enterprise lacks some GPO setting available in domain joined environments. All settings applied via registry edits and are documented.
- Debian 13 does not yet have an official CIS Benchmark. THe Debian 12 CIS benchmark is used as closest reference. ALl gaps are documented.

## Repository Structure
- windows/ - Windows 11 hardening scripts and evidence
- debian/ - Debian hardening scripts and evidence
- reports/ - Compliance scna results and analysis
- docs/ - Methodology, exceptions, and risk analysis

## Methodology
1. Take baseline snapshot of clean VM
2. Run initial compliance scan
3. Document baseline findings
4 Apply hardening configurations
5. Run post-hardening can
6. Document remaining findings with POA&M
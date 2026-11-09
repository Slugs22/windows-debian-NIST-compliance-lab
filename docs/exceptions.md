\# Exceptions and Limitations



\## Windows 11 Enterprise



\### GPO Limitations

Windows 11 Enterprise in a standalone (non-domain-joined) environment has limited Group Policy functionality compare to a domain-joined system. The following applies:

* All STIG settings normally applied via GPO are instead applied via registry edits using PowerShell
* Each registry edit is documented with the corresponding STIG rule ID
* A production environment would use domain-joined GPO deployment



\### FIPS Limitations

FIPS-validated cryptography requires specific Windows configurations that may break certain applications in a lab environment. Any FIPS-related findings will be documented as Open with justification.



\## Debian 13



\### Benchmark Gap

No official CIS Benchmark exists for Debian 13 at the time of this lab.

The Debian 12 CIS Benchmark is used as the closest available reference.

All rules are applied and tested against Debian 13 with the following approach:

* Rules that apply cleanly are marked compliant
* Rules that fail due to Debian 13 differences are documented
* Rules that cannot be assessed are marked Not Reviewed with explanation



\### Tooling Gap

ComplianceAsCode and OpenSCAP content for Debian 13 may be incomplete or unavailable. Any tooling gaps encountered are documented here as they are discovered during this lab.



\## General Limitations

* Neither VM is domain-joined, so domain-specific controls are Not Applicable
* No DoD PKI infrastructure is available, so CAC/PKI controls are Not Applicable
* No external log server exists, so log offload controls are Open
* No DoD time servers are available, public NTP servers are used instead




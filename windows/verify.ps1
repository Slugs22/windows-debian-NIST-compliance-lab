# Windows 11 NIST Compliance Verification Script
# Benchmark: Microsoft Security Compliance Toolkit v25H2
# NIST SP 800-53 Control Mapping
# Run as Administrator

# =================================================================
# Configuration
# =================================================================
$reportPath = "C:\Users\vboxuser\Documents\windows-debian-NIST-complaince-lab\windows\evidence"
$reportFile = "$reportPath\verification-results.txt"
$pass = 0
$fail = 0
$manual = 0

# =================================================================
# HELPER FUNCTIONS
# =================================================================
function Check-Control {
	param(
		[string]$ControlID,
		[string]$ControlName,
		[string]$Result,
		[string]$Expected,
		[string]$Actual
	)
	if ($Result -eq "PASS") {
		$script:pass++
		$status = "[PASS]"
	} elseif ($Result -eq "FAIL") {
		$script:fail++
		$status = "[FAIL]"
	} else {
		$script:manual++
		$status = "[MANUAL}"
	}
	$line = "$status $ControlID - $ControlName | Expected: $Expected | Actual: $Actual"
	Write-Host $line
	Add-Content -Path $script:reportFile -Value $line
}

# ===============================================================
# START REPORT
# ===============================================================
$header = @"
================================================
Windows 11 NIST Compliance Verification Report
Date: $ (Get-Date)
Benchmark: Microsoft Security Baseline v25H2
================================================
"@
Write-Host $header
Set-Content -Path $reportFile -Value $header

# ================================================================
# AC-7 UNSUCCESSFUL LOGIN ATTEMPTS
# ================================================================
$lockoutThreshold = (net accounts | Select-String "Lockout threshold").ToString().Trim()
$lockoutDuration = (net accounts | Select-String "Lockout duration").ToString().Trim()
if ($lockoutThreshold -match "\d+" -and [int]$Matches[0] -le 5 -and [int]$Matches[0] -gt 0) {
	Check-Control "AC-7" "Account Lockout Threshold" "PASS" "5 or less" $lockoutThreshold
} else {
	Check-Control "AC-7" "Account Lockout Threshold" "FAIL" "5 or less" $lockoutThreshold
}

# ================================================================
# IA-5 - PASSWORD LENGTH
# ================================================================
$minPwdLength = (net accounts | Select-String "Minimum password length").ToString().Trim()
if ($minPwdLength -match "\d+" -and [int]$Matches[0] -ge 14) {
	Check-Control "IA-5" "Minimum Password Length" "PASS" "14 or more" $minPwdLength
} else {
	Check-Control "IA-5" "Minimum Password Length" "FAIL" "14 or more" $minPwdLength
}

# ===============================================================
# AC-2 - GUEST ACCOUNT DISABLED
# ===============================================================
$guest = (net user guest | Select-String "Account active").ToString().Trim()
if ($guest -match "No") {
	Check-Control "AC-2" "Guest Account Disabled" "PASS" "No" $guest
} else {
	Check-Control "AC-2" "Guest Account Disabled" "FAIL" "No" $guest
}

# ===============================================================
# SC-28 - BITLOCKER ENCRYPTION
# ===============================================================
$bitlocker = manage-bde -status C: 2>$null | Select-String "Protection Status"
if ($bitlocker -match "Protection On") {
	Check-Control "SC-28" "Bitlocker Drive Encryption" "PASS" "Protection On" $bitlocker
} else {
	Check-Control "SC-28" "BitLocker Drive Encryption" "FAIL" "Protection On" "Protection Off or Not Configured"
}

# ================================================================
# AU-2 - AUDIT POLICY
# ================================================================
$auditLogon = auditpol /get /subcategory:"Logon" 2>$null
if ($auditLogon -match "Success and Failure") {
	Check-Control "AU-2" "Audit Logon Events" "PASS" "Success and Failure" "Success and Failure"
} else {
	Check-Control "AU-2" "Audit Logon Events" "FAIL" "Success and Failure" $auditLogon
}

# ================================================================
# SC-5 - WINDOWS FIREWALL
# ================================================================
$fwDomain = (Get-NetFirewallProfile -Profile Domain).Enabled
$fwPrivate = (Get-NetFirewallProfile -Profile Private).Enabled
$fwPublic = (Get-NetFirewallProfile -Profile Public).Enabled
if ($fwDomain -and $fwPrivate -and $fwPublic) {
	Check-Control "SC-5" "Windows Firewall All Profiles" "PASS" "All Enabled" "All Enabled"
} else {
	Check-Control "SC-5" "Windows Firewall All Profiles" "FAIL" "All Enabled" "Domain:$fwDomain Private:$fwPrivate Public:$fwPublic"
}

# ================================================================
# SI-3 - WINDOWS DEFENDER
# ================================================================
$defender = Get-MpComputerStatus 2>$null
if ($defender.AntivirusEnabled -and $defender.RealTimeProtectionEnabled) {
	Check-Control "SI-3" "Windows Defender Antivirus" "PASS" "Enabled" "Enabled"
} else {
	Check-Control "SI-3" "Windows Defender Antivirus" "FAIL" "Enabled" "Disabled or Note Running"
}

# ===============================================================
# CM-7 - AUTOPLAY DISABLED 
# ===============================================================
$autoplay = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -ErrorAction SilentlyContinue
if ($autoplay.NoDriveTypeAutoRun -eq 255) {
	Check-Control "CM-7" "AutoPlay Disabled" "PASS" "255 (All Disabled)" $autoplay.NoDriveTypeAutoRun
} else {
	Check-Control "CM-7" "AutoPlay Disabled" "FAIL" "255 (All Disabled)" $autoplay.NoDriveTypeAutoRun
}

# ===============================================================
# SUMMARY
# ===============================================================
$summary = @"

==========================================================
SUMMARY
==========================================================
PASS:	$pass
FAIL:	$fail
MANUAL:	$manual
TOTAL:	$($pass + $fail + $manual)
==========================================================
"@
Write-Host $summary
Add-Content -Path $reportFile -Value $summary
Write-Host "Report saved to: $reportFile"

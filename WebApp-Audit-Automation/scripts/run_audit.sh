#!/bin/bash
TARGET=$1
nmap -sV -p 80,443 $TARGET -oN reports/nmap_scan.txt
nikto -h http://$TARGET -output reports/nikto_report.txt
echo "[*] Scans complete. Parsing next..."
python3 scripts/parse_results.py
#!/bin/bash
echo "[*] Checking sudo permissions..."
sudo -l

echo "[*] Checking SUID binaries..."
find / -perm -4000 2>/dev/null

echo "[*] Kernel version:"
uname -a
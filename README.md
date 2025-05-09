

# 🔐 Penetration Testing Lab: DoubleTrouble (VulnHub)

This repository documents a complete penetration testing walkthrough against the **DoubleTrouble** VulnHub machine running `qdPM 9.1`. It includes network scanning, web enumeration, brute-force attacks, steganography, file upload exploitation, and shell access.

---

## 🧭 Lab Environment

- **Target IP:** `10.10.10.101`
- **Attacker:** Kali Linux (VirtualBox)
- **Network Mode:** Internal Network (isolated)
- **Target Service:** qdPM 9.1 Web App

---

## 🔍 Step 1: Network Scanning

```bash
sudo nmap -sS -T4 10.10.10.100-120
```
![Nmap Scan](screenshots/nmap.png)

Discovered open ports: `22 (SSH)`, `80 (HTTP)`

---

## 🌐 Step 2: Web App Enumeration

Used `curl` and browser to find qdPM login page.

![qdPM Login Page HTML](screenshots/dbtb.png)

---

## 📂 Step 3: Gobuster Directory Discovery

```bash
gobuster dir -u http://10.10.10.101 -w /usr/share/wordlists/dirb/common.txt -x php,html,txt -t 30
```
![Gobuster Results](screenshots/gobstr.png)

Discovered `/core/config/databases.yml`, `/secret/`, `/uploads/`

---

## 🖼️ Step 4: Steganography with StegSeek

```bash
stegseek doubletrouble.jpg /usr/share/wordlists/rockyou.txt
cat doubletrouble.jpg.out
```
![StegSeek Output](screenshots/usrpsw.png)

Extracted credentials:
- Email: `otisrush@localhost.com`
- Password: `otis666`

---

## 🔐 Step 5: Brute-Force Login via Burp Suite

Used Burp Intruder to brute-force `admin@qdpm.com` with `rockyou.txt`.

![Burp Intruder Results](screenshots/p5.png)

Successful login password: `000000`

---

## 📜 Step 6: Config File Credentials Leak

Visited `/core/config/databases.yml` from Gobuster discovery.

![Config File Leak](screenshots/pvesc.png)

Extracted:
- Username: `otis`
- Password: `rush`

---

## 🪝 Step 7: Exploit Arbitrary File Upload

Identified this vulnerability via Searchsploit:

![Exploit Writeup](screenshots/p4.png)

Uploaded a reverse shell file as `shell.PHP` via user profile page.

---

## 🖥️ Step 8: Remote Shell Access

Started listener:
```bash
nc -lvnp 4444
```

Triggered shell by visiting:
```
http://10.10.10.101/uploads/shell.PHP
```

---

## ✅ Step 9: Admin Panel Access

Accessed qdPM Dashboard after login:

![Logged-in Dashboard](screenshots/lgd.png)

---

## 📚 Exploit Research

Used `searchsploit` to find all qdPM 9.1 exploits.

![Searchsploit Results](screenshots/ssplt.png)

---

## 📁 Project Structure

```
DoubleTrouble-Pentest/
├── README.md
└── screenshots/
    ├── nmap.png
    ├── dbtb.png
    ├── gobstr.png
    ├── usrpsw.png
    ├── p5.png
    ├── pvesc.png
    ├── p4.png
    ├── lgd.png
    └── ssplt.png
```

---

## 👨‍💻 Author

**Pentester:** [Your Name]  
**Platform:** VulnHub  
**Machine:** DoubleTrouble

---

## ⚠️ Disclaimer

This lab is for educational purposes only.

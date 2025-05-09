# Simple result parser (example)
with open("reports/nikto_report.txt", "r") as f:
    lines = f.readlines()

findings = [line for line in lines if "OSVDB" in line or "Server" in line]

with open("reports/sample_report.md", "w") as out:
    out.write("# Web App Scan Findings\n\n")
    for finding in findings:
        out.write(f"- {finding}")
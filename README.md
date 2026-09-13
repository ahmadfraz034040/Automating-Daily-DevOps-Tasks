# 📘 Real-World Bash Scripting: Automating Daily DevOps Tasks

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-Automation-blue?style=for-the-badge)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

> A hands-on guide to writing practical Bash scripts that solve real problems sysadmins and DevOps engineers face every day — system monitoring, backups, and connectivity checks.

---

## 🎯 Objective

- Understand how to write, execute, and apply basic Bash scripts in real-world industry scenarios.
- Learn common administrative automation tasks like system monitoring, backup, and connectivity checking.
- Build confidence writing scripts that are reusable, readable, and production-ready.

---

## 📂 Table of Contents

1. [Why Bash for DevOps?](#-why-bash-for-devops)
2. [Prerequisites](#-prerequisites)
3. [Script 1: System Health Monitor](#-script-1-system-health-monitor)
4. [Script 2: Automated Backup](#-script-2-automated-backup)
5. [Script 3: Connectivity Checker](#-script-3-connectivity-checker)
6. [Scheduling with Cron](#-scheduling-with-cron)
7. [Best Practices](#-best-practices)
8. [Key Takeaways](#-key-takeaways)

---

## 💡 Why Bash for DevOps?

Bash is the glue of Linux systems. It's pre-installed everywhere, lightweight, and perfect for:

- Automating repetitive admin tasks
- Gluing together CLI tools (`grep`, `awk`, `curl`, `df`, `ping`)
- Writing quick monitoring and alerting scripts
- Building the foundation for CI/CD pipeline steps

---

## ✅ Prerequisites

- A Linux/macOS environment (or WSL on Windows)
- Basic familiarity with the terminal
- Bash `4.x+` recommended

```bash
bash --version
```

---

## 🖥 Script 1: System Health Monitor

Checks CPU, memory, and disk usage — and warns when thresholds are exceeded.

```bash
#!/bin/bash
# system_monitor.sh - Basic system health check

THRESHOLD=80

echo "🔍 System Health Report - $(date)"
echo "-----------------------------------"

# CPU usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "CPU Usage: $CPU%"

# Memory usage
MEM=$(free | awk '/Mem/{printf("%.0f", $3/$2 * 100)}')
echo "Memory Usage: $MEM%"

# Disk usage
DISK=$(df -h / | awk 'NR==2{print $5}' | tr -d '%')
echo "Disk Usage: $DISK%"

if [ "$DISK" -ge "$THRESHOLD" ]; then
  echo "⚠️  Warning: Disk usage above ${THRESHOLD}%!"
fi
```

**Run it:**
```bash
chmod +x system_monitor.sh
./system_monitor.sh
```

---

## 💾 Script 2: Automated Backup

Compresses a target directory into a timestamped archive.

```bash
#!/bin/bash
# backup.sh - Simple automated backup script

SOURCE_DIR="/home/user/project"
BACKUP_DIR="/home/user/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
  echo "✅ Backup successful: $BACKUP_FILE"
else
  echo "❌ Backup failed!"
  exit 1
fi
```

**Run it:**
```bash
chmod +x backup.sh
./backup.sh
```

---

## 🌐 Script 3: Connectivity Checker

Pings a list of hosts and reports which are reachable.

```bash
#!/bin/bash
# connectivity_check.sh - Check network connectivity

HOSTS=("google.com" "github.com" "8.8.8.8")

for HOST in "${HOSTS[@]}"; do
  if ping -c 1 -W 2 "$HOST" &> /dev/null; then
    echo "✅ $HOST is reachable"
  else
    echo "❌ $HOST is NOT reachable"
  fi
done
```

**Run it:**
```bash
chmod +x connectivity_check.sh
./connectivity_check.sh
```

---

## ⏰ Scheduling with Cron

Automate these scripts to run on a schedule using `crontab -e`:

```bash
# Run system monitor every hour
0 * * * * /home/user/scripts/system_monitor.sh >> /var/log/system_monitor.log

# Run backup daily at 2 AM
0 2 * * * /home/user/scripts/backup.sh >> /var/log/backup.log

# Check connectivity every 15 minutes
*/15 * * * * /home/user/scripts/connectivity_check.sh >> /var/log/connectivity.log
```

---

## 🛠 Best Practices

- Always start scripts with `#!/bin/bash` and `chmod +x`
- Use `set -euo pipefail` for safer error handling
- Log output instead of printing only to console
- Quote your variables: `"$VAR"` not `$VAR`
- Comment generously — future you will thank you

---

## 📌 Key Takeaways

- Bash scripting turns repetitive manual tasks into one-line commands.
- System monitoring, backups, and connectivity checks are foundational DevOps skills.
- Combined with `cron`, these scripts become a lightweight automation layer — no extra tooling required.

---

⭐ If this helped you, consider starring the repo and sharing it with others learning DevOps!

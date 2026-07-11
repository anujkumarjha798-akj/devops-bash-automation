# 📦 Backup Manager

A simple and interactive **Bash Backup Manager** that creates compressed backups of a source directory, verifies backup integrity, and allows users to create a backup destination if it does not exist.

---

## 📌 Features

* ✅ Root privilege validation
* ✅ Source directory validation
* ✅ Empty directory detection
* ✅ Backup destination validation
* ✅ Automatically create the backup destination if it does not exist
* ✅ Compressed backup using `tar.gz`
* ✅ Timestamp-based backup filenames
* ✅ Display backup file size
* ✅ Backup integrity verification
* ✅ Interactive user prompts
* ✅ Cron automation support

---

## 🛠️ Technologies Used

* Bash Scripting
* Linux
* `tar`
* `du`
* Cron

---

## 📂 Project Structure

```text
backup-manager/
├── backup_manager.sh
└── README.md
```

---

# 🚀 How to Run

### 1. Make the script executable

```bash
chmod +x backup_manager.sh
```

### 2. Run the script as root

```bash
sudo ./backup_manager.sh
```

---

## 📋 Script Workflow

1. Check for root privileges.
2. Ask the user for the source directory.
3. Validate the source directory.
4. Check whether the source directory is empty.
5. Ask for the backup destination.
6. Create the destination directory if it does not exist.
7. Create a compressed `.tar.gz` backup with a timestamp.
8. Display backup details.
9. Show the backup file size.
10. Verify the backup archive.

---

## 💻 Example Output

```text
===================================
          BACKUP MANAGER
===================================

Enter your Source Destination:
/home/user/Documents/project

Enter your Backup Destination:
/home/user/backups

Backup directory already exists

===============================
DATE and TIME:
2026-07-11::22-15-10

Backup completed...
===============================
PATH:
 /home/user/backups/backup_2026-07-11::22-15-10.tar.gz

📏 Size: 12 MB

Backup verified successfully!
```

---

# ⏰ Cron Setup (Automatic Backup Every 2 Minutes)

## Step 1: Make the script executable

```bash
chmod +x /home/user/Documents/task4/backup_manager.sh
```

## Step 2: Open the user's crontab

```bash
crontab -e
```

## Step 3: Add one of the following cron jobs

### Run every 2 minutes

```cron
*/2 * * * * /bin/bash /home/user/Documents/task4/backup_manager.sh
```

### Run every 2 minutes and save logs

```cron
*/2 * * * * /bin/bash /home/user/Documents/task4/backup_manager.sh >> /var/log/backup.log 2>&1
```

---

## Step 4: Verify Cron Service

### Check cron service status

```bash
sudo systemctl status cron
```

### View backup logs

```bash
sudo tail -f /var/log/syslog | grep backup
```

### List all cron jobs

```bash
crontab -l
```

---

## 📚 Commands Used

| Command   | Purpose                    |
| --------- | -------------------------- |
| `tar`     | Create compressed backups  |
| `du`      | Display backup file size   |
| `mkdir`   | Create backup directories  |
| `ls`      | List backup files          |
| `date`    | Generate timestamps        |
| `crontab` | Schedule automatic backups |

---

## ⚠️ Requirements

* Linux Operating System
* Bash Shell
* Root Privileges
* `tar` package installed
* Cron service (optional for scheduled backups)

---

## 🔮 Future Improvements

* Delete old backups automatically
* Restore backups
* Backup logging
* Email notifications
* Configuration file support
* Backup encryption
* Incremental backups

---

## Author

**Anuj Kumar Jha**

Aspiring DevOps Engineer | Linux | Bash Scripting | Git & GitHub


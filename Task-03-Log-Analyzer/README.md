# Log Analyzer

A simple Bash script that analyzes Linux log files and provides useful statistics through an interactive menu.

## Features

- Validate log file before processing
- Count total words
- Count total lines
- Count total characters
- Display file size
- Show last modified date and time
- Count `ERROR` entries
- Count `WARNING` entries
- Count `INFO` entries
- Count `DEBUG` entries
- Search for any keyword in the log file
- Interactive menu-driven interface

## Requirements

- Linux Operating System
- Bash Shell
- Root Privileges

## Usage

1. Make the script executable.

```bash
chmod +x log_analyzer.sh
```

2. Run the script as root.

```bash
sudo ./log_analyzer.sh
```

3. Enter the path to the log file when prompted.

Example:

```text
/var/log/syslog
```

or

```text
/var/log/auth.log
```

## Menu Options

```
1. Word Count
2. Line Count
3. Character Count
4. File Size
5. Last Modified
6. ERROR Count
7. WARNING Count
8. INFO Count
9. DEBUG Count
10. Search Keyword
11. Exit
```

## Example Output

```text
=================================
          Log Analyzer
=================================

Enter the log file path: /var/log/syslog

============================================
              LOG ANALYZER MENU
============================================
1) Word Count
2) Line Count
3) Character Count
4) File Size
5) Last Modified
6) ERROR Count
7) WARNING Count
8) INFO Count
9) DEBUG Count
10) Search Keyword
11) Exit
============================================

Select an option: 6

ERROR Entries : 12
```

## Project Structure

```
log-analyzer/
├── log_analyzer.sh
└── README.md
```

## Skills Demonstrated

- Bash Scripting
- Shell Functions
- Conditional Statements
- Loops
- Case Statements
- User Input Validation
- File Handling
- Linux Commands (`grep`, `wc`, `stat`, `date`)
- Text Processing
- Interactive CLI Development

## Future Improvements

- Export analysis report to a file
- Display top frequent log messages
- Filter logs by date
- Search using regular expressions
- Generate colored terminal output
- Support compressed log files (`.gz`)

## Author

**Anuj Kumar Jha**

Aspiring DevOps Engineer | Linux | Bash Scripting | Git & GitHub

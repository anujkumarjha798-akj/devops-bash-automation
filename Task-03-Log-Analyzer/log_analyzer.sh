#!/bin/bash

echo "================================="
echo "          Log Analyzer           "
echo "================================="

# ==============================
# Root Privilege Check
# ==============================
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root."
    echo "Usage: sudo ./log_analyzer.sh"
    exit 1
fi

# ==============================
# Get Log File
# ==============================
read -p "Enter the log file path: " LOG_FILE

# Check if file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: File does not exist."
    exit 1
fi

# Check read permission
if [[ ! -r "$LOG_FILE" ]]; then
    echo "Error: File is not readable."
    exit 1
fi

# Check if file is empty
if [[ ! -s "$LOG_FILE" ]]; then
    echo "Error: File is empty."
    exit 1
fi

# ==============================
# File Statistics
# ==============================
word_count() {
    words=$(wc -w < "$LOG_FILE")
    echo
    echo "Total Words      : $words"
}

line_count() {
    lines=$(wc -l < "$LOG_FILE")
    echo "Total Lines      : $lines"
}

character_count() {
    chars=$(wc -m < "$LOG_FILE")
    echo "Total Characters : $chars"
}

show_file_size() {
    echo
    echo "============================================"
    size=$(stat -c%s "$LOG_FILE")
    echo "File Size        : $size bytes"
}

last_modified() {
    echo
    echo "============================================"
    modified=$(date -r "$LOG_FILE" "+%Y-%m-%d %H:%M:%S")
    echo "Last Modified    : $modified"
}

# ==============================
# Log Statistics
# ==============================
error_count() {
    errors=$(grep -c "ERROR" "$LOG_FILE")
    echo "ERROR Entries    : $errors"
}

warning_count() {
    warnings=$(grep -c "WARNING" "$LOG_FILE")
    echo "WARNING Entries  : $warnings"
}

info_count() {
    infos=$(grep -c "INFO" "$LOG_FILE")
    echo "INFO Entries     : $infos"
}

debug_count() {
    debug=$(grep -c "DEBUG" "$LOG_FILE")
    echo "DEBUG Entries    : $debug"
}

# ==============================
# Search Keyword
# ==============================
search_keyword() {
    read -p "Enter keyword to search: " keyword

    echo
    echo "============================================"

    result=$(grep -i -n "$keyword" "$LOG_FILE")

    if [[ -z "$result" ]]; then
        echo "No matching entries found."
    else
        echo "Matching Entries:"
        echo "$result"
    fi

    echo "============================================"
}

# ==============================
# Menu
# ==============================
while true; do

    echo
    echo "============================================"
    echo "              LOG ANALYZER MENU"
    echo "============================================"
    echo "1) Word Count"
    echo "2) Line Count"
    echo "3) Character Count"
    echo "4) File Size"
    echo "5) Last Modified"
    echo "6) ERROR Count"
    echo "7) WARNING Count"
    echo "8) INFO Count"
    echo "9) DEBUG Count"
    echo "10) Search Keyword"
    echo "11) Exit"
    echo "============================================"

    read -p "Select an option: " option
    echo

    case $option in
        1)
            echo "Word Count"
            word_count
            ;;
        2)
            echo "Line Count"
            line_count
            ;;
        3)
            echo "Character Count"
            character_count
            ;;
        4)
            echo "File Size"
            show_file_size
            ;;
        5)
            echo "Last Modified"
            last_modified
            ;;
        6)
            echo "ERROR Count"
            error_count
            ;;
        7)
            echo "WARNING Count"
            warning_count
            ;;
        8)
            echo "INFO Count"
            info_count
            ;;
        9)
            echo "DEBUG Count"
            debug_count
            ;;
        10)
            echo "Search Keyword"
            search_keyword
            ;;
        11)
            echo "Exiting Log Analyzer..."
            break
            ;;
        *)
            echo "Error: Invalid option. Please try again."
            ;;
    esac

done

echo
echo "================================="
echo "       Program Terminated        "
echo "================================="

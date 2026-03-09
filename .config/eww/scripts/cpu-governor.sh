#!/usr/bin/env bash
# cpu-governor.sh — CPU governor management
# Usage: cpu-governor.sh get            → print current governor
#        cpu-governor.sh set <governor> → set all CPUs to governor (needs pkexec)
#        cpu-governor.sh list           → list available governors

case "$1" in
    get)
        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "unknown"
        ;;
    list)
        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors 2>/dev/null \
            | tr ' ' '\n' | grep -v '^$'
        ;;
    set)
        gov="$2"
        if [[ -z "$gov" ]]; then echo "No governor specified" >&2; exit 1; fi
        pkexec /usr/local/bin/set-cpu-governor "$gov"
        ;;
esac

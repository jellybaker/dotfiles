#!/usr/bin/env bash
# Persistent loop — one process, no spawning overhead

read_cpu() {
    awk '/^cpu / {idle=$5; total=0; for(i=2;i<=NF;i++) total+=$i; print idle" "total}' /proc/stat
}

while true; do
    snap1=$(read_cpu); sleep 2; snap2=$(read_cpu)

    idle1=${snap1% *}; total1=${snap1#* }
    idle2=${snap2% *}; total2=${snap2#* }
    dt=$(( total2 - total1 ))
    di=$(( idle2  - idle1  ))
    cpu=$(( dt > 0 ? (dt - di) * 100 / dt : 0 ))

    mem_total=$(awk '/MemTotal:/    {print $2}' /proc/meminfo)
    mem_avail=$(awk '/MemAvailable:/{print $2}' /proc/meminfo)
    used_kb=$(( mem_total - mem_avail ))
    used_g=$(( used_kb / 1024 / 1024 ))
    used_d=$(( (used_kb / 1024 * 10 / 1024) % 10 ))
    tot_g=$(( mem_total / 1024 / 1024 ))
    tot_d=$(( (mem_total / 1024 * 10 / 1024) % 10 ))
    mem_pct=$(( used_kb * 100 / mem_total ))
    load=$(awk '{print $1}' /proc/loadavg)

    printf '{"text":"","tooltip":"CPU: %d%%  Load: %s\\nRAM: %d.%dG / %d.%dG  (%d%%)"}\n' \
        "$cpu" "$load" "$used_g" "$used_d" "$tot_g" "$tot_d" "$mem_pct"
done

#!/system/bin/sh
# Mock script to trick Android 13 into thinking eBPF loaded perfectly
setprop bpf.progs_loaded 1
setprop ro.bpf.progs_loaded 1
exit 0

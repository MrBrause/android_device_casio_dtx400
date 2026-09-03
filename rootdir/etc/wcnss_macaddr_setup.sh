#!/vendor/bin/sh
# Provision the real per-device WLAN MAC into the wcnss platform driver's
# sysfs node, BEFORE wlan.ko loads. prima's hdd_wlan_startup() reads this
# node once at module init; without it, sources 2 (NV) and 3 fall through to
# hdd_generate_iface_mac_addr_auto() which invents a 00:0a:f5 address.
# Ref: sailfish-on-karatep prima commit 9c05f56 (same driver).
node=/sys/devices/soc/a000000.qcom,wcnss-wlan/wcnss_mac_addr
src=/oempersist/data/param/macaddr

[ -w "$node" ] || { log -t wcnss_macaddr "node not writable"; exit 0; }
[ -r "$src" ]  || { log -t wcnss_macaddr "$src not readable"; exit 0; }

# Only provision if the node is empty/zero — never clobber an existing value.
case "$(cat "$node" 2>/dev/null)" in
    00:00:00:00:00:00|"") ;;
    *) log -t wcnss_macaddr "already set, leaving it"; exit 0 ;;
esac

mac=$(cat "$src")
# Validate it looks like a MAC (xx:xx:xx:xx:xx:xx) before writing.
case "$mac" in
    [0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]) ;;
    *) log -t wcnss_macaddr "bad mac '$mac'"; exit 0 ;;
esac

echo "$mac" > "$node"   # echo appends newline -> 18 chars, as store() requires
log -t wcnss_macaddr "wcnss_mac_addr <- $mac"

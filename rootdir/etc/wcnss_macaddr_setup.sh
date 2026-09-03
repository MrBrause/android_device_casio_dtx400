#!/vendor/bin/sh
# Provision the per-device MAC addresses for the WCNSS combo radio (WCN3660B),
# from the Casio factory files in /oempersist/data/param/, before the WiFi and
# BT stacks read them:
#   - WLAN: macaddr -> /sys/.../wcnss_mac_addr  (prima reads at module init)
#   - BT:   btaddr  -> persist.service.bdroid.bdaddr  (BlueDroid reads at stack init)
# Provision the real per-device WLAN MAC into the wcnss platform driver's
# sysfs node, BEFORE wlan.ko loads. prima's hdd_wlan_startup() reads this
# node once at module init; without it, sources 2 (NV) and 3 fall through to
# hdd_generate_iface_mac_addr_auto() which invents a 00:0a:f5 address.
# Ref: sailfish-on-karatep prima commit 9c05f56 (same driver).

# --- WLAN ---
node=/sys/devices/soc/a000000.qcom,wcnss-wlan/wcnss_mac_addr
wsrc=/oempersist/data/param/macaddr
if [ -w "$node" ] && [ -r "$wsrc" ]; then
    case "$(cat "$node" 2>/dev/null)" in
        00:00:00:00:00:00|"")
            wmac=$(cat "$wsrc")
            case "$wmac" in
                [0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F])
                    echo "$wmac" > "$node"   # echo appends newline -> 18 chars, as store() requires
                    log -t wcnss_macaddr "wcnss_mac_addr <- $wmac" ;;
                *) log -t wcnss_macaddr "bad wlan mac '$wmac'" ;;
            esac ;;
        *) log -t wcnss_macaddr "wlan node already set, leaving it" ;;
    esac
else
    log -t wcnss_macaddr "wlan node/src not accessible"
fi

# --- BT ---
bsrc=/oempersist/data/param/btaddr
if [ -r "$bsrc" ]; then
    raw=$(cat "$bsrc")   # bare hex, e.g. 002406f90e17 (already display order, NO reversal)
    case "$raw" in
        [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])
            bmac=$(echo "$raw" | sed 's/\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)/\1:\2:\3:\4:\5:\6/')
            setprop persist.service.bdroid.bdaddr "$bmac"
            log -t wcnss_macaddr "bdroid.bdaddr <- $bmac" ;;
        *) log -t wcnss_macaddr "bad btaddr '$raw'" ;;
    esac
else
    log -t wcnss_macaddr "btaddr not readable"
fi

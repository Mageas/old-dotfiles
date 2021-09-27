#!/bin/sh

_auto_detect_ethernet="$(nmcli c show --active | grep ethernet | awk '{print $NF}')"
INTERFACE=${_auto_detect_ethernet:-enp1s0}

INTERVAL=10

test_interface=$(ip addr show | grep ${INTERFACE})
[ "${test_interface}" = "" ] && echo "[ Unknow]" && exit 1

print_bytes() {
    if [ "${1}" -eq 0 ] || [ "${1}" -lt 1000 ]; then
        bytes="0kB"
    elif [ "${1}" -lt 1000000 ]; then
        bytes="$(echo "scale=0;${1}/1000" | bc -l )kB"
    else
        bytes="$(echo "scale=1;${1}/1000000" | bc -l )MB"
    fi

    echo "${bytes}"
}

ORX="$(cat /sys/class/net/"${INTERFACE}"/statistics/rx_bytes)"
OTX="$(cat /sys/class/net/"${INTERFACE}"/statistics/tx_bytes)"

sleep 0.1s
down=0
up=0

NRX="$(cat /sys/class/net/"${INTERFACE}"/statistics/rx_bytes)"
NTX="$(cat /sys/class/net/"${INTERFACE}"/statistics/tx_bytes)"

bytes_down=$(((( ${NRX} - ${ORX} )) * ${INTERVAL} ))
bytes_up=$(((( ${NTX} - ${OTX} )) * ${INTERVAL} ))

down=$(( ${down} + ${bytes_down} ))
up=$(( ${up} + ${bytes_up} ))

echo "[$(print_bytes ${down}) $(print_bytes ${up})]"

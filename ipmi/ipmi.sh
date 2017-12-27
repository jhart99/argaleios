#!/bin/bash
ipmitool -I lanplus -H $1 -U Administrator -f /etc/argaleios/ipmi/ipmi_password "${@:2}"

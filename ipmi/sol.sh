#!/bin/bash
ipmitool -I lanplus -H $1 -U Administrator -f /etc/argaleios/ipmi/ipmi_password sol deactivate
ipmitool -I lanplus -H $1 -U Administrator -f /etc/argaleios/ipmi/ipmi_password sol activate

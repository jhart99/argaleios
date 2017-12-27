#!/bin/bash
ipmitool -I lanplus -H $1 -U Administrator -f /etc/argaleios/ipmi/ipmi_password chassis bootdev pxe
ipmitool -I lanplus -H $1 -U Administrator -f /etc/argaleios/ipmi/ipmi_password power reset
ipmitool -I lanplus -H $1 -U Administrator -f /etc/argaleios/ipmi/ipmi_password power on

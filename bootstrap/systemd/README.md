# Systemd
To link these units into systemd do the following
1. Link the service units
'''
ln -s system/* /etc/systemd/system
'''
1. Link the network units
'''
ln -s network/* /etc/systemd/network
'''
1. Reload the systemd daemon
'''
systemctl daemon-reload
'''
1. Finally launch all the units

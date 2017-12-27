# Bootstrap services

These services are needed to transform the bare metal servers into a
functioning Kubernetes cluster.

During the boot process, these services will provide the ip addresses,
TFTP server for PXE, http servers for iPXE booting and cloud config
production.  After booting, there are further services which support
the early stages of the cluster including DNS, NTP and cryptographic
key signing.

All of the services are given as systemd modules to facilitate
deployment on the bootstrap server.

To bootstrap the cluster:
1. Copy the hierarchy to /etc/argaleios.
1. Create all the keys for the CFSSL servers.
1. Link the the public keys for the CAs to
   /etc/argaleios/bootstrap/matchbox/assets/tls so that the servers
   can download them.
1. Link the systemd units and start the services and networks. Add
   symbolic links for each unit to the systemd services and network
   units under /etc/systemd to get all the services up and running.

After that just reimage all the machines by setting them to boot up
using PXE.

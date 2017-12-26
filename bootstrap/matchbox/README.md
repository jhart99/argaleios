# Matchbox
Matchbox gives us a way of generating cloud-config files for each
machine as needed.  Matchbox uses a variety of different config files
to do its job. These files will cause the machines to boot up first in
install-reboot mode.  In this part the machine will install CoreOS
Container OS onto the nodes.  In the second round, the machines will
request a cloud-config with with the os=installed flag which will give
the machine specific configuration.  If the machines have a definition
in the groups directory, they will get special metadata set and
profile.  There are 2 types of special machines currently: controller
nodes which will run etcd and kubernetes core services and ingress
nodes which will be assigned a public IP address.  Everything else
will get the gateway profile as a default.

Groups: define the metadata and selectors

Profiles: define the iPXE script that the nodes will receieve

Ignition: define the cloud config templates that will be filled in with the metadata from the groups

Assets: the assets directory contains some basic materials needed to boot the machines including ipxe scripts, CoreOS releases, kubeconfigs, and tls assets like ca.pem.

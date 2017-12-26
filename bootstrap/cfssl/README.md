# CFSSL
In this directory are the parts needed to generate PKI resources.

To generate everything to bootstrap the cluster you need to do the following steps.

## Generate the root Certificate Authority
1. Look at the root-ca.json and root-ca-config.json and edit them as needed.
2. Use CFSSL to generate the public and private key pair.
'''
cfssl gencert -initca root_ca.json | cfssljson -bare root_ca
'''
3. (optional) Have a look at what you generated
'''
openssl x509 -in root_ca.pem -text
'''

## Generate some intermediate CAs
It is a bad idea for etcd and kubernetes to share trust of each
other's certificates because if you can get into etcd you could change
the state of the cluster directly or read any part of the current
state.  Essentially etcd certificates are admin users in kubernetes.
Because of this etcd certificates are kept seperate.
'''
cfssl gencert -ca=root-ca.pem -ca-key=root-ca-key.pem \
    -config=root_ca-config.json -profile=signing \
	etcd-ca.json | cfssljson -bare etcd-ca

cfssl gencert -ca=root-ca.pem -ca-key=root-ca-key.pem \
    -config=root_ca-config.json -profile=signing \
	k8s-ca.json | cfssljson -bare k8s-ca
'''

## Generate the admin kubernetes Certificate
This certificate will be used to authenticate an administrator with
the cluster for kubectl. The important part of this configuration is that the admin user has a "O" of "system:masters" which will allow it to do anything in kubernetes.

'''
cfssl gencert -ca=k8s-ca.pem -ca-key=k8s-ca-key.pem \
	-config=ca-config.json -profile=peer \
	admin.json | cfssljson -bare admin
'''

## Kubernetes Node certificates
In a departure from the kubernetes-the-hard-way, I think a better way
is for the nodes to generate their own private keys and then have
these signed by the k8s-ca so that the private keys are never sent
across a network.  After the initial provisioning the k8s-ca can be
brought down until a new node needs to be provisioned.  An important
part of this is that the nodes get an "CN" of "system:node:{nodename}"
and an "O" of "system:nodes" which will let the kubelet running on the
node talk to the apiserver as the API server admites the nodes using
the Node Authorizer.  The CFSSL server for k8s-ca is in the systemd
unit. The key generation happens in the cloud config.

## ETCD node certificates
The same thing goes along with the ETCD servers and peers.  We need to
generate key pairs and then have them signed by the server so that
servers can talk to each other and peers can talk to the server. The
server is in the systemd unit and key generation pieces are in the
cloud config.

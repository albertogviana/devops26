# Replace `[...]` with the IP of the load balancer created when you installed nginx Ingress`

LB_IP=[...]

# Replace `[...]` with the domain that will be used to access Jenkins X and that is pointing to your LB. 
# If you don't have a domain, use `jenkinx.$LB_IP.nip.io` as the value.`

DOMAIN=[...]

# The command that follows uses `-b` to run in the batch mode and it assumes that this is not the first time you create a cluster with `jx`.
# If that's not the case and this is indeed the first time you're creating a `jx` cluster, it will not have some of the default values like GitHub user and the installation might fail.
# Please remove `-b` from the command if this is NOT the first time you're creating a cluster with `jx`.

jx install \
    --provider kubernetes \
    --external-ip $LB_IP \
    --domain $DOMAIN \
    --default-admin-password=admin \
    --ingress-namespace ingress-nginx \
    --ingress-deployment nginx-ingress-controller \
    --tiller-namespace kube-system \
    --default-environment-prefix jx-rocks \
    -b
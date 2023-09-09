echo "installing network on master node"
kubeadm init --pod-network-cidr=192.168.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

echo "installing calico and applying it to kubectl"
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml


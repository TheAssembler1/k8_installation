echo "setting cgroup driver"
cp /home/vm_test/k8_installation/daemon.json /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
systemctl restart kubelet

echo "initializing kubernetes cluster"
sudo kubeadm init --control-plane-endpoint kube-master:6443 --pod-network-cidr 192.168.150.0/23 --cri-socket=unix:///var/run/cri-dockerd.sock --ignore-preflight-errors=1
echo "installing networking ext on master node"
kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=1 --cri-socket=unix:///var/run/cri-dockerd.sock --ignore-preflight-errors=1
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

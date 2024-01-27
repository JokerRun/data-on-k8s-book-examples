
# === 安装tidb-crd ===
# wget https://raw.githubusercontent.com/pingcap/tidb-operator/v1.5.2/manifests/crd.yaml 01.tidb-crd.yaml
k create -f 01.tidb-crd.yaml
kg crds
k api-resources | grep tidb

# === 安装tidb-operator ===

helm repo add pingcap https://charts.pingcap.org
# helm show values pingcap/tidb-operator  --version v1.5.2 > 02.values.yaml
helm install --create-namespace --namespace tidb-admin tidb-operator pingcap/tidb-operator --version v1.5.2
kubectl get pods

# === 创建tidb集群 ===
# wget https://raw.githubusercontent.com/pingcap/tidb-operator/master/examples/basic/tidb-cluster.yaml \
#    03.basic-example-tidb-cluster.yaml
# 或者: helm show values pingcap/tidb-cluster  --version v1.5.2 > 03.values.yaml
kubectl create namespace tidb-cluster 
kubectl -n tidb-cluster  apply -f 03.basic-example-tidb-cluster.yaml

# === monitor ===
# wget https://raw.githubusercontent.com/pingcap/tidb-operator/master/examples/basic/tidb-monitor.yaml \
#  04.basic-example-tidb-monitor.yaml
kubectl -n tidb-cluster  apply -f 04.basic-example-tidb-monitor.yaml
kpf service/basic-grafana 3000:3000 
# http://localhost:3000 default username and password admin.




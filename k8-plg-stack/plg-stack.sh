#Install the PLG Stack with Helm

#Create a Kubernetes namespace to deploy the PLG Stack to:
kubectl create namespace plg-stack

#Add Loki’s Helm Chart repository:
helm repo add plg https://grafana.github.io/helm-charts

#Run the following command to update the repository:
helm repo update

#Deploy the Loki stack:
helm upgrade --install loki plg/loki-stack --namespace=plg-stack --set grafana.enabled=true
#This will install Loki, Grafana and Promtail into your Kubernetes cluster.


# helm install loki-grafana plg/grafana --namespace=plg-stack

#As "grafana.enable=true" it looks for admin-user, admin-password key in loki-grafana secret which is not set by default.
#Once all service is up, we can see loki-grafana will fail with above error
#Manually edit the loki-grafana secert and add 'admin-user: <username>' and 'admin-password: <password>' in data section.

#Retrieve the password to log into Grafana:
kubectl get secret loki-grafana --namespace=plg-stack -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

#HANDLED BY k8 ingress-nginx
# #Finally, execute the command below to access the Grafana UI.
# kubectl port-forward --namespace loki service/loki-grafana 3000:80


#GRAFANA UI
#add data source Loki : http://loki:3100
#add data source pormetheus : http://loki-prometheus-server:80
#Import Dashboard: 15141

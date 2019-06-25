# create virtual machines using azure

#create a resource group to be used
az group create --name myresource --location uksouth

#create a virtual network and attach adress prefixes and a subnet
az network vnet create --resource-group myresource --name myvirtualnetwork --address-prefixes 10.0.0.0/16 --subnet-name mysubnet --subnet-prefix 10.0.0.0/24

#create a network security group to manage port access to the virtual machine
az network nsg create --resource-group myresource --name mynetworksecuritygroup

#add rules to specify which ports are open
az network nsg rule create --resource-group myresource --name SSH --priority 300 --nsg-name mynetworksecuritygroup --destination-port-ranges 22

#create a public ip to access your virtual machine
az network public-ip create --resource-group myresource --name mypublicip --dns-name ferdinand1234

#create the network interface card and attach the security group and public ip
az network nic create --resource-group myresource --name mynetworkinterface --vnet-name myvirtualnetwork --subnet mysubnet --network-security-group mynetworksecuritygroup --public-ip-address mypublicip


#create a vm by attaching the network interface card and specifying a username and password along with the type of machine to make
vm create --resource-group myresource --name jenkins-Server --image UbuntuLTS --nics mynetworkinterface --admin-username "ferdinand" --size Standard_F1



vms="jenkins jenkins-build python"

for vm in ${vms}; do

	vm create --resource-group myresource --name $vm --image UbuntuLTS --nics mynetworkinterface --admin-username "ferdinand" --size Standard_F1
done


az login

ssh-keygen -f devops_admin 

chmod 600 devops_admin

chown vimalesh:vimalesh devops_admin

change subscriptions and resource group , region

az group show --name 1-70a46fec-playground-sandbox --query id --output tsv

/subscriptions/0cfe2870-d256-4119-b0a3-16293ac11bdc/resourceGroups/1-70a46fec-playground-sandbox

terraform import azurerm_resource_group.my_rg /subscriptions/2213e8b1-dbc7-4d54-8aff-b5e315df5e5b/resourceGroups/1-a8b27dc1-playground-sandbox
terraform import azurerm_network_security_group.agent_security_group /subscriptions/9734ed68-621d-47ed-babd-269110dbacb1/resourceGroups/1-a6ad5047-playground-sandbox/providers/Microsoft.Network/networkSecurityGroups/devops-agent-security-group
Terraform\modules-practise\

# commnet backup file first 

terraform plan -var-file terraform.admin.tfvars  -out "m2.tfplan"
terraform plan -var-file terraform.agent.tfvars  -out "m2.tfplan"

terraform apply "m4.tfplan"
# uncomment file now

terraform init

# this will store to storage

# create jenkin agent

 terraform destroy -var-file terraform.dev.tfvars  -out "m2.tfplan"



 ssh-keygen -f ssh_globo
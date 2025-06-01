# orbit_interview
### How would you publish your app to be accessible from the internet? What can you use to protect your publicly facing apps?

In my case, I’m using Azure Front Door , which includes integrated L3/L4 DDoS protection and a Web Application Firewall (WAF) that handles L7 protection by blocking attacks and unwanted connections.

### You should provide clear instructions on how to deploy and test your code.

1. Install Terraform
2. Clone the repository from the provided link
3. Navigate to the terraform folder
4. Edit the subscription_id value in the main.tf file – insert the target Azure subscription ID
5. Edit the default value of the resource_group_name variable – insert the target resource group name
6. Edit the default value of the location variable – insert the desired location name
7. Edit the default value of the aks_cluster_name variable – insert the desired AKS cluster name
8. Run az login and select the target subscription
9. Run: terraform init
10. Run: terraform validate to check the configuration syntax
11. Run: terraform plan to preview the changes
12. Run: terraform apply and confirm by typing yes
13. If you want to delete the created resources, run: terraform destroy and confirm by typing yes
# Terrafrom learning

## Intro to Terraform

## What is Terraform? What is it used for?

* Orchestration tool
* Best for infrastructure provisioning
* Originally inspired by AWS CloudFormation
* See infrastructure as immutable (cannot be changed after its set) -> will need to reassign value if needed. Correct terminolgy is disposable.
  * Compare this to CM tools which usually see infrastructure as mutable/reusable.
* Code in Hashicorp Configuration Language (HCL) 
  * Aims to give a balance between human and machine readability.
  * HCL can be converted to JSON and vice vera

## Why use Terraform? The benefits?

* Easy to use
* Sort-of open-source. Something to do with Licence issues so many people have left it and went on to use something else.
  * Since 2023, uses Business Source License (BSL)
  * Some organisations are now moving onto using OpenTofu (an open-source drop-in).
* Declarative
    * About the destination and not the journey (Explain what you want and it will figure out the rest).
* Cloud-agnostic - can use different cloud providers
  * To support a cloud provider, you need to first download the "provider" (plug-in) for that cloud provider.
  * Each cloud vendor maintains its own "provider".
  * Expressive and extendible. Can download your own custom cloud provider if need be.

## Alternative to Terraform

* Pulimi - not declarative.
* AWS CloudFormation, GCP Deployment Manager, Azure Resource Manager (using ARM templates).
  * Cloud-specific products 

## Who is using Terraform in the industry?
1. Tech Companies and Startups:
Uber, Spotify, Airbnb, Coinbase
2. Financial Institutions (regulated industry):
JPMorgan Chase, Goldman Sachs, Capital One
3. Cloud Providers and SaaS Platforms:
AWS, Google Cloud, Salesforce
4. Media and Entertainment:
The New York Times, Netflix
5. Healthcare (regulated industry) and Life Sciences:
Philips, Cerner
6. Telecommunications:
Verizon, T-Mobile
7. Retail and E-Commerce:
Walmart, Target
8. Gaming Industry:
Electronic Arts (EA), Riot Games (they make/run League of Legends)
9. Government and Public Sector:
UK Government Digital Service (GDS), NASA
10. Consulting and Cloud Services:
Accenture, Deloitte
11. Education and Research Institutions:
Harvard University, MIT
 
## In IaC, what is orchestration? How does Terraform act as "orchestrator"?

* Process of automating and managing the entire lifecycle of infrastructure resource.
* Takes care of order in which to create/modify/destroy.

## Best practice supplying AWS credentials to Terraform

Look for credentials in this order:

1. Environment variables: AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY (okay for local use and if restricted to your user).
2. Terraform variables - should never do this because we NEVER hard-code credentials.
3. AWS CLI when you run `aws config`. (good way to do it)
4. If we use Terraform, we install it on an EC2 instance, we can then give it an IAM role. We can then give it permissions to do certain things. -> This is the best way to do it. 

How should AWS credentials never passed to Terraform?
* NEVER hard-code them - and they can never end up on a public Git Repo.

## Why use Terraform for different environments (e.g. production, testing, etc)

Examples:
* Testing env
  * Easily/quickly spin up infrastructure for testing purposes that mirror production, easily/quickly bring it down at COB.
  * Consistency between environments, reducing bugs caused by environment disrepancies.
  * Non-distraught.

## How Terraform works
* We have installed Terraform in our local machine (laptop).
* On our local machine, we have installed terraform where we have a Terraform folder.
* In our Terraform folder, we have:
  * main.tf - store code
  * variable.tf - store code
  *  terraform.lock.hcl
  *  terraform.tfstate - could have credentials
  *  terraform.tfstate.backup - could have credentials
  *  terraform folder - stores provider files
* Commands:
  * terraform init: sets up backend, and saves the state files in AWS S3 if needed. 
  * terraform plan: non-destructive. Shows the console the plan before running the code.
  * terraform destroy: destructive. Destroys/terminates the code.
  * terraform apply: destructive. Applies the changes made and runs the code if changes are made.
* The apply/destroy command can be done on AWS, Azure, GCP, while using the provider file and going through the APIs. Other tools will also go through APIs.
* AWS Console will also go through APIs.

## What is a configuration drift?
* If you change a software, then the config file is going to be responsible to it.
* However, a software that would be used to fix the config file back will all the required configurations would the Configuration Management tools (like Ansible).
* If someone accidentally renames instance, then orchestration tools would be applied here.


Before committing, make sure that the variables.tf file is hidden since that it has the credentias.
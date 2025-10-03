# AWS Immutable Infrastructure Makefile

.PHONY: help build-ami deploy-infra destroy-infra plan validate clean

# Default target
help:
	@echo "Available targets:"
	@echo "  build-ami        - Build AMI with Packer"
	@echo "  deploy-infra     - Deploy infrastructure with Terraform"
	@echo "  destroy-infra    - Destroy infrastructure"
	@echo "  plan            - Show Terraform plan"
	@echo "  validate        - Validate Terraform and Packer configs"
	@echo "  clean           - Clean up temporary files"
	@echo "  help            - Show this help message"

# Build AMI with Packer
build-ami:
	@echo "Building AMI with Packer..."
	cd packer && packer validate nginx.json
	cd packer && packer build nginx.json

# Deploy infrastructure
deploy-infra:
	@echo "Deploying infrastructure..."
	cd terraform && terraform init
	cd terraform && terraform plan
	cd terraform && terraform apply -auto-approve

# Destroy infrastructure
destroy-infra:
	@echo "Destroying infrastructure..."
	cd terraform && terraform destroy -auto-approve

# Show Terraform plan
plan:
	@echo "Creating Terraform plan..."
	cd terraform && terraform init
	cd terraform && terraform plan

# Validate configurations
validate:
	@echo "Validating Packer template..."
	cd packer && packer validate nginx.json
	@echo "Validating Terraform configuration..."
	cd terraform && terraform init
	cd terraform && terraform validate
	@echo "Formatting Terraform files..."
	cd terraform && terraform fmt -check

# Clean up temporary files
clean:
	@echo "Cleaning up temporary files..."
	rm -rf terraform/.terraform
	rm -rf terraform/.terraform.lock.hcl
	rm -rf terraform/terraform.tfstate*
	rm -rf terraform/terraform.tfplan
	rm -rf packer/packer_cache

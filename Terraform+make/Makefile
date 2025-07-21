RED = ${shell tput -Txterm setab 1 && tput -Txterm setaf 0}
GREN = ${shell tput -Txterm setab 2 && tput -Txterm setaf 0}
PURPLE = ${shell tput -Txterm setab 5 && tput -Txterm setaf 7}
RESET = ${shell tput -Txterm sgr0}

terraform_init:
	@echo ""
	@echo "${PURPLE} Terraform Init ${PURPLE}"
	@terraform init

terraform_plan: terraform_init
	@echo ""
	@echo "${PURPLE} Terraform Plan ${PURPLE}"
	@terraform plan

terraform_apply: terraform_plan
	@echo ""
	@terraform apply

terraform_destroy:
	@echo ""
	@terraform destroy

terraform: terraform_apply

# Get what variables we can from terraform
GET_TF_VAR = cd terraform/production && terraform output
PROJECT_ID = $(shell $(GET_TF_VAR) project_id)
PROJECT_ZONE = $(shell $(GET_TF_VAR) project_zone)
CONSUL_JOIN_IPS = $(shell $(GET_TF_VAR) consul_instance_in_ips)

ANSIBLE_HEADER = cd ansible
PLAYBOOK = ansible-playbook -i inventories/gce.py -u hashiconf-demo
ANSIBLE_VARS = 'consul_join_ip="$(CONSUL_JOIN_IPS)"'

create: scaffold-production configure-consul configure-memcache

destroy:
	cd terraform/production && terraform get && terraform destroy -force

scaffold-production:
	cd terraform/production && terraform get && terraform apply && sleep 20

configure-consul:
	$(ANSIBLE_HEADER) && $(PLAYBOOK) -e $(ANSIBLE_VARS) -e 'consul_server_count=3' consul-configure.yml

configure-memcache:
	$(ANSIBLE_HEADER) && $(PLAYBOOK) -e $(ANSIBLE_VARS) memcache-configure.yml

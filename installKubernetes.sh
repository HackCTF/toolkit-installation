#!/bin/bash

cd ~
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
python -m pip install -r requirements.txt
ansible-playbook -i /inventory/inventory.ini cluster.yml -vvvv
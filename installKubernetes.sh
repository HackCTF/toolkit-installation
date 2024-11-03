#!/bin/bash

cd ~
git clone https://github.com/HackCTF/kubespray
cd kubespray
python -m pip install -r requirements.txt
ansible-playbook -i ./inventory/sample/inventory.ini cluster.yml -vvvv

# Role Name

A brief description of the role goes here.

## Requirements

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

## Role Variables

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

## Dependencies

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

## License

BSD

## Author Information

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

# Ansible Role: common

An Ansible role that manages aedar basic configuration settings on Ubuntu based systems.
https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html
git://bitbucket.org/witconsult/aedar-semaphore.git

t2todL:

- name: Set hostname
  ansible.builtin.hostname:
  name: "{{ common_hostname }}"
  when: common_hostname is not none

  - name: "Ping hosts"
    action: ping

## Supported OS

- Ubuntu

## Role Variables

## Dependencies

## Preparations

### ansible configuration

/etc/ansible/ansible.cfg
depreciation_warnings: False
remote_tmp = ~/.ansible/tmp
local_tmp = ~/.ansible/tmp

### copy ssh key (from main)

### copy ssh id

potentially create root password and allow ssh login as root:

`sudo passwd root sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config sudo systemctl restart ssh`

`ssh-copy-id -i ./.ssh/id_rsa.pub user@server`

### install python & ansible

````sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get install -y python3.8 python3-pip virtualenv

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y```
````

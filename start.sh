#!/bin/bash

cd /tmp/inacademia/hinting

# download eduGAN metadata to input dir
echo "Downloading eduGAIN metadata"
/usr/bin/wget http://mds.edugain.org/ -q  -O input/edugain.xml
echo "Downloading eduGAIN metadata done"

# pul the latest version of idp_hint data from the git repo
cd output/idp_hint

GIT_SSH_COMMAND='ssh -i /home/ubuntu/.ssh/id_rsa_inacademia' /usr/bin/git pull

# parse the eduGAIN xml, this produces data in the output dir, potentially overwriting data in output/idp_hint
cd ../..
/usr/bin/python parse.py

# comit and push the updated data to git repo.
cd output/idp_hint
GIT_SSH_COMMAND='ssh -i /home/ubuntu/.ssh/id_rsa_inacademia' /usr/bin/git add --all
GIT_SSH_COMMAND='ssh -i /home/ubuntu/.ssh/id_rsa_inacademia' /usr/bin/git commit -am "Updated entities $(date +'%F %T')"
GIT_SSH_COMMAND='ssh -oStrictHostKeyChecking=no -i /home/ubuntu/.ssh/id_rsa_inacademia' /usr/bin/git push origin-ssh

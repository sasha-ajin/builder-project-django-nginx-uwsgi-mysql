#!/bin/bash
project_path=`pwd`
project_name=""
env_name=""

# Inputting
read -p "Project name: " project_name
read -p "Environment name: " env_name
read -p "Domain name(dev.source.com): " project_domain

# Setting up virtual environment 
python3 -m venv $env_name
echo "environment was created"
source $env_name/bin/activate
pip install -r requirements.txt
echo "requirements was installed"

# Django project create
django-admin startproject $project_name  $project_path
echo "django project was created"

# Django project assemble
echo 'import os' >> $project_name/settings.py
echo 'STATIC_ROOT = os.path.join(BASE_DIR, "static/") ' >> $project_name/settings.py
mkdir templates
python3 manage.py collectstatic
cur_path=${PWD%/*}
mv $project_path $cur_path/$project_name
project_path=`pwd`
echo "django project was assembled"

# Changing config files for web servers
sed -i "" "s~projectpath~$project_path~g" $project_path/deploy/nginx/myapp.conf
sed -i "" "s~projectpath~$project_path~g" $project_path/deploy/uWSGI/myapp.ini 
sed -i "" "s~projectname~$project_name~g" $project_path/deploy/uWSGI/myapp.ini 

# Configuring Nginx
rm -r /usr/local/etc/nginx/sites-enabled/*
sudo ln -s $project_path/deploy/nginx/myapp.conf /usr/local/etc/nginx/sites-enabled/
sudo chmod -R ugo+rwx $project_path/ 
sudo chmod +rwx ~/Desktop/

# Running project up
sudo nginx -s reload 
uwsgi --ini deploy/uWSGI/myapp.ini

# Clearing the project
rm collect_mac.sh

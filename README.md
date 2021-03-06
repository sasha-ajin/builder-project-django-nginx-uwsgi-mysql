# What is it?

Creating a lot of Django projects,I noticed, that creating Nginx, connecting uWSGI web-server, virtual environment setting and other typical doings for assembly the django-project are so similar and easy-automated.That was motivation to create bash-script, which is going to build empty django project in a few seconds with 2 commands in terminal

# Installation

Before installation you should have python installed on your machine, which should be available on **python3** command in bash,and **nginx** server,which you should start before installation.Make sure you have the same path to **nginx** folder as in **build.sh**

Firstly clone this repo
```
git clone https://github.com/sasha-ajin/clean-project-django-nginx-uwsgi-mysql.git
```

After that with super-user permission start **build.sh** 
```
sudo sh build.sh 
```

Go to http://127.0.0.1/

# What does the project include?

## Explanation
Installation of base requirements to **virtual environment**, creating **Nginx** and **uWSGI** web servers, Nginx store static files, **uWSGI** store dynamic files, starting program locally

## Structure
```
├── servers                   
│   ├── nginx        
│   │   └── myapp.conf         
│   └── uWSGI
|       └── myapp.ini
├── <virtual environment>
├── <project name>   
│    ├── asgi.py
│    ├── settings.py
│    ├── urls.py
│    └── wsgi.py
├── static
│   └── ....
├── templates
├── .gitignore
└── manage.py
```


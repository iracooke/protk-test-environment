# Uncomment this and set it to your proxy address if needed
#http_proxy=http://proxy.latrobe.edu.au:8080

# Either galaxy-dist (stable) or galaxy-central
# 
galaxy_branch='galaxy-dist'

# Replace with your email address
# Use this email address when registering as a user in the galaxy interface
admin_email='iracooke@gmail.com'


if [[ -n $http_proxy ]]; then

	sudo touch /etc/apt/apt.conf
	sudo chmod o+w /etc/apt/apt.conf
	sudo echo "Acquire::http::Proxy \"$http_proxy\";" > /etc/apt/apt.conf
	sudo chmod o-w /etc/apt/apt.conf

	export http_proxy
	export https_proxy=$http_proxy

	sudo echo "export http_proxy=\"$http_proxy\";" > /home/vagrant/.bashrc
	sudo echo "export https_proxy=\"$http_proxy\";" >> /home/vagrant/.bashrc
fi

sudo echo "export _JAVA_OPTIONS='-Xmx1500M';" >> /home/vagrant/.bashrc

sudo apt-get update

# Galaxy base
sudo apt-get install -y build-essential autoconf automake git-core mercurial subversion pkg-config libc6-dev



if [[ ! -f /usr/local/bin/virtualenv ]]; then
	sudo apt-get install -y python-pip
	sudo pip install virtualenv
fi


if [[ ! -f /usr/bin/docker ]]; then
	sudo wget -qO- https://get.docker.com/ | sh
	sudo usermod -aG docker vagrant
fi

if [ ! -d /home/vagrant/galaxy_env ]; then
	su vagrant -c "virtualenv --no-site-packages galaxy_env"
	su vagrant -c "echo '. ~/galaxy_env/bin/activate' >> ~/.bashrc"
fi

if [ ! -d /home/vagrant/$galaxy_branch ]; then
	if [ -d /vagrant/$galaxy_branch ]; then
		su vagrant -c "cp -r /vagrant/$galaxy_branch ./"
	else
		su vagrant -c "hg clone https://bitbucket.org/galaxy/$galaxy_branch#stable"
		su vagrant -c "cd $galaxy_branch;hg update stable"
	fi
fi

if [ ! -f /home/vagrant/$galaxy_branch/config/galaxy.ini ]; then
	cd /home/vagrant/$galaxy_branch/config/
	su vagrant -c "cp galaxy.ini.sample galaxy.ini"
	sed -i.bak s/'#host = 127.0.0.1'/'host = 0.0.0.0'/ galaxy.ini
	sed -i.bak s%'#tool_dependency_dir = None'%'tool_dependency_dir = ../tool_dependencies'% galaxy.ini
	sed -i.bak s%'#tool_config_file = tool_conf.xml,shed_tool_conf.xml'%'tool_config_file = tool_conf.xml,shed_tool_conf.xml'% galaxy.ini
	admin_users_string="admin_users = "$admin_email
	sed -i.bak "s%#admin_users = None%$admin_users_string%" galaxy.ini
fi

if [[ ! -f /home/vagrant/$galaxy_branch/config/job_conf.xml ]]; then
	cp /vagrant/job_conf.xml /home/vagrant/$galaxy_branch/config/job_conf.xml
	sudo chown vagrant ~/galaxy-dist/config/job_conf.xml
	sudo chgrp vagrant ~/galaxy-dist/config/job_conf.xml	
fi



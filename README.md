#Protk Test Environment

A Vagrantfile and bootstrap script for setting up a clean VM for testing galaxy tools

Clone the repo and startup the VM

```bash
	vagrant up
	vagrant ssh
```

Check out the protk tools

```bash
	git clone https://github.com/iracooke/protk-galaxytools.git
```

Run a test using planemo (with docker for protk dependencies)

```bash
	pip install planemo
	planemo test --install_galaxy --job_config_file /vagrant/job_conf.xml protk-galaxytools/xtandem/
```

Or if you installed galaxy

```bash
	planemo test --galaxy_root /home/vagrant/galaxy-dist --job_config_file /vagrant/job_conf.xml protk-galaxytools/xtandem/	
```
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

Install planemo

```bash
	pip install planemo
	cp /vagrant/.planemo.yml ~/
```

Run a test using planemo (with docker for protk dependencies)

```bash
	planemo test --install_galaxy --job_config_file /vagrant/job_conf.xml protk-galaxytools/xtandem/
```

Or if you installed galaxy

```bash
	planemo test --job_config_file /vagrant/job_conf.xml protk-galaxytools/xtandem/	
```

And if you want to test tools with dependencies. First install them manually. Then source their env.sh files.
For example, for peptideshaker

```bash
	
```
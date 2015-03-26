#Protk Test Environment

A Vagrantfile and bootstrap script for setting up a clean VM for testing galaxy tools

Clone the repo and startup the VM

```bash
	vagrant up
	vagrant ssh
```

Check out the protk tools

```bash
	git clone git@github.com:iracooke/protk-galaxytools.git
```

Run a test using planemo

```bash
	planemo test --install_galaxy --job_config_file job_conf.xml protk-galaxytools/xtandem/
```
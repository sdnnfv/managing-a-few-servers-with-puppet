# Managing a few Servers with Puppet

Check out my blog post about this: http://crafted.ch/blog/managing-a-few-servers-with-puppet.

This lets you easily manage a few servers with Puppet centrally from your computer.

It uses the [supply_drop][supply-drop] Gem, so credits to them!


## Prerequisites

**Use this at your own risk!**

- A working Ruby installation (tested with Ruby > 2, 1.9.3 should do too)
- SSH access with a key to your servers

## Quick Start

1. Clone or fork this repo and run `bundle install`
2. Add your server configurations to `nodes/`
3. Bootstrap a server

  ```bash
  # This installs a recent version of Puppet on the server
  cap example.org puppet:bootstrap:puppetlabs:ubuntu
  ```

4. Apply configuration to a server

  ```bash
  cap example.org puppet:apply
  ```

  If you want to see what would change instead of directly applying it, you can use the `noop`-Mode:

  ```bash
  # Shows what would change, but doesn't do anything
  cap example.org puppet:noop
  ```

## How To

- Put your server configurations into `nodes/`. The naming scheme is `<SSH user>@<hostname>.pp`
- Put your own Puppet modules into `custom-modules`
- This uses `librarian-puppet`, put your dependencies into the `Puppetfile`
- Libraries from the Puppetfile are automatically installed when you run `cap <server> puppet:apply`
- You can use the example config in `nodes/admin@example.org.pp` as a starting point

## Vagrant

You can test your configurations in a local Vagrant VM.
There is an example configuration in `nodes/admin@example.org.pp`. You can use it as is and set up a local VM with it.

### Before you start

1. Make sure you got an entry in your `/etc/hosts` for test.local with the IP address of the Vagrant VM (defined in `Vagrantfile`):

  ```
  10.10.10.174    test.local
  ```

2. Make sure you have the Vagrant "Inscure Private Key". Download it from [here][vagrant-key] and put it into `~/.ssh/`. Then, add the following to your `~/.ssh/config`

  ```
  Host test.local
    IdentityFile ~/.ssh/vagrant
  ```

This will allow SSHing (in addition to `vagrant ssh`) into Vagrant VMs without using a password.


[supply-drop]: https://github.com/pitluga/supply_drop
[vagrant-key]: https://github.com/mitchellh/vagrant/blob/master/keys/vagrant


### Setting up the Vagrant VM

Boot up the VM:

```
vagrant up
```

Now you should be able to SSH to it with `ssh admin@test.local`.

### Bootstrap

Bootstrap Puppet:
```
cap example.org-test puppet:bootstrap:puppetlabs:ubuntu
```

Appending `-test` to the host always results in using the Vagrant VM `test.local`.

### Run Puppet:

Apply the configuration under `nodes/admin@example.org.pp`:

```
cap example.org-test puppet:apply
```

Done!


## Questions & Feedback

If you have any questions, feedback or know a better solution, open an issue in this repository.

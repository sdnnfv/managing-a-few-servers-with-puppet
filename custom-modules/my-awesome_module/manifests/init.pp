class awesome_module {
  ################# APT #################
  include apt

  class { 'apt::unattended_upgrades':
    mail_to             => "user@example.org",
    mail_only_on_error  => false,
  }

  class { '::postfix::server':
    inet_interfaces => '127.0.0.1',
  }

  ################# FIREWALL #################
  include ufw

  ufw::allow { "allow-ssh-from-all":
    port => 22,
  }


  ################# SSH #################
  ssh_authorized_key {
    'example@MacBookAir.local':
      ensure   => present,
      # This is the public "insecure vagrant key, never use it in production!"
      key      => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==',
      type     => 'ssh-rsa',
      user     => 'admin';
  }

  class { 'ssh::server':
      storeconfigs_enabled => false,
      options => {
        'PasswordAuthentication' => 'no',
        'PermitRootLogin'        => 'no',
        'Port'                   => [22],
      },
    }

}

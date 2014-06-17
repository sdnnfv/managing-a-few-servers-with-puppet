include awesome_module

# install webserver
ensure_packages(['apache2'])

# allow HTTP
ufw::allow { "allow-http":
  port => 80,
}

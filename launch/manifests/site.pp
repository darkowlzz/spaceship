# Copy id_rsa
file { hiera('keypath'):
  ensure => file,
  source => hiera('filedir'),
  mode   => '0600',
  owner  => hiera('system_user'),
  group  => hiera('system_user'),
} -> # Add ssh config file to disable StrictHostKeyChecking on github
file { hiera('ssh_config_path'):
  ensure => file,
  source => hiera('ssh_config_file'),
  mode   => '0664',
  owner  => hiera('system_user'),
  group  => hiera('system_user'),
} -> # Clone project repo
vcsrepo { hiera('repopath'):
  ensure   => present,
  provider => git,
  source   => hiera('repo'),
  user     => hiera('system_user'),
}

# Create secrets file
file { hiera('secrets_path'):
  ensure  => file,
  content => template(hiera('secrets_template'))
}

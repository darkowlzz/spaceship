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

# Variables to be used in secrets template
$aws_access_key_id = hiera('aws_access_key_id')
$aws_secret_access_key = hiera('aws_secret_access_key')
$aws_region = hiera('aws_region')

# Create secrets file
file { hiera('secrets_path'):
  ensure  => file,
  content => template(hiera('secrets_template'))
}

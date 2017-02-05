ensure_packages(
  ['ntp', 'git', 'unzip', 'htop', 'ncdu'],
  {'ensure' => 'present'}
)

# Install terraform
include '::archive'
archive { '/tmp/terraform.zip':
  ensure       => present,
  extract      => true,
  extract_path => '/usr/local/bin',
  source       => 'https://releases.hashicorp.com/terraform/0.8.5/terraform_0.8.5_linux_amd64.zip',
  user         => 'root',
  group        => 'root'
}

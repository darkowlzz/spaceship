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
  source       => hiera('terraform_download_link'),
  user         => 'root',
  group        => 'root'
}

# Install terragrunt
# Using wget because `file` resource fails to fetch the remote resources with
# url redirections.
include wget
wget::fetch { hiera('terragrunt_download_link'):
  destination => '/usr/local/bin/terragrunt',
} -> # make the file executable
file { '/usr/local/bin/terragrunt':
  mode => '0755'
}

# Terragrunt requires path of terraform in environment variable.
file { '/etc/profile.d/terragrunt.sh':
  ensure  => file,
  content => "export TERRAGRUNT_TFPATH=/usr/local/bin/terraform",
}

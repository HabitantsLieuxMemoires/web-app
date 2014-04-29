node "vagrant.hlm.local" {
  # Packages
  $packages = ['git-core', 'curl', 'xvfb', 'libqtwebkit-dev', 'imagemagick', 'unzip']
  package { $packages:
    ensure => present,
  }

  # User
  account { 'hlm':
    ensure    => present,
    comment   => 'HLM user',
  }

  # RBEnv
  class { 'rbenv': }
  rbenv::plugin { 'sstephenson/ruby-build': }
  rbenv::build { '2.1.1': global => true }

  # Java
  class { 'java': }

  # MongoDB
  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class {'::mongodb::server': }

  mongodb::db { 'hlm_development':
    user      => 'hlm',
    password  => 'hlm',
  }

  # ElasticSearch
  class { 'elasticsearch':
    manage_repo  => true,
    repo_version => '1.0',
    config => {
     'cluster' => {
       'name' => 'Hlm',
    },
    require => Class['java'],
   }
  }

  realize Account['hlm']
}

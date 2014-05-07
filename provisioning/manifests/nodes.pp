node "vagrant.hlm.local" {
  # Packages
  $packages = ['curl', 'xvfb', 'libqtwebkit-dev', 'imagemagick', 'unzip']
  package { $packages:
    ensure => present,
  }

  # Locale
  class { 'locales':
    default_value  => "en_US.UTF-8",
    available      => ["en_US.UTF-8 UTF-8", "en_GB.UTF-8 UTF-8"],
  }

  # RBEnv
  rbenv::install { 'vagrant':
  }
  rbenv::compile { '2.1.1':
    user => 'vagrant',
  }

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
}

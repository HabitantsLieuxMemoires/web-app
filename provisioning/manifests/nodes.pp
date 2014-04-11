node "vagrant.hlm.local" {
  # Packages
  $packages = ['git-core', 'curl', 'xvfb', 'libqtwebkit-dev']
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

  # Bundler
  exec { 'bundle install':
    command   => "/usr/local/rbenv/shims/bundle install",
    cwd       => "/vagrant",
    require   => Class['rbenv'],
  }

  # MongoDB
  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class {'::mongodb::server': }

  mongodb::db { 'hlm_development':
    user      => 'hlm',
    password  => 'hlm',
  }

  #TODO: ElasticSearch

  realize Account['hlm']
}

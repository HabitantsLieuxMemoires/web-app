# Be sure to restart your server when you modify this file.
# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.

# Add images to assets
Rails.application.config.assets.precompile += %w(*.png *.jpg *.gif)

# Add admin assets
Rails.application.config.assets.precompile += ['admin/admin.js', 'admin/admin.css']

# Add css assets
Rails.application.config.assets.precompile += %w( editor.css )

# Add fonts
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w( .svg .eot .woff .ttf )

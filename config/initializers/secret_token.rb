# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Hlm::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '5df6ff095d7aa94abe42b1b468dc18e8d84393bc54632abbcdff2b15f03cfb05f5673a9960f38267b03b8f0f9eda25ded275899dbfee6d483779e445c957c8d5'

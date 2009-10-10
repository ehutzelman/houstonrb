# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_houstonrb_session',
  :secret      => '2054c5537b8480e5cbf97766ba9d5d3d0f85d01f327da747deff77123356ec2a270a4a22b109c55f3607804156de6c2358ea65d6e5f1e3741c8a29794d4ded25'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

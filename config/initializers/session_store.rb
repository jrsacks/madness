# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_madness_session',
  :secret      => '2396a41f4686aa27801b70bdf4925eea33b9225ac54f6b778cf007417505db0bc983b90485c2d5a5271b87a9e5a53fafb831ec5d54b81785a849c14f2c337010'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

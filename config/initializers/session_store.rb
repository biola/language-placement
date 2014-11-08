require 'rack-cas/session_store/rails/mongoid'
LanguagePlacement::Application.config.session_store :rack_cas_mongoid_store, key: '_language_placement_session'
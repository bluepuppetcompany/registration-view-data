require 'eventide/postgres'
require 'view_data/postgres'
require 'settings'
require 'telemetry'

require 'registration/client'

require 'registration_view_data/settings'
require 'registration_view_data/session'

require 'registration_view_data/load'

require 'registration_view_data/data_command/session'
require 'registration_view_data/data_command/insert_email_rejected'
require 'registration_view_data/data_command/insert_registered'

require 'registration_view_data/registration'
require 'registration_view_data/projection'
require 'registration_view_data/store'

require 'registration_view_data/handlers/registration/events'

require 'registration_view_data/consumers/registration/events'

require 'registration_view_data/start'

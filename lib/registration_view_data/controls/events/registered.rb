module RegistrationViewData
  module Controls
    module Events
      module Registered
        def self.example
          registered = RegistrationViewData::Messages::Events::Registered.build

          registered.registration_id = Registration.id
          registered.user_id = User.id
          registered.email_address = Registration.email_address
          registered.time = Controls::Time::Effective.example
          registered.processed_time = Controls::Time::Processed.example

          registered
        end
      end
    end
  end
end

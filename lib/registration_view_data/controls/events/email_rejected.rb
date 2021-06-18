module RegistrationViewData
  module Controls
    module Events
      module EmailRejected
        def self.example
          email_rejected = RegistrationViewData::Messages::Events::EmailRejected.build

          email_rejected.registration_id = Registration.id
          email_rejected.user_id = User.id
          email_rejected.email_address = Registration.email_address
          email_rejected.time = Controls::Time::Effective.example
          email_rejected.processed_time = Controls::Time::Processed.example

          email_rejected
        end
      end
    end
  end
end

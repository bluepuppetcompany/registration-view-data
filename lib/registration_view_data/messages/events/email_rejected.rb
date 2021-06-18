module RegistrationViewData
  module Messages
    module Events
      class EmailRejected
        include Messaging::Message

        attribute :registration_id, String
        attribute :user_id, String
        attribute :email_address, String
        attribute :time, String
        attribute :processed_time, String
      end
    end
  end
end

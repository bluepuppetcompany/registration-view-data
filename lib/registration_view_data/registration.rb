module RegistrationViewData
  class Registration
    include Schema::DataStructure

    attribute :id, String
    attribute :email_rejected_time, Time
    attribute :registered_time, Time

    def email_rejected?
      !email_rejected_time.nil?
    end

    def registered?
      !registered_time.nil?
    end
  end
end

module RegistrationViewData
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :registration

    apply EmailRejected do |email_rejected|
      registration.id = email_rejected.registration_id
      registration.email_rejected_time = Clock.parse(email_rejected.time)
    end

    apply Registered do |registered|
      registration.id = registered.registration_id
      registration.registered_time = Clock.parse(registered.time)
    end
  end
end

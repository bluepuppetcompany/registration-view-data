require_relative '../automated_init'

context "Projection" do
  context "Email Rejected" do
    registration = Controls::Registration::New.example

    assert(registration.email_rejected_time.nil?)

    email_rejected = Controls::Events::EmailRejected.example

    registration_id = email_rejected.registration_id or fail
    email_rejected_time_iso8601 = email_rejected.time or fail

    Projection.(registration, email_rejected)

    test "ID is set" do
      assert(registration.id == registration_id)
    end

    test "Email Rejected time is converted and copied" do
      email_rejected_time = Time.parse(email_rejected_time_iso8601)

      assert(registration.email_rejected_time == email_rejected_time)
    end
  end
end

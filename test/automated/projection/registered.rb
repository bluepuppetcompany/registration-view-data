require_relative '../automated_init'

context "Projection" do
  context "Registered" do
    registration = Controls::Registration::New.example

    assert(registration.registered_time.nil?)

    registered = Controls::Events::Registered.example

    registration_id = registered.registration_id or fail
    registered_time_iso8601 = registered.time or fail

    Projection.(registration, registered)

    test "ID is set" do
      assert(registration.id == registration_id)
    end

    test "Registered time is converted and copied" do
      registered_time = Time.parse(registered_time_iso8601)

      assert(registration.registered_time == registered_time)
    end
  end
end

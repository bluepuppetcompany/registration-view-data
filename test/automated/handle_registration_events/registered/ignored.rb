require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Registered" do
    context "Ignored" do
      handler = Handlers::Registration::Events.new

      registration_registered = Registration::Client::Controls::Events::Registered.example

      registration = Controls::Registration::Registered.example

      handler.store.add(registration.id, registration)

      handler.(registration_registered)

      writer = handler.write

      registered = writer.one_message do |event|
        event.instance_of?(Messages::Events::Registered)
      end

      test "Registered Event is not Written" do
        assert(registered.nil?)
      end
    end
  end
end

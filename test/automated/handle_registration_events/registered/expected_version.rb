require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Registered" do
    context "Expected Version" do
      handler = Handlers::Registration::Events.new

      registration_registered = Registration::Client::Controls::Events::Registered.example

      registration = Controls::Registration.example

      version = Controls::Version.example

      handler.store.add(registration.id, registration, version)

      handler.(registration_registered)

      writer = handler.write

      registered = writer.one_message do |event|
        event.instance_of?(Messages::Events::Registered)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(registered) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end

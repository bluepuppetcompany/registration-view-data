require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Email Rejected" do
    context "Expected Version" do
      handler = Handlers::Registration::Events.new

      registration_email_rejected = Registration::Client::Controls::Events::EmailRejected.example

      registration = Controls::Registration.example

      version = Controls::Version.example

      handler.store.add(registration.id, registration, version)

      handler.(registration_email_rejected)

      writer = handler.write

      email_rejected = writer.one_message do |event|
        event.instance_of?(Messages::Events::EmailRejected)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(email_rejected) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end

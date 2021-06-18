require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Email Rejected" do
    context "Ignored" do
      handler = Handlers::Registration::Events.new

      registration_email_rejected = Registration::Client::Controls::Events::EmailRejected.example

      registration = Controls::Registration::EmailRejected.example

      handler.store.add(registration.id, registration)

      handler.(registration_email_rejected)

      writer = handler.write

      email_rejected = writer.one_message do |event|
        event.instance_of?(Messages::Events::EmailRejected)
      end

      test "Email Rejected Event is not Written" do
        assert(email_rejected.nil?)
      end
    end
  end
end

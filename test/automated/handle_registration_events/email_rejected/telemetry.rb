require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Email Rejected" do
    context "Telemetry" do
      handler = Handlers::Registration::Events.new

      insert_email_rejected = handler.insert_email_rejected

      registration_email_rejected = Registration::Client::Controls::Events::EmailRejected.example

      handler.(registration_email_rejected)

      test "Records inserted_email_rejected signal" do
        sink = insert_email_rejected.sink

        recorded = sink.recorded_once? do |record|
          record.signal == :inserted_email_rejected
        end

        assert(recorded)
      end
    end
  end
end

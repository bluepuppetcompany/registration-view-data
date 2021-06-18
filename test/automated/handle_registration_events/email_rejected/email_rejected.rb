require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Email Rejected" do
    context "Email Rejected" do
      handler = Handlers::Registration::Events.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      registration_email_rejected = Registration::Client::Controls::Events::EmailRejected.example

      registration_id = registration_email_rejected.registration_id or fail
      user_id = registration_email_rejected.user_id or fail
      email_address = registration_email_rejected.email_address or fail
      effective_time = registration_email_rejected.time or fail

      handler.(registration_email_rejected)

      writer = handler.write

      email_rejected = writer.one_message do |event|
        event.instance_of?(Messages::Events::EmailRejected)
      end

      test "Email Rejected Event is Written" do
        refute(email_rejected.nil?)
      end

      test "Written to the registration view data stream" do
        written_to_stream = writer.written?(email_rejected) do |stream_name|
          stream_name == "registrationViewData-#{registration_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "registration_id" do
          assert(email_rejected.registration_id == registration_id)
        end

        test "user_id" do
          assert(email_rejected.user_id == user_id)
        end

        test "email_address" do
          assert(email_rejected.email_address == email_address)
        end

        test "time" do
          assert(email_rejected.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(email_rejected.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end

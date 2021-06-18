require_relative '../../automated_init'

context "Data Command" do
  context "Telemetry" do
    context "Insert Email Rejected" do
      registration_id = Identifier::UUID::Random.get
      user_id = Controls::User.id
      email_address = Controls::Registration.email_address
      time = Controls::Time::Effective.example

      insert_email_rejected = DataCommand::InsertEmailRejected.build

      sink = DataCommand::InsertEmailRejected.register_telemetry_sink(insert_email_rejected)

      insert_email_rejected.(
        registration_id: registration_id,
        user_id: user_id,
        email_address: email_address,
        time: time
      )

      test "Records inserted_email_rejected signal" do
        recorded = sink.recorded_once? do |record|
          record.signal == :inserted_email_rejected
        end

        assert(recorded)
      end
    end
  end
end

require_relative '../../automated_init'

context "Data Command" do
  context "Telemetry" do
    context "Insert Registered" do
      registration_id = Identifier::UUID::Random.get
      user_id = Controls::User.id
      email_address = Controls::Registration.email_address
      time = Controls::Time::Effective.example

      insert_registered = DataCommand::InsertRegistered.build

      sink = DataCommand::InsertRegistered.register_telemetry_sink(insert_registered)

      insert_registered.(
        registration_id: registration_id,
        user_id: user_id,
        email_address: email_address,
        time: time
      )

      test "Records inserted_registered signal" do
        recorded = sink.recorded_once? do |record|
          record.signal == :inserted_registered
        end

        assert(recorded)
      end
    end
  end
end

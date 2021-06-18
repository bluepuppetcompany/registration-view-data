require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registration Registered" do
    context "Telemetry" do
      handler = Handlers::Registration::Events.new

      insert_registered = handler.insert_registered

      registration_registered = Registration::Client::Controls::Events::Registered.example

      handler.(registration_registered)

      test "Records inserted_registered signal" do
        sink = insert_registered.sink

        recorded = sink.recorded_once? do |record|
          record.signal == :inserted_registered
        end

        assert(recorded)
      end
    end
  end
end

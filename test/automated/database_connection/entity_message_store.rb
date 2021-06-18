require_relative '../automated_init'

context "Database Connection" do
  context "Entity Message Store" do
    registration_view_data_settings = RegistrationViewData::Settings.instance
    entity_message_store = registration_view_data_settings.data.dig("registration_view_data", "entity_message_store")

    settings = ::MessageStore::Postgres::Settings.build(entity_message_store)

    session = ::MessageStore::Postgres::Session.build(settings: settings)

    refute(session.connected?)

    test "Connects on first use" do
      refute_raises do
        session.execute('SELECT 1;')
      end
    end
  end
end

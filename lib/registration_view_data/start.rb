module RegistrationViewData
  class Start
    def self.build
      instance = new
      instance
    end

    def call
      settings = Settings.instance
      entity_message_store_data = settings.data.dig("registration_view_data", "entity_message_store")
      entity_message_store_settings = ::MessageStore::Postgres::Settings.build(entity_message_store_data)

      Consumers::Registration::Events.start("registration", settings: entity_message_store_settings)
    end
  end
end

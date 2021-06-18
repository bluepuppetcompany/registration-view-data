module RegistrationViewData
  class Session < ::MessageStore::Postgres::Session
    settings.each do |setting_name|
      setting setting_name
    end

    def self.build(settings: nil)
      registration_view_data_settings = Settings.instance
      view_data_message_store = registration_view_data_settings.data.dig("registration_view_data", "view_data_message_store")

      settings = ::MessageStore::Postgres::Settings.build(view_data_message_store)

      super(settings: settings)
    end
  end
end

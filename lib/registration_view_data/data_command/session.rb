module RegistrationViewData
  module DataCommand
    class Session < ::ViewData::Postgres::Session
      settings.each do |setting_name|
        setting setting_name
      end

      def self.build(settings: nil)
        registration_view_data_settings = Settings.instance
        view_data = registration_view_data_settings.data.dig("registration_view_data", "view_data")

        settings = ::ViewData::Postgres::Settings.build(view_data)

        super(settings: settings)
      end
    end
  end
end

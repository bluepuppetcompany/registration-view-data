module RegistrationViewData
  class Settings < ::Settings
    def self.instance
      @instance ||= build
    end

    def self.data_source
      Defaults.data_source
    end

    def self.names
      [
        :entity_message_store,
        :view_data_message_store,
        :view_data
      ]
    end

    module Defaults
      def self.data_source
        ENV["REGISTRATION_VIEW_DATA_SETTINGS_PATH"] || "settings/registration_view_data.json"
      end
    end
  end
end

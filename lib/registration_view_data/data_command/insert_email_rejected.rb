module RegistrationViewData
  module DataCommand
    class InsertEmailRejected
      include Dependency

      dependency :session, Session
      dependency :insert, ViewData::Postgres::Insert
      dependency :telemetry, Telemetry

      def self.configure(receiver, attr_name: nil, session: nil)
        attr_name ||= :insert_email_rejected
        instance = build(session: session)
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.build(session: nil)
        instance = new
        instance.configure(session: session)
        instance
      end

      def configure(session: nil)
        Session.configure(self, session: session)
        ViewData::Postgres::Insert.configure(self, session: self.session)
        ::Telemetry.configure(self)
      end

      def call(
        registration_id:,
        user_id:,
        email_address:,
        time:
      )
        create_command = ViewData::Commands::Create.new
        create_command.name = "registrations"
        create_command.identifier = {
          :registration_id => registration_id
        }
        create_command.data = {
          :user_id => user_id,
          :email_address => email_address,
          :is_email_rejected => true,
          :is_registered => false,
          :created_at => time
        }

        insert.(create_command)

        telemetry.record(:inserted_email_rejected)
      end

      module Telemetry
        class Sink
          include ::Telemetry::Sink

          record :inserted_email_rejected
        end

        def self.sink
          Sink.new
        end
      end

      def self.register_telemetry_sink(receiver)
        sink = Telemetry.sink
        receiver.telemetry.register(sink)
        sink
      end

      module Substitute
        def self.build
          instance = InsertEmailRejected.build
          sink = InsertEmailRejected.register_telemetry_sink(instance)
          instance.sink = sink
          instance
        end

        class InsertEmailRejected < ::RegistrationViewData::DataCommand::InsertEmailRejected
          attr_accessor :sink

          def self.build
            instance = new
            instance.configure
            instance
          end

          def configure
            ::Telemetry.configure(self)
          end
        end
      end
    end
  end
end

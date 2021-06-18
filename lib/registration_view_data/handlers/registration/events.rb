module RegistrationViewData
  module Handlers
    module Registration
      class Events
        include Log::Dependency
        include Messaging::Handle
        include Messaging::StreamName
        include Messages::Events

        dependency :session, Session
        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :store, Store
        dependency :view_data_session, DataCommand::Session
        dependency :insert_email_rejected, DataCommand::InsertEmailRejected

        def configure
          Session.configure(self)
          Messaging::Postgres::Write.configure(self, session: session)
          Clock::UTC.configure(self)
          Store.configure(self, session: session)
          DataCommand::Session.configure(self, attr_name: :view_data_session)
          DataCommand::InsertEmailRejected.configure(self, session: view_data_session)
        end

        category :registration_view_data

        handle ::Registration::Client::Messages::Events::EmailRejected do |registration_email_rejected|
          registration_id = registration_email_rejected.registration_id

          registration, version = store.fetch(registration_id, include: :version)

          if registration.email_rejected?
            logger.info(tag: :ignored) { "Event ignored (Event: #{registration_email_rejected.message_type}, Registration ID: #{registration_id}, User ID: #{registration_email_rejected.user_id})" }
            return
          end

          user_id = registration_email_rejected.user_id
          email_address = registration_email_rejected.email_address
          email_rejected_time = registration_email_rejected.time

          insert_email_rejected.(
            registration_id: registration_id,
            user_id: user_id,
            email_address: email_address,
            time: email_rejected_time
          )

          time = clock.iso8601

          stream_name = stream_name(registration_id)

          email_rejected = EmailRejected.follow(registration_email_rejected)
          email_rejected.processed_time = time

          write.(email_rejected, stream_name, expected_version: version)
        end
      end
    end
  end
end

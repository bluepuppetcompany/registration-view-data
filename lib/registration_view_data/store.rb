module RegistrationViewData
  class Store
    include EntityStore

    category :registration_view_data
    entity Registration
    projection Projection
    reader MessageStore::Postgres::Read
  end
end

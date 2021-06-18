require_relative '../automated_init'

context "Data Command" do
  context "Insert Registered" do
    registration_id = Controls::Registration.id
    user_id = Controls::User.id
    email_address = Controls::Registration.email_address
    time = Controls::Time::Effective.example

    insert_registered = DataCommand::InsertRegistered.new

    insert_registered.(
      registration_id: registration_id,
      user_id: user_id,
      email_address: email_address,
      time: time
    )

    insert = insert_registered.insert

    test "Insert matches name" do
      inserted = insert.inserted? do |name|
        name == "registrations"
      end

      assert(inserted)
    end

    test "Insert matches identifier" do
      inserted = insert.inserted? do |_, identifier|
        identifier == { :registration_id => registration_id }
      end

      assert(inserted)
    end

    test "Insert matches data" do
      registration_data = {
        :user_id => user_id,
        :email_address => email_address,
        :is_email_rejected => false,
        :is_registered => true,
        :created_at => time
      }

      inserted = insert.inserted? do |_, _, data|
        data == registration_data
      end

      assert(inserted)
    end
  end
end

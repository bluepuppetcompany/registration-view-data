require_relative '../automated_init'

context "Data Command" do
  context "Insert Email Rejected" do
    registration_id = Controls::Registration.id
    user_id = Controls::User.id
    email_address = Controls::Registration.email_address
    time = Controls::Time::Effective.example

    insert_email_rejected = DataCommand::InsertEmailRejected.new

    insert_email_rejected.(
      registration_id: registration_id,
      user_id: user_id,
      email_address: email_address,
      time: time
    )

    insert = insert_email_rejected.insert

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
        :is_email_rejected => true,
        :is_registered => false,
        :created_at => time
      }

      inserted = insert.inserted? do |_, _, data|
        data == registration_data
      end

      assert(inserted)
    end
  end
end

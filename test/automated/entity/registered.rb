require_relative "../automated_init"

context "Registration" do
  context "Has Registered Time" do
    registration = Controls::Registration::Registered.example

    test "Is registered" do
      assert(registration.registered?)
    end
  end

  context "Does not Have Registered Time" do
    registration = Controls::Registration.example

    test "is not registered" do
      refute(registration.registered?)
    end
  end
end

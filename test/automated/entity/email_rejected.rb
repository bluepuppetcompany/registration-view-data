require_relative "../automated_init"

context "Registration" do
  context "Has Email Rejected Time" do
    registration = Controls::Registration::EmailRejected.example

    test "Is email_rejected" do
      assert(registration.email_rejected?)
    end
  end

  context "Does not Have Email Rejected Time" do
    registration = Controls::Registration::New.example

    test "is not email_rejected" do
      refute(registration.email_rejected?)
    end
  end
end

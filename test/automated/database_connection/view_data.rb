require_relative '../automated_init'

context "Database Connection" do
  context "View Data" do
    session = DataCommand::Session.build

    refute(session.connected?)

    test "Connects on first use" do
      refute_raises do
        session.execute('SELECT 1;')
      end
    end
  end
end

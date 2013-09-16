require 'test_helper'

class EmailTest < ActiveSupport::TestCase

  self.use_transactional_fixtures = true
  fixtures :emails

  test "loading from db" do
    email = Email.find(ActiveRecord::Fixtures.identify(:existing))

    from = email.from
    assert_equal("No Reply <noreply@foo.com>", from.to_s)

    to = email.to
    assert_equal("foo@bar.com, Jeff Ching <ching.jeff@gmail.com>", to.to_s)
    assert_equal(2, to.length)
  end

  test "creating" do
    email = Email.new({
      to: ["foo@bar.com", "bar@foo.com"],
      from: "sender@foo.com",
      body: "blah",
      subject: "blah"
    })

    assert_difference "Email.count", 1 do
      email.save
    end

    email = Email.last
    assert_equal(2, email.to.length)
    assert_equal("foo@bar.com, bar@foo.com", email.to.to_s)
    assert_equal("sender@foo.com", email.from.to_s)
  end

end
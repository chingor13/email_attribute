require 'test_helper'

class EmailValidatorTest < ActiveSupport::TestCase

  test "validating single address" do
    email = Email.new({
      from: "some invalid email address",
      to: "foo@bar.com",
      body: "body",
      subject: "subject"
    })

    assert_equal("some invalid email address", email.from)
    assert_equal(false, email.save)
    assert email.errors[:from].present?
    assert email.errors[:from].first.match("custom message")
  end

  test "validating list addresses" do
    email = Email.new({
      from: "sender@foo.com",
      to: "some invalid email address",
      body: "body",
      subject: "subject"
    })

    assert_equal(1, email.to.length)
    assert_equal(["some invalid email address"], email.to.addresses)
    assert_equal(false, email.save)
    assert email.errors[:to].present?
    assert email.errors[:to].first.match("another message")
  end

  test "validating several addresses" do
    email = Email.new({
      from: "sender@foo.com",
      to: "some invalid email address, valid@foo.com",
      body: "body",
      subject: "subject"
    })

    assert_equal(2, email.to.length)
    assert_equal(false, email.save)
    assert email.errors[:to].present?
    assert email.errors[:to].first.match("another message")
  end

end
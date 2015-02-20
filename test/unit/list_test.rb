require 'test_helper'

class ListTest < ActiveSupport::TestCase
  context "list attribute" do

    should "handle single values" do
      list = EmailAttribute::List.new("foo@bar.com")
      assert_equal(1, list.length)
      assert_equal("foo@bar.com", list.to_s)
    end

    should "handle complex single values" do
      list = EmailAttribute::List.new("Jeffrey Ching <ching.jeff@gmail.com>")
      assert_equal(1, list.length)
      assert_equal("Jeffrey Ching <ching.jeff@gmail.com>", list.to_s)
    end

    should "handle bad single values" do
      list = EmailAttribute::List.new("some bad value")
      assert_equal(1, list.length)
      assert_equal("some bad value", list.to_s)
    end

    should "handle empty values" do
      list = EmailAttribute::List.new("")
      assert_equal(0, list.length)
      assert_equal("", list.to_s)
    end

    should "handle nil values" do
      list = EmailAttribute::List.new(nil)
      assert_equal(0, list.length)
      assert_equal("", list.to_s)
    end

    should "dump empty values as nil" do
      list = EmailAttribute::List.new(nil)
      assert_nil(EmailAttribute::List.dump(list))
    end

    should "load nil values as empty lists" do
      list = EmailAttribute::List.load(nil)
      assert_equal(0, list.length)
      assert_equal("", list.to_s)
    end

    should "handle array values" do
      list = EmailAttribute::List.new(["foo@bar.com", "blah@blabber.com"])
      assert_equal(2, list.length)
      assert_equal("foo@bar.com, blah@blabber.com", list.to_s)
    end

    should "handle lists with comma separators" do
      list = EmailAttribute::List.new("foo@bar.com, blah@blabber.com")
      assert_equal(2, list.length)
      assert_equal("foo@bar.com, blah@blabber.com", list.to_s)
    end

    should "handle lists with semicolor separators" do
      list = EmailAttribute::List.new("foo@bar.com; blah@blabber.com")
      assert_equal(2, list.length)
      assert_equal("foo@bar.com, blah@blabber.com", list.to_s)
    end

    should "handle lists with complex values" do
      list = EmailAttribute::List.new("foo@bar.com; Blabber <blah@blabber.com>")
      assert_equal(2, list.length)
      assert_equal("foo@bar.com, Blabber <blah@blabber.com>", list.to_s)
    end

    should 'responds to strip for strip_attributes gem' do
      list = EmailAttribute::List.new(" foo@bar.com; blah@blabber.com ")
      assert_equal 'foo@bar.com, blah@blabber.com', list.strip

      list = EmailAttribute::List.new("   ")
      assert_equal '', list.strip
    end
  end
end

require 'test_helper'

class EmailAttributeTest < ActiveSupport::TestCase

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
      list = EmailAttribute::List.new("Mark Britton_pub")
      assert_equal(1, list.length)
      assert_equal("Mark Britton_pub", list.to_s)
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

  context "single attribute" do
    should "handle single values" do
      single = EmailAttribute::SingleAddress.new("foo@bar.com")
      assert_equal("foo@bar.com", single)
    end

    should "handle complex single values" do
      single = EmailAttribute::SingleAddress.new("Jeffrey Ching <ching.jeff@gmail.com>")
      assert_equal("Jeffrey Ching <ching.jeff@gmail.com>", single)
    end

    should "handle bad single values" do
      single = EmailAttribute::SingleAddress.new("Mark Britton_pub")
      assert_equal("Mark Britton_pub", single)
    end

    should "handle empty values" do
      single = EmailAttribute::SingleAddress.new("")
      assert_equal("", single)
    end

    should "handle nil values" do
      single = EmailAttribute::SingleAddress.new(nil)
      assert_equal("", single)
    end

    should 'responds to strip for strip_attributes gem' do
      single = EmailAttribute::SingleAddress.new(' foo@bar.com ')
      assert_equal 'foo@bar.com', single.strip
    end
  end

end

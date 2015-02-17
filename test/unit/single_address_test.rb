require 'test_helper'

class SingleAddressTest < ActiveSupport::TestCase

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
      single = EmailAttribute::SingleAddress.new("some bad value")
      assert_equal("some bad value", single)
    end

    should "handle empty values" do
      single = EmailAttribute::SingleAddress.new("")
      assert_equal("", single)
    end

    should "handle nil values" do
      single = EmailAttribute::SingleAddress.new(nil)
      assert_equal("", single)
    end

    should "dump empty values as nil" do
      list = EmailAttribute::SingleAddress.new(nil)
      assert_nil(EmailAttribute::SingleAddress.dump(list))
    end

    should "load nil values as empty lists" do
      list = EmailAttribute::SingleAddress.load(nil)
      assert_equal(0, list.length)
      assert_equal("", list.to_s)
    end
    
    should 'responds to strip for strip_attributes gem' do
      single = EmailAttribute::SingleAddress.new(' foo@bar.com ')
      assert_equal 'foo@bar.com', single.strip
    end
  end

end

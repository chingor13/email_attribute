module EmailAttribute
  class SingleAddress < String
    def initialize(str = "")
      @address = Mail::Address.new(str.to_s) rescue nil
      if @address
        value = @address.format
      else
        value = str || ""
      end
      super(value)
    end

    # rebuilds the Mail::Address if necessary
    # using string methods on this object can bypass the initializer
    def address
      @address ||= Mail::Address.new(self.to_s) rescue nil
    end

    class << self
      def dump(email_address)
        return nil if email_address.nil?

        email_address.to_s
      end

      def load(email_address)
        new(email_address)
      end
    end
  end
end
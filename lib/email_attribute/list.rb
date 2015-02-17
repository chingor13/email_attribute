module EmailAttribute
  # serializeable model that wraps Mail::AddressList
  class List
    attr_reader :addresses
    delegate :length, :size, :each, :to => :addresses

    def initialize(email_addresses)
      email_addresses = email_addresses.join(", ") if email_addresses.respond_to?(:join)
      @addresses = begin
        Mail::AddressList.new(email_addresses).addresses.map(&:format)
      rescue
        manual_parse(email_addresses)
      end
    end

    def inspect
      to_s
    end

    def to_s
      addresses.join(", ")
    end

    def present?
      length > 0
    end

    def blank?
      !present?
    end

    def strip
      to_s.strip
    end

    class << self
      def dump(email_address)
        return nil if email_address.blank?

        email_address.to_s
      end

      def load(email_address)
        new(email_address)
      end
    end

    protected

    def manual_parse(email_addresses)
      email_addresses.split(/[,;]/).map do |address|
        Mail::Address.new(address).format rescue address
      end
    end
  end

end

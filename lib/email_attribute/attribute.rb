module EmailAttribute
  module Attribute
    extend ActiveSupport::Concern

    module ClassMethods
      def email_address_list_attribute(*attributes)
        options = attributes.extract_options!

        attributes.each do |attribute|
          serialize attribute, EmailAttribute::List

          method_body, line = <<-EOV, __LINE__ + 1
            def #{attribute}=(email_address)
              list = EmailAttribute::List.new(email_address) rescue email_address
              write_attribute(:#{attribute}, list)
            end
          EOV

          class_eval method_body, __FILE__, line
        end
      end

      def email_address_attribute(*attributes)
        options = attributes.extract_options!

        attributes.each do |attribute|
          serialize attribute, EmailAttribute::SingleAddress

          method_body, line = <<-EOV, __LINE__ + 1
            def #{attribute}=(email_address)
              write_attribute(:#{attribute}, EmailAttribute::SingleAddress.new(email_address))
            end
          EOV

          class_eval method_body, __FILE__, line
        end
      end
    end
  end
end
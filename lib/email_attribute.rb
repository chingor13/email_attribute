require 'mail'

module EmailAttribute
  autoload :Attribute, "email_attribute/attribute"
  autoload :List, "email_attribute/list"
  autoload :SingleAddress, "email_attribute/single_address"
end

require 'email_attribute/railtie'
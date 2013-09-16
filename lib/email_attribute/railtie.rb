module EmailAttribute
  class Railtie < ::Rails::Railtie

    initializer "email_attribute" do
      require 'email_attribute/email_validator'
      ActiveSupport.on_load :active_record do
        include EmailAttribute::Attribute
      end
    end

  end
end
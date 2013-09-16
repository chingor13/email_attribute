# global namespace so you can use the rails 3 "validate :field, email: [options]"
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    return if value.blank? && options[:allow_blank]

    case value
    when EmailAttribute::SingleAddress
      validate_single_address_model(record, attribute, value.address)
    when String
      validate_single_address_model(record, attribute, value)
    when EmailAttribute::List
      value.each do |address|
        validate_single_address_model(record, attribute, address)
      end
    end
  end

  protected

  # model should be a Mail::Address model
  def validate_single_address_model(record, attribute, model)
    begin
      model = EmailAttribute::SingleAddress.new(model).address if model.is_a?(String)
      r = model.domain && model.domain.split(".").length > 1
    rescue Exception => e
      r = false
    end
    record.errors.add(attribute, (options[:message] || :invalid)) unless r
  end
end

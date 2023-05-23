class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? || value.empty?

    unless value =~ /[A-Z]/ && value =~ /[a-z]/ && value =~ /[0-9]/ && value =~ /[^A-Za-z0-9]/
      record.errors[attribute] << (options[:message] || "must contain at least one uppercase letter, one lowercase letter, one number, and one special character")
    end
  end
end
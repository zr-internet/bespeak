module ActiveRecord
  module Validations
    class AssociatedWithErrorMessagesValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        (value.is_a?(Array) ? value : [value]).each do |v|
          unless v.valid?
            v.errors.full_messages.each do |msg|
              record.errors.add(attribute, msg, options.merge(:value => value))
            end
          end
        end
      end
    end

    module ClassMethods
      def validates_associated_with_error_messages(*attr_names)
        validates_with AssociatedWithErrorMessagesValidator, _merge_attributes(attr_names)
      end
    end
  end
end
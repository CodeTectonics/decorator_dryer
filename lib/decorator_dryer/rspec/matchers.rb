# frozen_string_literal: true

module DecoratorDryer
  module RSpec
    module Matchers
      RSpec::Matchers.define :format_field_to_name do |field|
        match do |subject|
          subject.decorate.send("#{field}_name") == subject.send(field).try(:name)
        end
      end

      RSpec::Matchers.define :format_field_to_datetime do |field|
        match do |subject|
          subject.decorate.send(field) == subject.send(field).try(:strftime, '%Y-%m-%d %H:%M')
        end
      end

      RSpec::Matchers.define :format_field_to_date do |field|
        match do |subject|
          subject.decorate.send(field) == subject.send(field).try(:strftime, '%Y-%m-%d')
        end
      end

      RSpec::Matchers.define :format_field_to_time do |field|
        match do |subject|
          subject.decorate.send(field) == subject.send(field).try(:strftime, '%H:%M')
        end
      end

      RSpec::Matchers.define :format_field_to_precision_number do |field, precision|
        match do |subject|
          subject.decorate.send(field) == number_with_precision(subject.send(field), precision: precision)
        end
      end

      RSpec::Matchers.define :delegate_field do |field, association|
        match do |subject|
          subject.decorate.send(field) == subject.send(association).decorate.send(field)
        end
        failure_message do |subject|
          "expected #{subject.class.name} to delegate #{field} to #{association}"
        end
      end

      RSpec::Matchers.define :delegate_field_with_prefix do |field, association|
        match do |subject|
          subject.decorate.send("#{association}_#{field}") ==
            subject.send(association).decorate.send(field)
        end
        failure_message do |subject|
          "expected #{subject.class.name} to delegate #{field} to #{association}"
        end
      end
    end
  end
end

# Auto-include matchers when RSpec is loaded
::RSpec.configure { |config| config.include DecoratorDryer::RSpec::Matchers }

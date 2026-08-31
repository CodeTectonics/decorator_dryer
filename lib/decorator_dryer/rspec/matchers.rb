# frozen_string_literal: true

module DecoratorDryer
  module RSpec
    module Matchers
      # Matcher to verify that a decorator defines a method to return the name attribute
      # of a field.
      #
      # @example
      #   expect(user).to format_field_to_name(:role)
      ::RSpec::Matchers.define :format_field_to_name do |field|
        match do |subject|
          subject.decorate.send("#{field}_name") == subject.send(field).try(:name)
        end
        description do
          "format #{field} to display its name attribute"
        end
        failure_message do |subject|
          "expected #{subject.class.name} decorator to format #{field} with a _name suffix method"
        end
      end

      # Matcher to verify that a decorator formats a datetime field with format '%Y-%m-%d %H:%M'.
      #
      # @example
      #   expect(post).to format_field_to_datetime(:published_at)
      ::RSpec::Matchers.define :format_field_to_datetime do |field|
        match do |subject|
          subject.decorate.send(field) == subject.send(field).try(:strftime, '%Y-%m-%d %H:%M')
        end
        description do
          "format #{field} as a datetime with format '%Y-%m-%d %H:%M'"
        end
        failure_message do |subject|
          "expected #{subject.class.name} decorator to format #{field} as '%Y-%m-%d %H:%M'"
        end
      end

      # Matcher to verify that a decorator formats a date field with format '%Y-%m-%d'.
      #
      # @example
      #   expect(event).to format_field_to_date(:start_date)
      ::RSpec::Matchers.define :format_field_to_date do |field|
        match do |subject|
          subject.decorate.send(field) == subject.send(field).try(:strftime, '%Y-%m-%d')
        end
        description do
          "format #{field} as a date with format '%Y-%m-%d'"
        end
        failure_message do |subject|
          "expected #{subject.class.name} decorator to format #{field} as '%Y-%m-%d'"
        end
      end

      # Matcher to verify that a decorator formats a time field with format '%H:%M'.
      #
      # @example
      #   expect(schedule).to format_field_to_time(:start_time)
      ::RSpec::Matchers.define :format_field_to_time do |field|
        match do |subject|
          subject.decorate.send(field) == subject.send(field).try(:strftime, '%H:%M')
        end
        description do
          "format #{field} as a time with format '%H:%M'"
        end
        failure_message do |subject|
          "expected #{subject.class.name} decorator to format #{field} as '%H:%M'"
        end
      end

      # Matcher to verify that a decorator formats a number field with a specific precision.
      #
      # @example
      #   expect(product).to format_field_to_precision_number(:price, 2)
      ::RSpec::Matchers.define :format_field_to_precision_number do |field, precision|
        match do |subject|
          subject.decorate.send(field) == number_with_precision(subject.send(field), precision: precision)
        end
        description do
          "format #{field} as a number with precision #{precision}"
        end
        failure_message do |subject|
          "expected #{subject.class.name} decorator to format #{field} with precision #{precision}"
        end
      end

      # Matcher to verify that a decorator delegates a field to an associated object.
      #
      # @example
      #   expect(order).to delegate_field(:email, :customer)
      ::RSpec::Matchers.define :delegate_field do |field, association|
        match do |subject|
          subject.decorate.send(field) == subject.send(association).decorate.send(field)
        end
        description do
          "delegate #{field} to #{association}"
        end
        failure_message do |subject|
          "expected #{subject.class.name} to delegate #{field} to #{association}"
        end
      end

      # Matcher to verify that a decorator delegates a field to an associated object with
      # a prefix based on the association name.
      #
      # @example
      #   expect(order).to delegate_field_with_prefix(:email, :customer)
      ::RSpec::Matchers.define :delegate_field_with_prefix do |field, association|
        match do |subject|
          subject.decorate.send("#{association}_#{field}") ==
            subject.send(association).decorate.send(field)
        end
        description do
          "delegate #{field} to #{association} with prefix"
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

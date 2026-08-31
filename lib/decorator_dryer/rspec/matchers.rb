# frozen_string_literal: true

module DecoratorDryer
  module RSpec
    module Matchers
      # Matcher to verify that a decorator defines a date format method for a given attribute
      #
      # Example:
      #   expect(PersonDecorator).to define_date_format_for(:date_of_birth)
      #
      ::RSpec::Matchers.define :define_date_format_for do |attribute|
        match do |decorator_class|
          decorator_class.instance_methods.include?(attribute)
        end

        failure_message do |decorator_class|
          "expected #{decorator_class} to define date format method for :#{attribute}"
        end

        failure_message_when_negated do |decorator_class|
          "expected #{decorator_class} not to define date format method for :#{attribute}"
        end

        description do
          "define date format method for :#{attribute}"
        end
      end

      # Matcher to verify that a decorator defines a datetime format method for a given attribute
      #
      # Example:
      #   expect(PersonDecorator).to define_datetime_format_for(:moment_of_birth)
      #
      ::RSpec::Matchers.define :define_datetime_format_for do |attribute|
        match do |decorator_class|
          decorator_class.instance_methods.include?(attribute)
        end

        failure_message do |decorator_class|
          "expected #{decorator_class} to define datetime format method for :#{attribute}"
        end

        failure_message_when_negated do |decorator_class|
          "expected #{decorator_class} not to define datetime format method for :#{attribute}"
        end

        description do
          "define datetime format method for :#{attribute}"
        end
      end

      # Matcher to verify that a decorator defines a time format method for a given attribute
      #
      # Example:
      #   expect(PersonDecorator).to define_time_format_for(:lunch_time)
      #
      ::RSpec::Matchers.define :define_time_format_for do |attribute|
        match do |decorator_class|
          decorator_class.instance_methods.include?(attribute)
        end

        failure_message do |decorator_class|
          "expected #{decorator_class} to define time format method for :#{attribute}"
        end

        failure_message_when_negated do |decorator_class|
          "expected #{decorator_class} not to define time format method for :#{attribute}"
        end

        description do
          "define time format method for :#{attribute}"
        end
      end
    end
  end
end

# Auto-include matchers when RSpec is loaded
::RSpec.configure { |config| config.include DecoratorDryer::RSpec::Matchers }

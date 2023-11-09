# frozen_string_literal: true

module DraperShortcuts
  module Shortcuts
    include DraperShortcuts::Formatters

    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def to_date_format(*attrs)
        attrs.each do |attr|
          define_method(attr) do
            format_date object.send(attr)
          end
        end
      end

      def to_time_format(*attrs)
        attrs.each do |attr|
          define_method(attr) do
            format_time object.send(attr)
          end
        end
      end

      def to_datetime_format(*attrs)
        attrs.each do |attr|
          define_method(attr) do
            format_datetime object.send(attr)
          end
        end
      end

      def to_precision_number(*attrs, precision: 0)
        attrs.each do |attr|
          define_method(attr) do
            format_precision_number object.send(attr), precision
          end
        end
      end

      def to_name(*attrs, suffix: "name")
        attrs.each do |attr|
          method_name = "#{attr}_#{suffix}".to_sym

          define_method(method_name) do
            to_name object.send(attr)
          end
        end
      end
    end
  end
end

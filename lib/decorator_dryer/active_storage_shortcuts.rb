# frozen_string_literal: true

module DecoratorDryer
  module ActiveStorageShortcuts
    def self.included(klass)
      klass.extend(ClassMethods)
      klass.include(Rails.application.routes.url_helpers)
    end

    module ClassMethods
      def to_attachment(*attrs, preview_transform: nil)
        to_attachment_url(*attrs)
        to_attachment_name(*attrs)
        to_attachment_preview(*attrs, transform: preview_transform)
        to_attachment_signed_id(*attrs)
      end

      def to_attachment_url(*attrs)
        attrs.each do |attr|
          method_name = "#{attr}_url".to_sym

          define_method(method_name) do
            attachment = object.send(attr)

            url_for(attachment) if attachment.attached?
          end
        end
      end

      def to_attachment_name(*attrs)
        attrs.each do |attr|
          method_name = "#{attr}_name".to_sym

          define_method(method_name) do
            attachment = object.send(attr)

            attachment.blob.filename.as_json if attachment.attached?
          end
        end
      end

      def to_attachment_preview(*attrs, transform: nil)
        transform ||= DecoratorDryer.configuration.attachment_shortcuts.default_preview_transform

        attrs.each do |attr|
          method_name = "#{attr}_preview".to_sym

          define_method(method_name) do
            return if transform.blank? || transform == :none

            attachment = object.send(attr)
            return unless attachment.attached?

            if transform.is_a? Symbol
              url_for attachment.variant(transform)
            else
              return unless attachment.representable?

              url_for attachment.representation(transform).processed
            end
          end
        end
      end

      def to_attachment_signed_id(*attrs)
        attrs.each do |attr|
          method_name = "#{attr}_signed_id".to_sym

          define_method(method_name) do
            attachment = object.send(attr)
            attachment.signed_id if attachment.attached?
          end
        end
      end
    end
  end
end

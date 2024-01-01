# frozen_string_literal: true

require "action_view"

require_relative "decorator_dryer/formatters"
require_relative "decorator_dryer/shortcuts"
require_relative "decorator_dryer/active_storage_shortcuts"
require_relative "decorator_dryer/configuration"

module DecoratorDryer
  def self.included(klass)
    klass.include(DecoratorDryer::Formatters)
    klass.include(DecoratorDryer::Shortcuts)

    if DecoratorDryer.configuration.attachment_shortcuts.mode == :active_storage
      klass.include(DecoratorDryer::ActiveStorageShortcuts)
    end

    DecoratorDryer.configuration.extensions.each do |extension|
      klass.include(extension)
    end
  end

  def self.configuration
    @configuration ||= DecoratorDryer::Configuration.new
  end

  def self.configure
    yield DecoratorDryer.configuration
  end
end

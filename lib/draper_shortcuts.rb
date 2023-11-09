# frozen_string_literal: true

require "action_view"

require_relative "draper_shortcuts/formatters"
require_relative "draper_shortcuts/shortcuts"
require_relative "draper_shortcuts/active_storage_shortcuts"
require_relative "draper_shortcuts/configuration"

module DraperShortcuts
  def self.included(klass)
    klass.include(DraperShortcuts::Formatters)
    klass.include(DraperShortcuts::Shortcuts)

    if DraperShortcuts.configuration.attachment_shortcuts.mode == :active_storage
      klass.include(DraperShortcuts::ActiveStorageShortcuts)
    end

    DraperShortcuts.configuration.extensions.each do |extension|
      klass.include(extension)
    end
  end

  def self.configuration
    @configuration ||= DraperShortcuts::Configuration.new
  end

  def self.configure
    yield DraperShortcuts.configuration
  end
end

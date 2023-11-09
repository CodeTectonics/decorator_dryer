# frozen_string_literal: true

module DraperShortcuts
  class Configuration
    attr_accessor :date_format, :humanized_date_format,
                  :datetime_format, :humanized_datetime_format, :time_format,
                  :extensions

    attr_reader :attachment_shortcuts

    def initialize
      @date_format = "%Y-%m-%d"
      @humanized_date_format = "%d/%m/%Y"
      @datetime_format = "%Y-%m-%d %H:%M"
      @humanized_datetime_format = "%H:%M %d/%m/%Y"
      @time_format = "%H:%M"
      @attachment_shortcuts = AttachmentShortcutsConfig.new
      @extensions = []
    end

    class AttachmentShortcutsConfig
      attr_accessor :mode, :default_preview_transform

      def initialize
        @mode = :none
        @default_preview_transform = :none
      end
    end
  end
end

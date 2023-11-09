# frozen_string_literal: true

module DraperShortcuts
  module Formatters
    include ActionView::Helpers::NumberHelper

    def format_date(date)
      if context[:humanize]
        date_format = DraperShortcuts.configuration.humanized_date_format
      else
        date_format = DraperShortcuts.configuration.date_format
      end
      date.try(:strftime, date_format)
    end

    def format_time(time)
      time_format = DraperShortcuts.configuration.time_format
      time.try(:strftime, time_format)
    end

    def format_datetime(datetime)
      if context[:humanize]
        datetime_format = DraperShortcuts.configuration.humanized_datetime_format
      else
        datetime_format = DraperShortcuts.configuration.datetime_format
      end
      datetime.try(:strftime, datetime_format)
    end

    def format_precision_number(number, precision = 0)
      return 0.0 if number.blank?
      return number.to_d if precision < 1

      number_with_precision(number, precision: precision)
    end

    def to_name(association)
      association.try(:name)
    end
  end
end

# frozen_string_literal: true

class DummyModelDecorator
  include DraperShortcuts

  attr_accessor :object, :context

  to_date_format :date1, :date2
  to_time_format :time1, :time2
  to_datetime_format :datetime1, :datetime2
  to_precision_number :number1, :number2, precision: 2
  to_name :association1, :association2

  def initialize(object, context = {})
    self.object = object
    self.context = context
  end
end

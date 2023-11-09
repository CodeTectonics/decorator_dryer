# frozen_string_literal: true

require "draper_shortcuts"
require "dummy/dummy_model"
require "dummy/dummy_model_decorator"

RSpec.describe DraperShortcuts do
  describe "::Formatters" do
    it "returns formatted dates" do
      decorator = DummyModelDecorator.new({})
      result = decorator.format_date(Date.new(2023, 11, 1))
      expect(result).to eq("2023-11-01")
    end

    it "returns humanized dates" do
      decorator = DummyModelDecorator.new({}, { humanize: true })
      result = decorator.format_date(Date.new(2023, 11, 1))
      expect(result).to eq("01/11/2023")
    end

    it "returns formatted times" do
      decorator = DummyModelDecorator.new({})
      result = decorator.format_time(Time.new(2023, 11, 1, 11, 30, 0))
      expect(result).to eq("11:30")
    end

    it "returns formatted datetimes" do
      decorator = DummyModelDecorator.new({})
      result = decorator.format_datetime(Time.new(2023, 11, 1, 11, 30, 0))
      expect(result).to eq("2023-11-01 11:30")
    end

    it "returns humanized datetimes" do
      decorator = DummyModelDecorator.new({}, { humanize: true })
      result = decorator.format_datetime(Time.new(2023, 11, 1, 11, 30, 0))
      expect(result).to eq("11:30 01/11/2023")
    end

    it "returns number with precision" do
      decorator = DummyModelDecorator.new({})
      result = decorator.format_precision_number(5, 3)
      expect(result).to eq("5.000")
    end

    it "returns association names" do
      decorator = DummyModelDecorator.new({})
      association = DummyModel.new
      association.name = "John Smith"
      result = decorator.to_name(association)
      expect(result).to eq("John Smith")
    end
  end

  describe "::Shortcuts" do
    let(:dummy_record) do
      association1 = DummyModel.new
      association1.name = "John Smith"

      association2 = DummyModel.new
      association2.name = "Joe Bloggs"

      dummy_record = DummyModel.new
      dummy_record.date1 = Date.new(2023, 11, 1)
      dummy_record.date2 = Date.new(2023, 11, 2)
      dummy_record.time1 = Time.new(2023, 11, 1, 11, 30, 0)
      dummy_record.time2 = Time.new(2023, 11, 1, 12, 59, 0)
      dummy_record.datetime1 = Time.new(2023, 11, 1, 13, 49, 0)
      dummy_record.datetime2 = Time.new(2023, 11, 1, 15, 23, 0)
      dummy_record.number1 = 5.321
      dummy_record.number2 = 77.888888
      dummy_record.association1 = association1
      dummy_record.association2 = association2
      dummy_record
    end

    it "returns formatted dates" do
      decorator = DummyModelDecorator.new(dummy_record)
      expect(decorator.date1).to eq("2023-11-01")
      expect(decorator.date2).to eq("2023-11-02")
    end

    it "returns humanized dates" do
      decorator = DummyModelDecorator.new(dummy_record, { humanize: true })
      expect(decorator.date1).to eq("01/11/2023")
      expect(decorator.date2).to eq("02/11/2023")
    end

    it "returns formatted times" do
      decorator = DummyModelDecorator.new(dummy_record, { humanize: true })
      expect(decorator.time1).to eq("11:30")
      expect(decorator.time2).to eq("12:59")
    end

    it "returns formatted datetimes" do
      decorator = DummyModelDecorator.new(dummy_record)
      expect(decorator.datetime1).to eq("2023-11-01 13:49")
      expect(decorator.datetime2).to eq("2023-11-01 15:23")
    end

    it "returns humanized datetimes" do
      decorator = DummyModelDecorator.new(dummy_record, { humanize: true })
      expect(decorator.datetime1).to eq("13:49 01/11/2023")
      expect(decorator.datetime2).to eq("15:23 01/11/2023")
    end

    it "returns number with precision" do
      decorator = DummyModelDecorator.new(dummy_record)
      expect(decorator.number1).to eq("5.32")
      expect(decorator.number2).to eq("77.89")
    end

    it "returns association names" do
      decorator = DummyModelDecorator.new(dummy_record)
      expect(decorator.association1_name).to eq("John Smith")
      expect(decorator.association2_name).to eq("Joe Bloggs")
    end
  end
end

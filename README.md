# Decorator Dryer

Welcome to Decorator Dryer! The aim of this gem is to help you write smaller, DRYer, easier to maintain, decorators.

Decorator Dryer contains a collection of formatters that cover some of the more common things that developers do in their decorators. On top of those formatters is a layer of shortcuts to help you reduce the amount of code in your decorator classes.

This is not a fully-formed decorator framework. Decorator Dryer is intended as a companion for Draper.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'draper'
gem 'decorator_dryer'
```

And then execute:

    $ bundle install

## Configuration

### Formatters

The formatters in Decorator Dryer use a set of default formats for things like dates and times.

If you are happy with the defaults, you can skip this section. However, if you would like to set your own defaults, you can do so with an initializer.

```ruby
DecoratorDryer.configure do |config|
  config.date_format = "%Y-%m-%d"
  config.humanized_date_format = "%d/%m/%Y"
  config.datetime_format = "%Y-%m-%d %H:%M"
  config.humanized_datetime_format = "%H:%M %d/%m/%Y"
  config.time_format = "%H:%M"
end
```

### Attachments

Decorator Dryer also provides shortcuts for attachments. There will be more detail on these shortcuts in later sections.

This can also be configured via an initializer.

```ruby
DecoratorDryer.configure do |config|
  config.attachment_shortcuts.mode = :none
  config.attachment_shortcuts.default_preview_transform = :none
end
```

Attachment shortcuts are disabled by default. To enable them, you can set `config.attachment_shortcuts.mode = :active_storage` Please note that this gem currently only provides shortcuts for Active Storage attachments.

You can also set a default transform for your attachment previews.

This could either be a variant, with something like:
    `config.attachment_shortcuts.default_preview_transform = :thumb`
Or, a representation with something like:
    `config.attachment_shortcuts.default_preview_transform = { resize: "400x" }`

## Usage

Decorator Dryer is not a complete decorator library. It is intended for use alongside Draper. Why reinvent the wheel when there is already such a good option out there?

You can use Decorator Dryer by either adding the shortcuts to your decorator classes or by directly calling the formatters from within your decorator methods.

### Shortcuts

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  to_date_format :date_of_birth
  to_datetime_format :moment_of_birth
  to_time_format :lunch_time
  to_precision_number :salary, precision: 2
  to_attachment :profile_picture
end
```

#### to_date_format

This shortcut adds a method to your decorator that returns the formatted date. It can accept 1 or more attributes of type Date, DateTime, or Time.

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  to_date_format :date_of_birth, :date_of_graduation
end

date_of_birth = Date.new(2000, 1, 1)
date_of_graduation = Date.new(2018, 6, 6)
person = Person.create(date_of_birth: date_of_birth, date_of_graduation: date_of_graduation)
person.decorate.date_of_birth # ==> '2000-01-01'
person.decorate.date_of_graduation # ==> '2018-06-06'
```

This shortcut uses the gem's default date format (%Y-%m-%d), or the format set in your initializer.

You could also provide a context when initializing your decorator, and tell it to return dates in a humanized format. The humanized format can also be set in your initializer.

```ruby
date_of_birth = Date.new(2000, 1, 1)
person = Person.create(date_of_birth: date_of_birth)
person.decorate(context: { humanize: true }).date_of_birth # ==> '01/01/2000'
```

#### to_datetime_format

This shortcut adds a method to your decorator that returns the formatted datetime. It can accept 1 or more attributes of type DateTime or Time.

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  to_datetime_format :moment_of_birth, :moment_of_graduation
end

moment_of_birth = DateTime.new(2000, 1, 1, 12, 30, 59)
moment_of_graduation = DateTime.new(2018, 6, 6, 17, 00, 03)
person = Person.create(moment_of_birth: moment_of_birth, moment_of_graduation: moment_of_graduation)
person.decorate.moment_of_birth # ==> '2000-01-01 12:30'
person.decorate.moment_of_graduation # ==> '2018-06-06 17:00'
```

This shortcut uses the gem's default datetime format (%Y-%m-%d %H:%M), or the format set in your initializer.

You could also provide a context when initializing your decorator, and tell it to return datetimes in a humanized format. The humanized format can also be set in your initializer.

```ruby
moment_of_birth = DateTime.new(2000, 1, 1, 12, 30, 59)
person = Person.create(moment_of_birth: moment_of_birth)
person.decorate(context: { humanize: true }).moment_of_birth # ==> '12:30 01/01/2000'
```

#### to_time_format

This shortcut adds a method to your decorator that returns the formatted time. It can accept 1 or more attributes of type DateTime or Time.

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  to_time_format :moment_of_birth, :moment_of_graduation
end

moment_of_birth = Time.new(2000, 1, 1, 12, 30, 59)
moment_of_graduation = Time.new(2018, 6, 6, 17, 00, 03)
person = Person.create(moment_of_birth: moment_of_birth, moment_of_graduation: moment_of_graduation)
person.decorate.moment_of_birth # ==> '12:30'
person.decorate.moment_of_graduation # ==> '17:00'
```

This shortcut uses the gem's default time format (%H:%M), or the format set in your initializer. This shortcut does not have an option for a humanized format.

#### to_precision_number

This shortcut adds a method to your decorator that returns the provided numbers as strings with a specific number of decimal places. It can accept 1 or more number attributes and a precision. If you would like to use different precisions for different attributes, you can use the shortcut multiple times.

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  to_precision_number :salary, :coffee_budget, precision: 2
  to_precision_number :height_in_meters, precision: 3
end

person = Person.create(salary: 1000, coffee_budget: 20, height_in_meters: 1.8516)
person.decorate.salary # ==> '1000.00'
person.decorate.coffee_budget # ==> '20.00'
person.decorate.height_in_meters # ==> '1.852'
```

#### to_attachment

To use this shortcut, you need to enable it in your initializer (see details above).

This shortcut adds 4 methods to your decorator for each of the specified attachments. Those methods return the attachment's URL, filename, signed-id, and preview-URL.

The preview is based on the gem's default preview-transform, or the transform set in your initializer. If you would like to override the transform in your decorator, you can provide a `preview_transform` option along with the attachment attributes. If you would like to use different transforms for different attributes, you can use the shortcut multiple times.

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  to_attachment :profile_picture, :resume
  to_attachment :birth_certificate, preview_transform: :thumbnail
end

person = Person.create(profile_picture: ..., resume: ..., birth_certificate: ...)
person.decorate.profile_picture_url
person.decorate.profile_picture_name
person.decorate.profile_picture_preview
person.decorate.profile_picture_signed_id
...
```

### Formatters

It is also possible to use the formatters directly, without the shortcuts. This gives you the flexibility to set different method names or use additional logic.

```ruby
class PersonDecorator < Draper::Decorator
  include DecoratorDryer

  def first_birthday
    format_date(object.date_of_birth)
  end

  def birth_datetime
    format_datetime(moment_of_birth)
  end

  def when_is_lunch
    format_time(lunch_time)
  end

  def income
    format_precision_number(salary, precision: 2)
  end
end
```

## To Do

* Enable formats to be overridden when calling shortcuts.
* Add support for additional attachment libraries.
* Add a more flexible replacement for the `to_name` shortcut.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `spec` to run the tests.

To release a new version of this gem, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CodeTectonics/decorator_dryer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/CodeTectonics/decorator_dryer/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DecoratorDryer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/CodeTectonics/decorator_dryer/blob/master/CODE_OF_CONDUCT.md).

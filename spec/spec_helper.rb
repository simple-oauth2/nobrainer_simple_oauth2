ENV['RAILS_ENV'] ||= 'test'
ENV['ORM']       ||= 'nobrainer'

if RUBY_VERSION >= '1.9'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    add_filter '/spec/'
    minimum_coverage(90)
  end
end

require 'ffaker'
require 'nobrainer'

require 'support/helper'
require 'support/mixins'

RSpec.configure do |config|
  config.include Helper

  config.filter_run_excluding skip_if: true

  config.order = :random
  config.color = true

  config.before(:all) do
    NoBrainer::Document::PrimaryKey.__send__(:remove_const, :DEFAULT_PK_NAME)
    NoBrainer::Document::PrimaryKey.__send__(:const_set,    :DEFAULT_PK_NAME, :_id_)

    NoBrainer.configure(&nobrainer_conf)
    NoBrainer.sync_schema
  end

  config.before(:each) do
    NoBrainer.purge!
    NoBrainer::Loader.cleanup
  end
end

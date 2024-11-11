# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

if ENV['COVERAGE']
  require File.join(File.dirname(File.expand_path(__FILE__)), 'minitest_rack_coverage')
  SimpleCov.minitest_rack_coverage
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'rubygems'
require 'rack/test'
require 'minitest/rack'
require 'minitest/autorun'
require 'minitest/hooks/default'
# require 'minitest/assert_errors'
require 'minitest/rg'

# used by rack/json tests
require 'sqlite3'
require 'sequel'

DB = Sequel.sqlite # :memory

DB.create_table(:users) do
  primary_key :id
  column :name, :text
  column :email, :text
end

class User < Sequel::Model
  plugin :json_serializer
end

# rubocop:disable Style/ClassAndModuleChildren
class Minitest::HooksSpec
  around(:all) do |&block|
    DB.transaction(rollback: :always) { super(&block) }
  end

  around do |&block|
    DB.transaction(rollback: :always, savepoint: true, auto_savepoint: true) { super(&block) }
  end

  if defined?(Capybara)
    after do
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
# rubocop:enable Style/ClassAndModuleChildren

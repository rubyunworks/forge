require 'rubygems'
require_gem 'rspec'
require 'spec'
$:.unshift('lib')
require 'meta_project'
require 'rscm'

def init(cls)
  begin
    cls.new
  rescue ArgumentError
    fail("#{cls.name} doesn't have a no-arg constructor")
  end
end


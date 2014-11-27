require "sablon/version"
require "sablon/template"
require "sablon/processor"
require "sablon/processor/section_properties"
require "sablon/parser/mail_merge"
require "sablon/operations"
require "sablon/image"
require 'zip'
require 'nokogiri'

module Sablon
  class TemplateError < ArgumentError; end
  class ContextError < ArgumentError; end

  def self.template(path)
    Template.new(path)
  end
end

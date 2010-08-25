require 'rubygems'
require 'appscript'

# Tiny class to assist in the creation of things to-dos
class Task
  include Appscript

  def initialize(name, notes)
    app('Things').make(
      :new => :to_do,
      :with_properties => { 
        :name => name,
        :notes => "#{notes}"
      }
    )
  end
end


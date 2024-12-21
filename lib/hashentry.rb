# frozen_string_literal: true

# Class that defines the structure of a Hash Entry
class HashEntry
  attr_accessor :key, :value

  def initialize(key = nil, value = nil)
    @key = key
    @value = value
  end

  def hash_entry_to_s
    "[#{@key}, #{@value}]"
  end
end

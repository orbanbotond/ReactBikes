# frozen_string_literal: true

def create_temporary_class(klass, subklass = Object, &block)
  temporary_class = Class.new(subklass)

  temporary_class.class_exec(&block) if block_given?

  stub_const klass, temporary_class
end

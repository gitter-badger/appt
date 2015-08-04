module Appt
  # Defines constants and methods related to configuration
  module Configuration
    UNKNOWN_CLASSES = {
      parent_mailer: -> { ActionMailer::Base },
      parent_controller: -> { ::ApplicationController },
      user_class: -> { nil },
    }

    UNKNOWN_CLASSES.each do |key, _default|
      attr_accessor key.to_sym

      define_method(key) do
        value = instance_variable_get("@#{key}") || UNKNOWN_CLASSES[key.to_sym]
        value = value.call if value.respond_to?(:call)
        c = force_to_constant(value)
        c
      end
    end

    VALID_OPTIONS_KEYS = [
    ].freeze

    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their
    # default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Reset all configuration options to defaults
    def reset
      self
    end

  private

    def force_to_constant(value)
      if value.is_a?(Class)
        value = value.name
      elsif value.is_a?(Symbol)
        value = value.to_s
      end

      value.try(:constantize)
    end
  end
end


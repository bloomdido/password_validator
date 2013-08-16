module ActiveModel
  module Validations
    class PasswordValidator < ActiveModel::Validator

      # Using multiple validators for passwords sucks because either the user receives a flood of
      # (often redundant) errors, or each validation must become conditional, which can get complex
      # fairly quickly.
      #
      # This class attempts to perform validations in a specific order of importance and only displays
      # the errors that are relevant.
      #
      # todo: add tests
      # todo: add more options
      # todo: check for password strength
      # todo: use I18n for errors

      def validate(record)
        @password = record.password
        @password_confirmation = record.password_confirmation

        default_options
                
        # skip checks if record already saved and password is not being updated
        return if record.persisted? && @password.blank?

        case
        when blank?
          record.errors.add(:password, "can't be blank")
        when too_short?
          record.errors.add(:password, "must be a minimum of #{options[:min_length]} characters in length")
        when too_common?
          record.errors.add(:password, "is too common")
        when not_confirmed?
          record.errors.add(:password_confirmation, "doesn't match password")
        end
      end

      def default_options
        options[:presence] = true unless options.has_key?(:presence)
        options[:common] = true unless options.has_key?(:common)
        options[:confirmation] = true unless options.has_key?(:confirmation)
      end

      def blank?
        options[:presence] && @password.blank?
      end

      def too_short?
        options[:min_length] && @password.length < options[:min_length]
      end

      def too_common?
        # todo: improve this
        common_passwords = %w(password qwerty abc123 abcdef 123456 111111)
        options[:common] && common_passwords.include?(@password)
      end

      def not_confirmed?
        options[:confirmation] && @password_confirmation != @password
      end
    end
  end
end

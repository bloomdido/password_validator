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

        # return if record.persisted? && @password.blank?

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

      def blank?
        @password.blank?
      end

      def too_short?
        options[:min_length] && @password.length < options[:min_length]
      end

      def too_common?
        # todo: improve this
        %w(password qwerty abc123 abcdef 123456 111111).include? @password
      end

      def not_confirmed?
        @password_confirmation != @password
      end
    end
  end
end
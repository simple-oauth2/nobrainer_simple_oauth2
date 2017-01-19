module NoBrainer
  module Simple
    module OAuth2
      # Client role mixin for NoBrainer.
      # Includes all the required API, associations, validations and callbacks.
      module Client
        extend ActiveSupport::Concern

        # Fields Declaration.
        include NoBrainer::Simple::OAuth2::Fields::Client

        included do
          # Database updates are skipped when no attributes changed during a save.
          # This callback is always triggered even when no attributes changed.
          # @see http://nobrainer.io/docs/timestamps/
          #
          before_save { self.updated_at = Time.now }

          # Returns associated AccessToken array.
          #
          # @return [Array<Object>] AccessToken array.
          #
          has_many :access_tokens, class_name: ::Simple::OAuth2.config.access_token_class_name, foreign_key: :client_id

          # Returns associated AccessGrant array.
          #
          # @return [Array<Object>] AccessGrant array.
          #
          has_many :access_grants, class_name: ::Simple::OAuth2.config.access_grant_class_name, foreign_key: :client_id

          # Searches for Client record with the specific `#key` value.
          #
          # @param key [#to_s] key value (any object that responds to `#to_s`).
          #
          # @return [Object, nil] Client object or nil if there is no record with such `#key`.
          #
          def self.by_key(key)
            where(key: key.to_s).first
          end
        end
      end
    end
  end
end

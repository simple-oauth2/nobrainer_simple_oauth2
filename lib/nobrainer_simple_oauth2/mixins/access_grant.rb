module NoBrainer
  module Simple
    module OAuth2
      # Includes all the required API, associations, validations and callbacks
      module AccessGrant
        extend ActiveSupport::Concern

        include NoBrainer::Simple::OAuth2::Fields::AccessGrant

        included do
          belongs_to :client, class_name: ::Simple::OAuth2.config.client_class_name,
                              foreign_key: :client_id, primary_key: :id
          belongs_to :resource_owner, class_name: ::Simple::OAuth2.config.resource_owner_class_name,
                                      foreign_key: :resource_owner_id, primary_key: :id

          before_save { self.updated_at = Time.now }
          before_validation :setup_expiration, if: :new_record?

          # Searches for AccessGrant record with the specific token value
          #
          # @param token [#to_s] token value (any object that responds to `#to_s`)
          #
          # @return [AccessGrant, nil] AccessGrant object or nil if there is no record with such `#token`
          #
          scope(:by_token) { |token| where(token: token.to_s).first }

          # Create a new AccessGrant object
          #
          # @param client [Object] Client instance
          # @param resource_owner [Object] ResourceOwner instance
          # @param redirect_uri [String] Redirect URI callback
          # @param scopes [String] set of scopes
          #
          # @return [AccessGrant] AccessGrant object
          #
          def self.create_for(client, resource_owner, redirect_uri, scopes = nil)
            create(
              client_id: client.id,
              resource_owner_id: resource_owner.id,
              redirect_uri: redirect_uri,
              scopes: scopes
            )
          end

          private

          # Set lifetime for code value during creating a new record
          #
          # @return clock [Time] time object
          #
          def setup_expiration
            self.expires_at = Time.now.utc + ::Simple::OAuth2.config.authorization_code_lifetime if expires_at.nil?
          end
        end
      end
    end
  end
end

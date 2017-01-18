module NoBrainer
  module Simple
    module OAuth2
      # Includes all the required API, associations, validations and callbacks
      module AccessToken
        extend ActiveSupport::Concern

        include NoBrainer::Simple::OAuth2::Fields::AccessToken

        included do # rubocop:disable Metrics/BlockLength
          before_save { self.updated_at = Time.now }
          before_validation :setup_expiration, if: :new_record?

          belongs_to :client, class_name: ::Simple::OAuth2.config.client_class_name,
                              foreign_key: :client_id, primary_key: :id
          belongs_to :resource_owner, class_name: ::Simple::OAuth2.config.resource_owner_class_name,
                                      foreign_key: :resource_owner_id, primary_key: :id

          # Searches for AccessToken record with the specific `#token` value
          #
          # @param token [#to_s] token value (any object that responds to `#to_s`)
          #
          # @return [AccessToken, nil] AccessToken object or nil if there is no record with such `#token`
          #
          scope(:by_token) { |token| where(token: token.to_s).first }

          # Returns an instance of the AccessToken with specific `#refresh_token` value
          #
          # @param refresh_token [#to_s] refresh token value (any object that responds to `#to_s`)
          #
          # @return [AccessToken, nil] AccessToken object or nil if there is no record with such `#refresh_token`
          #
          scope(:by_refresh_token) { |refresh_token| where(refresh_token: refresh_token.to_s).first }

          # Create a new AccessToken object
          #
          # @param client [Object] Client instance
          # @param resource_owner [Object] ResourceOwner instance
          # @param scopes [String] set of scopes
          #
          # @return [AccessToken] AccessToken object
          #
          def self.create_for(client, resource_owner, scopes = nil)
            create(
              client_id: client.id,
              resource_owner_id: resource_owner.id,
              scopes: scopes
            )
          end

          # Indicates whether the object is expired (`#expires_at` present and expiration time has come)
          #
          # @return [Boolean] true if object expired and false in other case
          #
          def expired?
            expires_at && Time.now.utc > expires_at
          end

          # Indicates whether the object has been revoked
          #
          # @return [Boolean] true if revoked, false in other case
          #
          def revoked?
            revoked_at && revoked_at <= Time.now.utc
          end

          # Revokes the object (updates `:revoked_at` attribute setting its value to the specific time)
          #
          # @param clock [Time] time object
          #
          def revoke!(revoked_at = Time.now.utc)
            update!(revoked_at: revoked_at)
          end

          # Exposes token object to Bearer token
          #
          # @return [Hash] bearer token instance
          #
          def to_bearer_token
            {
              access_token: token,
              expires_in: expires_at && ::Simple::OAuth2.config.access_token_lifetime.to_i,
              refresh_token: refresh_token,
              scope: scopes
            }
          end

          private

          # Set lifetime for token value during creating a new record
          #
          # @return clock [Time] time object
          #
          def setup_expiration
            expires_in = ::Simple::OAuth2.config.access_token_lifetime.to_i
            self.expires_at = Time.now.utc + expires_in if expires_at.nil? && !expires_in.nil?
          end
        end
      end
    end
  end
end

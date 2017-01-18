module NoBrainer
  module Simple
    module OAuth2
      # Includes all the required API, associations, validations and callbacks
      module ResourceOwner
        extend ActiveSupport::Concern

        include NoBrainer::Simple::OAuth2::Fields::ResourceOwner

        included do
          # Searches for ResourceOwner record with the specific params
          #
          # @param _client [Object] Client instance
          # @param username [String, #to_s] username value (any object that responds to `#to_s`)
          # @param password [String] password value
          #
          # @return [ResourceOwner, nil] ResourceOwner object or nil if there is no record with such params
          #
          def self.oauth_authenticate(_client, username, password)
            user = where(username: username.to_s).first
            user if user && user.encrypted_password == password
          end
        end
      end
    end
  end
end

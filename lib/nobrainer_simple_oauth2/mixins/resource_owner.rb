module NoBrainer
  module Simple
    module OAuth2
      # Includes all the required API, associations, validations and callbacks
      module ResourceOwner
        extend ActiveSupport::Concern

        included do
          include ::NoBrainer::Document

          field :username, type: String, required: true, index: true, uniq: true
          field :encrypted_password, type: String, required: true, length: (8..32)

          # Searches for ResourceOwner record with the specific params
          #
          # @param [_client] Client instance
          # @param username [#to_s] username value (any object that responds to `#to_s`)
          # @param [password] password value
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

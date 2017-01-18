module NoBrainer
  module Simple
    module OAuth2
      module Fields
        # Defines a AccessToken model with next fields
        module AccessToken
          extend ActiveSupport::Concern

          included do
            include ::NoBrainer::Document
            include ::NoBrainer::Document::Timestamps

            field :resource_owner_id, type: String, index: true, required: true
            field :client_id,         type: String, index: true, required: true
            field :token,
                  type: String,
                  index: true,
                  required: true,
                  uniq: true,
                  default: -> { ::Simple::OAuth2.config.token_generator.generate }
            field :refresh_token,
                  type: String,
                  index: true,
                  uniq: true,
                  default: -> do
                    ::Simple::OAuth2.config.issue_refresh_token ? ::Simple::OAuth2.config.token_generator.generate : ''
                  end

            field :scopes,     type: String

            field :revoked_at, type: Time
            field :expires_at, type: Time, required: true
            field :created_at, type: Time, required: true, default: -> { Time.now }
            field :updated_at, type: Time, required: true, default: -> { Time.now }
          end
        end
      end
    end
  end
end

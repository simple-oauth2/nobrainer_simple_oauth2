module NoBrainer
  module Simple
    module OAuth2
      module Fields
        # Defines a AccessGrant model with next fields
        module AccessGrant
          extend ActiveSupport::Concern

          included do
            include ::NoBrainer::Document
            include ::NoBrainer::Document::Timestamps

            field :resource_owner_id, type: String, index: true, required: true
            field :client_id,         type: String, index: true, required: true

            field :token,
                  type: String,
                  required: true,
                  uniq: true,
                  index: true,
                  default: -> { ::Simple::OAuth2.config.token_generator.generate }

            field :redirect_uri, type: String, required: true
            field :scopes,       type: String

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

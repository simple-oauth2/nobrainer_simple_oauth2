module NoBrainer
  module Simple
    module OAuth2
      module Fields
        # Defines a ResourceOwner model with next fields
        module ResourceOwner
          extend ActiveSupport::Concern

          included do
            include ::NoBrainer::Document
            include ::NoBrainer::Document::Timestamps

            field :username, type: String, required: true, index: true, uniq: true
            field :encrypted_password, type: String, required: true, length: (8..32)

            field :created_at, type: Time, required: true, default: -> { Time.now }
            field :updated_at, type: Time, required: true, default: -> { Time.now }
          end
        end
      end
    end
  end
end

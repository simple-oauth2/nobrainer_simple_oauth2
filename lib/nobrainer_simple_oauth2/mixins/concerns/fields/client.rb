module NoBrainer
  module Simple
    module OAuth2
      module Fields
        # Defines a Client model with next fields
        module Client
          extend ActiveSupport::Concern

          included do
            include ::NoBrainer::Document
            include ::NoBrainer::Document::Timestamps

            field :name,         type: String, required: true
            field :redirect_uri, type: String, required: true

            field :key,
                  type: String,
                  required: true,
                  index: true,
                  uniq: true,
                  default: -> { ::Simple::OAuth2.config.token_generator.generate }
            field :secret,
                  type: String,
                  required: true,
                  index: true,
                  uniq: true,
                  default: -> { ::Simple::OAuth2.config.token_generator.generate }

            field :created_at, type: Time, required: true, default: -> { Time.now }
            field :updated_at, type: Time, required: true, default: -> { Time.now }
          end
        end
      end
    end
  end
end

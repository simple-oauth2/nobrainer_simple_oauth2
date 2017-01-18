module NoBrainer
  module Simple
    module OAuth2
      module Fields
        # Defines a ResourceOwner model with next fields
        module ResourceOwner
          extend ActiveSupport::Concern

          included do
            include ::NoBrainer::Document

            field :username, type: String, required: true, index: true, uniq: true
            field :encrypted_password, type: String, required: true, length: (8..32)
          end
        end
      end
    end
  end
end

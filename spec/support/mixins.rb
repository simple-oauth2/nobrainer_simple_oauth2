require File.expand_path('../../../lib/nobrainer_simple_oauth2', __FILE__)

class Client
  include NoBrainer::Simple::OAuth2::Client
end

class AccessToken
  include NoBrainer::Simple::OAuth2::AccessToken
end

class AccessGrant
  include NoBrainer::Simple::OAuth2::AccessGrant
end

class User
  include NoBrainer::Simple::OAuth2::ResourceOwner
end

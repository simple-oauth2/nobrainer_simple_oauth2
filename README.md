# NoBrainer SimpleOAuth2

[![Build Status](https://travis-ci.org/simple-oauth2/nobrainer_simple_oauth2.svg?branch=master)](https://travis-ci.org/simple-oauth2/nobrainer_simple_oauth2)
[![Dependency Status](https://gemnasium.com/badges/github.com/simple-oauth2/nobrainer_simple_oauth2.svg)](https://gemnasium.com/github.com/simple-oauth2/nobrainer_simple_oauth2)
[![Coverage Status](https://coveralls.io/repos/github/simple-oauth2/nobrainer_simple_oauth2/badge.svg)](https://coveralls.io/github/simple-oauth2/nobrainer_simple_oauth2)
[![Code Climate](https://codeclimate.com/github/simple-oauth2/nobrainer_simple_oauth2/badges/gpa.svg)](https://codeclimate.com/github/simple-oauth2/nobrainer_simple_oauth2)
[![security](https://hakiri.io/github/simple-oauth2/nobrainer_simple_oauth2/master.svg)](https://hakiri.io/github/simple-oauth2/nobrainer_simple_oauth2/master)
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/simple-oauth2/nobrainer_simple_oauth2/blob/master/LICENSE)

[NoBrainer](http://nobrainer.io/) mixin for [simple_oauth2](https://github.com/simple-oauth2/simple_oauth2). Includes all the required API, associations, validations and callbacks.

## Installation

Add this line to your application's *Gemfile:*

```ruby
gem 'nobrainer_simple_oauth2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nobrainer_simple_oauth2

## Usage

*OAuth2* workflow implies the existence of the next four roles: **Access Token**, **Access Grant**, **Application** and **Resource Owner**. The gem needs to know what classes work, you need to create them and configure [Simple::OAuth2](https://github.com/simple-oauth2/simple_oauth2). Your project must include 4 models - *AccessToken*, *AccessGrant*, *Client* and *User* **for example**. These models must contain a specific set of API (methods).

***AccessToken*** class:
```ruby
  # app/models/access_token.rb

  class AccessToken
    include NoBrainer::Simple::OAuth2::AccessToken
  end
```

***AccessGrant*** class:
```ruby
  # app/models/access_grant.rb

  class AccessGrant
    include NoBrainer::Simple::OAuth2::AccessGrant
  end
```

***Client*** class:
```ruby
  # app/models/client.rb

  class Client
    include NoBrainer::Simple::OAuth2::Client
  end
```

***User*** class:
```ruby
  # app/models/user.rb

  class User
    include NoBrainer::Simple::OAuth2::ResourceOwner
  end
```
And that's it.
Also you can take a look at the [mixins](https://github.com/simple-oauth2/nobrainer_simple_oauth2/tree/master/lib/nobrainer_simple_oauth2/mixins) to understand what they are doing and what they are returning.

## Bugs and Feedback

Bug reports and feedback are welcome on GitHub at https://github.com/simple-oauth2/nobrainer_simple_oauth2/issues.

## Contributing

1. Fork the project.
1. Create your feature branch (`git checkout -b my-new-feature`).
1. Implement your feature or bug fix.
1. Add documentation for your feature or bug fix.
1. Add tests for your feature or bug fix.
1. Run `rake` and `rubocop` to make sure all tests pass.
1. Commit your changes (`git commit -am 'Add new feature'`).
1. Push to the branch (`git push origin my-new-feature`).
1. Create new pull request.

Thanks.

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/simple-oauth2/nobrainer_simple_oauth2/blob/master/LICENSE).

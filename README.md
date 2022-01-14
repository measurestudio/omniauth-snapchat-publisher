# Omniauth::SnapchatPublisher

A OmniAuth strategy for Snapchat Publisher

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-snapchat-publisher', github: 'measurestudio/omniauth-snapchat-publisher'
```

And then execute:

    $ bundle install

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :snapchat, ENV["SNAPCHAT_CLIENT_ID"], ENV["SNAPCHAT_CLIENT_SECRET"], scope: ENV["SNAPCHAT_SCOPES"], setup: true
end
```

## Auth Hash

Here's an example Auth Hash available in `request.env['omniauth.auth']`:

```ruby
{
  provider: 'snapchat',
  uid: 'CAvJQ2/adr9EIS1fUOubMJIjjPCxarc7CK4',
  info: {
    display_name: 'SnapName',
    external_id: 'CAvJQ2/adr9EIS1fUOubMJIjjPCxarc7CK4',
    avatar: 'https://sdk.bitmoji.com/render/panel/20745505asjdkasjh'
  },
  credentials: {
    token: 'ABCDEF...',
    refresh_token: 'XYZAKJS...',
    expires_at: 1321747205,
    expires: true
  },
  extra: {
    raw_info: {
       display_name: 'SnapName',
        external_id: 'CAvJQ2/adr9EIS1fUOubMJIjjPCxarc7CK4',
        avatar: 'https://sdk.bitmoji.com/render/panel/20745505asjdkasjh'
    }
  },
  errors: []
}

```

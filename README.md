# Shelby.tv

This is a Ruby wrapper for the [Shelby.tv](http://shelby.tv/) API. It uses objects instead of hashes and add associations.

## Installation

Install it as a gem (in your `Gemfile`) and its dependencies:

    gem "shelbytv"

## Usage

Get a Shelby object:

    shelbytv = Shelbytv::Base.new("CONSUMER_KEY", "CONSUMER_SECRET",
                                  "AUTH_TOKEN", "AUTH_SECRET")

Get current user:

    user = shelbytv.user    # Returns a Shelbytv::User object

Get a user by id:

    user = shelbytv.users.find('ID')  # Returns a Shelbytv::User object

Get the current users channels:

    shelbytv.channels.all   # Returns an array for Shelbytv::Channel objects

    # or

    user.channels           # Returns an array for Shelbytv::Channel objects

Get a channels broadcasts:

    channel.broadcasts    # Returns an array for Shelbytv::Broadcast objects

### Authentication

First, you need to [register your application](http://dev.shelby.tv/myapps).

#### Web server application

Get a Shelby object:

    shelbytv = Shelbytv::Base.new("CONSUMER_KEY", "CONSUMER_SECRET")

Redirect users to the Shelby authentication page. You need to pass your `callback_url`. Get the url to redirect to with:

    shelbytv.authorize_url("CALLBACK_SESSION_URL")

Then Shelby.tv will redirect the user to your callback url with a code parameter in the url. Exchange this code for an access token using:

    access_token = shelbytv.access_token("OAUTH_VERIFIER")

Now you can get a Shelby using only an access token and make requests on user's behalf:

    shelbytv.auth_token = access_token.token
    shelbytv.auth_secret = access_token.secret

#### License

See `LICENSE`

#### Built at [Hackday.tv](http://hackday.tv/)


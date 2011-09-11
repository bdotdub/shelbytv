require 'rubygems'
require 'oauth'
require 'sinatra'

$:.unshift '../lib'

require 'shelbytv'

CONSUMER_KEY = '<INSERT YOUR KEY HERE>'
CONSUMER_SECRET = '<INSERT YOUR SECRET HERE>'

enable :sessions

get '/' do
  erb :index
end

# Authentication

get '/auth' do
  url = client.authorize_url
  session[:request_token] = client.request_token
  redirect url
end

get '/auth/callback' do
  client.request_token = session.delete(:request_token)
  access_token = client.access_token(params[:oauth_verifier])

  session[:auth_token] = access_token.token
  session[:auth_secret] = access_token.secret

  redirect '/user'
end

# Utility

get '/logout' do
  session.delete(:auth_token)
  session.delete(:auth_secret)
  session.delete(:user)
  redirect '/'
end

# API / Fun Stuff!

get '/user' do
  @user = session[:user] = client.user
  erb :user
end

get '/user/channels' do
  @channels = session[:user].channels
  @user = session[:user]
  erb :channels
end

get '/user/channels/:channel_id' do
  @channel = client.channels.find(params[:channel_id])
  @broadcasts = @channel.broadcasts
  erb :channel
end

helpers do

  def client
    @_client ||= Shelbytv::Base.new(CONSUMER_KEY, CONSUMER_SECRET, session[:auth_token], session[:auth_secret])
  end

end

__END__

@@ layout
<!DOCTYPE html>
<html>
  <head>
    <title>Simple App</title>
    <style type='text/css'>
      * { margin: 0; padding: 0; }

      body {
        font-family: 'Helvetica Neue', Helvetica, Arial, san-serif;
      }

      #container {
        margin: 15px auto;
        width: 800px;
      }
    </style>
  </head>
  <body>
    <div id='container'>
      <%= yield %>
    </div>
  </body>
</html

@@ index

  <a href='/auth'>Sign in with Shelby</a>

@@ user

  <h2>Welcome <%= @user.name %></h2>

  <a href='/user/channels'>View channels</a>

@@ channels

  <h2><%= @user.name %>'s Channels</h2>
  <ul>
    <% @channels.each do |channel| %>
      <li>
        <a href='/user/channels/<%= channel.id %>'><%= channel.name %></a>
      </li>
    <% end %>
  </ul>

@@ channel

  <h2><%= @channel.name %></h2>
  <ul>
    <% @broadcasts.each do |broadcast| %>
      <li>
        <strong><%= broadcast.name %></strong>
        <%= broadcast.description %>
        <br />
        <a href='http://shelby.tv/#!/<%= broadcast.user_nickname %>/broadcasts/<%= broadcast.id %>'>
          link
        </a>
      </li>
    <% end %>
  </ul>

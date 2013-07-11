require 'evernote_oauth'

class OauthController < ApplicationController
	def initialize
		@client = EvernoteOAuth::Client.new(
		  consumer_key: 'kjsery',
		  consumer_secret: 'e819b5887b9342c7',
		  sandbox: true
		)
	end
	def auth
		@request_token = @client.request_token(:oauth_callback => 'http://localhost:3000/token')
		session[:request_token] = @request_token
		redirect_to @request_token.authorize_url
	end
	def token
		if session[:request_token]
			@access_token = session[:request_token].get_access_token(oauth_verifier: params[:oauth_verifier])	
			session[:access_token] = @access_token
		else
			redirect_to :auth
		end
	end
end

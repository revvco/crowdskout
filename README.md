# Crowdskout

[![Build Status](https://travis-ci.org/revvco/crowdskout.png?branch=master)](https://travis-ci.org/revvco/crowdskout) [![Gem Version](https://badge.fury.io/rb/crowdskout.svg)](https://badge.fury.io/rb/crowdskout) [![Code Climate](https://codeclimate.com/github/revvco/crowdskout/badges/gpa.svg)](https://codeclimate.com/github/revvco/crowdskout)

A Ruby wrapper for the Crowdskout API.

Crowdskout API documentation can be found [here](http://docs.crowdskout.com/api/#get-the-options-for-a-field)

## Installation

Add this line to your application's Gemfile:

    gem 'crowdskout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crowdskout

## Usage

**Example for OAuth provider:**

	require 'crowdskout'

	oauth_provider = Crowdskout::Auth::OAuth2.new(
        :api_key => client_id,
        :api_secret => client_secret,
        :redirect_url => redirect_uri
      ) 

	url = oauth_provider.get_authorization_url("a_state_param")
	
	# after post to URL and granting access
	access_token = oauth_provider.get_access_token(params[:code])

**Example for Crowdskout API:**

	require 'crowdskout'

	api = Crowdskout::Api.new(api_key, access_token)

	# Fetching profiles
	profile = api.get_profile(164)

	# Fetching field options
	field_options = api.get_options_for_a_field("AddressCity")

	# Fetching attributes
	attributes = api.get_attributes

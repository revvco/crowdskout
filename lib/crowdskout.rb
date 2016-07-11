# Copyright, 2016, by Kyle Schutt.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'rubygems'
require 'rest_client'
require 'json'
require 'cgi'
require 'cgi/session'
require 'cgi/session/pstore'
require 'openssl'
require 'base64'

module Crowdskout
  autoload :Api, 'crowdskout/api'
  autoload :VERSION, 'crowdskout/version'

  module Auth
    autoload :OAuth2, 'crowdskout/auth/oauth2'
  end

  module Services
    autoload :BaseService, 'crowdskout/services/base_service'
    autoload :ProfileService, 'crowdskout/services/profile_service'
    autoload :FieldService, 'crowdskout/services/field_service'
    autoload :AttributeService, 'crowdskout/services/attribute_service'
    autoload :QuartermasterService, 'crowdskout/services/quartermaster_service'
  end  

  module Components
    autoload :Component, 'crowdskout/components/component'
    autoload :ResultSet, 'crowdskout/components/result_set'
    autoload :Attribute, 'crowdskout/components/attributes/attribute'
    autoload :Option, 'crowdskout/components/attributes/option'
    autoload :Profile, 'crowdskout/components/profiles/profile'
    autoload :Collection, 'crowdskout/components/profiles/collection'
    autoload :Item, 'crowdskout/components/profiles/item'
    autoload :Field, 'crowdskout/components/profiles/field'
    autoload :Value, 'crowdskout/components/profiles/value'
    autoload :FieldOptions, 'crowdskout/components/fields/field_options'
    autoload :TrackingCode, 'crowdskout/components/quartermaster/tracking_code'
  end

  module Exceptions
    autoload :OAuth2Exception, 'crowdskout/exceptions/oauth2_exception'
    autoload :ServiceException, 'crowdskout/exceptions/service_exception'
  end

  module Util
    autoload :Config, 'crowdskout/util/config'
    autoload :Helpers, 'crowdskout/util/helpers'
  end
end
require 'rack/ssl'
require 'rack/protection'
require 'yaml'

use Rack::CommonLogger

if ENV["RACK_ENV"] == "production"
  use Rack::SSL
end

use Rack::Protection::HttpOrigin
use Rack::Protection::FrameOptions

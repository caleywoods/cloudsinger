require './app'
# this let's us serve static files from public/css
# and public/images
use Rack::Static, :urls => ["/css", "/images"], :root => "public"
run Sinatra::Application

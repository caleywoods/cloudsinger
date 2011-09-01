require 'sinatra'
require 'yaml'
require 'twilio'

CALLER_ID = config['caller_id']

# You need to replace the entries in config.yml
# with your own twilio information like so:
#
# caller_id  = your twilio phone number
# twilio_sid = your twilio sid, keep this private
# twilio_tkn = your twilio token, keep this private
#
# You can access these later with config['param']
# where param is replaced by an option in the yaml
# file.
config = YAML.load_file('./config/config.yml')

get '/' do
  haml :index
end

post '/sms' do
  Twilio.connect(config['twilio_sid'], config['twilio_tkn'])
  number  = params[:number]
  message = params[:msg]

  # If you're using a twilio demo number you'll need
  # to include your twilio PIN as the first argument
  # here:
  #
  # Twilio::Sms.message(PIN, CALLER_ID, number, message)
  Twilio::Sms.message(CALLER_ID, number, message)

  redirect '/'
end

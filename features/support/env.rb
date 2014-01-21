$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../')
require 'lib/blinkbox/mailer'
require 'features/support/bunny-events-mock'
require 'features/support/helpers.rb'
require 'stringio'

propfile = "features/support/mailer.properties.test"
unless File.exist?(propfile)
  $stderr.puts "No properties file found."
  Process.exit(-1)
end

require 'java_properties'
options = JavaProperties::Properties.new(propfile)

require 'logger'
stdout = StringIO.new
options['logger'] = Logger.new(stdout) # replace with $stdout if you want the errors displayed in the command line
$example_outputs_location = File.expand_path('features/support/example_outputs')


begin
  $mailer_daemon = Blinkbox::Mailer::Daemon.new(options)
  $mailer_daemon.start
rescue SystemExit, Interrupt
  options['logger'].info "Thanks for watching, shutting down."
  $mailer_daemon.stop
rescue Exception => e
  options['logger'].fatal "#{e.message} (see debug log for more details)"
  options['logger'].debug "#{e.class}: #{e.message}\n#{e.backtrace.join("\n")}"
end


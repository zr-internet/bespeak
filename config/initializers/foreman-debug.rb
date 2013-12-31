# Enabled debugger with foreman, see https://github.com/ddollar/foreman/issues/58
if Rails.env.development? && ARGV.include?('--debugger')
  require 'debugger'
  Debugger.wait_connection = true

  def find_available_port
    server = TCPServer.new(nil, 0)
    server.addr[1]
  ensure
    server.close if server
  end

  port = find_available_port
  puts "Remote debugger on port #{port}"
  Debugger.start_remote(nil, port)
end
require 'socket'
require 'pry'
s = UDPSocket.new
s.bind(nil, 1234)
$pid = nil
loop do
  text, sender = s.recvfrom(16)
  case text
  when "start_horn"
    if $pid
      puts "still running horn"
    else
      puts "starting horn"
      $pid = fork{ exec 'mpg123', '--loop', '-1', './sound/klaxon.mp3' }
    end
  when "stop_horn"
    if $pid
      puts "killing"
      Process.kill("HUP", $pid)
      puts "killed"
    else
      puts "horn not sounding"
    end
  end
end
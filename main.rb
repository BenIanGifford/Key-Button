require 'socket'
require 'pry'
s = UDPSocket.new
s.bind(nil, 1234)
$klaxon_pid = nil
$explosion_pid = nil
loop do
  text, sender = s.recvfrom(16)
  case text
  when "start_horn"
    if $klaxon_pid
      puts "still running horn"
    else
      puts "starting horn"
      $klaxon_pid = fork{ exec 'mpg123', '--loop', '-1', './sound/klaxon.mp3' }
    end
  when "stop_horn"
    if $klaxon_pid
      puts "killing $klaxon_pid"
      Process.kill("HUP", $klaxon_pid)
      puts "killed $klaxon_pid"
      $klaxon_pid = nil
    else
      puts "horn not sounding"
    end
  when "classic_destroy"
    puts "classic destroyed"
    if $explosion_pid
      puts "this shouldn't trigger"
    else
      puts "starting horn"
      $explosion_pid = fork{ exec 'mpg123', '--loop', '3', './sound/rpg_shrapnel.mp3' }
    end
  end
end
require 'socket'
require 'pry'

s = UDPSocket.new
s.bind(nil, 1234)
$klaxon_pid = nil
$explosion_pid = nil
$explosion_paths = [
  "./sound/button_push1.mp3","./sound/button_push2.mp3",
  "./sound/button_push3.mp3", "./sound/button_push4.mp3",
  "./sound/button_push5.mp3", "./sound/button_push6.mp3",
]
loop do
  text, sender = s.recvfrom(16)
  case text
  when "start_horn"
    if ($klaxon_pid.to_i > 0) && !(Process.getpgid($klaxon_pid) rescue nil).nil?
      puts "still running horn"
    else
      puts "starting horn"
      $klaxon_pid = fork{ exec 'mpg123', '--loop', '-1', './sound/rogue_one_2.mp3' }
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
    puts "fire in the hole"
    $explosion_pid = fork{ exec 'mpg123', '--loop', '3', $explosion_paths.sample }
  end
end
import socket
import time

UDP_IP = "127.0.0.1"
UDP_PORT = 1234
MESSAGES = ["start_horn", "stop_horn", "classic_destroy"]

for message in MESSAGES:
	print "UDP target IP:", UDP_IP
	print "UDP target port:", UDP_PORT
	print "message:", message

	sock = socket.socket(socket.AF_INET, # Internet
	                     socket.SOCK_DGRAM) # UDP
	sock.sendto(message, (UDP_IP, UDP_PORT))
	time.sleep(5)
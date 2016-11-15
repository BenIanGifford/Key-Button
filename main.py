from gpiozero import Button
from threading import Thread
import socket

key = Button(4)
btn = Button(17)
UDP_IP = "127.0.0.1"
UDP_PORT = 1234
sock = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

def function1():
    while True:
        btn.wait_for_press()
        sock.sendto("classic_destroy", (UDP_IP, UDP_PORT))
        print("hello world, from btn")
        btn.wait_for_release()
        sock.sendto("classic_destroy", (UDP_IP, UDP_PORT))
        print("goodbye world from btn")

def function2():
    while True:
        key.wait_for_press()
        sock.sendto("start_horn", (UDP_IP, UDP_PORT))
        print("hello world from the key")
        key.wait_for_release()
        sock.sendto("stop_horn", (UDP_IP, UDP_PORT))
        print("goodbye world from the key")
        
function1 = Thread(target=function1)
function1.start()

function2 = Thread(target=function2)
function2.start()

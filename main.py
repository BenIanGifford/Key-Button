from gpiozero import Button
from threading import Thread

key = Button(4)
btn = Button(17)

def function1():
    while True:
        btn.wait_for_press()
        print("hello world, from btn")
        btn.wait_for_release()
        print("goodbye world from btn")

def function2():
    while True:
        key.wait_for_press()
        print("hello world from the key")
        key.wait_for_release()
        print("goodbye world from the key")
        
function1 = Thread(target=function1)
function1.start()

function2 = Thread(target=function2)
function2.start()

from gpiozero import Button

def key_turned():
    key_engged = True
    print("Key engaged!")

def key_released():
    key_engaged = False

def btn_pressed():
    btn_down = True
    print("Button down!")
    
def btn_released():
    btn_down = False
    
key = Button(14)
key_engaged = False
btn = Button(28)
btn_down = False

key.when_pressed = key_turned()
key.when_released = key_released()
btn.when_pressed = btn_pressed()
btn.when_released = btn.released()

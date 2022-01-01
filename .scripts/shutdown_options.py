import subprocess
import os


def showWindow(options):
    optionsString = "\n".join(options)
    output = subprocess.check_output("echo -e \"" + optionsString + "\" | rofi -dmenu -p \"Shutdown\" -lines 5 -i", shell=True, text=True).strip()
    return output


options = ["Off Screen", "Lock Screen", "Shutdown", "Reboot", "Kill Xorg"]

answer = showWindow(options)

if (answer == options[0]):
    os.system("screen_off")
elif (answer == options[1]):
    os.system("notify-send \"Maybe it's time to implement it?\"")
elif (answer == options[2]):
    os.system("shutdown now")
elif (answer == options[3]):
    os.system("reboot")
elif (answer == options[4]):
    os.system("killall Xorg")
else:
    showWindow(["Invalid argument:", answer])


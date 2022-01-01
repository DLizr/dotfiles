import subprocess
import os


def showWindow(options):
    optionsString = "\n".join(options)
    output = subprocess.check_output("echo -e \"" + optionsString + "\" | rofi -dmenu -p \"Redshift\" -lines 4 -i", shell=True, text=True).strip()
    return output


options = ["Day (5000)", "Night (3250)", "Reset", "Or type in the number."]

answer = showWindow(options)
os.system("redshift -x")

if (answer == "Day (5000)"):
    os.system("redshift -O 5000")
elif (answer == "Night (3250)"):
    os.system("redshift -O 3250")
elif (answer == "Reset"):
    pass
elif (answer.isdigit()):
    os.system("redshift -O " + answer)
else:
    showWindow(["Invalid argument:", answer])


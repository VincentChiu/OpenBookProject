"""New version written by Marcelo Santos Araujo"""

# forbid execution from Karrigell
try:
    SCRIPT_END
except NameError:
    pass
else:
    print "This script can't be executed by Karrigell"
    raise SCRIPT_END

import md5
from sys import exit
from getpass import getpass
print "Create a login/password for administrator"
login=raw_input("Login: ")
password=getpass("Password: ")
confirm_password = getpass("Password again (to confirm): ")
if password != confirm_password:
    print "Password mismatch!"
    exit()
else:
    loginDigest=md5.new(login).digest()
    passwordDigest=md5.new(password).digest()
    out=open("admin.ini","wb")
    out.write(loginDigest+passwordDigest)
    out.close()
    print "Done..!"
" Reads a line, then records value to specific pre-existing file
function! RecVal(outfile)
let myline = getline('.')
pyx << EOF
import vim
import time

def is_float(input):
  try:
    num = float(input)
  except ValueError:
    return False
  return True

def add_obs(myf, name, value):
    myd = []
    todays = time.strftime("%Y-%m-%d")
    today_ind = -1
    with open(myf) as inputfile:
        for ind, line in enumerate(inputfile):
            myd.append(line.strip().split(','))
            if todays in line:
                today_ind = ind
    varnames = [var.lower() for var in myd[0]]
    if today_ind == -1:
        myd.append([todays] + [''] * (len(varnames)-1))
        today_ind = len(myd)-1
    if name.lower() in varnames:
        yindex = varnames.index(name.lower())
        myd[today_ind][yindex] = str(value)
        with open(myf, "wb") as outputfile:
            for line in myd:
                outputfile.write((','.join(line) + '\n').encode('utf-8'))
        print("SUCCESS: " + name + " = "+str(value) + " to file " + myf)
    elif name.lower() != "na":
        print("ERROR: variable \"" + name + "\" not found")

def getNV(mystring):
    mystring = " ".join(mystring.split())
    mystring = mystring.replace(" :",":")
    mystring = mystring.replace(": ",":")
    mystring = mystring.replace(",",".")
    if mystring.count(":") != 1:
        print("ERROR: wrong string")
        return "NA", "NA"
    else:
        parts = mystring.split(":")
        name = parts[0].split(" ")[-1]
        value = parts[1].split(" ")[0]
        if name == "" or not is_float(value):
            print("ERROR: value not recognised")
            return "NA", "NA"
        else:
            return name.lower(), value

myn, myv = getNV(vim.eval("myline"))
if myn != "NA":
    add_obs(vim.eval("a:outfile"), myn, myv)

EOF
endfunction

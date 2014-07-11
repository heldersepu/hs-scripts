Dim objShell, i, j, x, c

x = inputbox("      Enter a Number","   Question",5)

'// Data validation 
'// In case is not a numeric value, is a negative #
'//   or is bigger than 50
'//   continue the execution of the program with 5
'// Case else make # Integer

if not IsNumeric(x) then
  x = 5
else if x < 1 or x > 50  then 
       x = 5
     else x = (x*2)\2
     end if
end if

Set objShell = CreateObject("WScript.Shell")
objShell.Run "notepad"
Wscript.Sleep 300


for i = 1 to x
  for j = 1 to i
    objShell.SendKeys "*"
  next
 objShell.SendKeys "{ENTER}"
next

objShell.SendKeys "{ENTER}"

j = x
do until j = 0
  for i = 1 to j
    objShell.SendKeys "*"
  next
  j = j - 1
  objShell.SendKeys "{ENTER}"
loop

objShell.SendKeys "{ENTER}"

c = 1
x = x*2 +1 
do until x < 1
  for i = 1 to x  
    objShell.SendKeys "*"
  next
  objShell.SendKeys "{ENTER}"
  for j = 1 to c	
    objShell.SendKeys " "
  next
  c = c + 1
  x = x - 2
loop

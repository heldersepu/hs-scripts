Dim myCard(5)
'Array of cards
myCard(1) = "Seven of spades"
myCard(2) = "Five of hearts"
myCard(3) = "Seven of diamonds"
myCard(4) = "Seven of clubs"
myCard(5) = "King of clubs"

Intcount = 0
'Chek for duplicate cards 
for i=1 to 4
  for y= i+1 to 5
    'Count the pairs cards if find
    if getFirst(myCard(i))= getFirst(myCard(y)) then
     Intcount= Intcount + 1
    end if 
  next
next 
Wscript.Echo Intcount & " Pairs in the Set"


'function  gets first item on the list
function getFirst(strCard)
  getFirst = left(strCard , instr(strCard," of "))
end function 


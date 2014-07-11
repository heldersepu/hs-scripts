TotalJacks = 0
TotalPicks = 0
Max = 10
For ToPick = 1 to Max
	JacksLeft = Max
	Do Until JacksLeft < ToPick
		JacksLeft = JacksLeft - ToPick
		TotalJacks = TotalJacks + ToPick
		TotalPicks = TotalPicks + 1
		'wscript.echo ToPick
	Loop
	If JacksLeft > 0 Then 
		TotalPicks = TotalPicks + 1
		TotalJacks = TotalJacks + JacksLeft
		'wscript.echo JacksLeft
	End If 
	'wscript.echo " ="&TotalJacks&" ="&TotalPicks
Next
wscript.echo "Total jacks: " & TotalJacks &_
	vbcrlf & "Total pick-ups: " & TotalPicks

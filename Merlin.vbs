' Show the Merlin windows Charater and do some tricks

Set objVoice = CreateObject("SAPI.SpVoice")
strAgentPath = "c:\windows\msagent\chars\Merlin.acs"
Set objAgent = CreateObject("Agent.Control.2")

objAgent.Connected = TRUE
objAgent.Characters.Load "Merlin", strAgentPath
Set objCharacter = objAgent.Characters.Character("Merlin")

objCharacter.MoveTo 200,150
objCharacter.Show
objCharacter.Play "GetAttention"
objCharacter.Play "GetAttentionContinued"
objCharacter.Speak "Hello, how are you?"
'objVoice.Speak "Hello, how are you?"
objCharacter.Play "LookDown"
objCharacter.Play "Think"
objCharacter.Think "Maybe I should move around a little ...."
objCharacter.MoveTo 800,600
objCharacter.MoveTo 500,600
objCharacter.MoveTo 500,400
objCharacter.Play "Pleased"
objCharacter.Speak "Goodbye."
'objVoice.Speak "Goodbye."
objCharacter.Play "Wave"
objCharacter.Hide

Do While objCharacter.Visible = TRUE
    Wscript.Sleep 250
Loop
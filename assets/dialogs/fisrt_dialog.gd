extends DialogueEngine

func _setup() -> void:
	add_text_entry("Johny [shake rate=20.0 level=5 connected=1]WTF[/shake] are you on my PC?").set_metadata("name", "You")
	add_text_entry("[wave amp=10.0 freq=5.0 connected=1]Chill bro[/wave], I want to show you my last purchase").set_metadata("name", "John")
	add_text_entry("Just look at that, it was too good").set_metadata("name", "John")
	add_text_entry("Oh man, what kind of garbage you brought this time?").set_metadata("name", "You")
	add_text_entry("Listen, I got it for [rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]free[/rainbow], just stop trashing").set_metadata("name", "John")
	add_text_entry("Ok sure, but leave [b]my[/b] PC alone").set_metadata("name", "You")
	add_text_entry("Just do it on your own >->").set_metadata("name", "You")
	add_text_entry("Nah, it should be fine").set_metadata("name","John")
	add_text_entry("U serious?").set_metadata("name", "You")
	add_text_entry("C'mon man, are you going to cry or what?").set_metadata("name", "John")
	add_text_entry("[shake rate=20.0 level=5 connected=1]That's freaking ridiculous man[/shake]").set_metadata("name", "You")

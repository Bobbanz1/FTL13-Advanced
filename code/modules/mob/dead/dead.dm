//Dead mobs can exist whenever. This is needful

INITIALIZE_IMMEDIATE(/mob/dead)

/mob/dead/Initialize()
	if(initialized)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	initialized = TRUE
	tag = "mob_[next_mob_id++]"
	GLOB.mob_list += src

	prepare_huds()

	if(length(CONFIG_GET(keyed_string_list/cross_server)))
		verbs += /mob/dead/proc/server_hop
	return INITIALIZE_HINT_NORMAL

/mob/dead/dust()	//ghosts can't be vaporised.
	return

/mob/dead/gib()		//ghosts can't be gibbed.
	return

/mob/dead/ConveyorMove()	//lol
	return



/mob/dead/proc/server_hop()
	set category = "OOC"
	set name = "Server Hop!"
	set desc= "Jump to the other server"
	if(notransform)
		return
	var/list/csa = CONFIG_GET(keyed_string_list/cross_server)
	var/pick
	switch(csa.len)
		if(0)
			verbs -= /mob/dead/proc/server_hop
			to_chat(src, "<span class='notice'>Server Hop has been disabled.</span>")
		if(1)
			pick = csa[0]
		else
			pick = input(src, "Pick a server to jump to", "Server Hop") as null|anything in csa

	if(!pick)
		return

	var/addr = csa[pick]

	if(alert(src, "Jump to server [pick] ([addr])?", "Server Hop", "Yes", "No") != "Yes")
		return

	var/client/C = client
	to_chat(C, "<span class='notice'>Sending you to [pick].</span>")
	new /obj/screen/splash(C)

	notransform = TRUE
	sleep(29)	//let the animation play
	notransform = FALSE

	if(!C)
		return

	winset(src, null, "command=.options") //other wise the user never knows if byond is downloading resources

	C << link("[addr]?server_hop=[key]")

/mob/dead/new_player/Login()
	if(CONFIG_GET(flag/use_exp_tracking))
		client.set_exp_from_db()
		client.set_db_player_flags()
	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	..()

	var/motd = global.config.motd
	if(motd)
		to_chat(src, "<div class=\"motd\">[motd]</div>")

	if(GLOB.admin_notice)
		to_chat(src, "<span class='notice'><b>Admin Notice:</b>\n \t [GLOB.admin_notice]</span>")

	var/spc = CONFIG_GET(number/soft_popcap)
	if(spc && living_player_count() >= spc)
		to_chat(src, "<span class='notice'><b>Server Notice:</b>\n \t [CONFIG_GET(string/soft_popcap_message)]</span>")

	sight |= SEE_TURFS

/*
	var/list/watch_locations = list()
	for(var/obj/effect/landmark/landmark in GLOB.landmarks_list)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		loc = pick(watch_locations)
*/
	new_player_panel()
	client.playtitlemusic()
	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = round(SSticker.GetTimeLeft(), 1)/10
		var/postfix
		if(tl >= 0)
			postfix = "in about [tl] seconds"
		else
			postfix = "soon"
		to_chat(src, "Please set up your character and select \"Ready\". The game will start [postfix].")

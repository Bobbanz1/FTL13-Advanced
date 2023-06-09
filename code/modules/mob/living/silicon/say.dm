
/mob/living/silicon/get_spans()
	return ..() | SPAN_ROBOT

/mob/living/proc/robot_talk(message)
	log_talk(src,"[key_name(src)] : [message]",LOGSAY)
	log_message(message, INDIVIDUAL_SAY_LOG)
	var/desig = "Default Cyborg" //ezmode for taters
	if(issilicon(src))
		var/mob/living/silicon/S = src
		desig = trim_left(S.designation + " " + S.job)
	var/message_a = say_quote(message, get_spans())
	var/rendered = "<i><span class='game say'>Robotic Talk, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i>"
	for(var/mob/M in GLOB.player_list)
		if(M.binarycheck())
			if(isAI(M))
				var/renderedAI = "<i><span class='game say'>Robotic Talk, <a href='?src=[REF(M)];track=[rhtml_encode(name)]'><span class='name'>[name] ([desig])</span></a> <span class='message'>[message_a]</span></span></i>"
				to_chat(M, renderedAI)
			else
				to_chat(M, rendered)
		if(isobserver(M))
			var/following = src
			// If the AI talks on binary chat, we still want to follow
			// it's camera eye, like if it talked on the radio
			if(isAI(src))
				var/mob/living/silicon/ai/ai = src
				following = ai.eyeobj
			var/link = FOLLOW_LINK(M, following)
			to_chat(M, "[link] [rendered]")

/mob/living/silicon/binarycheck()
	return 1

/mob/living/silicon/lingcheck()
	return 0 //Borged or AI'd lings can't speak on the ling channel.

/mob/living/silicon/radio(message, message_mode, list/spans, language)
	. = ..()
	if(. != 0)
		return .

	if(message_mode == "robot")
		if (radio)
			radio.talk_into(src, message, , spans, language)
		return REDUCE_RANGE

	else if(message_mode in GLOB.radiochannels)
		if(radio)
			radio.talk_into(src, message, message_mode, spans, language)
			return ITALICS | REDUCE_RANGE

	return 0

/mob/living/silicon/get_message_mode(message)
	. = ..()
	if(..() == MODE_HEADSET)
		return MODE_ROBOT
	else
		return .

/mob/living/silicon/handle_inherent_channels(message, message_mode)
	. = ..()
	if(.)
		return .

	if(message_mode == MODE_BINARY)
		if(binarycheck())
			robot_talk(message)
		return 1
	return 0

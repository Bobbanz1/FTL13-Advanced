SUBSYSTEM_DEF(ast)
	name = "Bot Comms"
	flags = SS_NO_FIRE

/datum/controller/subsystem/ast/Initialize(timeofday)
	var/bot_ip = CONFIG_GET(string/bot_ip)
	var/comms_key = CONFIG_GET(string/comms_key)
	if(config && bot_ip)
		var/query = "http://[bot_ip]/?serverStart=1&key=[comms_key]"
		world.Export(query)

/datum/controller/subsystem/ast/proc/send_discord_message(var/channel, var/message, var/priority_type)
	var/bot_ip = CONFIG_GET(string/bot_ip)
	var/comms_key = CONFIG_GET(string/comms_key)
	if(!config || !bot_ip)
		return
	if(priority_type && !total_admins_active())
		send_discord_message(channel, "@here - A new [priority_type] requires/might need attention, but there are no admins online.")
	var/list/data = list()
	data["key"] = comms_key
	data["announce_channel"] = channel
	data["announce"] = message
	world.Export("http://[bot_ip]/?[list2params(data)]")

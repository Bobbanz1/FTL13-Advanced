/obj/item/radio/integrated
	name = "\improper PDA radio module"
	desc = "An electronic radio system of nanotrasen origin."
	icon = 'icons/obj/module.dmi'
	icon_state = "power_mod"

	var/on = FALSE //Are we currently active??
	var/menu_message = ""

/obj/item/radio/integrated/Initialize()
	. = ..()

/obj/item/radio/integrated/Destroy()
	return ..()

/*
 *	Radio Cartridge, essentially a signaler.
 */


/obj/item/radio/integrated/signal
	var/frequency = FREQ_SIGNALER
	var/code = DEFAULT_SIGNALER_CODE
	var/last_transmission
	var/datum/radio_frequency/radio_connection

/obj/item/radio/integrated/signal/Destroy()
	SSradio.remove_object(src, frequency)
	radio_connection = null
	return ..()

/obj/item/radio/integrated/signal/Initialize()
	..()
	if (src.frequency < MIN_FREE_FREQ || src.frequency > MAX_FREE_FREQ)
		src.frequency = sanitize_frequency(src.frequency)

	set_frequency(frequency)

/obj/item/radio/integrated/signal/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/radio/integrated/signal/proc/send_signal(message="ACTIVATE")

	if(last_transmission && world.time < (last_transmission + 5))
		return
	last_transmission = world.time

	var/time = time2text(world.realtime,"hh:mm:ss")
	var/turf/T = get_turf(src)
	GLOB.lastsignalers.Add("[time] <B>:</B> [usr.key] used [src] @ location ([T.x],[T.y],[T.z]) <B>:</B> [format_frequency(frequency)]/[code]")

	var/datum/signal/signal = new
	signal.source = src
	signal.encryption = code
	signal.data["message"] = message

	radio_connection.post_signal(src, signal)

	return

/*
  HOW IT WORKS

  The SSradio is a global object maintaining all radio transmissions, think about it as about "ether".
  Note that walkie-talkie, intercoms and headsets handle transmission using nonstandard way.
  procs:

    add_object(obj/device as obj, var/new_frequency as num, var/filter as text|null = null)
      Adds listening object.
      parameters:
        device - device receiving signals, must have proc receive_signal (see description below).
          one device may listen several frequencies, but not same frequency twice.
        new_frequency - see possibly frequencies below;
        filter - thing for optimization. Optional, but recommended.
                 All filters should be consolidated in this file, see defines later.
                 Device without listening filter will receive all signals (on specified frequency).
                 Device with filter will receive any signals sent without filter.
                 Device with filter will not receive any signals sent with different filter.
      returns:
       Reference to frequency object.

    remove_object (obj/device, old_frequency)
      Obliviously, after calling this proc, device will not receive any signals on old_frequency.
      Other frequencies will left unaffected.

   return_frequency(var/frequency as num)
      returns:
       Reference to frequency object. Use it if you need to send and do not need to listen.

  radio_frequency is a global object maintaining list of devices that listening specific frequency.
  procs:

    post_signal(obj/source as obj|null, datum/signal/signal, var/filter as text|null = null, var/range as num|null = null)
      Sends signal to all devices that wants such signal.
      parameters:
        source - object, emitted signal. Usually, devices will not receive their own signals.
        signal - see description below.
        filter - described above.
        range - radius of regular byond's square circle on that z-level. null means everywhere, on all z-levels.

  obj/proc/receive_signal(datum/signal/signal, var/receive_method as num, var/receive_param)
    Handler from received signals. By default does nothing. Define your own for your object.
    Avoid of sending signals directly from this proc, use spawn(0). Do not use sleep() here please.
      parameters:
        signal - see description below. Extract all needed data from the signal before doing sleep(), spawn() or return!
        receive_method - may be TRANSMISSION_WIRE or TRANSMISSION_RADIO.
          TRANSMISSION_WIRE is currently unused.
        receive_param - for TRANSMISSION_RADIO here comes frequency.

  datum/signal
    vars:
    source
      an object that emitted signal. Used for debug and bearing.
    data
      list with transmitting data. Usual use pattern:
        data["msg"] = "hello world"
    encryption
      Some number symbolizing "encryption key".
      Note that game actually do not use any cryptography here.
      If receiving object don't know right key, it must ignore encrypted signal in its receive_signal.

*/
/*	the radio controller is a confusing piece of shit and didnt work
	so i made radios not use the radio controller.
*/
GLOBAL_LIST_EMPTY(all_radios)
/proc/add_radio(obj/item/radio, freq)
	if(!freq || !radio)
		return
	if(!GLOB.all_radios["[freq]"])
		GLOB.all_radios["[freq]"] = list(radio)
		return freq

	GLOB.all_radios["[freq]"] |= radio
	return freq

/proc/remove_radio(obj/item/radio, freq)
	if(!freq || !radio)
		return
	if(!GLOB.all_radios["[freq]"])
		return

	GLOB.all_radios["[freq]"] -= radio

/proc/remove_radio_all(obj/item/radio)
	for(var/freq in GLOB.all_radios)
		GLOB.all_radios["[freq]"] -= radio

// For information on what objects or departments use what frequencies,
// see __DEFINES/radio.dm. Mappers may also select additional frequencies for
// use in maps, such as in intercoms.

GLOBAL_LIST_INIT(radiochannels, list(
	"Common" = FREQ_COMMON,
	"Science" = FREQ_SCIENCE,
	"Command" = FREQ_COMMAND,
	"Medical" = FREQ_MEDICAL,
	"Engineering" = FREQ_ENGINEERING,
	"Security" = FREQ_SECURITY,
	"CentCom" = FREQ_CENTCOM,
	"Syndicate" = FREQ_SYNDICATE,
	"Supply" = FREQ_SUPPLY,
	"Service" = FREQ_SERVICE,
	"AI Private" = FREQ_AI_PRIVATE,
	"Red Team" = FREQ_CTF_RED,
	"Blue Team" = FREQ_CTF_BLUE
))

GLOBAL_LIST_INIT(reverseradiochannels, list(
	"[FREQ_COMMON]" = "Common",
	"[FREQ_SCIENCE]" = "Science",
	"[FREQ_COMMAND]" = "Command",
	"[FREQ_MEDICAL]" = "Medical",
	"[FREQ_ENGINEERING]" = "Engineering",
	"[FREQ_SECURITY]" = "Security",
	"[FREQ_CENTCOM]" = "CentCom",
	"[FREQ_SYNDICATE]" = "Syndicate",
	"[FREQ_SUPPLY]" = "Supply",
	"[FREQ_SERVICE]" = "Service",
	"[FREQ_AI_PRIVATE]" = "AI Private",
	"[FREQ_CTF_RED]" = "Red Team",
	"[FREQ_CTF_BLUE]" = "Blue Team"
))

/datum/radio_frequency

	var/frequency as num
	var/list/list/obj/devices = list()

//If range > 0, only post to devices on the same z_level and within range
//Use range = -1, to restrain to the same z_level without limiting range
/datum/radio_frequency/proc/post_signal(obj/source as obj|null, datum/signal/signal, filter = null as text|null, range = null as num|null)

	//Apply filter to the signal. If none supply, broadcast to every devices
	//_default channel is always checked
	var/list/filter_list

	if(filter)
		filter_list = list(filter,"_default")
	else
		filter_list = devices

	//If checking range, find the source turf
	var/turf/start_point
	if(range)
		start_point = get_turf(source)
		if(!start_point)
			return 0

	//Send the data
	for(var/current_filter in filter_list)
		for(var/obj/device in devices[current_filter])
			if(device == source)
				continue
			if(range)
				var/turf/end_point = get_turf(device)
				if(!end_point)
					continue
				if(start_point.z != end_point.z || (range > 0 && get_dist(start_point, end_point) > range))
					continue
			device.receive_signal(signal, TRANSMISSION_RADIO, frequency)

/datum/radio_frequency/proc/add_listener(obj/device, filter as text|null)
	if (!filter)
		filter = "_default"

	var/list/devices_line = devices[filter]
	if(!devices_line)
		devices_line = list()
		devices[filter] = devices_line
	devices_line += device


/datum/radio_frequency/proc/remove_listener(obj/device)
	for(var/devices_filter in devices)
		var/list/devices_line = devices[devices_filter]
		if(!devices_line)
			devices -= devices_filter
		devices_line -= device
		if(!devices_line.len)
			devices -= devices_filter



/obj/proc/receive_signal(datum/signal/signal, receive_method, receive_param)
	return

/datum/signal
	var/obj/source

	var/transmission_method = TRANSMISSION_WIRE

	var/data = list()
	var/encryption

	var/frequency = 0

/datum/signal/proc/copy_from(datum/signal/model)
	source = model.source
	transmission_method = model.transmission_method
	data = model.data
	encryption = model.encryption
	frequency = model.frequency

/datum/signal/proc/debug_print()
	if (source)
		. = "signal = {source = '[source]' [COORD(source)]\n"
	else
		. = "signal = {source = '[source]' ()\n"
	for (var/i in data)
		. += "data\[\"[i]\"\] = \"[data[i]]\"\n"
		if(islist(data[i]))
			var/list/L = data[i]
			for(var/t in L)
				. += "data\[\"[i]\"\] list has: [t]"

/datum/signal/proc/sanitize_data()
	for(var/d in data)
		var/val = data[d]
		if(istext(val))
			data[d] = rhtml_encode(val)

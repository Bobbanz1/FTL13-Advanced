/obj/machinery/computer/ftl_weapons
	name = "ship tactical console"
	desc = "Used to control ship weaponry."
	var/list/kinetic_weapons = list()
	var/list/laser_weapons = list()
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "security_key"
	icon_screen = "tactical"
	var/secondary = FALSE //For secondary Battle Bridge computers
	var/general_quarters = FALSE //Secondary computers only work during General Quarters

	var/datum/starship/target
	var/datum/ship_component/target_ship_component

/obj/machinery/computer/ftl_weapons/New()
	..()
	if(secondary)
		name = "secondary tactical console"
		desc = "This is a backup tactical console. It will only work during General Quarters."
		icon = 'icons/obj/computerold.dmi' //old nasty sprite for a secondary computer
		icon_keyboard = "security_key" //so it fits the old sprite
		icon_screen = "tactical" //so it has a screen
	GLOB.ftl_weapons_consoles += src
	spawn(5)
		refresh_weapons()

/obj/machinery/computer/ftl_weapons/Destroy()
	GLOB.ftl_weapons_consoles -= src
	. = ..()

/obj/machinery/computer/ftl_weapons/proc/refresh_weapons()
	kinetic_weapons = list()
	for(var/obj/machinery/mac_barrel/K in world)
		if(!istype(get_area(K), /area/shuttle/ftl))
			continue
		kinetic_weapons += K
	laser_weapons = list()
	for(var/obj/machinery/power/shipweapon/L in world)
		if(!istype(get_area(L), /area/shuttle/ftl))
			continue
		laser_weapons += L

/obj/machinery/computer/ftl_weapons/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	if(secondary && !general_quarters)
		user << "This console is locked. Backup consoles only work during General Quarters."
		return
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		var/datum/asset/assets = get_asset_datum(/datum/asset/simple/tactical)
		assets.send(user)

		ui = new(user, src, ui_key, "ftl_weapons", name, 800, 660, master_ui, state)
		ui.open()

/obj/machinery/computer/ftl_weapons/ui_data(mob/user)
	var/list/data = list()

	var/list/kinetics_list = list()
	data["kinetic_weapons"] = kinetics_list
	for(var/obj/machinery/mac_barrel/K in kinetic_weapons)
		if(K.breech)
			var/list/kinetic_list = list()

			kinetic_list["name"] = "[K]"
			kinetic_list["id"] = "[REF(K)]"
			kinetic_list["loaded"] = K.breech.loaded_shell
			kinetic_list["can_fire"] = K.can_fire(TRUE)
			kinetics_list[++kinetics_list.len] = kinetic_list
		else
			K.find_breech()
	var/list/lasers_list = list()
	data["laser_weapons"] = lasers_list
	for(var/obj/machinery/power/shipweapon/L in laser_weapons)
		var/list/laser_list = list()

		laser_list["name"] = "[L]"
		laser_list["id"] = "[REF(L)]"
		laser_list["can_fire"] = L.can_fire()
		if(L.chip)
			laser_list["charge"] = L.current_charge
			laser_list["maxcharge"] = L.chip.attack_data.charge_to_fire
		else
			laser_list["charge"] = 0
			laser_list["maxcharge"] = 1

		lasers_list[++lasers_list.len] = laser_list

	if(SSstarmap.ftl_shieldgen)
		data["has_shield"] = 1
		if(SSstarmap.ftl_shieldgen.is_active())
			data["shield_status"] = "Fully charged, shields up"
			data["shield_class"] = "good"
		else if(SSstarmap.ftl_shieldgen.charging_power || SSstarmap.ftl_shieldgen.charging_plasma)
			data["shield_status"] = "Charging, shields down"
			data["shield_class"] = "average"
		else if(SSstarmap.ftl_shieldgen.stat & BROKEN)
			data["shield_status"] = "Broken"
			data["shield_class"] = "bad"
		else
			data["shield_status"] = "Not charging, shields down"
			data["shield_class"] = "bad"

		data["shield_plasma_charge"] = SSstarmap.ftl_shieldgen.plasma_charge
		data["shield_plasma_charge_max"] = SSstarmap.ftl_shieldgen.plasma_charge_max
		data["shield_charging_plasma"] = SSstarmap.ftl_shieldgen.charging_plasma
		data["shield_power_charge"] = SSstarmap.ftl_shieldgen.power_charge
		data["shield_power_charge_max"] = SSstarmap.ftl_shieldgen.power_charge_max
		data["shield_charging_power"] = SSstarmap.ftl_shieldgen.charging_power
		data["shield_on"] = SSstarmap.ftl_shieldgen.on
	else
		data["has_shield"] = 0
		data["shield_status"] = "Not found"
		data["shield_class"] = "bad"

	if(SSstarmap.in_transit)
		data["location"] = "In Transit"
	else
		if(SSstarmap.in_transit_planet)
			data["location"] = "[SSstarmap.current_system] - In Transit"
		else
			data["location"] = "[SSstarmap.current_system] - [SSstarmap.current_planet]"
		var/list/ships_list = list()
		data["ships"] = ships_list
		for(var/datum/starship/S in SSstarmap.current_system.ships)
			ships_list[++ships_list.len] = list("name" = S.name, "faction" = S.faction, "planet" = S.planet.name, "id" = "[REF(S)]", "selected" = (S == target))

		if(target)
			data["target"] = target.name
			var/list/ship_components_list = list()
			data["components"] = ship_components_list
			for(var/cy in 1 to target.y_num)
				var/list/row = list()
				ship_components_list[++ship_components_list.len] = list("row" = row)
				for(var/cx in 1 to target.x_num)
					var/list/ship_component_list = list()
					var/datum/ship_component/C
					for(var/datum/ship_component/check in target.ship_components)
						if(check.x_loc == cx && check.y_loc == cy)
							C = check
							break
					if(C != null)
						if(!C.alt_image)
							ship_component_list["image"] = "tactical_[C.cname].png"
						else
							ship_component_list["image"] = "tactical_[C.alt_image].png"
						var/health = C.health / initial(C.health)
						var/color
						if(health == 0)
							color = "red"
						else if (!C.online)
							color = "blue"
						else if(health > 0 && health < 1)
							color = "orange"
						else
							color = "black"
						ship_component_list["color"] = color
						ship_component_list["health"] = C.health
						ship_component_list["max_health"] = initial(C.health)
						ship_component_list["selected"] = (C == target_ship_component)
						ship_component_list["name"] = C.name
						ship_component_list["id"] = "[REF(C)]"
					row[++row.len] = ship_component_list

	return data

/obj/machinery/computer/ftl_weapons/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("refresh")
			refresh_weapons()
			. = 1
		if("fire_kinetic")
			var/obj/machinery/mac_barrel/K = locate(params["id"])
			if(!istype(K))
				return
			if(!(K in kinetic_weapons))
				return
			if(copytext(K.id, 1, 7) != "weapon")
				kinetic_weapons -= K
			if(K.can_fire())
				K.attempt_fire(target_ship_component,usr)
				if(!target)
					spawn(10)
						SSship.broadcast_message("No ship targetted! Shot missed!",SSship.error_sound)

			. = 1
		if("fire_laser")
			var/obj/machinery/power/shipweapon/L = locate(params["id"])
			if(!istype(L))
				return
			if(!(L in laser_weapons))
				return
			if(L.attempt_fire(target_ship_component,usr))
				if(!target)
					spawn(10)
						SSship.broadcast_message("No ship targetted! Shot missed!",SSship.error_sound)

			. = 1
		if("toggle_shields")
			SSstarmap.ftl_shieldgen.on = !SSstarmap.ftl_shieldgen.on
			. = 1
		if("target")
			var/datum/starship/S = locate(params["id"])
			if(istype(S))
				target = S
				target_ship_component = S.ship_components[1]
			. = 1
		if("target_component")
			var/datum/ship_component/C = locate(params["id"])
			if(istype(C) && (C in target.ship_components))
				target_ship_component = C
			. = 1

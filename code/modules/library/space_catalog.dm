GLOBAL_LIST_EMPTY(space_catalog_buffer)

/obj/item/book/space_catalog
	unique = 1
	window_size = "570x680"
	desc = "A book full of useful information about nearby space stations"
	icon_state = "space_yellow_pages"

/obj/item/book/space_catalog/Initialize()
	var/turf/T = get_turf(src)
	var/datum/planet/PL = SSstarmap.current_system.get_planet_for_z(T.z)
	if(!PL)
		..()
		return
	var/datum/star_system/ST = PL.parent_system

	title = "[PL.name] yellow pages"
	name = title
	author = ST.alignment

	if(GLOB.space_catalog_buffer[title])
		dat = GLOB.space_catalog_buffer[title]
		..()
		return

	dat = "<h2>[title]</h2><br>"

	for(var/datum/star_system/S2 in SSstarmap.star_systems)
		var/dist = ST.dist(S2)
	 	// Anything within jump distance is guaranteed to be on the list
		// Anything within 40 ly has a 50% chance of being on the list
		if((dist > 20 && prob(50)) || dist > 40)
			continue
		// NT only shows NT, solgov and neutral show all, syndies show all but NT
		if((ST.alignment == "nanotrasen" && S2.alignment != "nanotrasen") || (ST.alignment == "syndicate" && S2.alignment == "nanotrasen"))
			continue

		for(var/datum/planet/P2 in S2.planets)
			if(!P2.station) // Ignore station-less planets
				continue

			// Add the station to the buffer
			dat += "<h3>[S2.alignment]-aligned station [P2.station.module.name] at [P2.name]([round(dist,0.1)]ly away)</h3><br>"
			dat += "<font size = \"1\">"
			dat += P2.station.dat
			/*
			for(var/PK in P2.station.stock)
				var/datum/supply_pack/pack = SSshuttle.supply_packs[PK]
				if(pack.hidden)
					continue
				dat += "<br><b>[pack.name] ([pack.cost] credits)</b><br>"
				if(pack.sensitivity == 2)
					dat += "<i>This crate is only available to [S2.alignment] allies. "
				if(pack.sensitivity == 1)
					dat += "<i>This crate is not available to [S2.alignment] enemies. "
				if(pack.sensitivity != 0)
					dat += "Distribution of this crate to restricted organizations could result in fines or criminal charges</i><br>"
				dat += "Contents: <br>"
				var/list/contents_bynumber = list()
				for(var/path in pack.contains)
					if(path in contents_bynumber)
						contents_bynumber[path] += 1
					else
						contents_bynumber[path] = 1
				for(var/path in contents_bynumber)
					var/atom/path_fuck_byond = path
					dat += "[contents_bynumber[path]]x [initial(path_fuck_byond.name)]"
					if(initial(path_fuck_byond.desc))
						dat += " - <i>[initial(path_fuck_byond.desc)]</i>"
					dat += "<br>"
			dat += "</font>"
			CHECK_TICK */

	GLOB.space_catalog_buffer[title] = dat

	..()

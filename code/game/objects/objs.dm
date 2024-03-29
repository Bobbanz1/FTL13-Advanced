/obj
	var/crit_fail = FALSE
	animate_movement = 2
	var/throwforce = 0
	var/obj_flags = CAN_BE_HIT
	var/set_obj_flags // ONLY FOR MAPPING: Sets flags from a string list, handled in Initialize. Usage: set_obj_flags = "EMAGGED;!CAN_BE_HIT" to set EMAGGED and clear CAN_BE_HIT.

	var/damtype = BRUTE
	var/force = 0

	var/list/armor
	var/obj_integrity	//defaults to max_integrity
	var/max_integrity = 500
	var/integrity_failure = 0 //0 if we have no special broken behavior

	var/resistance_flags = 0 // INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ON_FIRE | UNACIDABLE | ACID_PROOF

	var/acid_level = 0 //how much acid is on that obj

	var/persistence_replacement //have something WAY too amazing to live to the next round? Set a new path here. Overuse of this var will make me upset.
	var/current_skin //Has the item been reskinned?
	var/unique_reskin //List of options to reskin.
	var/shuttle_abstract_movable = 0

/obj/vv_edit_var(vname, vval)
	switch(vname)
		if("obj_flags")
			if ((obj_flags & DANGEROUS_POSSESSION) && !(vval & DANGEROUS_POSSESSION))
				return FALSE
		if("control_object")
			var/obj/O = vval
			if(istype(O) && (O.obj_flags & DANGEROUS_POSSESSION))
				return FALSE
	..()

/obj/Initialize()
	. = ..()
	if (!armor)
		armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)
	if(obj_integrity == null)
		obj_integrity = max_integrity
	if (set_obj_flags)
		var/flagslist = splittext(set_obj_flags,";")
		var/list/string_to_objflag = GLOB.bitfields["obj_flags"]
		for (var/flag in flagslist)
			if (findtext(flag,"!",1,2))
				flag = copytext(flag,1-(length(flag))) // Get all but the initial !
				obj_flags &= ~string_to_objflag[flag]
			else
				obj_flags |= string_to_objflag[flag]
	if((obj_flags & ON_BLUEPRINTS) && isturf(loc))
		var/turf/T = loc
		T.add_blueprints_preround(src)

/obj/Destroy(force=FALSE)
	if(!istype(src, /obj/machinery))
		STOP_PROCESSING(SSobj, src) // TODO: Have a processing bitflag to reduce on unnecessary loops through the processing lists
	SStgui.close_uis(src)
	. = ..()

/obj/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback)
	..()
	if(flags_2 & FROZEN_2)
		visible_message("<span class='danger'>[src] shatters into a million pieces!</span>")
		qdel(src)

/obj/assume_air(datum/gas_mixture/giver)
	if(loc)
		return loc.assume_air(giver)
	else
		return null

/obj/remove_air(amount)
	if(loc)
		return loc.remove_air(amount)
	else
		return null

/obj/return_air()
	if(loc)
		return loc.return_air()
	else
		return null

/obj/proc/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	//Return: (NONSTANDARD)
	//		null if object handles breathing logic for lifeform
	//		datum/air_group to tell lifeform to process using that breath return
	//DEFAULT: Take air from turf to give to have mob process

	if(breath_request>0)
		var/datum/gas_mixture/environment = return_air()
		var/breath_percentage = BREATH_VOLUME / environment.return_volume()
		return remove_air(environment.total_moles() * breath_percentage)
	else
		return null

/obj/proc/updateUsrDialog()
	if(obj_flags & IN_USE)
		var/is_in_use = 0
		var/list/nearby = viewers(1, src)
		for(var/mob/M in nearby)
			if ((M.client && M.machine == src))
				is_in_use = 1
				src.attack_hand(M)
		if(isAI(usr) || iscyborg(usr) || IsAdminGhost(usr))
			if (!(usr in nearby))
				if (usr.client && usr.machine==src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
					is_in_use = 1
					src.attack_ai(usr)

		// check for TK users

		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(!(usr in nearby))
				if(usr.client && usr.machine==src)
					if(H.dna.check_mutation(TK))
						is_in_use = 1
						src.attack_hand(usr)
		if (is_in_use)
			obj_flags |= IN_USE
		else
			obj_flags &= ~IN_USE

/obj/proc/updateDialog()
	// Check that people are actually using the machine. If not, don't update anymore.
	if(obj_flags & IN_USE)
		var/list/nearby = viewers(1, src)
		var/is_in_use = 0
		for(var/mob/M in nearby)
			if ((M.client && M.machine == src))
				is_in_use = 1
				src.interact(M)
		var/ai_in_use = AutoUpdateAI(src)

		if(!ai_in_use && !is_in_use)
			obj_flags &= ~IN_USE


/obj/attack_ghost(mob/user)
	if(ui_interact(user) != -1)
		return
	..()

/obj/proc/container_resist(mob/living/user)
	return

/obj/proc/update_icon()
	return

/mob/proc/unset_machine()
	if(machine)
		machine.on_unset_machine(src)
		machine = null

//called when the user unsets the machine.
/atom/movable/proc/on_unset_machine(mob/user)
	return

/mob/proc/set_machine(obj/O)
	if(src.machine)
		unset_machine()
	src.machine = O
	if(istype(O))
		O.obj_flags |= IN_USE

/obj/item/proc/updateSelfDialog()
	var/mob/M = src.loc
	if(istype(M) && M.client && M.machine == src)
		src.attack_self(M)

/obj/proc/hide(h)
	return

/obj/singularity_pull(S, current_size)
	if(!anchored || current_size >= STAGE_FIVE)
		step_towards(src,S)

/obj/get_spans()
	return ..() | SPAN_ROBOT

/obj/storage_contents_dump_act(obj/item/storage/src_object, mob/user)
	var/turf/T = get_turf(src)
	return T.storage_contents_dump_act(src_object, user)

/obj/proc/CanAStarPass()
	. = !density

/obj/proc/check_uplink_validity()
	return 1

/obj/proc/on_mob_move(dir, mob, oldLoc)
	return

/obj/proc/on_mob_turn(dir, mob)
	return

/obj/proc/intercept_user_move(dir, mob, newLoc, oldLoc)
	return

/obj/vv_get_dropdown()
	. = ..()
	.["Delete all of type"] = "?_src_=vars;[HrefToken()];delall=[REF(src)]"

/obj/examine(mob/user)
	..()
	if(obj_flags & UNIQUE_RENAME)
		to_chat(user, "<span class='notice'>Use a pen on it to rename it or change its description.</span>")
	if(unique_reskin && !current_skin)
		to_chat(user, "<span class='notice'>Alt-click it to reskin it.</span>")

/obj/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && in_range(user,src))
		if(user.incapacitated())
			to_chat(user, "<span class='warning'>You can't do that right now!</span>")
			return
		reskin_obj(user)

/obj/proc/reskin_obj(mob/M)
	if(!LAZYLEN(unique_reskin))
		return
	var/choice = input(M,"Warning, you can only reskin [src] once!","Reskin Object") as null|anything in unique_reskin
	if(!QDELETED(src) && choice && !current_skin && !M.incapacitated() && in_range(M,src))
		if(!unique_reskin[choice])
			return
		current_skin = choice
		icon_state = unique_reskin[choice]
		to_chat(M, "[src] is now skinned as '[choice].'")

/obj/proc/gang_contraband_value()
	return 0

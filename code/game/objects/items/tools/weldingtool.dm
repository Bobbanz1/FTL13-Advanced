#define WELDER_FUEL_BURN_INTERVAL 13

/*
 * Welding Tool
 */
/obj/item/weldingtool
	name = "welding tool"
	desc = "A standard edition welder provided by Nanotrasen."
	icon = 'icons/obj/tools.dmi'
	icon_state = "welder"
	item_state = "welder"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = SLOT_BELT
	force = 3
	throwforce = 5
	hitsound = "swing_hit"
	usesound = 'sound/items/welder.ogg'
	var/acti_sound = 'sound/items/welderactivate.ogg'
	var/deac_sound = 'sound/items/welderdeactivate.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 30)
	resistance_flags = FIRE_PROOF

	materials = list(MAT_METAL=70, MAT_GLASS=30)
	origin_tech = "engineering=1;plasmatech=1"
	var/welding = 0 	//Whether or not the welding tool is off(0), on(1) or currently welding(2)
	var/status = TRUE 		//Whether the welder is secured or unsecured (able to attach rods to it to make a flamethrower)
	var/max_fuel = 20 	//The max amount of fuel the welder can hold
	var/change_icons = 1
	var/can_off_process = 0
	var/light_intensity = 2 //how powerful the emitted light is when used.
	var/burned_fuel_for = 0	//when fuel was last removed
	heat = 3800
	toolspeed = 1

/obj/item/weldingtool/Initialize()
	. = ..()
	create_reagents(max_fuel)
	reagents.add_reagent("welding_fuel", max_fuel)
	update_icon()


/obj/item/weldingtool/proc/update_torch()
	if(welding)
		add_overlay("[initial(icon_state)]-on")
		item_state = "[initial(item_state)]1"
	else
		item_state = "[initial(item_state)]"


/obj/item/weldingtool/update_icon()
	cut_overlays()
	if(change_icons)
		var/ratio = get_fuel() / max_fuel
		ratio = CEILING(ratio*4, 1) * 25
		add_overlay("[initial(icon_state)][ratio]")
	update_torch()
	return


/obj/item/weldingtool/process()
	switch(welding)
		if(0)
			force = 3
			damtype = "brute"
			update_icon()
			if(!can_off_process)
				STOP_PROCESSING(SSobj, src)
			return
	//Welders left on now use up fuel, but lets not have them run out quite that fast
		if(1)
			force = 15
			damtype = "fire"
			++burned_fuel_for
			if(burned_fuel_for >= WELDER_FUEL_BURN_INTERVAL)
				remove_fuel(1)
			update_icon()

	//This is to start fires. process() is only called if the welder is on.
	open_flame()


/obj/item/weldingtool/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] welds [user.p_their()] every orifice closed! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (FIRELOSS)


/obj/item/weldingtool/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/screwdriver))
		flamethrower_screwdriver(I, user)
	else if(istype(I, /obj/item/stack/rods))
		flamethrower_rods(I, user)
	else
		return ..()


/obj/item/weldingtool/attack(mob/living/carbon/human/H, mob/user)
	if(!istype(H))
		return ..()

	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))

	if(affecting && affecting.status == BODYPART_ROBOTIC && user.a_intent != INTENT_HARM)
		if(src.remove_fuel(1))
			playsound(loc, usesound, 50, 1)
			if(user == H)
				user.visible_message("<span class='notice'>[user] starts to fix some of the dents on [H]'s [affecting.name].</span>", "<span class='notice'>You start fixing some of the dents on [H]'s [affecting.name].</span>")
				if(!do_mob(user, H, 50))
					return
			item_heal_robotic(H, user, 15, 0)
	else
		return ..()


/obj/item/weldingtool/afterattack(atom/O, mob/user, proximity)
	if(!proximity) return

	if(welding)
		remove_fuel(1)
		var/turf/location = get_turf(user)
		location.hotspot_expose(700, 50, 1)
		if(get_fuel() <= 0)
			set_light(0)

		if(isliving(O))
			var/mob/living/L = O
			if(L.IgniteMob())
				message_admins("[key_name_admin(user)] set [key_name_admin(L)] on fire")
				log_game("[key_name(user)] set [key_name(L)] on fire")


/obj/item/weldingtool/attack_self(mob/user)
	switched_on(user)
	if(welding)
		set_light(light_intensity)

	update_icon()


//Returns the amount of fuel in the welder
/obj/item/weldingtool/proc/get_fuel()
	return reagents.get_reagent_amount("welding_fuel")


//Removes fuel from the welding tool. If a mob is passed, it will try to flash the mob's eyes. This should probably be renamed to use()
/obj/item/weldingtool/proc/remove_fuel(amount = 1, mob/living/M = null)
	if(!welding || !check_fuel())
		return 0
	if(amount)
		burned_fuel_for = 0
	if(get_fuel() >= amount)
		reagents.remove_reagent("welding_fuel", amount)
		check_fuel()
		if(M)
			M.flash_act(light_intensity)
		return TRUE
	else
		if(M)
			to_chat(M, "<span class='warning'>You need more welding fuel to complete this task!</span>")
		return FALSE


//Turns off the welder if there is no more fuel (does this really need to be its own proc?)
/obj/item/weldingtool/proc/check_fuel(mob/user)
	if(get_fuel() <= 0 && welding)
		switched_on(user)
		update_icon()
		//mob icon update
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands(0)

		return 0
	return 1

//Switches the welder on
/obj/item/weldingtool/proc/switched_on(mob/user)
	if(!status)
		to_chat(user, "<span class='warning'>[src] can't be turned on while unsecured!</span>")
		return
	welding = !welding
	if(welding)
		if(get_fuel() >= 1)
			to_chat(user, "<span class='notice'>You switch [src] on.</span>")
			playsound(loc, acti_sound, 50, 1)
			force = 15
			damtype = "fire"
			hitsound = 'sound/items/welder.ogg'
			update_icon()
			START_PROCESSING(SSobj, src)
		else
			to_chat(user, "<span class='warning'>You need more fuel!</span>")
			switched_off(user)
	else
		to_chat(user, "<span class='notice'>You switch [src] off.</span>")
		playsound(loc, deac_sound, 50, 1)
		switched_off(user)

//Switches the welder off
/obj/item/weldingtool/proc/switched_off(mob/user)
	welding = 0
	set_light(0)

	force = 3
	damtype = "brute"
	hitsound = "swing_hit"
	update_icon()


/obj/item/weldingtool/examine(mob/user)
	..()
	to_chat(user, "It contains [get_fuel()] unit\s of fuel out of [max_fuel].")

/obj/item/weldingtool/is_hot()
	return welding * heat

//Returns whether or not the welding tool is currently on.
/obj/item/weldingtool/proc/isOn()
	return welding


/obj/item/weldingtool/proc/flamethrower_screwdriver(obj/item/I, mob/user)
	if(welding)
		to_chat(user, "<span class='warning'>Turn it off first!</span>")
		return
	status = !status
	if(status)
		to_chat(user, "<span class='notice'>You resecure [src].</span>")
	else
		to_chat(user, "<span class='notice'>[src] can now be attached and modified.</span>")
	add_fingerprint(user)

/obj/item/weldingtool/proc/flamethrower_rods(obj/item/I, mob/user)
	if(!status)
		var/obj/item/stack/rods/R = I
		if (R.use(1))
			var/obj/item/flamethrower/F = new /obj/item/flamethrower(user.loc)
			if(!remove_item_from_storage(F))
				user.transferItemToLoc(src, F, TRUE)
			F.weldtool = src
			add_fingerprint(user)
			to_chat(user, "<span class='notice'>You add a rod to a welder, starting to build a flamethrower.</span>")
			user.put_in_hands(F)
		else
			to_chat(user, "<span class='warning'>You need one rod to start building a flamethrower!</span>")

/obj/item/weldingtool/ignition_effect(atom/A, mob/user)
	if(welding && remove_fuel(1, user))
		. = "<span class='notice'>[user] casually lights [A] with [src], what a badass.</span>"
	else
		. = ""

/obj/item/weldingtool/largetank
	name = "industrial welding tool"
	desc = "A slightly larger welder with a larger tank."
	icon_state = "indwelder"
	max_fuel = 40
	materials = list(MAT_GLASS=60)
	origin_tech = "engineering=2;plasmatech=2"

/obj/item/weldingtool/largetank/cyborg
	name = "integrated welding tool"
	desc = "An advanced welder designed to be used in robotic systems."
	toolspeed = 0.5

/obj/item/weldingtool/largetank/flamethrower_screwdriver()
	return


/obj/item/weldingtool/mini
	name = "emergency welding tool"
	desc = "A miniature welder used during emergencies."
	icon_state = "miniwelder"
	max_fuel = 10
	w_class = WEIGHT_CLASS_TINY
	materials = list(MAT_METAL=30, MAT_GLASS=10)
	change_icons = 0

/obj/item/weldingtool/mini/flamethrower_screwdriver()
	return

/obj/item/weldingtool/abductor
	name = "alien welding tool"
	desc = "An alien welding tool. Whatever fuel it uses, it never runs out."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "welder"
	toolspeed = 0.1
	light_intensity = 0
	change_icons = 0
	origin_tech = "plasmatech=5;engineering=5;abductor=3"

/obj/item/weldingtool/abductor/process()
	if(get_fuel() <= max_fuel)
		reagents.add_reagent("welding_fuel", 1)
	..()

/obj/item/weldingtool/hugetank
	name = "upgraded industrial welding tool"
	desc = "An upgraded welder based of the industrial welder."
	icon_state = "upindwelder"
	item_state = "upindwelder"
	max_fuel = 80
	materials = list(MAT_METAL=70, MAT_GLASS=120)
	origin_tech = "engineering=3;plasmatech=2"

/obj/item/weldingtool/experimental
	name = "experimental welding tool"
	desc = "An experimental welder capable of self-fuel generation and less harmful to the eyes."
	icon_state = "exwelder"
	item_state = "exwelder"
	max_fuel = 40
	materials = list(MAT_METAL=70, MAT_GLASS=120)
	origin_tech = "materials=4;engineering=4;bluespace=3;plasmatech=4"
	var/last_gen = 0
	change_icons = 0
	can_off_process = 1
	light_intensity = 1
	toolspeed = 0.5
	var/nextrefueltick = 0

/obj/item/weldingtool/experimental/brass
	name = "brass welding tool"
	desc = "A brass welder that seems to constantly refuel itself. It is faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "brasswelder"
	item_state = "brasswelder"


/obj/item/weldingtool/experimental/process()
	..()
	if(get_fuel() < max_fuel && nextrefueltick < world.time)
		nextrefueltick = world.time + 10
		reagents.add_reagent("welding_fuel", 1)

#undef WELDER_FUEL_BURN_INTERVAL
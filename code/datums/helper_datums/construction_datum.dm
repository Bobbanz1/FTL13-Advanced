#define FORWARD -1
#define BACKWARD 1

/datum/construction
	var/list/steps
	var/atom/holder
	var/result
	var/list/steps_desc

/datum/construction/New(atom)
	..()
	holder = atom
	if(!holder) //don't want this without a holder
		qdel(src)
	set_desc(steps.len)
	return

/datum/construction/proc/next_step()
	steps.len--
	if(!steps.len)
		spawn_result()
	else
		set_desc(steps.len)
	return

/datum/construction/proc/action(atom/used_atom,mob/user)
	return

/datum/construction/proc/check_step(atom/used_atom,mob/user) //check last step only
	var/valid_step = is_right_key(used_atom)
	if(valid_step)
		if(custom_action(valid_step, used_atom, user))
			next_step()
			return 1
	return 0

/datum/construction/proc/is_right_key(atom/used_atom) // returns current step num if used_atom is of the right type.
	var/list/L = steps[steps.len]
	if(istype(used_atom, L["key"]))
		return steps.len
	return 0

/datum/construction/proc/custom_action(step, used_atom, user)
	if(istype(used_atom, /obj/item/weldingtool))
		var/obj/item/weldingtool/W = used_atom
		if (W.remove_fuel(0, user))
			playsound(holder, 'sound/items/welder2.ogg', 50, 1)
		else
			return 0
	else if(istype(used_atom, /obj/item/wrench))
		playsound(holder, 'sound/items/ratchet.ogg', 50, 1)

	else if(istype(used_atom, /obj/item/screwdriver))
		playsound(holder, 'sound/items/screwdriver.ogg', 50, 1)

	else if(istype(used_atom, /obj/item/wirecutters))
		playsound(holder, 'sound/items/wirecutter.ogg', 50, 1)

	else if(istype(used_atom, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = used_atom
		if(C.amount<4)
			to_chat(user, "There's not enough cable to finish the task.")
			return 0
		else
			C.use(4)
			playsound(holder, 'sound/items/deconstruct.ogg', 50, 1)
	else if(istype(used_atom, /obj/item/stack))
		var/obj/item/stack/S = used_atom
		if(S.amount < 5)
			to_chat(user, "There's not enough material in this stack.")
			return 0
		else
			S.use(5)
	return 1

/datum/construction/proc/check_all_steps(atom/used_atom,mob/user) //check all steps, remove matching one.
	for(var/i=1;i<=steps.len;i++)
		var/list/L = steps[i];
		if(istype(used_atom, L["key"]))
			if(custom_action(i, used_atom, user))
				steps[i]=null;//stupid byond list from list removal...
				listclearnulls(steps);
				if(!steps.len)
					spawn_result()
				return 1
	return 0


/datum/construction/proc/spawn_result()
	if(result)
		new result(get_turf(holder))
		qdel(holder)
	return

/datum/construction/proc/spawn_mecha_result()
	if(result)
		var/obj/mecha/m = new result(get_turf(holder))
		var/obj/item/oldcell = locate (/obj/item/stock_parts/cell) in m
		QDEL_NULL(oldcell)
		m.CheckParts(holder.contents)
		SSblackbox.record_feedback("tally", "mechas_created", 1, m.name)
		QDEL_NULL(holder)

/datum/construction/proc/set_desc(index as num)
	var/list/step = steps[index]
	holder.desc = step["desc"]
	return

/datum/construction/reversible
	var/index

/datum/construction/reversible/New(atom)
	..()
	index = steps.len
	return

/datum/construction/reversible/proc/update_index(diff as num)
	index+=diff
	if(index==0)
		spawn_result()
	else
		set_desc(index)
	return

/datum/construction/reversible/is_right_key(atom/used_atom) // returns index step
	var/list/L = steps[index]
	if(istype(used_atom, L["key"]))
		return FORWARD //to the first step -> forward
	else if(L["backkey"] && istype(used_atom, L["backkey"]))
		return BACKWARD //to the last step -> backwards
	return 0

/datum/construction/reversible/check_step(atom/used_atom,mob/user)
	var/diff = is_right_key(used_atom)
	if(diff)
		if(custom_action(index, diff, used_atom, user))
			update_index(diff)
			return 1
	return 0

/datum/construction/reversible/custom_action(index, diff, used_atom, user)
	if(!..(index,used_atom,user))
		return 0
	return 1


#define state_next "next"
#define state_prev "prev"

/datum/construction/reversible2
	var/index
	var/base_icon = "durand"

	New(atom)
		..()
		index = 1
		return

	proc/update_index(diff as num, mob/user as mob)
		index-=diff
		if(index==steps.len+1)
			spawn_result(user)
		else
			set_desc(index)
		return

	proc/update_icon()
		holder.icon_state="[base_icon]_[index]"

	is_right_key(mob/user as mob,atom/used_atom) // returns index step
		var/list/state = steps[index]
		if(state_next in state)
			var/list/step = state[state_next]
			if(istype(used_atom, step["key"]))
				//if(L["consume"] && !try_consume(used_atom,L["consume"]))
				//	return 0
				return FORWARD //to the first step -> forward
		else if(state_prev in state)
			var/list/step = state[state_prev]
			if(istype(used_atom, step["key"]))
				//if(L["consume"] && !try_consume(used_atom,L["consume"]))
				//	return 0
				return BACKWARD //to the first step -> forward
		return 0

	check_step(atom/used_atom,mob/user as mob)
		var/diff = is_right_key(user,used_atom)
		if(diff)
			if(custom_action(index, diff, used_atom, user))
				update_index(diff,user)
				update_icon()
				return 1
		return 0

	proc/fixText(text,user)
		text = replacetext(text,"{USER}","[user]")
		text = replacetext(text,"{HOLDER}","[holder]")
		return text

	custom_action(index, diff, used_atom, var/mob/user)
		if(!..(index,used_atom,user))
			return 0

		var/list/step = steps[index]
		var/list/state = step[diff==FORWARD ? state_next : state_prev]
		user.visible_message(fixText(state["vis_msg"],user),fixText(state["self_msg"],user))

		if("delete" in state)
			qdel(used_atom)
		else if("spawn" in state)
			var/spawntype=state["spawn"]
			var/atom/A = new spawntype(holder.loc)
			if("amount" in state)
				if(istype(A,/obj/item/stack/cable_coil))
					var/obj/item/stack/cable_coil/C=A
					C.amount=state["amount"]
				if(istype(A,/obj/item/stack))
					var/obj/item/stack/S=A
					S.amount=state["amount"]

		return 1
	action(used_atom,user)
		return check_step(used_atom,user)

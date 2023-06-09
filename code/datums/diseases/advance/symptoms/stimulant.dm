/*
//////////////////////////////////////

Stimulant //gotta go fast

	Noticable.
	Lowers resistance significantly.
	Decreases stage speed moderately..
	Decreases transmittablity tremendously.
	Moderate Level.

Bonus
	The body generates Ephedrine.

//////////////////////////////////////
*/

/datum/symptom/stimulant

	name = "Stimulant"
	stealth = -1
	resistance = -3
	stage_speed = -2
	transmittable = -4
	level = 3
	base_message_chance = 5

/datum/symptom/stimulant/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(4, 5)
			if (M.reagents.get_reagent_amount("ephedrine") < 10)
				M.reagents.add_reagent("ephedrine", 10)
		else
			if(prob(base_message_chance))
				to_chat(M, "<span class='notice'>[pick("You feel restless.", "You feel like running laps around the station.")]</span>")
	return
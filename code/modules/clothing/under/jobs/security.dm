/*
 * Contains:
 *		Security
 *		Detective
 *		Navy uniforms
 */

/*
 * Security
 */

/obj/item/clothing/under/rank/security
	name = "security jumpsuit"
	desc = "A tactical security jumpsuit for officers complete with nanotrasen belt buckle."
	icon_state = "rsecurity"
	item_state = "r_suit"
	item_color = "rsecurity_s"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, fire = 30, acid = 30)
	strip_delay = 50
	alt_covers_chest = 1
	sensor_mode = SENSOR_COORDS
	random_sensor = 0

/obj/item/clothing/under/rank/security/grey
	name = "grey security jumpsuit"
	desc = "A tactical relic of years past before nanotrasen decided it was cheaper to dye the suits red instead of washing out the blood."
	icon_state = "security"
	item_state = "gy_suit"
	item_color = "security"

/obj/item/clothing/under/rank/masteratarms
	name = "master-at-arms suit"
	desc = "An authoritative suit for nanotrasen shipbound master-at-arms."
	icon_state = "rmasteratarms"
	item_state = "r_suit"
	item_color = "rmasteratarms"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, fire = 30, acid = 30)
	strip_delay = 50
	alt_covers_chest = 1
	sensor_mode = 3
	random_sensor = 0


/obj/item/clothing/under/rank/masteratarms/grey
	icon_state = "masteratarms"
	item_state = "gy_suit"
	item_color = "masteratarms"

/*
 * Detective
 */
/obj/item/clothing/under/rank/det
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	item_state = "det"
	item_color = "detective"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, fire = 30, acid = 30)
	strip_delay = 50
	alt_covers_chest = 1
	sensor_mode = 3
	random_sensor = 0

/obj/item/clothing/under/rank/det/grey
	name = "noir suit"
	desc = "A hard-boiled private investigator's grey suit, complete with tie clip."
	icon_state = "greydet"
	item_state = "greydet"
	item_color = "greydet"
	alt_covers_chest = 1

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/head_of_security
	name = "head of security's jumpsuit"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "rhos"
	item_state = "r_suit"
	item_color = "rhos_s"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, fire = 50, acid = 50)
	strip_delay = 60
	alt_covers_chest = 1
	sensor_mode = 3
	random_sensor = 0

/obj/item/clothing/under/rank/head_of_security/grey
	name = "head of security's grey jumpsuit"
	desc = "There are old men, and there are bold men, but there are very few old, bold men."
	icon_state = "hos"
	item_state = "gy_suit"
	item_color = "hos"

/obj/item/clothing/under/rank/head_of_security/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt"
	item_state = "bl_suit"
	item_color = "hosalt"

/*
 * Navy uniforms
 */

/obj/item/clothing/under/rank/security/navyblue
	name = "security officer's formal uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "officerblueclothes"
	item_state = "officerblueclothes"
	item_color = "officerblueclothes"
	alt_covers_chest = 1

/obj/item/clothing/under/rank/head_of_security/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's formal uniform"
	icon_state = "hosblueclothes"
	item_state = "hosblueclothes"
	item_color = "hosblueclothes"
	alt_covers_chest = 1

/obj/item/clothing/under/rank/masteratarms/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden."
	name = "master at arms's formal uniform"
	icon_state = "wardenblueclothes"
	item_state = "wardenblueclothes"
	item_color = "wardenblueclothes"
	alt_covers_chest = 1

/*
 *Blueshirt
 */

/obj/item/clothing/under/rank/security/blueshirt
	desc = "I'm a little busy right now, Calhoun."
	icon_state = "blueshift"
	item_state = "blueshift"
	item_color = "blueshift"
	can_adjust = 0

/obj/item/clothing/under/rank/masteratarms/navyblue
	desc = "The insignia on this uniform tells you that this uniform belongs to the Master-at-Arms."
	name = "master-at-arms's formal uniform"
	icon_state = "masteratarmsblueclothes"
	item_state = "masteratarmsblueclothes"
	item_color = "masteratarmsblueclothes"
	alt_covers_chest = 1

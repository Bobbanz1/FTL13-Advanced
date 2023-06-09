/datum/outfit/defender/pirate
  name = "pirate ship swabbie"
  uniform = /obj/item/clothing/under/pirate
  shoes = /obj/item/clothing/shoes/combat
  suit = /obj/item/clothing/suit/armor/piratejacket
  suit_store = /obj/item/reagent_containers/food/drinks/bottle/rum
  head = /obj/item/clothing/head/bandana
  back = /obj/item/storage/backpack/satchel
  glasses = /obj/item/clothing/glasses/eyepatch

/datum/outfit/defender/pirate/announce_to()
  var/text = "<B>YARRRRRRR!</B>\n"
  text +="<B>This bastards want to test themselves in a close combat!</B>\n"
  text +="<B>Defend Self-Destruct device for 18 minutes, take them by surprise and die a glorious death!\n</B>"
  return text

/datum/outfit/defender/command/pirate
  name = "pirate ship captain"
  uniform = /obj/item/clothing/under/pirate
  suit = /obj/item/clothing/suit/space/hardsuit/steampunk_pirate
  head = null
  mask = /obj/item/clothing/mask/gas
  shoes = /obj/item/clothing/shoes/combat
  back = /obj/item/storage/backpack/satchel
  suit_store = /obj/item/gun/energy/laser/retro
  glasses = /obj/item/clothing/glasses/thermal/eyepatch
  belt = /obj/item/nullrod/claymore/saber/pirate
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/tank/jetpack/oxygen/harness=1,\
    /obj/item/ammo_box/n762=1,\
    /obj/item/crowbar=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/command/pirate/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/device/radio/uplink/U = H.get_item_by_slot(slot_l_store)
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Cap'n [H.real_name]", "Pirate Leader")
  U.hidden_uplink.name = "Pirate Freedom Network"
  U.hidden_uplink.style = "pirate"

/datum/outfit/defender/command/pirate/announce_to()
  var/text = "<B>YARR! You are the captain of this ship!</B>\n"
  text +="<B>Huge blast disrupted our primary systems! Self-destruction mechanism was launched automatically on ship main terminal.</B>\n"
  text +="<B>Defend the Self-destruction mechanism for 18 minutes, do not let this bastards take our treasures!\n</B>"
  return text


/datum/outfit/defender/pirate/gunner
  name = "pirate ship gunner"
  belt = /obj/item/gun/ballistic/revolver/nagant
  shoes = /obj/item/clothing/shoes/combat
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/storage/box/handcuffs=1,\
    /obj/item/ammo_box/n762=1,\
    /obj/item/crowbar=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/pirate/gunner/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("1st Mate [H.real_name]", "Pirate Gunner")

/datum/outfit/defender/pirate/carpenter
  name = "pirate ship carpenter"
  head = /obj/item/clothing/head/welding
  belt = /obj/item/storage/belt/utility/full
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/storage/box/metalfoam=1)

/datum/outfit/defender/pirate/carpenter/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("2nd Mate [H.real_name]", "Pirate Carpenter")

/datum/outfit/defender/pirate/surgeon
  name = "pirate ship surgeon"
  head = /obj/item/clothing/head/plaguedoctorhat
  glasses = /obj/item/clothing/glasses/hud/health
  belt = /obj/item/storage/belt/medical
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
		/obj/item/reagent_containers/hypospray/medipen/survival=3,\
    /obj/item/crowbar=1,\
    /obj/item/storage/firstaid/brute=1,\
    /obj/item/storage/firstaid/fire=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/pirate/surgeon/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("3rd Mate [H.real_name]", "Pirate Sawbones")

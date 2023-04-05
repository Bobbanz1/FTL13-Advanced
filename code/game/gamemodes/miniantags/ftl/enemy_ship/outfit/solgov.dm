/datum/outfit/defender/solgov
  name = "SolGov ship passengeer"
  uniform = /obj/item/clothing/under/solgov
  shoes = /obj/item/clothing/shoes/jackboots
  back = /obj/item/storage/backpack/satchel
  glasses = /obj/item/clothing/glasses/eyepatch

/datum/outfit/defender/solgov/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/device/radio/R = H.ears
  R.set_frequency(FREQ_CENTCOM)
  R.freqlock = TRUE

/datum/outfit/defender/solgov/announce_to()
  var/text = "<span class='warning'>-ALERT! This is transmission from Earth Fleet Command!-</span>\n"
  text +="<B>Huge blast destroyed your primary systems! Self-destruction mechanism launched on your ship main terminal.</B>\n"
  text +="<B>Defend the ship main terminal for 18 minutes, we can't let them have this freight!\n</B>"
  text +="<B>My apologies, but your surviving chance is 0%. Stick with a mission.</B>"
  text +="<span class='warning'>-END OF TRANSMISSION-</span>"
  return text

/datum/outfit/defender/command/solgov
  name = "SolGov ship captain"
  uniform = /obj/item/clothing/under/solgov/command
  suit = /obj/item/clothing/suit/space/nasavoid/defender
  shoes = /obj/item/clothing/shoes/laceup
  mask = /obj/item/clothing/mask/gas/sechailer
  back = /obj/item/storage/backpack/satchel
  suit_store = /obj/item/gun/energy/disabler
  glasses = /obj/item/clothing/glasses/hud/security/night
  belt = /obj/item/storage/belt/sabre
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/tank/jetpack/oxygen/harness=1,\
    /obj/item/clothing/head/helmet/space/nasavoid=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/command/solgov/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("CEO [H.real_name]", "Executive Officer")
  var/obj/item/device/radio/R = H.ears
  R.set_frequency(FREQ_CENTCOM)
  R.freqlock = TRUE
  var/obj/item/device/radio/uplink/U = H.get_item_by_slot(slot_l_store)
  U.hidden_uplink.name = "Earth Emergency Network"
  U.hidden_uplink.style = "solgov"

/datum/outfit/defender/command/solgov/announce_to()
  var/text = "<span class='warning'>-ALERT! This is transmission from Earth Fleet Command!-</span>\n"
  text += "<B>You are RESPONSIBLE for this ship!</B>\n"
  text +="<B>Huge blast disrupted our primary systems! Self-destruction mechanism was launched automatically on ship main terminal.</B>\n"
  text +="<B>Defend the ship main terminal for 18 minutes, do not let them take our freight!\n</B>"
  text +="<span class='warning'>-END OF TRANSMISSION-</span>"
  return text

/datum/outfit/defender/solgov/peacekeeper
  name = "SolGov ship peacekeeper"
  head = /obj/item/clothing/head/helmet/swat/nanotrasen
  belt = /obj/item/gun/energy/e_gun/advtaser
  suit = /obj/item/clothing/suit/armor/bulletproof
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/storage/box/handcuffs=1,\
    /obj/item/ammo_box/magazine/m45=2,\
    /obj/item/device/radio=1)

/datum/outfit/defender/solgov/marine/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Cpt. [H.real_name]", "Peacekeeper")

/datum/outfit/defender/solgov/engineer
  name = "SolGov ship engineer"
  head = /obj/item/clothing/head/welding
  belt = /obj/item/storage/belt/utility/full
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/storage/box/metalfoam=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/solgov/engineer/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Lt. [H.real_name]", "Engineering Worker")

/datum/outfit/defender/solgov/medic
  name = "SolGov ship medic"
  glasses = /obj/item/clothing/glasses/hud/health
  belt = /obj/item/storage/belt/medical
  l_hand = /obj/item/storage/firstaid/regular
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
		/obj/item/reagent_containers/hypospray/medipen/survival=3,\
    /obj/item/crowbar=1,\
    /obj/item/storage/firstaid/brute=1,\
    /obj/item/storage/firstaid/fire=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/solgov/medic/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Lt. [H.real_name]", "Medical Worker")

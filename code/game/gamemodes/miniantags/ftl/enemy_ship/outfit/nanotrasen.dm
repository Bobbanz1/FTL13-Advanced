/datum/outfit/defender/nanotrasen
  name = "NT ship employee"
  uniform = /obj/item/clothing/under/rank/centcom_officer
  shoes = /obj/item/clothing/shoes/laceup
  back = /obj/item/storage/backpack/satchel
  glasses = /obj/item/clothing/glasses/eyepatch

/datum/outfit/defender/nanotrasen/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/device/radio/R = H.ears
  R.set_frequency(FREQ_CENTCOM)
  R.freqlock = TRUE

/datum/outfit/defender/nanotrasen/announce_to()
  var/text = "<B>You need to protect NT property!</B>\n"
  text +="<B>Shameless traitors approaching our ship! They think they can loot us...</B>\n"
  text +="<B>Defend Self-Destruct device for 18 minutes, do not let traitors take our high-tech devices and valuable recources!\n</B>"
  return text

/datum/outfit/defender/command/nanotrasen
  name = "NT ship captain"
  uniform = /obj/item/clothing/under/rank/centcom_commander
  suit = /obj/item/clothing/suit/space/syndicate/green
  shoes = /obj/item/clothing/shoes/laceup
  mask = /obj/item/clothing/mask/gas/sechailer/swat
  back = /obj/item/storage/backpack/satchel
  suit_store = /obj/item/gun/energy/laser/retro
  glasses = /obj/item/clothing/glasses/hud/security/night
  belt = /obj/item/storage/belt/sabre
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/tank/jetpack/oxygen/harness=1,\
    /obj/item/clothing/head/helmet/space/syndicate/green=1,\
    /obj/item/crowbar=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/command/nanotrasen/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Cpt. [H.real_name]", "NT Ship Commander")
  var/obj/item/device/radio/R = H.ears
  R.set_frequency(FREQ_CENTCOM)
  R.freqlock = TRUE
  var/obj/item/device/radio/uplink/U = H.get_item_by_slot(slot_l_store)
  U.hidden_uplink.name = "Centcomm TCNet"
  U.hidden_uplink.style = "nanotrasen"

/datum/outfit/defender/command/nanotrasen/announce_to()
  var/text = "<B>You are Commander of this ship!</B>\n"
  text +="<B>Huge blast disrupted our primary systems! Self-destruction mechanism was launched automatically on ship main terminal.</B>\n"
  text +="<B>Defend the ship main terminal for 18 minutes, do not let this traitors take our high-tech devices and valuable recources!\n</B>"
  return text

/datum/outfit/defender/nanotrasen/marine
  name = "NT ship marine"
  head = /obj/item/clothing/head/helmet/swat/nanotrasen
  belt = /obj/item/gun/ballistic/automatic/pistol/m1911
  suit = /obj/item/clothing/suit/armor/bulletproof
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/storage/box/handcuffs=1,\
    /obj/item/ammo_box/magazine/m45=2,\
    /obj/item/crowbar=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/nanotrasen/marine/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Lt. [H.real_name]", "NT Ship Marine")

/datum/outfit/defender/nanotrasen/engineer
  name = "NT ship engineer"
  head = /obj/item/clothing/head/welding
  belt = /obj/item/storage/belt/utility/full
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/storage/box/metalfoam=1)

/datum/outfit/defender/nanotrasen/engineer/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Sgt. [H.real_name]", "NT Ship Engineering Officer")

/datum/outfit/defender/nanotrasen/medic
  name = "NT ship medic"
  glasses = /obj/item/clothing/glasses/hud/health
  belt = /obj/item/storage/belt/medical
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
		/obj/item/reagent_containers/hypospray/medipen/survival=3,\
    /obj/item/crowbar=1,\
    /obj/item/storage/firstaid/brute=1,\
    /obj/item/storage/firstaid/fire=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/nanotrasen/medic/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Cpl. [H.real_name]", "NT Ship Medical Officer")

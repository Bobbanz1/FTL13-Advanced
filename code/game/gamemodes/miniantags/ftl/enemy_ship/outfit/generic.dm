/datum/outfit/defender/command/generic
  name = "syndicate ship captain"
  mask = /obj/item/clothing/mask/gas/syndicate
  suit = /obj/item/clothing/suit/space/syndicate/black/red
  suit_store = /obj/item/gun/energy/laser/retro
  belt =/obj/item/katana/ceremonial
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
    /obj/item/tank/jetpack/oxygen/harness=1,\
    /obj/item/clothing/head/helmet/space/syndicate/black/red=1,\
    /obj/item/crowbar=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/generic/security
  name = "syndicate ship security officer"
  suit = /obj/item/clothing/suit/armor/bulletproof
  belt = /obj/item/gun/ballistic/automatic/pistol
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
		/obj/item/storage/box/handcuffs=1,\
    /obj/item/ammo_box/magazine/m10mm=2,\
    /obj/item/crowbar=1)

/datum/outfit/defender/generic/security/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Sergeant [H.real_name]", "Syndicate Agent")

/datum/outfit/defender/generic/engineer
  name = "syndicate ship engineering officer"
  head = /obj/item/clothing/head/welding
  belt = /obj/item/storage/belt/utility/full
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
		/obj/item/storage/box/metalfoam=1,\
    /obj/item/crowbar=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/generic/engineer/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Pioneer [H.real_name]", "Syndicate Maintainer")

/datum/outfit/defender/generic/medic
  name = "syndicate ship medical officer"
  glasses = /obj/item/clothing/glasses/hud/health
  back = /obj/item/storage/backpack/medic
  belt = /obj/item/storage/belt/medical
  backpack_contents = list(/obj/item/storage/box/syndie=1,\
		/obj/item/reagent_containers/hypospray/medipen/survival=3,\
    /obj/item/crowbar=1,\
    /obj/item/storage/firstaid/brute=1,\
    /obj/item/storage/firstaid/fire=1,\
    /obj/item/device/radio=1)

/datum/outfit/defender/generic/medic/post_equip(mob/living/carbon/human/H)
  . = ..()
  var/obj/item/card/id/I = H.wear_id
  I.update_label("Doc [H.real_name]", "Syndicate Medic")

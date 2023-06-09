/datum/export/salvage
	cost_modifiers = list("Salvage")

/datum/export/salvage/low_salvage
	cost = 250
	unit_name = "Low value salvage"
	export_types = list(
    /obj/structure/janitorialcart,
    /obj/structure/reagent_dispensers/beerkeg,
    /obj/machinery/portable_atmospherics/canister/air,
    /obj/machinery/portable_atmospherics/canister/oxygen,
    /obj/machinery/portable_atmospherics/canister/nitrogen,
    /obj/structure/statue/sandstone/assistant,
    /obj/machinery/food_cart,
  )

/datum/export/salvage/medium_salvage
  cost = 1250
  unit_name = "medium value salvage"
  export_types = list(
    /obj/item/pickaxe/drill,
    /obj/machinery/monkey_recycler,
    /obj/item/circuitboard/machine/mac_breech,
    /obj/item/circuitboard/machine/mac_barrel,
    /obj/machinery/portable_atmospherics/canister/toxins,
    /mob/living/simple_animal/bot/secbot,
    /mob/living/simple_animal/bot/cleanbot,
    /mob/living/simple_animal/bot/medbot,
    /obj/item/grenade/plastic/c4,
    /obj/machinery/shieldwallgen,
    /obj/machinery/vending/boozeomat,
    /obj/item/pickaxe/drill/jackhammer,
    /obj/item/grenade/syndieminibomb,
    /obj/item/grenade/plastic/x4,
    /obj/item/gun/energy/pulse,
    /obj/item/abductor_baton,
    /mob/living/simple_animal/bot/ed209,
    )

/datum/export/salvage/high_salvage
  cost = 3500
  unit_name = "high value salvage"
  export_types = list(
    /obj/item/circuitboard/machine/phase_cannon,
    /obj/structure/AIcore,
    /obj/item/grenade/clusterbuster,
    /obj/item/gun/ballistic/revolver/golden,
    /obj/mecha/working/ripley/mining,
    /obj/mecha/working/ripley,
    )

/datum/export/Omega_salvage
  cost = 7500
  unit_name = "omega value salvage"
  export_types = list(
    /obj/machinery/syndicatebomb,
    /obj/structure/displaycase/shiplabcage,
    /obj/machinery/power/supermatter_shard,
    /obj/mecha/combat/gygax,
    /obj/item/gun/magic/staff/honk,
    /obj/item/gun/medbeam,

    )

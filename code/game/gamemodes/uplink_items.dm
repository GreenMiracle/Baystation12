/datum/spawn_item
	var/name = "invalid"
	var/path = /obj
	var/cost = 1
	var/category = ""

	proc/give_item(var/atom/loc)
		var/obj/I = new path(loc)
		if(ishuman(loc))
			var/mob/living/carbon/human/A = loc
			A.put_in_any_hand_if_possible(I)

/datum/spawn_item/revolver
	name = "Revolver"
	path = /obj/item/weapon/gun/projectile
	cost = 6
	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/revolver_ammo
	name = "Ammo-357"
	path = /obj/item/ammo_magazine/a357
	cost = 2
	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/crossbow
	name = "Energy Crossbow"
	path = /obj/item/weapon/gun/energy/crossbow
	cost = 5
	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/crossbow
	name = "Energy Crossbow"
	path = /obj/item/weapon/gun/energy/crossbow
	cost = 5
	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/sword
	name = "Energy Sword"
	path = /obj/item/weapon/melee/energy/sword
	cost = 4
	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/syndicate_bundle
	name = "Syndicate Bundle"
	path = /obj/item/weapon/storage/box/syndicate
	cost = 10
	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/emp_grenades
	name = "5 EMP Grenades"
	path = /obj/item/weapon/storage/box/emps
	cost = 3
	category = "Highly Visible and Dangerous Weapons"
//To transfer
//datum/spawn_item/syndicate_bomb
//	name = "Syndicate Bundle"
//	path = /obj/item/device/syndicatebomb
//	cost = 6
//	category = "Highly Visible and Dangerous Weapons"

/datum/spawn_item/paralysis_pen
	name = "Paralysis Pen"
	path = /obj/item/weapon/pen/paralysis
	cost = 3
	category = "Stealthy and Inconspicuous Weapons"

/datum/spawn_item/syndicate_soap
	name = "Syndicate Soap"
	path = /obj/item/weapon/soap/syndie
	cost = 1
	category = "Stealthy and Inconspicuous Weapons"

/datum/spawn_item/detomatrix
	name = "Detomatix PDA Cartridge"
	path = /obj/item/weapon/cartridge/syndicate
	cost = 3
	category = "Stealthy and Inconspicuous Weapons"

//datum/spawn_item/chameleon_kit
//	name = "Chameleon Kit"
//	path = /obj/item/weapon/storage/box/syndie_kit/chameleon
//	cost = 7
//	category = "Stealth and Camouflage Items"

/datum/spawn_item/syndicate_shoes
	name = "No-Slip Syndicate Shoes"
	path = /obj/item/clothing/shoes/syndigaloshes
	cost = 2
	category = "Stealth and Camouflage Items"

/datum/spawn_item/agentcard
	name = "Agent ID card"
	path = /obj/item/weapon/card/id/syndicate
	cost = 2
	category = "Stealth and Camouflage Items"

/datum/spawn_item/voice_changer
	name = "Voice Changer"
	path = /obj/item/clothing/mask/gas/voice
	cost = 4
	category = "Stealth and Camouflage Items"

/datum/spawn_item/chameleon_projector
	name = "Chameleon-Projector"
	path = /obj/item/device/chameleon
	cost = 4
	category = "Stealth and Camouflage Items"

/datum/spawn_item/cloaking_device
	name = "Cloaking Device"
	path = /obj/item/weapon/cloaking_device
	cost = 8
	category = "Stealth and Camouflage Items"

	give_item(var/atom/loc)
		loc << "/red You feel some shitty smell from [name]"
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			message_admins("[H.name]([H.ckey]) spawned cloaking device.")
		..()

/datum/spawn_item/emag
	name = "Cryptographic Sequencer"
	path = /obj/item/weapon/card/emag
	cost = 3
	category = "Devices and Tools"

///datum/spawn_item/hacktool
//	name = "Hacktool (Slow, but stealthy.  Unlimited uses)"
//	path = /obj/item/device/hacktool
//	cost = 4
//	category = "Devices and Tools"

/datum/spawn_item/toolbox
	name = "Fully Loaded Toolbox;"
	path = /obj/item/weapon/storage/toolbox/syndicate
	cost = 1
	category = "Devices and Tools"

/datum/spawn_item/thermal
	name = "Thermal Imaging Glasses"
	path = /obj/item/clothing/glasses/thermal/syndi
	cost = 3
	category = "Devices and Tools"

/datum/spawn_item/binary
	name = "Binary Translator Key"
	path = /obj/item/device/encryptionkey/binary
	cost = 3
	category = "Devices and Tools"

/datum/spawn_item/aimodule
	name = "Hacked AI Upload Module"
	path = /obj/item/weapon/aiModule/syndicate
	cost = 7
	category = "Devices and Tools"

/datum/spawn_item/c4
	name = "C-4 (Destroys walls)"
	path = /obj/item/weapon/plastique
	cost = 2
	category = "Devices and Tools"

/datum/spawn_item/powersink
	name = "Powersink (DANGER!)"
	path = /obj/item/device/powersink
	cost = 5
	category = "Devices and Tools"

/datum/spawn_item/singularity_beacon
	name = "Singularity Beacon (DANGER!)"
	path = /obj/item/device/radio/beacon/syndicate
	cost = 7
	category = "Devices and Tools"

/datum/spawn_item/teleporter_board
	name = "Teleporter Circuit Board"
	path = /obj/item/weapon/circuitboard/teleporter
	cost = 20
	category = "Devices and Tools"

/datum/spawn_item/imp_freedom
	name = "Freedom Implant"
	path = /obj/item/weapon/storage/box/syndie_kit/imp_freedom
	cost = 3
	category = "Implants"

/datum/spawn_item/imp_uplink
	name = "Uplink Implant (Contains 5 Telecrystals)"
	path = /obj/item/weapon/storage/box/syndie_kit/imp_uplink
	cost = 10
	category = "Implants"

/datum/spawn_item/imp_explosive
	name = "Explosive Implant (DANGER!)"
	path = /obj/item/weapon/storage/box/syndie_kit/imp_explosive
	cost = 6
	category = "Implants"

/datum/spawn_item/imp_explosive
	name = "Compressed Matter Implant"
	path = /obj/item/weapon/storage/box/syndie_kit/imp_compress
	cost = 4
	category = "Implants"

/datum/spawn_item/balloon
	name = "For showing that You Are The BOSS (Useless Balloon)"
	path = /obj/item/toy/syndicateballoon
	cost = 10
	category = "Badassery"

	give_item(var/atom/loc)
		loc << "You are real badass"
		..()

/*
/datum/spawn_item
	name = ""
	path =
	cost =
	category = ""
*/
var/list/donators = list()
var/list/datum/spawn_item/donator_items = list()

/proc/load_donators()
	if(donators.len)
		return

	establish_db_connection()
	if(!dbcon.IsConnected())
		world.log << "Failed to connect to database in load_donators()."
		diary << "Failed to connect to database in load_donators()."
		donators["fail"] = 1
		return
	var/DBQuery/query = dbcon.NewQuery("SELECT byond,sum FROM forum2.Z_donators")
	query.Execute()
	while(query.NextRow())
		donators[query.item[1]] = round(query.item[2])

	load_donator_items()

/proc/load_donator_items()
	//Hats
	donator_items.Add(new /datum/spawn_item/swat_cap)
	donator_items.Add(new /datum/spawn_item/collectable_pete_hat)
//	donator_items.Add(new /datum/spawn_item/collectable_metroid_hat)
	donator_items.Add(new /datum/spawn_item/collectable_xeno_hat)
	donator_items.Add(new /datum/spawn_item/collectable_top_hat)
	donator_items.Add(new /datum/spawn_item/kitty_ears)
	donator_items.Add(new /datum/spawn_item/ushanka)
	//Personal Stuff
	donator_items.Add(new /datum/spawn_item/eye_patch)
	donator_items.Add(new /datum/spawn_item/cane)
	donator_items.Add(new /datum/spawn_item/golden_pen)
	donator_items.Add(new /datum/spawn_item/zippo)
	donator_items.Add(new /datum/spawn_item/engraved_zippo)
	donator_items.Add(new /datum/spawn_item/golden_zippo)
	donator_items.Add(new /datum/spawn_item/cigarette_packet)
	donator_items.Add(new /datum/spawn_item/dromedaryco_packet)
	donator_items.Add(new /datum/spawn_item/premium_havanian_cigar)
	donator_items.Add(new /datum/spawn_item/electronic_cigarette)
//	donator_items.Add(new /datum/spawn_item/beer_bottle)
	donator_items.Add(new /datum/spawn_item/captain_flask)
	donator_items.Add(new /datum/spawn_item/pai_card)
	donator_items.Add(new /datum/spawn_item/teapot)
	donator_items.Add(new /datum/spawn_item/three_mile_island_ice_tea)
	donator_items.Add(new /datum/spawn_item/plague_doctor_set)
	//Shoes
	donator_items.Add(new /datum/spawn_item/clown_shoes)
	donator_items.Add(new /datum/spawn_item/rainbow_shoes)
	donator_items.Add(new /datum/spawn_item/cyborg_shoes)
	donator_items.Add(new /datum/spawn_item/laceups_shoes)
	donator_items.Add(new /datum/spawn_item/leather_shoes)
	donator_items.Add(new /datum/spawn_item/red_shoes)
	donator_items.Add(new /datum/spawn_item/green_shoes)
	donator_items.Add(new /datum/spawn_item/blue_shoes)
	donator_items.Add(new /datum/spawn_item/yellow_shoes)
	donator_items.Add(new /datum/spawn_item/purple_shoes)
	donator_items.Add(new /datum/spawn_item/wooden_sandals)
	donator_items.Add(new /datum/spawn_item/fluffy_slippers)
	//Jumpsuits
	donator_items.Add(new /datum/spawn_item/vice_policeman)
	donator_items.Add(new /datum/spawn_item/rainbow_suit)
	donator_items.Add(new /datum/spawn_item/lightblue_suit)
	donator_items.Add(new /datum/spawn_item/aqua_suit)
	donator_items.Add(new /datum/spawn_item/purple_suit)
	donator_items.Add(new /datum/spawn_item/lightpurple_suit)
	donator_items.Add(new /datum/spawn_item/lightbrown_suit)
	donator_items.Add(new /datum/spawn_item/brown_suit)
	donator_items.Add(new /datum/spawn_item/darkblue_suit)
	donator_items.Add(new /datum/spawn_item/lightred_suit)
	donator_items.Add(new /datum/spawn_item/darkred_suit)
	donator_items.Add(new /datum/spawn_item/grim_jacket)
	donator_items.Add(new /datum/spawn_item/black_jacket)
	donator_items.Add(new /datum/spawn_item/police_uniform)
	donator_items.Add(new /datum/spawn_item/scratched_suit)
	donator_items.Add(new /datum/spawn_item/downy_jumpsuit)
	donator_items.Add(new /datum/spawn_item/tacticool_turtleneck)
	//Gloves
	donator_items.Add(new /datum/spawn_item/white)
	donator_items.Add(new /datum/spawn_item/rainbow)
	donator_items.Add(new /datum/spawn_item/black)
	//Coats
	donator_items.Add(new /datum/spawn_item/brown_coat)
	//Bedsheets
	donator_items.Add(new /datum/spawn_item/clown_bedsheet)
	donator_items.Add(new /datum/spawn_item/mime_bedsheet)
	donator_items.Add(new /datum/spawn_item/rainbow_bedsheet)
	donator_items.Add(new /datum/spawn_item/captain_bedsheet)
	//Toys
	donator_items.Add(new /datum/spawn_item/rubber_duck)
	donator_items.Add(new /datum/spawn_item/the_holy_cross)
	donator_items.Add(new /datum/spawn_item/champion_belt)
	donator_items.Add(new /datum/spawn_item/keppel)
	//Special Stuff
	donator_items.Add(new /datum/spawn_item/santabag)
	donator_items.Add(new /datum/spawn_item/sunglasses)

/client/var/datum/donators/donator = null

/client/verb/cmd_donator_panel()
	set name = "Donator panel"
	set category = "OOC"

	if(!ticker || ticker.current_state < 3)
		alert("Please wait until game setting up!")
		return

	if(!donators.len)
		load_donators()

	if(!donator)
		var/exists = 0
		for(var/datum/donators/D)
			if(D.ownerkey == ckey)
				exists = 1
				src.donator = D
				break
		if(!exists)
			src.donator = new /datum/donators()
			src.donator.owner = src
			src.donator.ownerkey = ckey
			if(donators[ckey])
				donator.maxmoney = donators[ckey]
				donator.money = src.donator.maxmoney

	donator.donatorpanel()

/var/list/donators_datums = list() //need for protect from garbage collector

/datum/donators
	var/client/owner = null
	var/ownerkey
	var/money = 0
	var/maxmoney = 0
	var/allowed_num_items = 10

	New()
		..()
		donators_datums += src

/datum/donators/proc/donatorpanel()
	var/dat = "<title>Donator panel</title>"
	dat += "Your money: [money]/[maxmoney]<br>"
	dat += "Allowed number of items: [allowed_num_items]/10<br><br>"
	dat += "<b>Select items:</b> <br>"

	var/last_category = ""
	for(var/datum/spawn_item/i in donator_items)
		if(last_category != i.category)
			dat += "<b>[i.category]</b><br>"
			last_category = i.category
		if(money < i.cost)
			dat += "[i.name] ([i.cost])<br>"
		else
			dat += "<a href='?src=\ref[src];buy_item=\ref[i]'>[i.name]</a> ([i.cost])<br>"
/*
	//here items list
	dat += "<b>Hats:</b> <br>"
//	dat += "Tough Guy's Toque: <A href='?src=\ref[src];item=/obj/item/clothing/head/fluff/enos_adlai_1;cost=600'>600</A><br>"
	dat += "SWAT cap: <A href='?src=\ref[src];item=/obj/item/clothing/head/secsoft/fluff/swatcap;cost=450'>450</A><br>"
//	dat += "Bloody Welding Helmet: <A href='?src=\ref[src];item=/obj/item/clothing/head/helmet/welding/fluff/yuki_matsuda_1;cost=600'>600</A><br>"
//	dat += "Welding Helmet with Flowers: <A href='?src=\ref[src];item=/obj/item/clothing/head/helmet/welding/fluff/alice_maccrea_1;cost=600'>600</A><br>"
//	dat += "Flagmask: <A href='?src=\ref[src];item=/obj/item/clothing/mask/fluff/flagmask;cost=600'>600</A><br>"
	dat += "Collectable Pete hat: <A href='?src=\ref[src];item=/obj/item/clothing/head/collectable/petehat;cost=2000'>2000</A><br>"
	dat += "Collectable Metroid hat: <A href='?src=\ref[src];item=/obj/item/clothing/head/collectable/metroid;cost=1300'>1300</A><br>"
	dat += "Collectable Xeno hat: <A href='?src=\ref[src];item=/obj/item/clothing/head/collectable/xenom;cost=1100'>1100</A><br>"
//	dat += "Collectable Slime hat: <A href='?src=\ref[src];item=/obj/item/clothing/head/collectable/slime;cost=1500'>1500</A><br>"
	dat += "Collectable Top hat: <A href='?src=\ref[src];item=/obj/item/clothing/head/collectable/tophat;cost=600'>600</A><br>"
	dat += "Kitty Ears: <A href='?src=\ref[src];item=/obj/item/clothing/head/kitty;cost=100'>100</A><br>"
	dat += "Ushanka: <A href='?src=\ref[src];item=/obj/item/clothing/head/ushanka;cost=300'>300</A><br>"

	dat += "<b>Personal Stuff:</b> <br>"
	dat += "Eye patch: <A href='?src=\ref[src];item=/obj/item/clothing/glasses/eyepatch;cost=200'>200</A><br>"
	dat += "Cane: <A href='?src=\ref[src];item=/obj/item/weapon/cane;cost=200'>200</A><br>"
	dat += "Golden Pen: <A href='?src=\ref[src];item=/obj/item/weapon/pen/fluff/eugene_bissegger_1;cost=300'>300</A><br>"
	dat += "Zippo: <A href='?src=\ref[src];item=/obj/item/weapon/lighter/zippo;cost=200'>200</A><br>"
	dat += "Engraved Zippo: <A href='?src=\ref[src];item=/obj/item/weapon/lighter/zippo/fluff/naples_1;cost=250'>250</A><br>"
	dat += "Golden Zippo: <A href='?src=\ref[src];item=/obj/item/weapon/lighter/zippo/fluff/michael_guess_1;cost=500'>500</A><br>"
	dat += "Cigarette packet: <A href='?src=\ref[src];item=/obj/item/weapon/storage/fancy/cigarettes;cost=20'>20</A><br>"
	dat += "DromedaryCo packet: <A href='?src=\ref[src];item=/obj/item/weapon/storage/fancy/cigarettes/dromedaryco;cost=50'>50</A><br>"
	dat += "Premium Havanian Cigar: <A href='?src=\ref[src];item=/obj/item/clothing/mask/cigarette/cigar/havana;cost=200'>200</A><br>"
	dat += "Electronic Cigarette: <A href='?src=\ref[src];item=/obj/item/clothing/mask/fluff/electriccig;cost=100'>100</A><br>"
	dat += "Beer bottle: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/food/drinks/beer;cost=80'>80</A><br>"
	dat += "Captain flask: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/food/drinks/flask;cost=300'>300</A><br>"
	dat += "pAI card: <A href='?src=\ref[src];item=/obj/item/device/paicard;cost=300'>300</A><br>"
	dat += "Teapot: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/glass/beaker/fluff/eleanor_stone;cost=200'>200</A><br>"
	dat += "\"Three Mile Island\" Ice Tea: <A href='?src=\ref[src];item=/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/threemileisland;cost=100'>100</A><br>"

	//dat += "<b>Clothing Sets:</b> <br>"
	//dat += "Prig Costume: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/prig;cost=750'>750</A><br>"
	dat += "Plague Doctor Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/plaguedoctor;cost=3750'>3750</A><br>"
	//dat += "Waiter Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/waiter;cost=750'>750</A><br>"
	//dat += "Commie Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/commie;cost=1100'>1100</A><br>"
	//dat += "Girly-girl Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/nyangirl;cost=750'>750</A><br>"
	//dat += "Rosh Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/rosh;cost=1200'>1200</A><br>"
	//dat += "Butler Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/butler;cost=750'>750</A><br>"
	//dat += "Highlander Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/highlander;cost=1100'>1100</A><br>"
	//dat += "Scratch Set: <A href='?src=\ref[src];item=/obj/effect/landmark/costume/scratch;cost=750'>750</A><br>"

	dat += "<b>Shoes:</b> <br>"
	dat += "Clown Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/clown_shoes;cost=200'>200</A><br>"
	dat += "Rainbow Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/rainbow;cost=200'>200</A><br>"
	dat += "Cyborg Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/cyborg;cost=200'>200</A><br>"
	dat += "Laceups Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/laceup;cost=200'>200</A><br>"
	dat += "Leather Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/leather;cost=200'>200</A><br>"
	dat += "Red Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/red;cost=100'>100</A><br>"
	dat += "Green Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/green;cost=100'>100</A><br>"
	dat += "Blue Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/blue;cost=100'>100</A><br>"
	dat += "Yellow Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/yellow;cost=100'>100</A><br>"
	dat += "Purple Shoes: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/purple;cost=100'>100</A><br>"
//	dat += "Yellow Boots: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/yellowboots;cost=100'>100</A><br>"
//	dat += "White Boots: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/whiteboots;cost=100'>100</A><br>"
//	dat += "Brown Boots: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/fullbrown;cost=100'>100</A><br>"
	dat += "Wooden Sandals: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/sandal;cost=80'>80</A><br>"
	dat += "Fluffy Slippers: <A href='?src=\ref[src];item=/obj/item/clothing/shoes/slippers;cost=150'>150</A><br>"

	dat += "<b>Jumpsuits:</b> <br>"
	dat += "Vice Policeman: <A href='?src=\ref[src];item=/obj/item/clothing/under/rank/vice;cost=900'>900</A><br>"
//	dat += "Johny~~ Suit: <A href='?src=\ref[src];item=/obj/item/clothing/suit/johnny_coat;cost=920'>920</A><br>"
	dat += "Rainbow Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/rainbow;cost=200'>200</A><br>"
//	dat += "Cloud Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/cloud;cost=900'>900</A><br>"
	dat += "Lightblue Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/lightblue;cost=200'>200</A><br>"
	dat += "Aqua Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/aqua;cost=900'>900</A><br>"
	dat += "Purple Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/purple;cost=200'>200</A><br>"
	dat += "Lightpurple Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/lightpurple;cost=200'>200</A><br>"
	dat += "Lightbrown Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/lightbrown;cost=200'>200</A><br>"
	dat += "Brown Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/brown;cost=200'>200</A><br>"
	dat += "Darkblue suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/darkblue;cost=200'>200</A><br>"
	dat += "Lightred Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/lightred;cost=200'>200</A><br>"
	dat += "Darkred Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/darkred;cost=200'>200</A><br>"
	dat += "Grim Jacket: <A href='?src=\ref[src];item=/obj/item/clothing/under/suit_jacket;cost=200'>200</A><br>"
	dat += "Black Jacket: <A href='?src=\ref[src];item=/obj/item/clothing/under/color/blackf;cost=200'>200</A><br>"
	dat += "Police Uniform: <A href='?src=\ref[src];item=/obj/item/clothing/under/det/fluff/retpoluniform;cost=400'>400</A><br>"
	dat += "Scratched Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/scratch;cost=200'>200</A><br>"
//	dat += "Purple Cheerleader Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/cheerleader/purple;cost=200'>200</A><br>"
//	dat += "Yellow Cheerleader Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/cheerleader/yellow;cost=200'>200</A><br>"
//	dat += "White Cheerleader Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/cheerleader/white;cost=200'>200</A><br>"
//	dat += "Cheerleader Suit: <A href='?src=\ref[src];item=/obj/item/clothing/under/cheerleader;cost=200'>200</A><br>"
	dat += "Downy Jumpsuit: <A href='?src=\ref[src];item=/obj/item/clothing/under/fluff/jumpsuitdown;cost=200'>200</A><br>"
	dat += "Tacticool Turtleneck: <A href='?src=\ref[src];item=/obj/item/clothing/under/syndicate/tacticool;cost=200'>200</A><br>"

	dat += "<b>Gloves:</b> <br>"
	dat += "White: <A href='?src=\ref[src];item=/obj/item/clothing/gloves/white;cost=200'>200</A><br>"
	dat += "Rainbow: <A href='?src=\ref[src];item=/obj/item/clothing/gloves/rainbow;cost=300'>300</A><br>"
//	dat += "Fingerless: <A href='?src=\ref[src];item=/obj/item/clothing/gloves/fingerless;cost=200'>200</A><br>"
	dat += "Black: <A href='?src=\ref[src];item=/obj/item/clothing/gloves/black;cost=250'>250</A><br>"

	dat += "<b>Coats:</b> <br>"
//	dat += "France Jacker: <A href='?src=\ref[src];item=/obj/item/clothing/suit/storage/labcoat/fr_jacket;cost=500'>500</A><br>"
//	dat += "Pink Labcoat: <A href='?src=\ref[src];item=/obj/item/clothing/suit/storage/labcoat/fluff/pink;cost=500'>500</A><br>"
//	dat += "Girly Labcoat: <A href='?src=\ref[src];item=/obj/item/clothing/suit/storage/labcoat/fluff/red;cost=500'>500</A><br>"
	dat += "Brown Coat: <A href='?src=\ref[src];item=/obj/item/clothing/suit/browncoat;cost=500'>500</A><br>"
//	dat += "Leather Coat: <A href='?src=\ref[src];item=/obj/item/clothing/suit/leathercoat;cost=600'>600</A><br>"
//	dat += "Neo Coat: <A href='?src=\ref[src];item=/obj/item/clothing/suit/neocoat;cost=900'>900</A><br>"
//	dat += "Wedding Dress: <A href='?src=\ref[src];item=/obj/item/clothing/suit/weddingdress;cost=500'>500</A><br>"
	dat += "<b>Bedsheets:</b> <br>"
	dat += "Clown Bedsheet: <A href='?src=\ref[src];item=/obj/item/weapon/bedsheet/clown;cost=300'>300</A><br>"
	dat += "Mime Bedsheet: <A href='?src=\ref[src];item=/obj/item/weapon/bedsheet/mime;cost=300'>300</A><br>"
	dat += "Rainbow Bedsheet: <A href='?src=\ref[src];item=/obj/item/weapon/bedsheet/rainbow;cost=300'>300</A><br>"
	dat += "Captain Bedsheet: <A href='?src=\ref[src];item=/obj/item/weapon/bedsheet/captain;cost=600'>600</A><br>"

	dat += "<b>Toys:</b> <br>"
	dat += "Rubber Duck: <A href='?src=\ref[src];item=/obj/item/weapon/bikehorn/rubberducky;cost=500'>500</A><br>"
	dat += "The Holy Cross: <A href='?src=\ref[src];item=/obj/item/fluff/val_mcneil_1;cost=600'>600</A><br>"
	dat += "Champion Belt: <A href='?src=\ref[src];item=/obj/item/weapon/storage/belt/champion;cost=400'>400</A><br>"
	dat += "Keppel: <A href='?src=\ref[src];item=/obj/item/weapon/fluff/cado_keppel_1;cost=400'>400</A><br>"

	dat += "<b>Special Stuff:</b> <br>"
	dat += "Santabag: <A href='?src=\ref[src];item=/obj/item/weapon/storage/backpack/santabag;cost=4000'>4000</A><br>"
	dat += "Sunglasses: <A href='?src=\ref[src];item=/obj/item/clothing/glasses/sunglasses;cost=600'>600</A><br>"
//	dat += "Soul stone shard: <A href='?src=\ref[src];item=/obj/item/device/soulstone;cost=1500'>1500</A><br>"
//	dat += "Plastic balisong knife: <A href='?src=\ref[src];item=/obj/item/weapon/kitchenknife/b_knife;cost=800'>800</A><br>"
*/
	usr << browse(dat, "window=donatorpanel;size=250x400")


/datum/donators/Topic(href, href_list)
	if(href_list["buy_item"])
		var/datum/spawn_item/I = locate(href_list["buy_item"])
		if(!I)
			return

		if(!istype(I))
			message_admins("[usr.name] tried to spawn custom item. (Cache Inject!)")
			return

		if(!(I in donator_items))
			message_admins("[usr.name] tried to spawn item have not in donator_items. (Cache Inject!)")
			return

		if(I.cost > money)
			usr << "\red You don't have enough funds."
			return

		if(!allowed_num_items)
			usr << "\red You already spawned max count of items."
			return

		if(!istype(owner.mob, /mob/living/carbon/human))
			usr << "\red You must be a human to use this."
			return

		if(owner.mob.stat)
			return


		message_admins("[usr.name]([usr.ckey]) spawned [I.name]")
		money -= I.cost
		I.give_item(owner.mob)
		owner.cmd_donator_panel()

/*
/datum/donators/proc/attemptSpawnItem(var/item,var/cost)
	var/path = text2path(item)

	if(cost > money)
		usr << "\red You don't have enough funds."
		return 0

	if(!allowed_num_items)
		usr << "\red You already spawned max count of items."
		return

	var/mob/living/carbon/human/H = owner.mob
	if(!istype(H))
		usr << "\red You must be a human to use this."
		return 0

	if(!ispath(path))
		//world << "attempted to spawn [item] - no such item exist"
		return 0

	if(H.stat) return 0

	if(ownerkey == "editorrus")
		usr << "\blue Your vial has been spawned in your anal slot!"
		new /obj/item/weapon/reagent_containers/glass/beaker/vial(H)
		return 0

	if(ownerkey == "mikles" || ispath(path, /obj/machinery/singularity))
		usr << "\blue Your Nar-Sie has been spawned in your anal slot!"
		H.gib()
		return 0

	var/obj/spawned = new path(H)
	var/list/slots = list (
		"backpack" = slot_in_backpack,
		"left pocket" = slot_l_store,
		"right pocket" = slot_r_store,
		"left hand" = slot_l_hand,
		"right hand" = slot_r_hand,
	)
	var/where = H.equip_in_one_of_slots(spawned, slots, del_on_fail=0)
	if (!where)
		spawned.loc = H.loc
		usr << "\blue Your [spawned.name] has been spawned!"
	else
		usr << "\blue Your [spawned.name] has been spawned in your [where]!"


	money -= cost
	allowed_num_items--
	owner.cmd_donator_panel()
*/


/proc/dd_text2list(text, separator, var/list/withinList)
	var/textlength = length(text)
	var/separatorlength = length(separator)
	if(withinList && !withinList.len) withinList = null
	var/list/textList = new()
	var/searchPosition = 1
	var/findPosition = 1
	var/loops = 0
	while(1)
		if(loops >= 1000)
			break
		loops++

		findPosition = findtext(text, separator, searchPosition, 0)
		var/buggyText = copytext(text, searchPosition, findPosition)
		if(!withinList || (buggyText in withinList)) textList += "[buggyText]"
		if(!findPosition) return textList
		searchPosition = findPosition + separatorlength
		if(searchPosition > textlength)
			textList += ""
			return textList
	return

//SPECIAL ITEMS
/obj/item/weapon/reagent_containers/food/drinks/drinkingglass/threemileisland
	New()
		..()
		reagents.add_reagent("threemileisland", 50)
		on_reagent_change()
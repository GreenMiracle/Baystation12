#define WHITELISTFILE "data/whitelist.txt"

var/list/whitelist = list()

/hook/startup/proc/loadWhitelist()
	if(config.usewhitelist)
		load_whitelist()
	return 1

/proc/load_whitelist()
	whitelist = file2list(WHITELISTFILE)
	if(!whitelist.len)	whitelist = null

/proc/is_whitelisted(mob/M /*, var/rank*/)
	if(!whitelist)
		return 0
	return ("[M.ckey]" in whitelist)

var/list/alien_whitelist = list()

/hook/startup/proc/loadAlienWhitelist()
	if(config.usealienwhitelist)
		load_alien_whitelist()
	return 1

/proc/load_alien_whitelist()
	establish_db_connection()
	if(!dbcon.IsConnected())
		return
	var/DBQuery/query = dbcon.NewQuery("SELECT ckey FROM alien_whitelist WHERE *")
	query.Execute()
	var/ckey = query.NextRow()
	while(ckey)
		alien_whitelist.Add(ckey)
		ckey = query.NextRow()

/proc/is_alien_whitelisted(mob/M)
	if(!config.usealienwhitelist)
		return 1
	if(check_rights(R_ADMIN, 0))
		return 1
	if(M && M.ckey)
		if(M.ckey in alien_whitelist)
			return 1

	return 0

#undef WHITELISTFILE

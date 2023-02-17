ESX = nil
TriggerEvent(Config.Settings.ESXStuff.SharedObject, function(obj)ESX = obj end)
local zones = {}
local isInFFA = {}

RegisterCommand(Config.Settings.CMD.Quit, function(s)
	local xPlayer = ESX.GetPlayerFromId(s)
	MySQL.Async.fetchAll('SELECT * FROM ffa WHERE identifier=@identifier', {
		['@identifier'] = xPlayer.getIdentifier(),
	}, function(res)
		for _, i in pairs(res) do
			if isInFFA[s] or i.isinffa == 1 then
				TriggerClientEvent('ardi:quitffa', s)
				SetPlayerRoutingBucket(s, Config.Settings.MainDim)
				MySQL.Async.execute('UPDATE ffa SET name = @name, isinffa = @isinffa WHERE identifier = @identifier', {
					['@name'] = GetPlayerName(s),
					['@isinffa'] = 0,
					['@identifier'] = xPlayer.getIdentifier(),
				})
				if not Config.Settings.UseOwnWeapons then
					RemoveAllPedWeapons(s)
					for _, i in pairs(xPlayer.getLoadout()) do
						GiveWeaponToPed(s, GetHashKey(i.name), i.ammo, false, false)
					end
				end
				isInFFA[s] = false
				if zones[s] ~= nil then
					Config.Zone[zones[s]].asd = Config.Zone[zones[s]].asd - 1
				end
			end
		end
	end)
end, false)

RegisterNetEvent('ardi:join:ffa')
AddEventHandler('ardi:join:ffa', function(zone)
	TriggerClientEvent('ardi:set:pos', source, Config.Zone[zone].position[math.random(1, #Config.Zone[zone].position)])
	SetPlayerRoutingBucket(source, Config.Zone[zone].dim)
	if not Config.Settings.UseOwnWeapons then
		RemoveAllPedWeapons(source)
		for _, i in pairs(Config.Zone[zone].weapons) do
			GiveWeaponToPed(source, GetHashKey(i), 100, false, false)
		end
	end
	zones[source] = zone
	isInFFA[source] = true
	Config.Zone[zone].asd = Config.Zone[zone].asd + 1
end)

RegisterNetEvent('ardi:ffa:killed')
AddEventHandler('ardi:ffa:killed', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	MySQL.Async.execute('UPDATE ffa SET deaths = deaths + 1 WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getIdentifier(),
	})
	MySQL.Async.execute('UPDATE ffa SET kills = kills + 1 WHERE identifier = @identifier', {
		['@identifier'] = xTarget.getIdentifier(),
	})
	TriggerClientEvent('ardi:ffa:hud', source)
	TriggerClientEvent('ardi:ffa:hud', target)
    if Config.Settings.Health.AddHealthOnKill.Enabled then
		TriggerClientEvent('ardi:ffa:healPlayer', target)
	end
	if Config.Settings.Money.Enabled then
		local money = Config.Settings.Money.Count
		xTarget.addMoney(money)
		Config.Settings.SVNotify(target, (Config.Settings.Language.MoneyMSG):format(GetPlayerName(source), money))
	else
		Config.Settings.SVNotify(target, (Config.Settings.Language.KillerMSG):format(GetPlayerName(source)))
	end
end)

ESX.RegisterServerCallback('ardi:get:count', function(src, cb)
	cb(Config.Zone)
end)

ESX.RegisterServerCallback('ardi:get:stats', function(src, cb)
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll('SELECT * FROM ffa WHERE identifier=@identifier', {
		['@identifier'] = xPlayer.getIdentifier(),
	}, function(results)
		if #results > 0 then
			cb(results)
			MySQL.Async.execute('UPDATE ffa SET name = @name, isinffa = @isinffa WHERE identifier = @identifier', {
				['@name'] = GetPlayerName(src),
				['@isinffa'] = 1,
				['@identifier'] = xPlayer.getIdentifier(),
			})
		else
			MySQL.Async.execute('INSERT INTO ffa(name, isinffa, identifier) VALUES (@name, @isinffa, @identifier)', {
				['@name'] = GetPlayerName(src),
				['@isinffa'] = 1,
				['@identifier'] = xPlayer.getIdentifier(),
			}, function()
				Wait(10)
				MySQL.Async.fetchAll('SELECT * FROM ffa WHERE identifier=@identifier', {
					['@identifier'] = xPlayer.getIdentifier(),
				}, function(res)
					cb(res)
				end)
			end)
		end
	end)
end)

ESX.RegisterServerCallback('ardi:get:all:stats', function(src, cb)
	MySQL.Async.fetchAll('SELECT * FROM ffa ORDER BY kills DESC LIMIT 10', {}, function(res)
		cb(res)
		Wait(50)
	end)
end)
ESX = nil
TriggerEvent(Config.Settings.ESXStuff.SharedObject, function(obj)ESX = obj end)
local zones = {}
local isInFFA = {}
local html = [[
    <div class="main">

    <div class="selection" style="display: none;">

        <button class="close" onclick="display(false, 'both')">schließen</button>

        <div class="grid" id="grid">
        </div>

    </div>

    <div class="leaderboard" style="display: none;">
        <button style="top: 1vh; right: 1vh; transform: scale(.8);" class="close"
            onclick="display(false, 'both')">Schließen</button>
        <div class="header">
            <img src="assets/img/deaths.png">
            <h1>leaderboard</h1>
        </div>
        <div class="grid">
        </div>
    </div>

    <div class="hud" style="display: none;">
        <div class="kills">
            <img src="assets/img/kills.png">
            <span>10</span>
        </div>
        <div class="deaths">
            <img src="assets/img/deaths.png">
            <span>10</span>
        </div>
        <div class="kd">
            <img src="assets/img/kd.png">
            <span>6</span>
        </div>
    </div>

    <div class="deathscreen" style="display: none;">
        <p data="1">Du wurdest von <span class="player">Spieler</span> getötet</p>
        <p data="2">[ health:<span class="health">100</span> armour:<span class="armour">100</span> ]</p>
    </div>

</div>

<style>
    * {
        margin: 0;
        padding: 0;
        border: none;
        user-select: none;
        box-sizing: border-box;
        font-family: var(--font);
        font-size: 1.5vh;
        color: var(--white);
        font-weight: 550;
        font-style: italic;
        text-transform: uppercase;
    }

    body {
        width: 100%;
        height: 100%;
    }

    .selection {
        position: absolute;
        width: 100%;
        height: 100%;
        background: var(--gradient);
    }

    .close {
        position: absolute;
        width: 15.5vh;
        height: 4.8vh;
        top: 4vh;
        right: 4vh;
        background: rgba(78, 78, 78, 0);
        border-radius: 10px;
        color: rgb(107, 107, 107);
        transition: .1s ease-in-out;
    }

    .close:hover {
        cursor: pointer;
        color: white;
        text-shadow: 0px 0px 5px white;
        background: rgb(207, 7, 0);
        box-shadow: 0px 0px 15px rgb(207, 7, 0);
    }

    .close:active {
        transform: scale(.96);
    }

    .selection .grid {
        position: absolute;
        display: grid;
        grid-template-rows: repeat(3, 1fr);
        grid-template-columns: repeat(4, 1fr);
        grid-row-gap: 1vh;
        grid-column-gap: 1vh;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 135vh;
        height: 61vh;
        overflow-y: scroll;
        transition: .1s ease-in-out;
        padding-right: 2vh;
    }

    .selection .grid::-webkit-scrollbar {
        width: 1vh;
    }

    .selection .grid::-webkit-scrollbar-track {
        width: 1vh;
        background: #FFFFFF15;
    }

    .selection .grid::-webkit-scrollbar-thumb {
        width: 1vh;
        background-color: var(--main);
        filter: drop-shadow(0 0 15px var(--main));
        /* box-shadow: ; */
    }

    .plyCount {
        position: absolute;
        display: flex;
        top: 67%;
    }

    .selection .grid .box {
        position: relative;
        display: flex;
        justify-content: center;
        width: 30vh;
        height: 30vh;
        background: rgba(78, 78, 78, 0.4);
        text-align: center;
        overflow: hidden;
        border-radius: 10px;
        border: 2px solid rgba(105, 105, 105, 0.719);
    }

    .selection .grid .box h1 {
        position: absolute;
        font-size: 2vh;
        width: 30vh;
        top: 10%;
        transform: translate(-0%, -50%);
    }

    .selection .grid .box img {
        position: absolute;
        top: 41%;
        left: 50%;
        width: 22vh;
        transition: .1s ease-in-out;
        transform: translate(-50%, -50%);
    }

    .selection .grid .box button {
        position: absolute;
        bottom: 2vh;
        width: 16vh;
        height: 5vh;
        transition: .2s ease-in-out;
        background: rgba(167, 13, 13, 0);
        border: 3px solid var(--main);
        box-shadow: 0px 0px 5px var(--main);
        transform: skew(3deg);
        transition: .1s ease-in-out;
    }

    .selection .grid .box button:hover {
        background: var(--main);
        cursor: pointer;
        transition: .1s ease-in-out;
    }

    .selection .grid .box button:active {
        background-color: var(--dark);
        border: var(--dark);
        box-shadow: 0px 0px 5px var(--dark);
        transform: scale(.96);
        transition: .1s ease-in-out;
    }

    .leaderboard {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        width: 90vh;
        height: 70vh;
        background: var(--gradient);
        border-radius: .5vh;
        text-align: center;
    }

    .leaderboard .header {
        position: absolute;
        top: 2vh;
        left: 50%;
        transform: translate(-50%);
    }

    .leaderboard .header img {
        width: 5.5vh;
    }

    .leaderboard .grid {
        position: absolute;
        left: 50%;
        top: 55%;
        transform: translate(-50%, -50%);
        display: grid;
        grid-template-rows: repeat(10, 1fr);
        grid-template-columns: repeat(2, 1fr);
        grid-row-gap: 1vh;
        grid-column-gap: 1vh;
        height: 54vh;
        width: 61vh;
    }

    .leaderboard .box {
        width: 30vh;
        height: 10vh;
        border-radius: 1vh;
        background: var(--stats-gradient);
        filter: drop-shadow(0 0 15px var(--main));
    }

    .leaderboard .box .number {
        position: absolute;
        font-size: 3vh;
        padding-top: 1.5vh;
        left: 1vh;
    }

    .leaderboard .box img {
        padding-top: 1vh;
        width: 4vh;
    }

    .hud {
        position: absolute;
        display: inline-flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: center;
        align-content: center;
        padding: 1vh;
        gap: .7vh;
        bottom: 5vh;
        left: 50%;
        transform: translate(-50%, 0%);
        background: var(--gradient);
        border-radius: 1vh;
        filter: drop-shadow(0 0 15px var(--dark));
        box-shadow: inset 0 0 15px var(--dark);
    }

    .hud div {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        align-content: center;
        margin: .3vh;
        gap: .7vh;
    }

    .hud img {
        width: 4vh;
        height: 4vh;
        border: .2vh solid #575757;
        background: rgba(78, 78, 78, .6);
        border-radius: 1vh;
        padding: 5px;
    }

    .hud span {
        font-size: 1.8vh;
        border-radius: .5vh;
        border: .2vh solid #575757;
        background: rgba(78, 78, 78, .6);
        padding: 0 .5vh;
        font-style: normal;
    }

    .deathscreen {
        position: absolute;
        width: 100%;
        height: 100%;
        background: var(--deathscreen-gradient);
    }

    .deathscreen .player {
        font-size: 3.5vh;
        color: var(--main);
        text-shadow: 0 0 15px var(--main);
    }

    .deathscreen p[data="1"] {
        position: absolute;
        top: 50%;
        left: 50%;
        font-size: 3vh;
        transform: translate(-50%, -50%);
        text-shadow: 0 0 15px var(--white);
    }

    .deathscreen p[data="2"] {
        position: absolute;
        top: 55%;
        left: 50%;
        font-size: 1.5vh;
        transform: translate(-50%, -50%);
        text-shadow: 0 0 15px var(--white);
    }

    .deathscreen .health,
    .armour {
        font-size: 2vh;
        color: var(--main);
        text-shadow: 0 0 15px var(--main);
    }
</style>
<script>
    function display(bool, what) {
        if (bool == true) {
            $(what).fadeIn();
        } else if (bool == false) {
            $(".selection .box").remove();
            $(".leaderboard .box").remove();
            if (what == 'both') {
                $('.selection').fadeOut();
                $('.leaderboard').fadeOut();
            } else {
                $(what).fadeOut();
            };
            $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
        };
    };

    function setElem(elem) {
        $('.box').removeClass('selected');
        $(elem).addClass('selected');
    }

    function joinFFA() {
        $.post(`https://${GetParentResourceName()}/join`, JSON.stringify({
            zone: $(".selected .name").text()
        }));
    };

    $(function() {

        window.addEventListener("keydown", (e) => {
            if (e.keyCode == 27) {
                display(false, 'both')
                $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
            }
        }, false);
    
        window.addEventListener('message', function (event) {
            var item = event.data
            if (item.action == 'selection') {
                if (item.display) {
                    display(true, '.selection')
                } else if (item.display == false) {
                    display(false, '.selection')
                };
            } else if (item.action == 'stats') {
                if (item.display) {
                    $(".kills span").text(item.kills);
                    $(".deaths span").text(item.deaths);
                    $(".kd span").text(item.kd);
                    $(".hud").fadeIn();
                } else if (!item.display) {
                    $(".hud").fadeOut();
                };
            } else if (item.action == 'zones') {
                $(".selection .grid").append(`
            <div class="box" onmousedown="setElem(this)">
                <img src="${item.img}">
                <button onclick="joinFFA()">Beitreten</button>
                <h1 class="name">${item.name}</h1>
                <div class="plyCount">
                    <p><span class="cur">${item.count}</span><span style="font-size: .9vh;"> ${item.lang}</span></p>
                </div>
            </div>
        `)
            } else if (item.action == 'deathscreen') {
                if (item.off) {
                    $(".deathscreen").hide();
                } else {
                    $(".deathscreen").show();
                };
                if (item.notplayer) {
                    $(".deathscreen p[data='1']").text(item.lang);
                    $(".deathscreen p[data='2']").hide();
                } else {
                    $(".deathscreen .player").text(item.player);
                    $(".deathscreen .health").text(item.health);
                    $(".deathscreen .armour").text(item.armour);
                };
            } else if (item.action == 'leaderboard') {
                $(".leaderboard .grid").append(`				
        <div class="box">
            <span class="number">${item.number}</span>
            <img src="assets/img/kd.png">
            <h1 class="name" style="text-transform: none;">${item.name}</h1>
            <p><span class="kills">${item.kills}</span> | <span class="deaths">${item.deaths}</span></p>
        </div>
        `)
                if (item.display) {
                    display(true, '.leaderboard')
                } else {
                    display(false, '.leaderboard')
                };
            };
        });
    });
</script>
]]

RegisterNetEvent('ardi:send:ffa:html')
AddEventHandler('ardi:send:ffa:html', function()
	TriggerClientEvent('ardi:get:ffa:html', source, html)
end)

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

print([[
^1==============================================================
															^1||^0
					^1Ultra^0-^1Scripts^0                           ^1||^0
			made with ^1<3^0 by ardelan^1#0808                    ^1||^0
	for support refer to: discord.gg/^1ultra^0-^1scripts^0          ^1||^0
															^1||^0
^1==============================================================
]])
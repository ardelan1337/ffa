RegisterServerEvent('ardi:send:stats')
AddEventHandler('ardi:send:stats', function()
    local date_local = os.date('%H:%M:%S', os.time())
    if date_local == '00:00:00' then
        FetchStats()
    elseif date_local == '01:00:00' then
        FetchStats()
    elseif date_local == '02:00:00' then
        FetchStats()
    elseif date_local == '03:00:00' then
        FetchStats()
    elseif date_local == '04:00:00' then
        FetchStats()
    elseif date_local == '05:00:00' then
        FetchStats()
    elseif date_local == '06:00:00' then
        FetchStats()
    elseif date_local == '07:00:00' then
        FetchStats()
    elseif date_local == '08:00:00' then
        FetchStats()
    elseif date_local == '09:00:00' then
        FetchStats()
    elseif date_local == '10:00:00' then
        FetchStats()
    elseif date_local == '11:00:00' then
        FetchStats()
    elseif date_local == '12:00:00' then
        FetchStats()
    elseif date_local == '13:00:00' then
        FetchStats()
    elseif date_local == '14:00:00' then
        FetchStats()
    elseif date_local == '15:00:00' then
        FetchStats()
    elseif date_local == '16:00:00' then
        FetchStats()
    elseif date_local == '17:00:00' then
        FetchStats()
    elseif date_local == '18:00:00' then
        FetchStats()
    elseif date_local == '19:00:00' then
        FetchStats()
    elseif date_local == '20:00:00' then
        FetchStats()
    elseif date_local == '21:00:00' then
        FetchStats()
    elseif date_local == '22:00:00' then
        FetchStats()
    elseif date_local == '23:00:00' then
        FetchStats()
    end
end)

function FetchStats()
    local description = ''
    MySQL.Async.fetchAll('SELECT * FROM ffa ORDER BY kills DESC LIMIT 10', {}, function(res)
        for _, i in pairs(res) do
            description =  ('%s**#%s** %s » Kills: %s Deaths: %s\n'):format(description, _, i.name, i.kills, i.deaths)
        end
        SendToDiscord(description, Webhooks.Username, Webhooks.AuthName, Webhooks.Icon, Webhooks.Title, Webhooks.Webhook)
    end)
end

function SendToDiscord(Message, Username, AuthName, Icon, Title, Webhook)
    local message = {
        username = Username,
        embeds = {{
            color = Webhooks.Color,
            author = {
                name = AuthName,
                icon_url = Icon
            },
            title = Title,
            description = Message,
            footer = {
                text = 'ardelan#0808' .. ' - ' .. os.date('%x %X %p'),
                icon_url = Icon,
            },
        }},
        avatar_url = Icon
    }
    PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode(message), {['Content-Type'] = 'application/json'})
end

function Loop()
    SetTimeout(1000, function()
        TriggerEvent('ardi:send:stats')
        Loop()
    end)
end
Loop()

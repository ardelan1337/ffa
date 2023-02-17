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

CreateThread(function()
    while true do
        FetchStats()
        Wait(3 * (60 * 60000))
    end
end)

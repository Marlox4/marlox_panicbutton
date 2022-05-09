
RegisterServerEvent('marlox_sendButton', function(Data)
	local xPlayer = ESX.GetPlayerFromId(source)
	SendPanicButton(Data ,xPlayer)
	xPlayer.showNotification(_U("sendButton"))
end)

function discordlogs(text)
	local embeds = {
		{
			["title"]= Discord.title,
			["description"]= "**"..text.."**",
			["type"]= "rich",
			["color"] =Discord.color,
			["footer"]=  {
			["text"]= Discord.text,
			["icon_url"] = Discord.icon_url
		},
		},
	}
	PerformHttpRequest(Discord.webhook, function(err, text, headers) end, 'POST', json.encode({avatar_url = Discord.avatar_url, username = Discord.username,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function SendPanicButton(Data,xPlayer)
	local discord = ""
	for k, v in ipairs(GetPlayerIdentifiers(xPlayer.source)) do
		if v:match("discord") then
			discord = v:gsub("discord:", "")
		end
	end
	discordlogs(_U("Discord1", xPlayer.getName(), xPlayer.getJob().name, discord))
	for _, xPlayers in pairs(ESX.GetExtendedPlayers('job', xPlayer.getJob().name )) do
		xPlayers.showNotification(_U("Discord2",xPlayer.getName() ))
		xPlayers.triggerEvent("marlox_markers", Data)
	end    
end

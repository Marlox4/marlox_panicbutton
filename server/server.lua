CreateThread(function()
	ESX = nil
	TriggerEvent(Config.esxgetSharedObjectevent, function(obj) ESX = obj end)


	RegisterServerEvent('marlox_sendbottum')
	AddEventHandler('marlox_sendbottum', function(Data)
		local xPlayer = ESX.GetPlayerFromId(source)
		SendPanikButton(Data ,xPlayer)
		xPlayer.showNotification(_U("sendbottum"))
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
		PerformHttpRequest(Discord.webhook, function(err, text, headers) end, 'POST', json.encode({avatar_url = Discord.avatar_url, username =Discord.username,embeds = embeds}), { ['Content-Type'] = 'application/json' })
	end

	function SendPanikButton(Data,xPlayer)
		local discord = ""
		for m, n in ipairs(GetPlayerIdentifiers(xPlayer.source)) do
			if n:match("discord") then
				discord = n:gsub("discord:", "")
			end
		end
		discordlogs(_U("Discord1", xPlayer.getName(), xPlayer.getJob().name, discord))
		for _, dasdasdasd in pairs(ESX.GetExtendedPlayers('job', xPlayer.getJob().name )) do
			dasdasdasd.showNotification(_U("Discord2",xPlayer.getName() ))
			dasdasdasd.triggerEvent("marlox_markers", Data)
		end    
	end
end)
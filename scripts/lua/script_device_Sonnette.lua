-- Script Sonnette pressée !
-- Actions quand sonnette pressée

commandArray = {}

-- Si la l'interrupteur "Sonnette" passe à "Group On"
if (devicechanged['Sonnette'] == 'Group On' ) then
	-- Envoi d'une notification
	commandArray['SendNotification']='Sonnette pressée #Quelqu\'un est à la porte.'
	-- Log
	print ('Sonnette pressée !"')
	-- Eteint les enceintes Sonos
	commandArray['OpenURL']='http://192.168.1.241:5005/pauseall' 
	-- Ajouter les autres actions ici
end 

return commandArray
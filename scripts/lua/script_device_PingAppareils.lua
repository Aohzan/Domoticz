-- Script Ping Appareils

-- Variables
commandArray = {}
debug=false
prefixe="Présence - "

-- Tableau des appareils à tester - IP et Nom int virtuel Domoticz
local ping={}
ping['192.168.1.180']='Téléphone Matthieu'
ping['192.168.1.181']='Téléphone Mélanie'

-- Boucle sur le tableau
for ip, switch in pairs(ping) do
	-- Ping Windows de l'IP
	ping_success=os.execute('ping '..ip..' -n 3 -w 100>nul')
	-- Si le ping répond
	if ping_success then
		if(debug==true)then
			print(prefixe..switch..' détecté')
		end
		-- Changement d'état du switch vers On
		if(otherdevices[switch]=='Off') then
			commandArray[switch]='On'
		end
	-- Si le ping ne répond pas
	else
		if(debug==true)then
			print(prefixe..switch..' n\'est plus détecté')
		end
		-- Changement d'état du switch vers Off
		if(otherdevices[switch]=='On') then
			commandArray[switch]='Off'
		end
	end
end

return commandArray
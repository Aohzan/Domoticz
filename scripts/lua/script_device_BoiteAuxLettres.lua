-- Script Boite aux lettres !

-- Définition des varaibles
time=os.time()
local hour = tonumber(os.date('%H',time))
-- Variable présence courrier dans BAL
state = tonumber(uservariables['presenceBAL'])

commandArray = {}

-- Si la BAL est ouverte
if (devicechanged['Boîte aux lettres'] == 'Open' ) then
	-- Si c'est le matin, on suppose qu'on y dépose quelque chose
	if ( hour > 5 and hour < 16) then
		commandArray['SendNotification']='Boîte aux lettres ouverte #Du courier ou colis a été déposé.'
		commandArray['Variable:presenceBAL'] = tostring (1)
		print ('Boîte aux lettres ouverte !"')
	-- Sinon on le récupère ou le vérifier
	else
		-- Si du courrier a été dépose, il est récupéré et on remet la var à 0
		if (uservariables["presenceBAL"]==1) then 
			commandArray['SendNotification']='Boîte aux lettres ouverte #Le courrier a été récupéré.'
			commandArray['Variable:presenceBAL'] = tostring (0)
			print ('Boîte aux lettres ouverte !"')
		else	
			commandArray['SendNotification']='Boîte aux lettres ouverte #Le courrier a été vérifié.'
			print ('Boîte aux lettres ouverte !"')
		end
	end
end 

return commandArray
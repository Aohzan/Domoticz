-- Script Sonos Salle de bains --
-- Si une présence est détectée dans la salle de bains, 
-- envoi d'une commande HTTP pour mettre la musique/radio

-- Définition des varaibles
time=os.time()
local hour = tonumber(os.date('%H',time))
local day = string.lower(os.date("%A"))
state = tonumber(uservariables['lectureSalleDeBains'])

commandArray = {}

-- A minuit reinitialisation de la variable utilisateur "lectureSalleDeBains"
if ( hour == 0 ) then commandArray['Variable:lectureSalleDeBains'] = tostring (0) end

-- Si présence détectée
if (devicechanged['Détecteur présence Salle de bains'] == 'On' ) then
	print ('Sonos Salle de bains - Présence détectée')

	-- Cas où il est le week-end ou journée entre 10 et 23h
	if (( hour > 10 and hour < 23 ) or (( hour > 7 and hour < 23 ) and ( day == "saturday" or day == "sunday" ))) then
		-- Si une liste de lecture a déjà été lancée
		if (uservariables["lectureSalleDeBains"]==1) then 
			commandArray['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Play'
			print ('Sonos Salle de bains - Reprise de la lecture')
		-- Sinon on lance la liste de lecture
		else 
			commandArray[1]={['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Shuffle/on'}
			commandArray[2]={['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Favorite/New%20Music%20Monday'}
			commandArray[3]={['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Volume/25'}
			print ('Sonos Salle de bains - Lecture New Music Monday en aleatoire')
			print (commandArray)
		end
		-- On met la var lectureSalleDeBains à 1 pour signaler que la lecture a déjà été lancée pour la journée
		commandArray['Variable:lectureSalleDeBains'] = tostring (1)
	-- Cas où le matin en semaine	
	elseif ( hour > 7 and hour < 10 ) then
		commandArray[1]={['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Favorite/Europe%201'}
		commandArray[2]={['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Volume/20'}
		print ('Sonos Salle de bains - Lecture Europe 1')
	-- Autres cas (nuit)
	else
		print ('Sonos Salle de bains - Pas de musique à cette heure')
	end

-- Si plus de présence
elseif (devicechanged['Détecteur présence Salle de bains'] == 'Off' ) then
	commandArray['OpenURL']='http://192.168.1.241:5005/Salle%20de%20bains/Pause' 
	print ('Sonos Salle de bains - Pause')
end 

return commandArray
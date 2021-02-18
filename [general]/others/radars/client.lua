ESX = nil
local playervehs = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('grabVehs')
AddEventHandler('grabVehs', function(vehicles)
	playervehs = vehicles
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local localPed = PlayerPedId()
		local coords = GetEntityCoords(localPed)

		if IsPedInAnyVehicle(localPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(localPed, false), -1) == localPed then
			local vehicle = GetVehiclePedIsIn(localPed, false)
			if not CheckPolice() then
				local owned = false

				for k,v in ipairs(playervehs) do
					if v.plate == GetVehicleNumberPlateText(vehicle) then
						owned = true
					end
				end

				if owned == true then
					local speed = GetEntitySpeed(localPed) * 2.236936
					speed = math.floor(speed)
					local chance = math.random(1,100)
					if speed > 60 and speed < 100 and chance >= 20 then
						local cost = 175
						for i=1,#citySpeedCameras do
							if GetDistanceBetweenCoords(coords, citySpeedCameras[i][1], citySpeedCameras[i][2], citySpeedCameras[i][3], true) < 30 then
								TriggerEvent('customNotification', "<font color='#ea002e'><b>" .. tostring(speed) .. " MPH</font></b> in a 45 MPH zone" .. "<br /><b><font color='#ea9f00'>$175</font> FINE!")
								Citizen.Wait(5000)
								TriggerServerEvent('others:speedingTicket', cost)
							end
						end

					elseif speed > 100 and chance >= 20 then
						local cost = 750
						for i=1,#citySpeedCameras do
							if GetDistanceBetweenCoords(coords, citySpeedCameras[i][1], citySpeedCameras[i][2], citySpeedCameras[i][3], true) < 30 then
								TriggerEvent('customNotification', "<font color='#ea002e'><b>" .. tostring(speed) .. " MPH</font></b> in a 45 MPH zone" .. "<br /><b><font color='#ea9f00'>$" ..cost.. "</font> FINE!")
								Citizen.Wait(5000)
								TriggerServerEvent('others:speedingTicket', cost)
							end
						end
					end
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function CheckPolice()
	if ESX and ESX.PlayerData and ESX.PlayerData.job then
		local job = ESX.PlayerData.job.name

		if job == 'police' or job == 'state' or job == 'sheriff' or job == 'usmarshal' or job == 'gruppe6' or job == 'ambulance' then
			return true
		end
	end

	return false
end

local citySpeedCameras = {
	{784.353088378906,-1005.27600097656,25.6527767181396, 94.677604675293},
	{223.694885253906,-1040.59167480469,28.8767967224121, 62.378173828125},
	{-37.257999420166,-943.666259765625,28.928653717041, 71.5499725341797},
	{-504.138824462891,-837.026916503906,29.9943675994873, 89.5957336425781},
	{-742.892700195313,-836.920288085938,22.2205505371094, 87.85888671875},
	{-1078.59790039063,-765.257751464844,18.860387802124, 37.3000144958496},
	{-1225.94445800781,-592.38623046875,26.7952575683594, 51.7979583740234},
	{-1384.16345214844,-391.589965820313,36.2012634277344, 47.5407524108887},
	{-1496.93139648438,-256.789672851563,49.8842353820801, 56.1923370361328},
	{-1566.62377929688,-178.044647216797,55.0403366088867, 40.225212097168},
	{-1469.84851074219,-103.59375,50.3908653259277, 311.701080322266},
	{-1303.43920898438,-343.979644775391,36.2439155578613, 224.096725463867},
	{-1649.34875488281,-578.279174804688,33.2079086303711, 152.670822143555},
	{-1290.49780273438,-912.126770019531,10.9101800918579, 212.981857299805},
	{-1157.18151855469,-1341.07604980469,4.62396478652954, 178.635162353516},
	{-771.457092285156,-1117.79272460938,10.2161588668823, 354.948516845703},
	{-638.809753417969,-957.388366699219,21.0177593231201, 1.60537207126617},
	{-651.909790039063,-1460.0234375,10.175742149353, 186.596725463867},
	{-1081.83386230469,264.307189941406,63.4517440795898, 79.2034530639648},
	{-884.664916992188,-116.859001159668,37.4720001220703, 213.356170654297},
	{-1032.13598632813,-192.253219604492,37.3590049743652, 118.607238769531},
	{-635.456359863281,-365.076293945313,34.3290634155273, 260.012878417969},
	{-556.828918457031,3.19479846954346,43.8862419128418, 347.794281005859},
	{-541.363098144531,255.761779785156,82.5815200805664, 15.7118864059448},
	{-222.882278442383,260.049621582031,91.5894165039063, 273.848571777344},
	{-254.890548706055,-45.5543975830078,49.057689666748, 178.222274780273},
	{228.815444946289,-220.215866088867,53.546875, 255.453125},
	{396.671081542969,-128.753219604492,64.4407653808594, 263.298278808594},
	{466.123596191406,-313.610748291016,46.8073959350586, 257.831970214844},
	{960.9775390625,-286.622009277344,66.4887008666992, 309.426361083984},
	{1020.84210205078,-200.687530517578,69.7568588256836, 313.175689697266},
	{1179.66479492188,-509.921142578125,64.6276245117188, 172.003128051758},
	{1256.18041992188,-1429.07556152344,34.613582611084, 201.156631469727},
	{1241.98852539063,-2055.25659179688,43.8659820556641, 124.925071716309},
	{338.719635009766,-1327.09643554688,32.3778114318848, 319.042724609375},
	{-385.195098876953,-1829.35131835938,21.1903018951416, 228.772369384766},
	{795.37890625,-1430.67834472656,26.7072448730469, 181.318115234375},
	{827.118347167969,-1746.89978027344,28.986083984375, 187.324844360352},
	{539.697814941406,-1431.99462890625,28.8534927368164, 94.0945663452148},
	{-272.573883056641,-1140.73986816406,22.4451522827148, 87.3228149414063},
	{-184.222839355469,-894.624572753906,28.6998157501221, 326.385803222656},
	{-117.894187927246,-712.510620117188,34.1800765991211, 338.447174072266}
}
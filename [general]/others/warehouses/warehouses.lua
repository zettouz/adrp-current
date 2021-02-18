	--[[
			fs_freemode - game mode for FiveM.
			  Copyright (C) 2018 FiveM-Scripts

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.
You should have received a copy of the GNU Affero General Public License
along with fs_freemode in the file "LICENSE". If not, see <http://www.gnu.org/licenses/>.
]]

local PlayerData                = {}

ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(100)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	PlayerData.gang = gang
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


CokePeds = {}
ForgeryPeds = {}
ipls = {"xm_bunkerentrance_door", "xm_hatch_terrain", "xm_hatches_terrain_lod", "xm_hatch_closed"}

local CokePedCoords = {
	{gender= "female", x= 1091.372, y= -3196.633, z= -38.993, heading= 1.891},
	{gender= "female", x= 1094.478, y= -3194.840, z= -38.993, heading= 181.500},
	{gender= "male",   x= 1099.576, y= -3194.175, z= -38.993, heading= 100.681}
}

local ForgeryCoords = {
	{gender="male", x= 1162.75, y= -3196.93, z= -38.2319, heading= 297.480}
}

local function CreateCokePed(gender, x, y, z, heading)
	if gender == "male" then
		model = GetHashKey("mp_m_cocaine_01")
	elseif gender == "female" then
		model = GetHashKey("mp_f_cocaine_01")
	end

	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end

	ped = CreatePed(26, model, x, y, z-1.0001, heading, false, false)
	GiveWeaponToPed(ped, GetHashKey("weapon_pistol"), 20, false, true)
	SetPedCombatAttributes(ped, 1424, 1)
	--SetBlockingOfNonTemporaryEvents(ped, true)
	SetModelAsNoLongerNeeded(model)

	table.insert(CokePeds, {ped = ped})
end

local function DeleteCokePed(i, index)
	if DoesEntityExist(i.ped) then
		DeleteEntity(i.ped)
		CokePeds[index] = nil
	end
end

local function CreateDocumentPed(gender, x, y, z, heading)
	if gender == "male" then
		model = GetHashKey("mp_m_forgery_01")
	elseif gender == "female" then
		model = GetHashKey("mp_f_forgery_01")
	end

	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end

	ped = CreatePed(26, model, x, y, z-1.0001, heading, false, false)

	SetBlockingOfNonTemporaryEvents(ped, true)
	table.insert(ForgeryPeds, {ped = ped})
	SetModelAsNoLongerNeeded(model)
end

local function DeleteDocumentPed(i, index)
	if DoesEntityExist(i.ped) then
		DeleteEntity(i.ped)
		ForgeryPeds[index] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep = true

		if GetDistanceBetweenCoords(playerCoords, 1312.100, 4362.241, 40.855, true) <= 5.0 then
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), 1063.445, -3183.618, -39.164, 168.407)

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_upgrade_equip")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_drying")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_security_upgrade")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_production")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_set_up")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_chairs")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growtha_stage3")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthb_stage3")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthc_stage3")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthd_stage3")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthe_stage3")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthf_stage3")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthg_stage3")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthh_stage3")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_growthi_stage3")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hosea")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hoseb")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hosec")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hosed")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hosee")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hosef")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hoseg")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hoseh")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "weed_hosei")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growtha_stage23_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthb_stage23_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthc_stage23_upgrade")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthd_stage23_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthe_stage23_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthf_stage23_upgrade")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthg_stage23_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthh_stage23_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247297, "light_growthi_stage23_upgrade")

				RefreshInterior(247297)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords, 1065.430, -3182.969, -39.163, true) <= 5.0 then
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 1318.317, 4360.806, 41.170, 239.736)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords, 1642.405, 4845.469, 45.55, true) <= 2.0 then --coke enter
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				for k,v in pairs(CokePedCoords) do
					CreateCokePed(v.gender, v.x, v.y, v.z, v.heading)
				end

				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 1088.472, -3191.326, -38.993, 193.129)

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "coke_cut_01")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "coke_cut_02")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "coke_cut_03")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "coke_cut_04")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "coke_cut_05")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "coke_press_upgrade")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "equipment_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "production_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "security_high")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "set_up")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247553, "table_equipment_upgrade")
				RefreshInterior(247553)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords, 1088.803, -3188.257, -38.993, true) <= 1.0 then
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				for n, i in pairs(CokePeds) do
					DeleteCokePed(i, n)
				end

				SetEntityCoords(PlayerPedId(), 1642.405, 4845.469, 45.55)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords, 87.61, 810.563, 211.706, true) <= 2.0 then --methhouse enter
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)
				SetEntityCoords(PlayerPedId(), 998.629, -3199.545, -36.394)

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247041, "meth_lab_upgrade")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247041, "meth_lab_production")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247041, "meth_lab_security_high")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247041, "meth_lab_setup")
				RefreshInterior(247041)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

		if GetDistanceBetweenCoords(playerCoords, 996.933, -3200.605, -36.394, true) <= 1.0 then
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				SetEntityCoords(PlayerPedId(), 87.61, 810.563, 211.706)
				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end

	if GetDistanceBetweenCoords(playerCoords, 958.50, -1586.30, 30.0, true) <= 3.0 then
		letSleep = false
		DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
		if IsControlJustPressed(0, 38) then
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)

			SetEntityCoords(PlayerPedId(), 1094.988, -3101.776, -39.00363)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
		end
	end

	if GetDistanceBetweenCoords(playerCoords, 1087.442, -3099.381, -39.000, true) <= 3.0 then
		letSleep = false
		DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
		if IsControlJustPressed(0, 38) then
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)

			SetEntityCoords(PlayerPedId(), 963.946, -1585.238, 30.447)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
		end
	end

	if GetDistanceBetweenCoords(playerCoords, -1253.626, -354.363, 43.9, true) <= 2.0 then
		letSleep = false
		if PlayerData.gang.name ~= 'nogang' or CheckPolice() then
			DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(1000)
				Citizen.Wait(1500)

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_security")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile100a")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile20a")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile10a")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile100b")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile100c")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile100d")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile20b")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile20c")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile20d")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile10b")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile10c")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_cashpile10d")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_setup")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "counterfeit_upgrade_equip")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "dryera_on")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "dryerb_on")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "dryerc_on")

				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "dryerd_on")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "money_cutter")
				Citizen.InvokeNative(0x55E86AF2712B36A1, 247809, "special_chairs")

				RefreshInterior(247809)
				SetEntityCoords(PlayerPedId(), 1121.897, -3195.338, -40.4025)

				Citizen.Wait(1000)
				DoScreenFadeIn(1000)
			end
		end
	end

	if GetDistanceBetweenCoords(playerCoords, 1118.683, -3193.319, -40.391, true) <= 2.0 then
		letSleep = false
		DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
		if IsControlJustPressed(0, 38) then
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)

			SetEntityCoords(PlayerPedId(), -1253.626, -354.363, 43.79)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
		end
	end

	if GetDistanceBetweenCoords(playerCoords, 378.646, -834.4833, 29.292, true) <= 3.0 then
		letSleep = false
		DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
		if IsControlJustPressed(0, 38) then
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)

			for k,v in pairs(ForgeryCoords) do
				CreateDocumentPed(v.gender, v.x, v.y, v.z, v.heading)
			end

			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "equipment_upgrade")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "production")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "security_high")

			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "set_up")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "clutter")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "interior_upgrade")

			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair01")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair02")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair03")

			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair04")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair05")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair06")
			Citizen.InvokeNative(0x55E86AF2712B36A1, 246785, "chair07")

			RefreshInterior(246785)
			SetEntityCoords(PlayerPedId(), 1171.920, -3195.916, -39.008, 206.511)

			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
		end
	end
	if GetDistanceBetweenCoords(playerCoords, 1173.700, -3196.799, -39.008, true) <= 2.0 then
		letSleep = false
		DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
		if IsControlJustPressed(0, 38) then
			DoScreenFadeOut(1000)
			Citizen.Wait(1500)

			for n, i in pairs(ForgeryCoords) do
				DeleteDocumentPed(i, n)
			end

			SetEntityCoords(PlayerPedId(), 366.980, -833.991, 29.292, 144.514)
			Citizen.Wait(1000)
			DoScreenFadeIn(1000)
		end
	end

	if letSleep then
		Citizen.Wait(500)
	end

	end
end)

local function LoadFacilityIpls()
	for k,v in pairs(ipls) do
		if not IsIplActive(tostring(v)) then
			RequestIpl(tostring(v))
		end
	end
end

local function RemoveFacilityIpls()
	for k,v in pairs(ipls) do
		if IsIplActive(tostring(v)) then
			RemoveIpl(tostring(v))
		end
	end
end

local function AddFacilityInterior()
	interiorID = GetInteriorAtCoordsWithType(345.0041, 4822.001, -59.9997, "xm_x17dlc_int_02")
	if IsValidInterior(interiorID) then
		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_decal_01")
		SetInteriorPropColor(interiorID, "set_int_02_decal_01", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_lounge1")
		SetInteriorPropColor(interiorID, "set_int_02_lounge1", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_cannon")
		SetInteriorPropColor(interiorID, "set_int_02_cannon", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_clutter1")
		SetInteriorPropColor(interiorID, "set_int_02_clutter1", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_crewemblem")

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID,   "set_int_02_shell")
		SetInteriorPropColor(interiorID, "set_int_02_shell", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_security")
		SetInteriorPropColor(interiorID, "set_int_02_security", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID,   "set_int_02_sleep")
		SetInteriorPropColor(interiorID, "set_int_02_sleep", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_trophy1")
		SetInteriorPropColor(interiorID, "set_int_02_trophy1", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "set_int_02_paramedic_complete")
		SetInteriorPropColor(interiorID, "set_int_02_paramedic_complete", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "Set_Int_02_outfit_paramedic")
		SetInteriorPropColor(interiorID, "Set_Int_02_outfit_paramedic", 1)

		Citizen.InvokeNative(0x55E86AF2712B36A1, interiorID, "Set_Int_02_outfit_serverfarm")
		SetInteriorPropColor(interiorID, "Set_Int_02_outfit_serverfarm", 1)

		RefreshInterior(interiorID)
	end
end

local function RemoveFacilityInterior()
	DisableInteriorProp(interiorID,  "set_int_02_decal_01")
	DisableInteriorProp(interiorID,  "set_int_02_lounge1")
	DisableInteriorProp(interiorID,  "set_int_02_cannon")
	DisableInteriorProp(interiorID,  "set_int_02_clutter1")
	DisableInteriorProp(interiorID,  "set_int_02_crewemblem")
	DisableInteriorProp(interiorID,  "set_int_02_shell")
	DisableInteriorProp(interiorID,  "set_int_02_security")
	DisableInteriorProp(interiorID,  "set_int_02_sleep")
	DisableInteriorProp(interiorID,  "set_int_02_trophy1")
	DisableInteriorProp(interiorID,  "set_int_02_paramedic_complete")
	DisableInteriorProp(interiorID,  "Set_Int_02_outfit_paramedic")
	DisableInteriorProp(interiorID,  "Set_Int_02_outfit_serverfarm")
end

Citizen.CreateThread(function()
	LoadFacilityIpls()

	while true do
		Citizen.Wait(1)
		local letSleep = true

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), -900.467, -2329.72, -3.507, true) < 2.0 then
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to enter the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				Wait(1000)
				DoScreenFadeOut(800)
				Wait(850)
				SetEntityCoordsNoOffset(PlayerPedId(), 1027.652, -3101.079, -38.0035)
				Wait(850)
				DoScreenFadeIn(800)

				RemoveFacilityIpls()
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 1027.652, -3101.079, -38.0035, true) < 2.0 then
			letSleep = false
			DisplayHelpText('Press ~INPUT_CONTEXT~ to exit the ~y~Warehouse~s~.')
			if IsControlJustPressed(0, 38) then
				DoScreenFadeOut(500)
				Wait(500)
				SetEntityCoordsNoOffset(PlayerPedId(), -900.467, -2329.72, -3.507)

				Wait(500)
				DoScreenFadeIn(500)
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

function CheckPolice(allowEms)
	if PlayerData.job then
		local job = PlayerData.job.name
		if job == 'police' or job == 'state' or job == 'sheriff' or job == 'usmarshal' or job == 'gruppe6' then
			return true
		end

		if allowEms and job == 'ambulance' then
			return true
		end
	end

	return false
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
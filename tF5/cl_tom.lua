ESX = nil

local serveur = "Fantaisie" -- Le nom de votre serveur 
local name = GetPlayerName(PlayerId())
local id = GetPlayerServerId(PlayerId())

RMenu.Add('tomn', 'main', RageUI.CreateMenu(serveur, "Menu Personnel"))
RMenu.Add('tomn', 'portefeuille', RageUI.CreateSubMenu(RMenu:Get('tomn', 'main'), "Portefeuille", "Voici votre portefeuille."))
RMenu.Add('tomn', 'vehicule', RageUI.CreateSubMenu(RMenu:Get('tomn', 'main'), "Gestion véhicule", "Voici les options disponibles."))
RMenu.Add('tomn', 'serveur', RageUI.CreateSubMenu(RMenu:Get('tomn', 'main'), "Info serveur", "Voici les informations du serveur."))
RMenu.Add('tomn', 'moderation', RageUI.CreateSubMenu(RMenu:Get('tomn', 'main'), "Modération", "Options administrateurs."))
RMenu.Add('tomn', 'administration', RageUI.CreateSubMenu(RMenu:Get('tomn', 'main'), "Menu Administration", "Options administrateurs."))
RMenu.Add('tomn', 'admin_vehicule', RageUI.CreateSubMenu(RMenu:Get('tomn', 'main'), "Menu Véhicule", "Options administrateurs."))

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        ESX.PlayerData = ESX.GetPlayerData()

        ESX.TriggerServerCallback('TomN:getUserGroup', function(group)
            playergroup = group
        end)
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end
		Citizen.Wait(100)
	end
    while true do
        RageUI.IsVisible(RMenu:Get('tomn', 'main'), true, true, true, function()
            RageUI.Separator('Bienvenue ~b~'..GetPlayerName(PlayerId()))
            RageUI.Separator("Votre ID : ~r~"..GetPlayerServerId(PlayerId()))
            RageUI.Button("~b~→ ~s~Portefeuille",nil,{RightLabel = "→→"},true,function()
            end,RMenu:Get("tomn", "portefeuille"))
            RageUI.Button("~b~→ ~s~Gestion véhicule",nil,{RightLabel = "→→"},true,function()
            end,RMenu:Get("tomn", "vehicule"))
            RageUI.Button("~b~→ ~s~Serveur",nil,{RightLabel = "→→"},true,function()
            end,RMenu:Get("tomn", "serveur"))
            if playergroup == "mod" or playergroup == "admin" or playergroup == "superadmin" or playergroup == "_dev" or playergroup == "owner" then
                RageUI.Button("~r~→ ~s~Administration", nil, {RightLabel = "→→"}, true, function(h,a,s)
                end, RMenu:Get('tomn', 'moderation'))
            else
                RageUI.Button("→ ~s~Administration", nil, {RightLabel = RageUI.BadgeStyle.Lock }, false, function(h,a,s)
                    if s then
                        print("Vous n'êtes pas administrateur sur le serveur.")
                    end
                end)
            end
            RageUI.Button("~r~→ Faire un report !", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    local raison = KeyboardInput("Raison de votre report", "", 45)
                    ExecuteCommand("report "..raison)
                end
            end)
        end, function()
        end)

        -- Portefeuille
        RageUI.IsVisible(RMenu:Get('tomn', 'portefeuille'), true, true, true, function()
            RageUI.Separator("Emploi ~c~→ ~b~" .. ESX.PlayerData.job.label .. "~s~ - ~b~" .. ESX.PlayerData.job.grade_label)
            RageUI.Separator("Gang/Orga ~c~→ ~b~" .. ESX.PlayerData.job2.label .. "~s~ - ~b~" .. ESX.PlayerData.job2.grade_label)
            RageUI.Separator("Argent liquide ~c~→ ~g~" .. ESX.Math.GroupDigits(ESX.PlayerData.money .. "$"))
            RageUI.Button("~r~→ ~s~Regarder sa carte d'identitée", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                end
            end)
            RageUI.Button("~b~→ ~s~Montrer sa carte d'identitée", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                    else
                        ESX.ShowNotification("FantaisieRP \nAucun joueur à proximité")
                    end
                end
            end)

            RageUI.Button('~r~→ ~s~Regarder son permis de conduire', nil, {RightLabel = "→→" }, true, function(h,a,s)
                if s then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                end
            end)

            RageUI.Button('~b~→ ~s~Montrer son permis de conduire', nil, {RightLabel = "→→" }, true, function(h,a,s)
                if s then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                    else
                        ESX.ShowNotification("FantaisieRP \nAucun joueur à proximité")
                    end
                end
            end)

            RageUI.Button('~r~→ ~s~Regarder son permis port d\'arme', nil, {RightLabel = "→→" }, true, function(h,a,s)
                if s then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                end
            end)

            RageUI.Button('~b~→ ~s~Montrer son permis port d\'arme', nil, {RightLabel = "→→" }, true, function(h,a,s)
                if s then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                    else
                        ESX.ShowNotification("FantaisieRP \nAucun joueur à proximité")
                    end
                end
            end)
        end)
        -- Serveur
        RageUI.IsVisible(RMenu:Get('tomn', 'serveur'), true, true, true, function()
            RageUI.Separator("~c~↓ ~s~Informations ~c~↓")
            RageUI.Separator("Votre pseudo ~c~→ " ..name)
            RageUI.Separator("Votre ID (~c~Unique~s~) ~c~→ " ..id)
        end)
        -- Gestion Véhicule
        RageUI.IsVisible(RMenu:Get('tomn', 'vehicule'), true, true, true, function()
            RageUI.Separator("~c~↓ ~s~Options disponibles ~c~↓")
            Id = GetPlayerPed(-1)
            vehicle = GetVehiclePedIsIn(Id, false)
            vievehicule = GetVehicleEngineHealth(vehicle) / 10
            local vievehicule = math.floor(vievehicule)
            local label = "~s~/100"
            RageUI.Button("Etat du ~b~Véhicule : ~g~" .. vievehicule .. label, nil, {}, true, function(_,_,s)
                if s then
                end
            end)
            RageUI.Button("Allumer/Eteindre le ~b~Moteur", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    Id = GetPlayerPed(-1)
                    vehicle = GetVehiclePedIsIn(Id, false)
                    if GetIsVehicleEngineRunning(vehicle) then
                        SetVehicleEngineOn(vehicle, false, false, true)
                        SetVehicleUndriveable(vehicle, true)
                    elseif not GetIsVehicleEngineRunning(vehicle) then
                        SetVehicleEngineOn(vehicle, true, false, true)
                        SetVehicleUndriveable(vehicle, false)
                    end
                end
            end)
        end)
    
        -- Modération
        RageUI.IsVisible(RMenu:Get('tomn', 'moderation'), true, true, true, function()
            RageUI.Separator("~c~↓ ~s~Administrations ~c~↓")
            RageUI.Checkbox("Activer la ~b~Modération",nil, service,{},function(_,_,s,Checked)
                if s then
                    aTenue()
                    service = Checked
                    if Checked then
                        onservice = true
                        local head = RegisterPedheadshot(PlayerPedId())
                        while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
                            Wait(1)
                        end
                        headshot = GetPedheadshotTxdString(head)
                    else
                        onservice = false
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    end
                end
            end)
            if onservice then

                RageUI.Button("→ Menu Administration", nil, {RightLabel = "→→"},true, function()
                end, RMenu:Get('tomn', 'administration'))

                RageUI.Button("→ Menu Véhicule", nil, {RightLabel = "→→"},true, function()
                end, RMenu:Get('tomn', 'admin_vehicule'))
            end
        end)
        -- MENU ADMINISTRATION
        RageUI.IsVisible(RMenu:Get('tomn', 'administration'), true, true, true, function()
            RageUI.Separator("~c~↓ ~s~Options admins ~c~↓")
            RageUI.Button("→ Se téléporter au ~b~Marqueur", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    admin_tp_marker()
                end
            end)
            RageUI.Button("→ Expulser un ~b~Joueur", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    local kickplayer = KeyboardInput("ID Du joueur à kick :", "", 45)
                    local kick_raison = KeyboardInput("Raison du kick :", "", 45)
                    ExecuteCommand("kick "..kickplayer.." Vous venez d'être kick de " ..serveur.. " Raison : " ..kick_raison)
                end
            end)
            RageUI.Button("→ Afficher les ~b~Coordonnés", nil, {RightLabel = "→→"}, false, function(_,_,s)
                if s then
                    -- en dev
                end
            end)
        end)
        -- MENU  ADMIN VEHICULE
        RageUI.IsVisible(RMenu:Get('tomn', 'admin_vehicule'), true, true, true, function()
            RageUI.Separator("~c~↓ ~s~Options véhicule ~c~↓")
            RageUI.Button("→ Give un ~b~Véhicule", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    local veh = KeyboardInput("Quel véhicule ?", "", 45)
                    ExecuteCommand("car "..veh)
                end
            end)
            RageUI.Button("→ Retourner le ~b~Véhicule", nil, {RightLabel = "→→"}, true, function(_,_,s)
                if s then
                    admin_vehicle_flip()
                end
            end)
        end)
        if IsControlJustPressed(1, 166) then
            RageUI.Visible(RMenu:Get("tomn", "main"), true)
        end
        Citizen.Wait(0)
    end
end)
function aTenue()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 178,   ['torso_2'] = 9,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 77,   ['pants_2'] = 9,
                ['shoes_1'] = 55,   ['shoes_2'] = 9,
                ['helmet_1'] = 91,  ['helmet_2'] = 9,
                ['chain_1'] = 1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  ['mask_2'] = 0,
                ['ears_1'] = 2,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 178,   ['torso_2'] = 9,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 77,   ['pants_2'] = 9,
                ['shoes_1'] = 55,   ['shoes_2'] = 9,
                ['helmet_1'] = 91,  ['helmet_2'] = 9,
                ['chain_1'] = 1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  ['mask_2'] = 0,
                ['ears_1'] = 2,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end    
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

function admin_tp_marker()

    local playerPed = GetPlayerPed(-1)
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
        SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
  ESX.ShowAdvancedNotification("Administration", "", "TP sur Marqueur : ~g~Réussi !", "CHAR_MP_MORS_MUTUAL", 1)
    else
  ESX.ShowAdvancedNotification("Administration", "", "~r~Aucun Marqueur !", "CHAR_MP_MORS_MUTUAL", 1)
    end
end

function admin_vehicle_flip()
	local plyCoords = GetEntityCoords(plyPed)
	local closestCar = GetClosestVehicle(plyCoords['x'], plyCoords['y'], plyCoords['z'], 10.0, 0, 70)
	local plyCoords = plyCoords + vector3(0, 2, 0)
	SetEntityCoords(closestCar, plyCoords)
end

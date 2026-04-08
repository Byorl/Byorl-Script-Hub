local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local TARGET_PLACE_ID = 9391468976

if game.PlaceId == TARGET_PLACE_ID then
    print("Riktig PlaceId oppdaget. Venter 10 sekunder...")
    
    task.wait(10)
    
    local charactersFolder = Workspace:FindFirstChild("Characters")
    local hasLocalPlayer = false
    
    if charactersFolder and charactersFolder:FindFirstChild("LocalPlayer") then
        hasLocalPlayer = true
    end
    
    if not hasLocalPlayer then
        warn("Workspace.Characters.LocalPlayer mangler! Rejoiner nøyaktig samme server...")
        
        local localPlayer = Players.LocalPlayer
        if localPlayer then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
        end
    else
        print("LocalPlayer ble funnet i Characters-mappen. Avbryter rejoin.")
    end
else
    warn("Feil PlaceId (" .. tostring(game.PlaceId) .. "). Scriptet gjør ingenting.")
end

local script_version = getgenv().script_version;
if script_version then getgenv().script_version += 1 else 
    getgenv().script_version = 1;
end; script_version = getgenv().script_version;

local rs = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local lplayer = players.LocalPlayer


getgenv().CurrentVersion = "1.31";

-- // Auto Loader \\ --
repeat task.wait(0.25) until game:IsLoaded();task.spawn(function() pcall(function() if game:GetService("CoreGui"):FindFirstChild("DrRay") then game:GetService("CoreGui").DrRay:Destroy() end end) end)

-- // Auto Skip Loading Menu \\ --
task.spawn(function()
    pcall(function()if not getgenv().SkippedMenu == true then getgenv().SkippedMenu = true;
        repeat task.wait(0.1) until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Loading") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainMenu");
            game:GetService("Players").LocalPlayer.PlayerGui.Loading:Destroy();game:GetService("Players").LocalPlayer.PlayerGui.MainMenu.Enabled = false;
            game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("Play"):FireServer();workspace.scene:Destroy();
        end
    end)
end)

-- // Auto Fix Camera \\ --
task.spawn(function()
    pcall(function()if not getgenv().FixedCamera == true then getgenv().FixedCamera = true;
            repeat task.wait(1.45) until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Stats");
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true);
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true);
            workspace.CurrentCamera:remove();task.wait(0.15);
            workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid");
            workspace.CurrentCamera.CameraType = "Custom";game:GetService("Players").LocalPlayer.PlayerGui.MainMenu:Destroy();
            game.Players.LocalPlayer.CameraMinZoomDistance = 0.5;game.Players.LocalPlayer.CameraMaxZoomDistance = 400;
            game.Players.LocalPlayer.CameraMode = "Classic";game.Players.LocalPlayer.Character.Head.Anchored = false;
            game:GetService("Players").LocalPlayer.PlayerGui.ItemStorage.Enabled = true;
            getgenv().CanLoadIntoSakuraStand = true;
        end
    end)
end)


-- // Anti AFK \\ --
task.spawn(function()
    while true do task.wait(1100);
        pcall(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true,"RightBracket",false,game);
        end)
    end
end)



-- // Settings Manager \\ --
getgenv().Configurations = function()
    pcall(function()
        -- [Grinding Scripts]
        getgenv().AutoPrivateGrinding = false;
        getgenv().AutoPublicGrinding = false;
        getgenv().AutoKillNearestMob = false;
        getgenv().AutoRollCidBanner = false;
        getgenv().AutoStealingItems = false;
        getgenv().AutoConvertTokens = false;
        getgenv().AutoStoreStageOne = false;
        getgenv().AutoBreakthrough = false;
        getgenv().AutoPickingItems = false;
        getgenv().AutoSpawningToji = false;
        getgenv().AutoOneShotting = false;
        getgenv().AutoStealingOfa = false;
        getgenv().AutoRolandTheme = false;
        getgenv().AutoSukunaTheme = false;
        getgenv().AutoSpawningDuo = false;
        getgenv().AutoSpawningDio = false;
        getgenv().AutoMainFarming = false;
        getgenv().AutoResetIchigo = false;
        getgenv().AutofarmOnDullahan1 = false;
        getgenv().AutofarmOnDeku1 = false;
        getgenv().AutofarmOnDeku2 = false;
        getgenv().AutofarmOnDeku3 = false;
        getgenv().AutoEquipWeapon = false;
        getgenv().AutoRollDeaths = false;
        getgenv().AutoRollArcade = false;
        getgenv().AutoSavingCash = false;
        getgenv().AutoRollBanner = false;
        getgenv().AutoBinahTheme = false;
        getgenv().AutoAltFarming = false;
        getgenv().AutoLevelingUp = false;
        getgenv().AutoRespawning = false;
        getgenv().AutoDekuTheme = false;
        getgenv().AutoMonotone = false;
        getgenv().AutoCidTheme = false;
        getgenv().AutoSafeZone = false;
        getgenv().AutoRebirth = false;
        getgenv().AutoSelling = false;
        getgenv().AutoRaining = false;
        getgenv().AutoCloudy = false;

        -- [Exchange Scripts]
        getgenv().AutoB4T = false;
        getgenv().AutoB4P = false;
        getgenv().AutoB4S = false;
        getgenv().AutoB4C = false;

        -- [Quest Scripts]
        getgenv().AutoParryingDamage = false;
        getgenv().AutoBlockingDamage = false;
        getgenv().AutoDealingDamage = false;
        getgenv().AutoTakingDamage = false;
        getgenv().AutoDyingDamage = false;

        -- [Storage Scripts]
        getgenv().StoringAnyEverything = false;
        getgenv().StoringSingularity = false;
        getgenv().StoringNikyuNikyu = false;
        getgenv().StoringDiosDiary = false;
        getgenv().StoringInverted = false;
        getgenv().StoringDiosBone = false;
        getgenv().StoringArasaka = false;
        getgenv().StoringKujoHat = false;
        getgenv().StoringHogyoku = false;
        getgenv().StoringCrimson = false;
        getgenv().StoringCortex = false;
        getgenv().StoringFinger = false;
        getgenv().StoringGloves = false;
        getgenv().StoringSplit = false;
        getgenv().StoringGrace = false;
        getgenv().StoringChain = false;
        getgenv().StoringCyan = false;
        getgenv().StoringTech = false;

        -- [Fighting Scripts]
        getgenv().AutoTeleportPunching = false;
        getgenv().AutoFuckingSyrentia = false;
        getgenv().AutoFuckingAuddy = false;
        getgenv().AutoBlockWarning = false;
        getgenv().AutoAimlocking = false;
        getgenv().AutoGlitching = false;
        getgenv().AutoDefending = false;
        getgenv().AutoRoasting = false;
        getgenv().AutoDashing = false;
        getgenv().AutoDodging = false;

        -- [Movement Scripts]
        getgenv().WalkspeedBypass = false;
        getgenv().JumpPowerBypass = false;

        -- [Esp Scripts]
        getgenv().EspEntities = false;
        getgenv().EspPlayers = false;
        getgenv().EspNpcs = false;
        getgenv().EspItems = false;

        -- [Sakura Hub UI Scripts]
        getgenv().AutoGoingRainbow = false;
    end)
end

getgenv().Configurations();

-----------------------------------[[ Main Ui Libs ]]------------------------------------------------------------------


-- Save function to write boolean settings to a file
getgenv().SaveConfigurations = function()
    local Data = ""
    for Key, Val in pairs(getgenv()) do
        if type(Val) == "boolean" then
            Data = Data .. Key .. "=" .. tostring(Val) .. "\n"
        end
    end
    writefile("Sakura_Hub_config.txt", Data)
    print("Configuration saved.")
end

-- Load function to read settings from file
getgenv().LoadConfigurations = function()
    if isfile("Sakura_Hub_config.txt") then
        local Data = readfile("Sakura_Hub_config.txt")
        for Line in string.gmatch(Data, "([^\n]*)\n?") do
            local Key, Val = string.match(Line, "([^=]+)=([^=]+)")
            if Key and Val then
                getgenv()[Key] = (Val:lower() == "true")
                print("Loaded config:", Key, "=", getgenv()[Key])
            else
                print("Failed to parse line:", Line)
            end
        end
        print("Config loading complete.")
    else
        print("No configuration file found.")
    end
end

-- Activates features based on loaded configurations



-- Load configurations and activate features
getgenv().LoadConfigurations();


local DiscordLib = loadstring(game:HttpGet"https://pastebin.com/raw/A7TgV1KU")()

local win = DiscordLib:Window("Sakura Stand")

local Main = win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")

local FarmTab = Main:Channel("Farming")

FarmTab:Label("Equip Best Farming Spec📌")
FarmTab:Button("Equip Shinra Kusakabe (Best for Private Server Autofarm)", function()
    pcall(function()
        if game:GetService("Players").LocalPlayer.Data.StandName.Value ~= "Shinra Kusakabe" then
            for i = 1,100 do
                if game:GetService("Players").LocalPlayer.PlayerGui.StandStorage.Outer.Inner.Inner["Slot"..i].Text.Text == "Shinra Kusakabe" then
                    local args = {"Slot"..i};
                    if i <= 6 then
                        game:GetService("ReplicatedStorage").StorageRemote["Slot"..i]:FireServer();
                    else
                        game:GetService("ReplicatedStorage").StorageRemote.UseStorageExtra:FireServer(unpack(args));
                    end
                end
            end
        else
            DiscordLib:Notification("Sakura Script", "You're already using Shinra Kusakabe", "Okay!")
        end
    end)
end)

FarmTab:Seperator()

FarmTab:Toggle("Start Farming [Public Server Edition]",getgenv().AutoPublicGrinding, function(Value)
    getgenv().AutoPublicGrinding = Value
    getgenv().PublicServerAutofarm();
end)


FarmTab:Toggle("Start Farming  [Private Server Edition]",getgenv().AutoPrivateGrinding or false, function(Value)
    getgenv().AutoPrivateGrinding = Value
    getgenv().PrivateServerAutofarm();
end)


FarmTab:Toggle("Start Farming XP (Main Account)",getgenv().AutoMainFarming or false, function(Value)
    getgenv().AutoMainFarming = Value
    getgenv().UsingMainAccountFarming();
end)

FarmTab:Toggle("Start Farming XP (Alt Account)",getgenv().AutoAltFarming or false, function(Value)
    getgenv().AutoAltFarming = Value
    getgenv().UsingAltFarming();
end)

FarmTab:Seperator()

FarmTab:Toggle("Deku / Roland Boss Farm",getgenv().AutofarmOnDeku1 or false, function(Value)
    getgenv().AutofarmOnDeku1 = Value
    getgenv().UsingDekuAutofarm1();
end)

FarmTab:Toggle("Dullahan Boss Farm",getgenv().AutofarmOnDullahan1 or false, function(Value)
    getgenv().AutofarmOnDullahan1 = Value
    getgenv().UsingDullahanAutofarm1();
end)


FarmTab:Seperator()

FarmTab:Toggle("Auto set Nearest Bosses / Mobs Health To 0 (Use Grab Moves)",getgenv().AutoOneShotting or false, function(Value)
    getgenv().AutoOneShotting = Value
    getgenv().OneShotAnyBossAndMob();
end)

FarmTab:Toggle("Auto kill Nearest Bosses / Mobs",getgenv().AutoKillNearestMob or false, function(Value)
    getgenv().AutoKillNearestMob = Value
    getgenv().AutofarmNearestMob();
end)


local RollingTab = Main:Channel("Rolling")

local ChooseRollType = RollingTab:Dropdown("Type Of Rolls!",{"Multi","Single"}, function(Value)
    pcall(function()
        getgenv().WhichType = Value;
    end)
end)

RollingTab:Toggle("Auto Roll Arrow Of Novae Banner",getgenv().AutoRollBanner or false, function(Value)
    getgenv().AutoRollBanner = Value
    getgenv().BannerRolling();
end)

RollingTab:Toggle("Auto Roll Cid Banner",getgenv().AutoRollCidBanner or false, function(Value)
    getgenv().AutoRollCidBanner = Value
    getgenv().CidBannerRolling();
end)

RollingTab:Toggle("Auto Roll Kaiju Banner",getgenv().AutoRollKaijuBanner or false, function(Value)
    getgenv().AutoRollKaijuBanner = Value
    getgenv().KaijuBannerRolling();
end)



local LevelTab = Main:Channel("Level")

LevelTab:Toggle("Auto Buy + Auto Sell Rokakaka (Use At 2x Weekend)",getgenv().AutoLevelingUp or false, function(Value)
    getgenv().AutoLevelingUp = Value
    getgenv().LevelingUp();
end)

LevelTab:Toggle("Auto Buy + Auto Sell Rokakaka (When Cash Capacity Full)",getgenv().AutoSavingCash or false, function(Value)
    getgenv().AutoSavingCash = Value
    getgenv().SavingUpCash();
end)

LevelTab:Seperator()

LevelTab:Toggle("Auto Upgrade Mastery",getgenv().AutoRebirth or false, function(Value)
    getgenv().AutoRebirth = Value
    getgenv().Rebirthing();
end)

LevelTab:Toggle("Auto Breakthrough",getgenv().AutoBreakthrough or false, function(Value)
    getgenv().AutoBreakthrough = Value
    getgenv().BreakingThrough();
end)

local SellTab = Main:Channel("Sell")

SellTab:Toggle("Auto Sell Everything",getgenv().AutoSelling or false, function(Value)
    getgenv().AutoSelling = Value
    getgenv().SellingAnyItem();
end)



local ShopTab = Main:Channel("Shop")

getgenv().HidePurchasePrompt = function()
    local LplayerGui = game:GetService("Players").LocalPlayer.PlayerGui;

    LplayerGui.PurchaseFailed.Spin1.Visible = false;
    LplayerGui.PurchaseFailed.Spin2.Visible = false;
    LplayerGui.PurchaseFailed.Spin3.Visible = false;
    LplayerGui.PurchaseFailed.Outer.Visible = false;
    LplayerGui.PurchaseFailed.ConfirmationText.Visible = false;

    LplayerGui.PurchaseSuccess.Spin1.Visible = false;
    LplayerGui.PurchaseSuccess.Spin2.Visible = false;
    LplayerGui.PurchaseSuccess.Spin3.Visible = false;
    LplayerGui.PurchaseSuccess.Outer.Visible = false;
    LplayerGui.PurchaseSuccess.ConfirmationText.Visible = false;
end

ShopTab:Button("Buy Arrow", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Arrow"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)

ShopTab:Button("Buy Rokakaka", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Rokakaka"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)

ShopTab:Button("Buy Stop Sign", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("StopSign"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)

ShopTab:Button("Buy Hamon Manual", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Hamon"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)

ShopTab:Button("Buy Spin Manual", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Spin"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)
    
ShopTab:Button("Buy Stone Mask", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Vampire"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)

ShopTab:Button("Buy Camera", function()
    local args = {[1] = "1"};
    game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Camera"):FireServer(unpack(args));
    getgenv().HidePurchasePrompt();
end)


local StorageTab = Main:Channel("Storage")
StorageTab:Label("Storage Stuff📁")
StorageTab:Button("Close / Open Stand Storage", function()
    pcall(function()
        game:GetService("Players").LocalPlayer.PlayerGui.StandStorage.Enabled = not game:GetService("Players").LocalPlayer.PlayerGui.StandStorage.Enabled;
    end)
end)

StorageTab:Button("Close / Open Item Storage", function()
    pcall(function()
        game:GetService("Players").LocalPlayer.PlayerGui.ItemStorage.Outer.Visible = not game:GetService("Players").LocalPlayer.PlayerGui.ItemStorage.Outer.Visible;
    end)
end)

local MiscTab = Main:Channel("Misc")
MiscTab:Label("Local Player Scripts📢")
MiscTab:Button("Reset Character (Gets rid of Combat Mark)", function()
    task.spawn(function()local ReturnAfterDeath = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame game:GetService("Players").LocalPlayer.CharacterAdded:Wait() repeat task.wait(1) until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = ReturnAfterDeath end)
    local args = {[1] = "kill"};
    game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("SukunaDialogue"):FireServer(unpack(args));
end)

MiscTab:Button("Insta Respawn Character (Gets rid of Combat Mark)", function()
    getgenv().GuildName = "Szechuan";
    getgenv().Password = "pepper";

    task.spawn(function()
        pcall(function()
            local Lplayer = game.Players.LocalPlayer
            local Location = Lplayer.Character.HumanoidRootPart.CFrame
            local Guild = game:GetService("Workspace").Living:FindFirstChild(Lplayer.Name).Head:FindFirstChild("GuildGUI");
            local args = {[1] = Guild and Guild.Text.Text == getgenv().GuildName and "Leave" or "Join",[2] = getgenv().GuildName,[3] = getgenv().Password,[4] = ""};
            game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("SetGuild"):FireServer(unpack(args));

            game.Players.LocalPlayer.CharacterAdded:Wait();

            repeat task.wait(0.015) until Lplayer.Character:FindFirstChild("HumanoidRootPart");task.wait(0.35);

            Lplayer.Character.HumanoidRootPart.CFrame = Location;
        end)
    end)
end)



MiscTab:Label("Visual Scripts👁️")
MiscTab:Toggle("Esp Players",getgenv().EspPlayers, function(Value)
    getgenv().EspPlayers = Value
    getgenv().EspOnPlayers();
end)

MiscTab:Toggle("Esp Entities",getgenv().EspEntities, function(Value)
    getgenv().EspEntities = Value
    getgenv().EspOnEntities();
end)

MiscTab:Toggle("Esp Items",getgenv().EspItems, function(Value)
    getgenv().EspItems = Value
    getgenv().EspOnItems();
end)

MiscTab:Toggle("Esp Npcs",getgenv().EspNpcs, function(Value)
    getgenv().EspNpcs = Value
    getgenv().EspOnNpcs();
end)



local ConfigTab = Main:Channel("Config")
ConfigTab:Label("Config")
ConfigTab:Button("Save Config", function()
    getgenv().SaveConfigurations();
end)










getgenv().BannerRolling = function()
    task.spawn(function()
        while getgenv().AutoRollBanner == true do
            pcall(function()
                local args = {getgenv().WhichType,"ArrowOfNovae"};
                game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("BannerPull"):FireServer(unpack(args));
            end)
            task.wait(1.25);
        end
    end)
end

getgenv().CidBannerRolling = function()
    task.spawn(function()
        while getgenv().AutoRollCidBanner == true do
            pcall(function()
                local args = {getgenv().WhichType,"TheShadowGarden"};
                game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("BannerPull"):FireServer(unpack(args));
            end)
            task.wait(1.25);
        end
    end)
end

getgenv().KaijuBannerRolling = function()
    task.spawn(function()
        while getgenv().AutoRollKaijuBanner == true do
            pcall(function()
                local args = {getgenv().WhichType,"KaijuNo.8"};
                game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("BannerPull"):FireServer(unpack(args));
            end)
            task.wait(1.25);
        end
    end)
end

getgenv().OneShotAnyBossAndMob = function()
    task.spawn(function()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if getgenv().AutoOneShotting == true then
                pcall(function()
                    for _,k in ipairs(workspace.Living:GetChildren()) do
                        if k:IsA("Model") and k:FindFirstChild("Head") and k.Head ~= game.Players.LocalPlayer.Character.Head then
                            if game.Players:GetPlayerFromCharacter(k) == nil then
                                if (k.Head.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude <= 9e9 then
                                    if k:FindFirstChild("Participated") and k.Participated:FindFirstChild(game.Players.LocalPlayer.Name) then
                                        k.Humanoid.Health = 0;
                                    end
                                end
                            end
                        end
                    end
                end)
            else
                connection:Disconnect();
            end
        end)
    end)
end

getgenv().AutofarmNearestMob = function()
    task.spawn(function()
        while getgenv().AutoKillNearestMob == true do
            pcall(function()
                local IgnoreShit = {"Attacking Dummy","Dummy","Counter Dummy","Blocking Dummy","Tough Dummy","Chariot Requiem","Bandit","Thug", "Mosquito Curse", "Adjuchas", "Paper Curse", "Contorted Curse"};                
                for _,k in ipairs(workspace.Living:GetChildren()) do
                    if k:IsA("Model") and k:FindFirstChild("Head") and k.Head ~= game.Players.LocalPlayer.Character.Head then
                        if game.Players:GetPlayerFromCharacter(k) == nil then
                            if not table.find(IgnoreShit,k.Name) then
                                if (k.Head.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude <= 9e9 then
                                    if game.Players[game.Players.LocalPlayer.Name].Character.Humanoid.Health ~= 0 then
                                        local Hum = k:FindFirstChild("HumanoidRootPart");
                                        if Hum then
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Hum.Position - Hum.CFrame.lookVector * 5,Hum.Position);
                                            getgenv().Attacking();
                                        end
                                    else
                                        task.wait(3.15);
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(0.15);
        end
    end)
end


getgenv().EspOnPlayers = function()
    local Folder = workspace.Living

    local function CreateBilboard(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end

        local BillboardGui = Instance.new("BillboardGui");
        local TextLabel = Instance.new("TextLabel");

        BillboardGui.Parent = Head
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0,100,0,50);
        BillboardGui.StudsOffset = Vector3.new(0,2,0);

        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1);
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1,0,1,0);
        TextLabel.Text = X.Name
        TextLabel.TextColor3 = Color3.fromRGB(255,255,0);
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0);
        TextLabel.Visible = false

        return BillboardGui,TextLabel
    end

    local function UseESP(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end

        local BillboardGui,TextLabel = CreateBilboard(X)
        local RenderSteppedCon

        local function DisconnectCons()
            if BillboardGui then
                BillboardGui:Destroy();
            end
            if RenderSteppedCon then
                RenderSteppedCon:Disconnect();
                RenderSteppedCon = nil
            end
        end

        RenderSteppedCon = game:GetService("RunService").RenderStepped:Connect(function()
            local HeadPosition,HeadOnScreen = workspace.CurrentCamera:WorldToViewportPoint(Head.Position);
            if HeadOnScreen then
                TextLabel.Visible = getgenv().EspPlayers
            else
                TextLabel.Visible = false
            end
        end)

        X.AncestryChanged:Connect(function(_,b)
            if not b then
                DisconnectCons();
            end
        end)
    end

    local function isPlayer(X)
        return game.Players:GetPlayerFromCharacter(X) ~= nil
    end

    local function XAdded(X)
        if isPlayer(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            UseESP(X);
        end
        X.ChildAdded:Connect(function(v)
            if isPlayer(v) and v:IsA("Model") and v:FindFirstChild("Head") then
                UseESP(v);
            end
        end)
    end

    for _,X in ipairs(Folder:GetChildren()) do
        if isPlayer(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            XAdded(X);
        end
    end

    Folder.ChildAdded:Connect(function(v)
        task.wait(0.5);XAdded(v);
    end)
end

getgenv().EspOnEntities = function()
    local Folder = workspace.Living
    local Dummies = {"Attacking Dummy","Dummy","Counter Dummy","Blocking Dummy","Tough Dummy"};

    local function CreateBilboard(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end

        local BillboardGui = Instance.new("BillboardGui");
        local TextLabel = Instance.new("TextLabel");

        BillboardGui.Parent = Head
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0,100,0,50);
        BillboardGui.StudsOffset = Vector3.new(0,2,0);

        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1);
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1,0,1,0);
        TextLabel.Text = X.Name
        TextLabel.TextColor3 = Color3.fromRGB(255,0,0);
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0);
        TextLabel.Visible = false

        return BillboardGui,TextLabel
    end

    local function UseESP(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end

        local BillboardGui,TextLabel = CreateBilboard(X)
        local RenderSteppedCon

        local function DisconnectCons()
            if BillboardGui then
                BillboardGui:Destroy();
            end
            if RenderSteppedCon then
                RenderSteppedCon:Disconnect();
                RenderSteppedCon = nil
            end
        end

        RenderSteppedCon = game:GetService("RunService").RenderStepped:Connect(function()
            local HeadPosition,HeadOnScreen = workspace.CurrentCamera:WorldToViewportPoint(Head.Position);
            if HeadOnScreen then
                TextLabel.Visible = getgenv().EspEntities
            else
                TextLabel.Visible = false
            end
        end)

        X.AncestryChanged:Connect(function(_,b)
            if not b then
                DisconnectCons();
            end
        end)
    end

    local function isPlayer(X)
        for _,k in pairs(game.Players:GetPlayers()) do
            if X.Name == k.Name then
                return true
            end
        end
        return false
    end

    local function isDummy(X)
        for _,m in pairs(Dummies) do
            if X.Name == m then
                return true
            end
        end
        return false
    end

    local function XAdded(X)
        if not isPlayer(X) and not isDummy(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            UseESP(X);
        end
        X.ChildAdded:Connect(function(v)
            if not isPlayer(v) and not isDummy(v) and v:IsA("Model") and v:FindFirstChild("Head") then
                UseESP(v);
            end
        end)
    end

    for _,X in ipairs(Folder:GetChildren()) do
        if not isPlayer(X) and not isDummy(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            XAdded(X);
        end
    end

    Folder.ChildAdded:Connect(function(v)
        task.wait(0.5);XAdded(v);
    end)
end

getgenv().EspOnItems = function()
    local Folder = {workspace.Item,workspace.Item2};
    local Casual = {"Chest","Box","Barrel"};
    
    local function CreateBillboard(X,Color)
        local BillboardGui = Instance.new("BillboardGui");
        local TextLabel = Instance.new("TextLabel");
    
        BillboardGui.Parent = X
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0,100,0,50);
        BillboardGui.StudsOffset = Vector3.new(0,2,0);
    
        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1,0,1,0);
        TextLabel.Text = X.Name
        TextLabel.TextColor3 = Color
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0);
        TextLabel.Visible = false
    
        return BillboardGui,TextLabel
    end
    
    local function ShouldIgnore(X)
        return X.Name == "SoulSpawn" or X.Position == Vector3.new(1804.5390625,-298.173583984375,-309.4649658203125);
    end
    
    local function UseESP(X)
        if ShouldIgnore(X) then
            return
        end
    
        local Color = table.find(Casual,X.Name) and Color3.fromRGB(255,255,255) or Color3.fromRGB(0,255,0);
        local BillboardGui,TextLabel = CreateBillboard(X,Color);
        local RenderSteppedCon
    
        local function DisconnectCons()
            if BillboardGui then
                BillboardGui:Destroy();
            end
            if RenderSteppedCon then
                RenderSteppedCon:Disconnect();
                RenderSteppedCon = nil
            end
        end
    
        RenderSteppedCon = game:GetService("RunService").RenderStepped:Connect(function()
            local HeadPosition,HeadOnScreen = workspace.CurrentCamera:WorldToViewportPoint(X.Position);
            if HeadOnScreen then
                TextLabel.Visible = getgenv().EspItems
            else
                TextLabel.Visible = false
            end
        end)
    
        X.AncestryChanged:Connect(function(b)
            if not b then
                DisconnectCons();
            end
        end)
    end
    
    local function XAdded(X)
        if X:IsA("BasePart") then
            UseESP(X);
        end
        X.ChildAdded:Connect(function(v)
            if v:IsA("BasePart") then
                UseESP(v);
            end
        end)
    end
    
    for _,X in ipairs(Folder) do
        for _,X in ipairs(X:GetChildren()) do
            if X:IsA("BasePart") then
                if not ShouldIgnore(X) then
                    XAdded(X);
                end
            end
        end
    
        X.ChildAdded:Connect(function(v)
            if v:IsA("BasePart") and not ShouldIgnore(v) then
                task.wait(0.5);XAdded(v);
            end
        end)
    end
end

getgenv().EspOnNpcs = function()
    local Folder = workspace.Map.NPCs

    local function CreateBilboard(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end
    
        local BillboardGui = Instance.new("BillboardGui");
        local TextLabel = Instance.new("TextLabel");
    
        BillboardGui.Parent = Head
        BillboardGui.AlwaysOnTop = true
        BillboardGui.Size = UDim2.new(0,100,0,50);
        BillboardGui.StudsOffset = Vector3.new(0,2,0);
    
        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1,1,1);
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(1,0,1,0);
        TextLabel.Text = X.Name
        TextLabel.TextColor3 = Color3.fromRGB(0,255,255);
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0);
        TextLabel.Visible = false
    
        return BillboardGui,TextLabel
    end
    
    local function UseESP(X)
        local Head = X:FindFirstChild("Head");
        if not Head then return end
    
        local BillboardGui,TextLabel = CreateBilboard(X)
        local RenderSteppedCon
    
        local function DisconnectCons()
            if BillboardGui then
                BillboardGui:Destroy();
            end
            if RenderSteppedCon then
                RenderSteppedCon:Disconnect();
                RenderSteppedCon = nil
            end
        end
    
        RenderSteppedCon = game:GetService("RunService").RenderStepped:Connect(function()
            local HeadPosition,HeadOnScreen = workspace.CurrentCamera:WorldToViewportPoint(Head.Position);
            if HeadOnScreen then
                TextLabel.Visible = getgenv().EspNpcs
            else
                TextLabel.Visible = false
            end
        end)
    
        X.AncestryChanged:Connect(function(_,b)
            if not b then
                DisconnectCons();
            end
        end)
    end
    
    local function isPlayer(X)
        for _,k in pairs(game.Players:GetPlayers()) do
            if X.Name == k.Name then
                return true
            end
        end
        return false
    end
    
    local function XAdded(X)
        if not isPlayer(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            UseESP(X);
        end
        X.ChildAdded:Connect(function(v)
            if not isPlayer(v) and v:IsA("Model") and v:FindFirstChild("Head") then
                UseESP(v);
            end
        end)
    end
    
    for _,X in ipairs(Folder:GetChildren()) do
        if not isPlayer(X) and X:IsA("Model") and X:FindFirstChild("Head") then
            XAdded(X);
        end
    end
    
    Folder.ChildAdded:Connect(function(v)
        task.wait(0.5);XAdded(v);
    end)
end

getgenv().LevelingUp = function()
    task.spawn(function()
        while getgenv().AutoLevelingUp == true do task.wait(1.5);
            pcall(function()
                if game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                    if game:GetService("Players").LocalPlayer.Data.Cash.Value > 75 then
                        local args = {[1] = "99"};
                        game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Rokakaka"):FireServer(unpack(args));
                    end

                    for i,v in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren()) do
                        if table.find({"Arrow","Barrel","Rokakaka","Stop Sign","Mysterious Camera","Haunted Sword","Spin Manual","Hamon Manual","Stone Mask","Bomu Bomu Devil Fruit","Mochi Mochi Devil Fruit","Bari Bari Devil Fruit"},v.Name) then
                            game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("SellItem"):FireServer(v.Name);
                        end
                    end
    
                    getgenv().HidePurchasePrompt();
                end
            end)
        end    
    end)
end

getgenv().SavingUpCash = function()
    task.spawn(function()
        while getgenv().AutoSavingCash == true do
            pcall(function()
                local Cash1 = game:GetService("Players").LocalPlayer.Data.Cash;
                local Cash2 = game:GetService("Players").LocalPlayer.PlayerGui.Menu.Currencies.Cash.Background.Inner.TextLabel;
                
                if Cash1.Value == tonumber(string.match(Cash2.Text,"%d+ / (%d+)")) then 
                    if game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                        if game:GetService("Players").LocalPlayer.Data.Cash.Value > 75 then
                            local args = {[1] = "99"};
                            game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Rokakaka"):FireServer(unpack(args));
                            local args = {[1] = "99"};
                            game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Rokakaka"):FireServer(unpack(args));
                            local args = {[1] = "99"};
                            game:GetService("ReplicatedStorage"):WaitForChild("BuyItemRemote"):WaitForChild("Rokakaka"):FireServer(unpack(args));
                        end
                
                        for i,v in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren()) do
                            if table.find({"Arrow","Barrel","Rokakaka","Stop Sign","Mysterious Camera","Haunted Sword","Spin Manual","Hamon Manual","Stone Mask","Bomu Bomu Devil Fruit","Mochi Mochi Devil Fruit","Bari Bari Devil Fruit"},v.Name) then
                                game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("SellItem"):FireServer(v.Name);
                            end
                        end
                
                        getgenv().HidePurchasePrompt();
                    end
                end
            end)
            task.wait(0.45);
        end    
    end)
end

getgenv().Rebirthing = function()
    task.spawn(function()
        while getgenv().AutoRebirth == true do
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Exp.Value == 30725 and game:GetService("Players").LocalPlayer.Data.Mastery.Value ~= 15 then
                    game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("UpgradeMas"):FireServer();
                end
            end)
            task.wait(0.45);
        end
    end)
end

getgenv().BreakingThrough = function()
    task.spawn(function()
        while getgenv().AutoBreakthrough == true do
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Exp.Value == 30725 and game:GetService("Players").LocalPlayer.Data.Mastery.Value == 15 then
                    game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("Breakthrough"):FireServer();
                end
            end)
            task.wait(0.45);
        end
    end)
end

getgenv().PublicServerAutofarm = function()
    local FloatPart = Instance.new("Part",game.Workspace);
    FloatPart.Name = "FloatPart"
    FloatPart.Size = Vector3.new(6,0.1,6);
    FloatPart.Anchored = true
    FloatPart.Transparency = 1
    
    task.spawn(function()
        if getgenv().AutoPublicGrinding == false then
            game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame * CFrame.new(0,8,0);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPublicGrinding == true do 
            local Connec
            Connec = game.Players.LocalPlayer.Character.Humanoid.StateChanged:Connect(function(_,z)
                if getgenv().AutoPublicGrinding == true then
                    game:GetService("Players").LocalPlayer.Character.Humanoid:SetStateEnabled(1,false);
                    if z == Enum.HumanoidStateType.FallingDown or z == Enum.HumanoidStateType.Ragdoll then
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
                    end
                else
                    Connec:Disconnect();
                end
            end)
           task.wait(0.35);
            if not getgenv().AutoPublicGrinding == true then
                break;
            end
        end
    end)
    
    task.spawn(function()
        while getgenv().AutoPublicGrinding == true do
            pcall(function()
                FloatPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,-3.05,0);
            end)
            task.wait(0.01);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPublicGrinding == true do
            pcall(function()
                for _,j in pairs(game:GetService("Players"):GetPlayers()) do
                    local Char = j.Character
                    if Char then
                        for _,n in pairs(Char:GetDescendants()) do
                            if n:IsA("BasePart") then
                                n.CanCollide = false
                            end
                        end
                    end
                end
            end)
            task.wait(0.15);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPublicGrinding == true do
            pcall(function()
                if not workspace.Living[game.Players.LocalPlayer.Name].CDValues:FindFirstChild("OnCooldown") and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                    local Lplayer = game:GetService("Players").LocalPlayer
                    local Folder = {workspace.Item,workspace.Item2};
                    
                    local NormalPartz = {}
                    local UniquePartz = {}
                    
                    for _,k in ipairs(Folder) do
                        for _,k in ipairs(k:GetChildren()) do
                            if k:IsA("BasePart") and k.Name ~= "SoulSpawn" and k.Name ~= "PerceptionMask" and k.Position ~= Vector3.new(1804.5390625,-298.173583984375,-309.4649658203125) then
                                if ((k.Name:sub(1,2) == "Bo" or k.Name:sub(1,3) == "Sec") and k:FindFirstChild("Outline")) or ((k.Name:sub(1,2) ~= "Bo" and k.Name:sub(1,3) ~= "Sec") and not k:FindFirstChild("Outline")) then
                                    if not ((Lplayer.Data.Mastery.Value == 0 and k.Name == "SukunaFinger") or (Lplayer.Data.Mastery.Value == 0 and k.Name == "HogyokuFragment") or (Lplayer.Data.Mastery.Value == 1 and Lplayer.Data.Mastery.Value == 2 and k.Name == "OA's Grace")) then
                                        if (k.Name ~= "Box" and k.Name ~= "Barrel" and k.Name ~= "Chest") then
                                            table.insert(UniquePartz,k);
                                        end
                                        if Lplayer.Backpack:FindFirstChild("Chest Key") and workspace.Item:FindFirstChild("Chest") and k.Name == "Chest" then
                                            table.insert(NormalPartz,k);
                                        elseif not Lplayer.Backpack:FindFirstChild("Chest Key") and workspace.Item:FindFirstChild("Chest") and k.Name ~= "Chest" then
                                            table.insert(NormalPartz,k);
                                        elseif not workspace.Item:FindFirstChild("Chest") then
                                            table.insert(NormalPartz,k);
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    local function TeleportTo(Parts)
                        if #Parts > 0 then
                            local Selected = Parts[math.random(1,#Parts)];
                            local Prompt = Selected:FindFirstChildOfClass("ProximityPrompt");
                    
                            if Selected and Prompt then
                                Lplayer.Character:SetPrimaryPartCFrame(CFrame.new(Selected.Position - Vector3.new(0,7,0)));
                                task.wait(0.15);
                                Prompt.HoldDuration = 0;Prompt:InputHoldBegin();Prompt:InputHoldEnd();
                            end
                        end
                    end
                    
                    if math.random() <= 0.90 and #UniquePartz > 0 then
                        TeleportTo(UniquePartz);
                    elseif #NormalPartz > 0 then
                        TeleportTo(NormalPartz);
                    end
                end
            end)
            task.wait(0.25);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPublicGrinding == true do
            pcall(function()
                local args = {[1] = "/e sadcat"};
                game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("Chatted"):FireServer(unpack(args));
            end)
            task.wait(0.35);
        end
    end)
end

getgenv().PrivateServerAutofarm = function()
    getgenv().ListOfNpcs = {"Arbiter","BossPudding","Pillar","Starrk","Bygone","Cid","Sukuna","Mahito","Gojo","Mahoraga","Q3","N4","Midknight","Space Curse","Jotaro Kujo","Toji","Roland","BlackSilence","AngelicaWeak","Angelica","","Dio","Deku","Adjuchas","Contorted Curse","Glutton Curse","Mosquito Curse","Spider Curse","Frog Hollow","Fishbone"};

    game.Players[game.Players.LocalPlayer.Name].PlayerGui.Chat.Frame.Visible = false;

    if game:GetService("Players").LocalPlayer.Data.StandName.Value == "Standless" or game:GetService("Players").LocalPlayer.Data.StandName.Value == "Shinra Kusakabe" or game:GetService("Players").LocalPlayer.Data.StandName.Value == "Shadow The World" then
        getgenv().Distance = -5.5;
    elseif game:GetService("Players").LocalPlayer.Data.StandName.Value == "Emperor" then
        getgenv().Distance = 19.5;
    else
        getgenv().Distance = -6.5;
    end

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do
            pcall(function()
                getgenv().Target = nil getgenv().FoundAnything = false
                for i,v in ipairs(getgenv().ListOfNpcs) do
                    if workspace.Living:FindFirstChild(v) and workspace.Living:FindFirstChild(v):FindFirstChild("Head") then
                        local NPC = workspace.Living:FindFirstChild(v);
                        if NPC then
                            getgenv().Target = NPC getgenv().FoundAnything = true;
                            break
                        end
                    end
                end
            end)
            task.wait(3.5);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do 
            local Connec
            Connec = game.Players.LocalPlayer.Character.Humanoid.StateChanged:Connect(function(_,z)
                if getgenv().AutoPrivateGrinding == true then
                    game:GetService("Players").LocalPlayer.Character.Humanoid:SetStateEnabled(1,false);
                    if z == Enum.HumanoidStateType.FallingDown or z == Enum.HumanoidStateType.Ragdoll then
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
                    end
                else
                    Connec:Disconnect();
                end
            end)
           task.wait(0.35);
            if not getgenv().AutoPrivateGrinding == true then
                break;
            end
        end
    end)

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do
            pcall(function()
                if getgenv().Target and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                    if getgenv().Target:FindFirstChild("Participated") and getgenv().Target.Participated:FindFirstChild(game.Players.LocalPlayer.Name) then
                        getgenv().Target.Humanoid.Health = 0;
                    end

                    if not getgenv().Target.CDValues:FindFirstChild("OnCooldown") and not getgenv().Target.CDValues:FindFirstChild("Grabbed") and not workspace.Living[game.Players.LocalPlayer.Name].CDValues:FindFirstChild("Dashing") then
                        task.spawn(function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(getgenv().Target.HumanoidRootPart.Position - getgenv().Target.HumanoidRootPart.CFrame.lookVector * getgenv().Distance,getgenv().Target.HumanoidRootPart.Position);task.wait(0.35);
                        end)getgenv().Attacking();
                    end
                else
                    task.wait(3.15);
                end
            end)
            task.wait(0.15);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do
            pcall(function()
                if getgenv().FoundAnything == false and game:GetService("Players").LocalPlayer.PlayerGui.InCombat.Enabled then
                    local args = {[1] = "kill"};
                    game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("SukunaDialogue"):FireServer(unpack(args));
                end            
            end)
            task.wait(3.5);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do
                pcall(function()
                    if getgenv().FoundAnything == false and not game:GetService("Players").LocalPlayer.PlayerGui.InCombat.Enabled and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                        local RespawnNeeded = false;

                        for _,k in pairs(game.Workspace.Item:GetChildren()) do
                            if ((k.Name == "Box" and k:FindFirstChild("Outline")) and k.Position ~= Vector3.new(1804.5390625,-298.173583984375,-309.4649658203125)) or k.Name == "Barrel" or k.Name == "Chest" and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chest Key") then
                                RespawnNeeded = true;
                                break
                            end
                        end

                        if RespawnNeeded and not workspace.Living[game.Players.LocalPlayer.Name].CDValues:FindFirstChild("OnCooldown") and getgenv().AutoLevelingUp == false then
                            local args = {[1] = "Exploiter"};
                            game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("ApplyAchievement"):FireServer(unpack(args));task.wait(4.5);
                        end
                    end
                end)
            task.wait(0.45);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do
            pcall(function()
                if getgenv().FoundAnything == false and not game:GetService("Players").LocalPlayer.PlayerGui.InCombat.Enabled and not workspace.Living[game.Players.LocalPlayer.Name].CDValues:FindFirstChild("OnCooldown") and game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 then
                    local Lplayer = game:GetService("Players").LocalPlayer
                    local Folder = {workspace.Item,workspace.Item2};
                    
                    local NormalParts = {}
                    local UniqueParts = {}
                    
                    for _,k in ipairs(Folder) do
                        for _,k in ipairs(k:GetChildren()) do
                            if k:IsA("BasePart") and k.Name ~= "SoulSpawn" and k.Name ~= "PerceptionMask" and k.Position ~= Vector3.new(1804.5390625,-298.173583984375,-309.4649658203125) then
                                if ((k.Name:sub(1,2) == "Bo" or k.Name:sub(1,3) == "Sec") and k:FindFirstChild("Outline")) or ((k.Name:sub(1,2) ~= "Bo" and k.Name:sub(1,3) ~= "Sec") and not k:FindFirstChild("Outline")) then
                                    if not ((Lplayer.Data.Mastery.Value == 0 and k.Name == "SukunaFinger") or (Lplayer.Data.Mastery.Value == 0 and k.Name == "HogyokuFragment") or (Lplayer.Data.Mastery.Value == 1 and Lplayer.Data.Mastery.Value == 2 and k.Name == "OA's Grace")) then
                                        if (k.Name ~= "Box" and k.Name ~= "Barrel" and k.Name ~= "Chest") then
                                            table.insert(UniqueParts,k);
                                        end
                                        if Lplayer.Backpack:FindFirstChild("Chest Key") and workspace.Item:FindFirstChild("Chest") and k.Name == "Chest" then
                                            table.insert(NormalParts,k);
                                        elseif not Lplayer.Backpack:FindFirstChild("Chest Key") and workspace.Item:FindFirstChild("Chest") and k.Name ~= "Chest" then
                                            table.insert(NormalParts,k);
                                        elseif not workspace.Item:FindFirstChild("Chest") then
                                            table.insert(NormalParts,k);
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    local function TeleportTo(Parts)
                        if #Parts > 0 then
                            local Selected = Parts[math.random(1,#Parts)];
                            local Prompt = Selected:FindFirstChildOfClass("ProximityPrompt");
                    
                            if Selected and Prompt then
                                Lplayer.Character:SetPrimaryPartCFrame(CFrame.new(Selected.Position - Vector3.new(0,-2.5,0)));
                                task.wait(0.15);
                                Prompt.HoldDuration = 0;Prompt:InputHoldBegin();Prompt:InputHoldEnd();
                            end
                        end
                    end
                    
                    if math.random() <= 0.85 and #UniqueParts > 0 then
                        TeleportTo(UniqueParts);
                    elseif #NormalParts > 0 then
                        TeleportTo(NormalParts);
                    end
                end
            end)
            task.wait(0.25);
        end
    end)

    task.spawn(function()
        while getgenv().AutoPrivateGrinding == true do
            pcall(function()
                workspace.Living[game.Players.LocalPlayer.Name]:FindFirstChild("Animate").idle.Animation1.AnimationId = "rbxassetid://12512421480";
            end)
            task.wait(0.35);
        end
    end) 
end

getgenv().SellingAnyItem = function()
    task.spawn(function()
        while getgenv().AutoSelling == true do
            pcall(function()                
                local Items = {"Arrow","Barrel","Rokakaka","Stop Sign","Mysterious Camera","Haunted Sword","Spin Manual","Hamon Manual","Stone Mask","Bomu Bomu Devil Fruit","Mochi Mochi Devil Fruit","Bari Bari Devil Fruit"};
                
                for i,v in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren()) do
                    if table.find(Items,v.Name) then
                        game:GetService("ReplicatedStorage"):WaitForChild("GlobalUsedRemotes"):WaitForChild("SellItem"):FireServer(v.Name);
                    end
                end
            end)
            task.wait(3.5);
        end
    end)
end

getgenv().UsingAltFarming = function()
    task.spawn(function()
        while getgenv().AutoAltFarming == true do
            pcall(function()                
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-85.82078552246094,-116.3696060180664,314.07122802734375);
                if workspace.Living[game.Players.LocalPlayer.Name]:FindFirstChild("Humanoid").MaxHealth ~= workspace.Living[game.Players.LocalPlayer.Name]:FindFirstChild("Humanoid").Health then
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0;
                end
            end)
            task.wait(0.015);
        end
    end)
end

getgenv().UsingMainAccountFarming = function()
    task.spawn(function()
        while getgenv().AutoMainFarming == true do
            pcall(function()           
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-87.23579406738281,-116.3696060180664,318.3973693847656);
                game:GetService("VirtualUser"):Button1Down(Vector2.new());
            end)
            task.wait(0.015);
        end
    end)
end



--[[
    Updated Script for Deku Autofarm with Revised OA's Grace Activation
    Changes:
      - Added a debounce (cooldown) to prevent spamming stand switches.
      - Reworked conditional logic to ensure mutually exclusive stand switching.
--]]

-----------------------------------------------------
-- Services & Cached References
-----------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

local lplayer = Players.LocalPlayer

-- Cache remote references
local QuestRemotes = ReplicatedStorage:WaitForChild("QuestRemotes")
local GlobalUsedRemotes = ReplicatedStorage:WaitForChild("GlobalUsedRemotes")
local StorageRemote = ReplicatedStorage:WaitForChild("StorageRemote")
local ShinraRemote = ReplicatedStorage:WaitForChild("ShinraRemote")
local BuyItemRemote = ReplicatedStorage:WaitForChild("BuyItemRemote")

-----------------------------------------------------
-- Utility Functions
-----------------------------------------------------

-- Fires all proximity prompts found in the given item’s descendants
local function fireProximityPrompts(item)
    for _, v in pairs(item:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
            pcall(function()
                v:InputHoldBegin()
                v:InputHoldEnd()
            end)
        end
    end
end

-- Resets the player by rejoining the guild and repositioning the character
local function resetPlayer()
    getgenv().GuildName = "Szechuan"
    getgenv().Password = "pepper"
    
    task.spawn(function()
        pcall(function()
            if not lplayer.Character or not lplayer.Character:FindFirstChild("HumanoidRootPart") then
                return
            end
            local currentCFrame = lplayer.Character.HumanoidRootPart.CFrame

            local livingChild = Workspace.Living:FindFirstChild(lplayer.Name)
            local guildGui = livingChild and livingChild:FindFirstChild("Head") and livingChild.Head:FindFirstChild("GuildGUI")
            local isInGuild = guildGui and guildGui.Text.Text == getgenv().GuildName
            local args = { isInGuild and "Leave" or "Join", getgenv().GuildName, getgenv().Password, "" }

            GlobalUsedRemotes:WaitForChild("SetGuild"):FireServer(unpack(args))
            
            lplayer.CharacterAdded:Wait()
            repeat task.wait(0.015) until lplayer.Character and lplayer.Character:FindFirstChild("HumanoidRootPart")
            task.wait(0.35)
            lplayer.Character.HumanoidRootPart.CFrame = currentCFrame
        end)
    end)
end

-- Teleports the player's character to a given position (Vector3)
local function teleportToPosition(position)
    if lplayer.Character and lplayer.Character:FindFirstChild("HumanoidRootPart") then
        lplayer.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-----------------------------------------------------
-- Stand Switching with Debounce
-----------------------------------------------------

-- Shared variable to control the cooldown between stand switches
local lastStandSwitchTime = 0
local standSwitchCooldown = 2 -- seconds

-- Switches the player's stand to the provided standName.
local function switchToStand(standName)
    -- Prevent switching if within the cooldown period
    if tick() - lastStandSwitchTime < standSwitchCooldown then
        return
    end
    lastStandSwitchTime = tick()

    if not lplayer:FindFirstChild("PlayerGui") or not lplayer.PlayerGui:FindFirstChild("StandStorage") then
        warn("StandStorage GUI not found.")
        return
    end
    local standStorage = lplayer.PlayerGui.StandStorage
    local slotContainer = standStorage:FindFirstChild("Outer")
        and standStorage.Outer:FindFirstChild("Inner")
        and standStorage.Outer.Inner:FindFirstChild("Inner")
    if not slotContainer then
        warn("Slot container not found.")
        return
    end

    local switched = false
    for i = 1, 100 do
        local slotFrame = slotContainer:FindFirstChild("Slot" .. i)
        if slotFrame and slotFrame:FindFirstChild("Text") and slotFrame.Text.Text == standName then
            local args = {"Slot" .. i}
            if i <= 6 then
                StorageRemote["Slot" .. i]:FireServer()
            else
                StorageRemote.UseStorageExtra:FireServer(unpack(args))
            end
            -- Wait until the player's Data.StandName is updated
            for j = 1, 20 do
                task.wait(0.1)
                if lplayer:FindFirstChild("Data") and lplayer.Data:FindFirstChild("StandName") and lplayer.Data.StandName.Value == standName then
                    switched = true
                    break
                end
            end
            break
        end
    end
    if not switched then
        warn("Failed to switch to stand:", standName)
    end
end

-----------------------------------------------------
-- Main Autofarm Function
-----------------------------------------------------

getgenv().UsingDekuAutofarm1 = function()
    getgenv().AutofarmOnDeku1 = true

    ------------------------------
    -- Quest Handling
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                local questId = 33
                QuestRemotes:WaitForChild("AcceptQuest"):FireServer(questId)
                QuestRemotes:WaitForChild("ClaimQuest"):FireServer(questId)
            end)
            task.wait(0.35)
        end
    end)

    ------------------------------
    -- Item Purchasing & Selling
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                local backpack = lplayer:WaitForChild("Backpack")
                if lplayer.Data and lplayer.Data.Mastery and lplayer.Data.Cash then
                    if lplayer.Data.Mastery.Value < 3 and lplayer.Data.Cash.Value > 75 then
                        BuyItemRemote:WaitForChild("Rokakaka"):FireServer("99")
                    end
                end

                local itemsToSell = {
                    "Arrow", "Barrel", "Rokakaka", "Stop Sign", "Mysterious Camera",
                    "Haunted Sword", "Spin Manual", "Hamon Manual", "Stone Mask",
                    "Bomu Bomu Devil Fruit", "Mochi Mochi Devil Fruit", "Bari Bari Devil Fruit"
                }
                for _, item in ipairs(backpack:GetChildren()) do
                    if table.find(itemsToSell, item.Name) then
                        GlobalUsedRemotes:WaitForChild("SellItem"):FireServer(item.Name)
                    end
                end

                if getgenv().HidePurchasePrompt then
                    pcall(getgenv().HidePurchasePrompt)
                end
            end)
            task.wait(0.35)
        end
    end)

    ------------------------------
    -- Enemy Attacks
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                for _, enemy in pairs(Workspace.Living:GetChildren()) do
                    if table.find({"Bygone", "Angelica", "AngelicaWeak", "BlackSilence"}, enemy.Name)
                       and enemy:FindFirstChild("Humanoid") then
                        enemy.Humanoid.Health = 0
                    end
                end
            end)
            task.wait(0.015)
        end
    end)

    ------------------------------
    -- Handle Roland-specific Logic
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                local roland = Workspace.Living:FindFirstChild("Roland")
                if roland 
                   and not Workspace.Item2:FindFirstChild("OA's Grace")
                   and lplayer.Data and lplayer.Data.StandName and lplayer.Data.StandName.Value == "Shinra Kusakabe" then

                    if lplayer.Character and lplayer.Character:FindFirstChild("Humanoid") and lplayer.Character.Humanoid.Health > 0 then
                        local rolandHumanoid = roland:FindFirstChild("Humanoid")
                        if rolandHumanoid and rolandHumanoid.Health < rolandHumanoid.MaxHealth then
                            task.spawn(function()
                                task.wait(4)
                                rolandHumanoid.Health = 0
                            end)
                        end

                        local rolandHRP = roland:FindFirstChild("HumanoidRootPart")
                        if rolandHRP then
                            teleportToPosition(rolandHRP.Position - rolandHRP.CFrame.LookVector * 7)
                        end

                        ShinraRemote:WaitForChild("Ignition"):FireServer()
                        ShinraRemote:WaitForChild("Punch"):FireServer()
                        ShinraRemote:WaitForChild("Fierce"):FireServer()
                        ShinraRemote:WaitForChild("Corna"):FireServer()
                    else
                        task.wait(3.15)
                    end
                end
            end)
            task.wait(0.1)
        end
    end)

    ------------------------------
    -- Handle Deku-specific Logic
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                local deku = Workspace.Living:FindFirstChild("Deku")
                if deku 
                   and not Workspace.Item2:FindFirstChild("OA's Grace")
                   and not lplayer.Backpack:FindFirstChild("OA's Grace")
                   and lplayer.Data and lplayer.Data.StandName and lplayer.Data.StandName.Value == "Shinra Kusakabe" then

                    if lplayer.Character and lplayer.Character:FindFirstChild("Humanoid") and lplayer.Character.Humanoid.Health > 0 
                       and not (deku.CDValues and deku.CDValues:FindFirstChild("Blocking")) then

                        local dekuHumanoid = deku:FindFirstChild("Humanoid")
                        if dekuHumanoid and dekuHumanoid.Health < dekuHumanoid.MaxHealth then
                            task.spawn(function()
                                dekuHumanoid.Health = 0
                            end)
                        end

                        local dekuHRP = deku:FindFirstChild("HumanoidRootPart")
                        if dekuHRP then
                            teleportToPosition(dekuHRP.Position - dekuHRP.CFrame.LookVector * 7)
                        end

                        ShinraRemote:WaitForChild("Ignition"):FireServer()
                        ShinraRemote:WaitForChild("Punch"):FireServer()
                        ShinraRemote:WaitForChild("Fierce"):FireServer()
                        ShinraRemote:WaitForChild("Corna"):FireServer()
                    else
                        task.wait(3.15)
                    end
                end
            end)
            task.wait(0.15)
        end
    end)

    ------------------------------
    -- Teleportation & Stand Switching Logic
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                local deku = Workspace.Living:FindFirstChild("Deku")
                local roland = Workspace.Living:FindFirstChild("Roland")
                local hasOAsGrace = lplayer.Backpack:FindFirstChild("OA's Grace") ~= nil
                local isInCombat = lplayer.PlayerGui.InCombat and lplayer.PlayerGui.InCombat.Enabled
                local currentStand = lplayer.Data and lplayer.Data.StandName and lplayer.Data.StandName.Value
                local oaGracePart = Workspace.Item2:FindFirstChild("OA's Grace")
                local character = lplayer.Character

                if character and character:FindFirstChild("HumanoidRootPart") then
                    if (not deku or roland) and (currentStand == "Shinra Kusakabe" or currentStand == "OA [Stage 3]") and not isInCombat then
                        if oaGracePart then
                            character.HumanoidRootPart.CFrame = oaGracePart.CFrame
                        else
                            teleportToPosition(Vector3.new(-50.88117599487305, -116.3696060180664, 344.53594970703125))
                        end
                    elseif (deku or roland) and not lplayer.Backpack:FindFirstChild("OA's Grace") and not isInCombat and (currentStand == "OA [Stage 3]" or currentStand == "OA [Stage 4]") then
                        teleportToPosition(Vector3.new(-50.88117599487305, -116.3696060180664, 344.53594970703125))
                        switchToStand("Shinra Kusakabe")
                        task.wait(1)
                        teleportToPosition(Vector3.new(-38.94095230102539, -117.37751770019531, 338.93267822265625))
                    end
                end

                --------------------------------------------------
                -- Handle OA's Grace Activation when using OA [Stage 3]
                --------------------------------------------------
                if currentStand == "OA [Stage 3]" then
                    local oasGrace = lplayer.Backpack:FindFirstChild("OA's Grace")
                    if oasGrace then
                        local humanoid = lplayer.Character and lplayer.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            -- Force the character to equip the tool
                            humanoid:EquipTool(oasGrace)
                        else
                            oasGrace.Parent = lplayer.Character
                        end
                        task.wait(1)  -- Wait a moment to ensure the tool is equipped
                        
                        -- Attempt to use the tool via its Activate() method
                        pcall(function()
                            oasGrace:Activate()
                        end)
                        task.wait(0.5)
                        
                        -- Simulate a left-click at the center of the screen
                        local camera = Workspace.CurrentCamera
                        if camera then
                            local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(screenCenter)
                            task.wait(0.1)
                            VirtualUser:Button1Up(screenCenter)
                        end
                        
                        task.wait(1)
                        -- If OA's Grace is still in the character, simulate another click
                        if oasGrace and oasGrace.Parent == lplayer.Character then
                            local camera = Workspace.CurrentCamera
                            if camera then
                                local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                                VirtualUser:Button1Down(screenCenter)
                                task.wait(0.1)
                                VirtualUser:Button1Up(screenCenter)
                            end
                        end
                    end
                end

                --------------------------------------------------
                -- Stand Switching (only one switch per cycle)
                --------------------------------------------------
                if currentStand == "Shinra Kusakabe" then
                    if hasOAsGrace then
                        switchToStand("OA [Stage 3]")
                    elseif (not deku and not roland) then
                        switchToStand("OA [Stage 4]")
                    end
                end
            end)
            task.wait(0.35)
        end
    end)

    ------------------------------
    -- Clear Proximity Prompts
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                fireProximityPrompts(Workspace)
            end)
            task.wait(0.1)
        end
    end)

    ------------------------------
    -- Auto-reset Under Specific Conditions
    ------------------------------
    task.spawn(function()
        while getgenv().AutofarmOnDeku1 do
            pcall(function()
                local dekuAlive = Workspace.Living:FindFirstChild("Deku") ~= nil
                local rolandAlive = Workspace.Living:FindFirstChild("Roland") ~= nil
                local isInCombat = lplayer.PlayerGui.InCombat and lplayer.PlayerGui.InCombat.Enabled
                if not (dekuAlive or rolandAlive) and isInCombat then
                    print("Neither Deku nor Roland is alive and you are in combat. Resetting player...")
                    resetPlayer()
                else
                    print("Conditions for reset not met. Continuing...")
                end
            end)
            task.wait(1)
        end
    end)

    ------------------------------
    -- Periodic Repositioning
    ------------------------------
    while getgenv().AutofarmOnDeku1 do
        pcall(function()
            local deku = Workspace.Living:FindFirstChild("Deku")
            local roland = Workspace.Living:FindFirstChild("Roland")
            if deku or roland then
                if lplayer.Character and lplayer.Character:FindFirstChild("HumanoidRootPart") then
                    lplayer.Character.HumanoidRootPart.CFrame = CFrame.new(
                        -7145.64014, -32.0226326, 1294.72046, 
                        0.264662892, 9.56355328e-10, -0.964340985, 
                        -2.0999007e-08, 1, -4.77144768e-09, 
                        0.964340985, 2.15130278e-08, 0.264662892
                    )
                end
            end
        end)
        task.wait(10)
    end
end



getgenv().UsingDullahanAutofarm1 = function()
    local rs = game:GetService("ReplicatedStorage")
    local players = game:GetService("Players")
    local workspace = game:GetService("Workspace")
    local lplayer = players.LocalPlayer

    task.spawn(function()
        while getgenv().AutofarmOnDullahan1 do
            pcall(function()
                local dullahan = workspace.Living:FindFirstChild("Dullahan")
                if dullahan and lplayer.Data.StandName.Value == "Shinra Kusakabe" then
                    if lplayer.Character.Humanoid.Health ~= 0 then
                        local dullahanHumanoid = dullahan.Humanoid
                        if dullahanHumanoid and dullahanHumanoid.Health ~= dullahanHumanoid.MaxHealth then
                            task.spawn(function()
                                dullahanHumanoid.Health = 0
                            end)
                        end
                        local dullahanBoss = dullahan:FindFirstChild("HumanoidRootPart")
                        teleportToPosition(dullahanBoss.Position - dullahanBoss.CFrame.lookVector * 7)
                        rs:WaitForChild("ShinraRemote"):WaitForChild("Ignition"):FireServer()
                        rs:WaitForChild("ShinraRemote"):WaitForChild("Punch"):FireServer()
                        rs:WaitForChild("ShinraRemote"):WaitForChild("Fierce"):FireServer()
                        rs:WaitForChild("ShinraRemote"):WaitForChild("Corna"):FireServer()
                    else
                        task.wait(3.15)
                    end
                end
            end)
            task.wait(0.15)
        end
    end)

    
end






spawn(function()
    getgenv().BannerRolling();

    getgenv().CidBannerRolling();

    getgenv().KaijuBannerRolling();

    getgenv().OneShotAnyBossAndMob();

    getgenv().AutofarmNearestMob();

    getgenv().EspOnPlayers();

    getgenv().EspOnEntities();

    getgenv().EspOnItems();

    getgenv().EspOnNpcs();

    getgenv().LevelingUp();

    getgenv().SavingUpCash();

    getgenv().Rebirthing();

    getgenv().BreakingThrough();

    getgenv().PublicServerAutofarm();

    getgenv().PrivateServerAutofarm();

    getgenv().SellingAnyItem();

    getgenv().UsingAltFarming();

    getgenv().UsingMainAccountFarming();

    getgenv().UsingDekuAutofarm1();

    getgenv().UsingDullahanAutofarm1();
end)

game:GetService('RunService').Stepped:Connect(function()
    if script_version ~= getgenv().script_version then return end;
end)

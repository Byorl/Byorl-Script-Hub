local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local TemplateCore = {}

function TemplateCore.Setup(scriptName)
    local unloadName = scriptName:gsub("%s+", "") .. "_Unload"
    if getgenv()[unloadName] then
        local oldUnload = getgenv()[unloadName]
        getgenv()[unloadName] = nil
        pcall(oldUnload)
    end

    local SharedState = {
        LocalPlayer = LocalPlayer,
        Connections = {},
        Modules = {}
    }

    local ErrorHandler = {
        SafeCall = function(self, name, func, ...)
            local args = {...}
            return xpcall(function()
                return func(table.unpack(args))
            end, function(err)
                local trace = debug.traceback(tostring(err), 2)
                warn(string.format("[%s] Execution Error [%s]:\n%s", scriptName, tostring(name), trace))
                pcall(function()
                    if MacLib then  
                        MacLib:Notify({
                            Title = "Execution Error",
                            Description = "Check F9 Console",
                            Time = 5
                        })
                    end
                end)
                return err
            end)
        end
    }
    SharedState.ErrorHandler = ErrorHandler

    local ConnectionManager = {
        Tasks = {}
    }
    function ConnectionManager:Add(task, name)
        name = name or ("Task_" .. tostring(#self.Tasks + 1))
        table.insert(self.Tasks, {Name = name, Task = task})
        return task
    end
    function ConnectionManager:Clean()
        for i = #self.Tasks, 1, -1 do
            local item = self.Tasks[i].Task
            if typeof(item) == "RBXScriptConnection" then
                item:Disconnect()
            elseif type(item) == "function" then
                pcall(item)
            elseif type(item) == "table" and type(item.Disconnect) == "function" then
                pcall(function() item:Disconnect() end)
            elseif type(item) == "table" and type(item.Destroy) == "function" then
                pcall(function() item:Destroy() end)
            elseif type(item) == "thread" then
                pcall(function() task.cancel(item) end)
            end
        end
        table.clear(self.Tasks)
    end
    SharedState.ConnectionManager = ConnectionManager

    local function LoadModule(url, fileName)
        local localDevPath = scriptName .. "/modules/" .. fileName .. ".lua"
        local cacheFolder = scriptName .. "/Cache"
        local cachePath = cacheFolder .. "/" .. fileName .. ".lua"

        if not isfolder(scriptName) then makefolder(scriptName) end
        if not isfolder(cacheFolder) then makefolder(cacheFolder) end

        local content = nil

        if isfile and isfile(localDevPath) then
            content = readfile(localDevPath)
        else
            local success, result = pcall(function()
                return game:HttpGet(url .. "?v=" .. tostring(os.time()))
            end)

            if success and result and #result > 0 then
                content = result
                writefile(cachePath, content)
            else
                if isfile and isfile(cachePath) then
                    content = readfile(cachePath)
                end
            end
        end
        
        if not content then return nil end
        
        local moduleFunc, compileErr = loadstring(content)
        if not moduleFunc then
            warn("[" .. fileName .. ".lua] Compile Error:\n" .. tostring(compileErr))
            return nil
        end
        
        local runOk, moduleResult = pcall(moduleFunc)
        if not runOk then
            warn("[" .. fileName .. ".lua] Runtime Error:\n" .. tostring(moduleResult))
            return nil
        end
        
        if type(moduleResult) == "table" then
            SharedState.Modules[fileName] = moduleResult
        end
        
        return moduleResult
    end

    local macLibUrl = "https://raw.githubusercontent.com/Byorl/Byorl-Script-Hub/refs/heads/main/Maclib%20UI.lua"
    local getOk, macLibStr = pcall(function() return game:HttpGet(macLibUrl) end)
    if not getOk then error("[Maclib] Failed to download: " .. tostring(macLibStr)) end
    
    local compileMacLib, macLibErr = loadstring(macLibStr)
    if not compileMacLib then
        error("[Maclib] Compile Error: " .. tostring(macLibErr))
    end
    local MacLib = compileMacLib()
    if not MacLib then
        error("[Maclib] Failed to initialize!")
    end

    local GlobalConfig = {
        Folder = scriptName,
        File = "Global.json",
        Data = { UIScale = 1, UIBlur = false, Notifications = true, UserInfo = false, AutoLoadConfig = "default", UIKeybind = "RightControl" }
    }

    function GlobalConfig:Load()
        local path = self.Folder .. "/" .. self.File
        if not isfolder(self.Folder) then makefolder(self.Folder) end
        if isfile(path) then
            local ok, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(path))
            if ok and type(decoded) == "table" then
                for k, v in pairs(decoded) do
                    self.Data[k] = v
                end
            end
        end
    end

    function GlobalConfig:Save()
        if not isfolder(self.Folder) then makefolder(self.Folder) end
        local ok, encoded = pcall(HttpService.JSONEncode, HttpService, self.Data)
        if ok then
            writefile(self.Folder .. "/" .. self.File, encoded)
        end
    end

    GlobalConfig:Load()

    local function CreateSignal()
        local callbacks = {}
        return {
            Connect = function(self, fn) table.insert(callbacks, fn) end,
            Fire = function(self, ...)
                local args = {...}
                for _, fn in ipairs(callbacks) do
                    task.spawn(function() pcall(fn, table.unpack(args)) end)
                end
            end
        }
    end

    local ConfigManager = {
        Folder = scriptName .. "/Configs",
        Elements = {},
        Flags = {},
        CurrentConfig = "default",
        AutoSave = false,
        _loaded = false,
        _saveTask = nil,
        OnLoad = CreateSignal(),
        OnSave = CreateSignal(),
    }
    SharedState.ConfigManager = ConfigManager

    function ConfigManager:Initialize()
        if not isfolder(scriptName) then makefolder(scriptName) end
        if not isfolder(self.Folder) then makefolder(self.Folder) end
    end

    function ConfigManager:Register(flag, element, type)
        self.Elements[flag] = { Element = element, Type = type }
        self.Flags[flag] = element
    end

    function ConfigManager:Unregister(flag)
        if self.Elements[flag] then
            self.Elements[flag] = nil
        end
        if self.Flags[flag] then
            self.Flags[flag] = nil
        end
    end

    function ConfigManager:GetPath(name)
        return self.Folder .. "/" .. name .. ".json"
    end

    function ConfigManager:Save(name)
        name = name or self.CurrentConfig
        local config = {}
        
        for flag, data in pairs(self.Elements) do
            local val = nil
            if data.Type == "Toggle" then
                val = data.Element.State
            elseif data.Type == "Slider" then
                val = data.Element.Value
            elseif data.Type == "Dropdown" then
                val = data.Element.Value
            elseif data.Type == "Input" then
                val = data.Element.Text
            elseif data.Type == "Colorpicker" then
                local c = data.Element.Color
                if c then
                    val = {c.R, c.G, c.B, data.Element.Alpha or 0}
                end
            elseif data.Type == "MultiSlider" then
                local ok, low, high = pcall(function() return data.Element:GetValue() end)
                if ok and low ~= nil and high ~= nil then
                    val = {low, high}
                elseif type(data.Element.Value) == "table" then
                    val = data.Element.Value
                end
            elseif data.Type == "Stepper" then
                val = data.Element.Value
            elseif data.Type == "Keybind" then
                local ok, b = pcall(function() return data.Element:GetBind() end)
                if ok and b and typeof(b) == "EnumItem" then
                    val = b.Name
                end
            end
            if val ~= nil then
                config[flag] = val
            end
        end
        
        local success, encoded = pcall(HttpService.JSONEncode, HttpService, config)
        if success then
            local mainPath = self:GetPath(name)
            local tmpPath = mainPath .. ".tmp"
            
            local writeSuccess = pcall(function()
                writefile(tmpPath, encoded)
                if isfile(tmpPath) then
                    local readBack = readfile(tmpPath)
                    if readBack and #readBack > 0 then
                        writefile(mainPath, encoded)
                        delfile(tmpPath)
                    end
                end
            end)
            
            if writeSuccess then
                self.OnSave:Fire(name)
            end
        end
    end

    function ConfigManager:Load(name)
        local path = self:GetPath(name)
        if not isfile(path) then
            self.CurrentConfig = name
            self._loaded = true
            self.OnLoad:Fire(name)
            return
        end
        
        local success, config = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        
        if not success then return end
        
        self.CurrentConfig = name
        self._loaded = false
        self.AutoSave = false
        
        for flag, value in pairs(config) do
            local data = self.Elements[flag]
            if data then
                pcall(function()
                    if data.Type == "Toggle" then
                        data.Element:UpdateState(value)
                    elseif data.Type == "Slider" then
                        data.Element:UpdateValue(value)
                    elseif data.Type == "Dropdown" then
                        local isMulti = data.Element.Settings and data.Element.Settings.Multi
                        if isMulti and type(value) ~= "table" then
                            value = {value}
                        elseif not isMulti and type(value) == "table" then
                            value = value[1]
                        end
                        data.Element:UpdateSelection(value)
                    elseif data.Type == "Input" then
                        data.Element:UpdateText(value)
                    elseif data.Type == "Colorpicker" then
                        if type(value) == "table" then
                            data.Element:SetColor(Color3.new(value[1], value[2], value[3]))
                            data.Element:SetAlpha(value[4] or 0)
                        end
                    elseif data.Type == "MultiSlider" then
                        if type(value) == "table" then
                            pcall(function() data.Element:SetValues(value[1] or 0, value[2] or 0) end)
                        end
                    elseif data.Type == "Stepper" then
                        pcall(function() data.Element:SetValue(value) end)
                    elseif data.Type == "Keybind" then
                        local ok, enum = pcall(function() return Enum.KeyCode[value] end)
                        if ok and enum then data.Element:Bind(enum) end
                    end
                end)
            end
        end

        self._loaded = true
        self.OnLoad:Fire(name)
    end

    function ConfigManager:Delete(name)
        local path = self:GetPath(name)
        if isfile(path) then
            delfile(path)
        end
    end

    function ConfigManager:GetConfigs()
        local configs = {}
        if isfolder(self.Folder) then
            for _, file in ipairs(listfiles(self.Folder)) do
                if file:sub(-5) == ".json" then
                    local name = file:match("([^/\\]+)%.json$")
                    if name then
                        table.insert(configs, name)
                    end
                end
            end
        end
        table.sort(configs)
        return configs
    end

    function ConfigManager:Export(configname)
        local config = { __CONFIG_NAME = configname or self.CurrentConfig }
        for flag, data in pairs(self.Elements) do
            local val = nil
            if data.Type == "Toggle" then
                val = data.Element.State
            elseif data.Type == "Slider" then
                val = data.Element.Value
            elseif data.Type == "Dropdown" then
                val = data.Element.Value
            elseif data.Type == "Input" then
                val = data.Element.Text
            elseif data.Type == "Colorpicker" then
                local c = data.Element.Color
                if c then val = {c.R, c.G, c.B, data.Element.Alpha or 0} end
            elseif data.Type == "MultiSlider" then
                local ok, low, high = pcall(function() return data.Element:GetValue() end)
                if ok and low ~= nil and high ~= nil then
                    val = {low, high}
                elseif type(data.Element.Value) == "table" then
                    val = data.Element.Value
                end
            elseif data.Type == "Stepper" or data.Type == "RadioGroup" then
                val = data.Element.Value
            elseif data.Type == "Keybind" then
                local ok, b = pcall(function() return data.Element:GetBind() end)
                if ok and b and typeof(b) == "EnumItem" then val = b.Name end
            end
            if val ~= nil then config[flag] = val end
        end
        return HttpService:JSONEncode(config)
    end

    function ConfigManager:Import(json)
        local success, config = pcall(function()
            return HttpService:JSONDecode(json)
        end)
        if not success or type(config) ~= "table" then return false, "Invalid JSON" end
        for flag, value in pairs(config) do
            local data = self.Elements[flag]
            if data then
                pcall(function()
                    if data.Type == "Toggle" then
                        data.Element:UpdateState(value)
                    elseif data.Type == "Slider" then
                        data.Element:UpdateValue(value)
                    elseif data.Type == "Dropdown" then
                        local isMulti = data.Element.Settings and data.Element.Settings.Multi
                        if isMulti and type(value) ~= "table" then
                            value = {value}
                        elseif not isMulti and type(value) == "table" then
                            value = value[1]
                        end
                        data.Element:UpdateSelection(value)
                    elseif data.Type == "Input" then
                        data.Element:UpdateText(value)
                    elseif data.Type == "Colorpicker" then
                        if type(value) == "table" then
                            data.Element:SetColor(Color3.new(value[1], value[2], value[3]))
                            data.Element:SetAlpha(value[4] or 0)
                        end
                    elseif data.Type == "MultiSlider" then
                        if type(value) == "table" then
                            pcall(function() data.Element:SetValues(value[1] or 0, value[2] or 0) end)
                        end
                    elseif data.Type == "Stepper" or data.Type == "RadioGroup" then
                        pcall(function() data.Element:SetValue(value) end)
                    elseif data.Type == "Keybind" then
                        local ok, enum = pcall(function() return Enum.KeyCode[value] end)
                        if ok and enum then data.Element:Bind(enum) end
                    end
                end)
            end
        end
        self.OnLoad:Fire("imported")
        return true
    end

    function ConfigManager:TriggerAutoSave()
        if self.AutoSave and self._loaded then
            if self._saveTask then
                pcall(function() task.cancel(self._saveTask) end)
                self._saveTask = nil
            end
            self._saveTask = task.delay(0.5, function()
                self._saveTask = nil
                if self.AutoSave and self._loaded then
                    self:Save(self.CurrentConfig)
                end
            end)
        end
    end

    local UI = {}

    function UI.WrapCallback(callback)
        return function(...)
            if callback then
                pcall(callback, ...)
            end
            ConfigManager:TriggerAutoSave()
        end
    end

    function UI.Toggle(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Toggle(options, flag)
        if flag then ConfigManager:Register(flag, element, "Toggle") end
        return element
    end

    function UI.Slider(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Slider(options, flag)
        if flag then ConfigManager:Register(flag, element, "Slider") end
        return element
    end

    function UI.Dropdown(section, options, flag)
        if options.Search == nil then options.Search = true end
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Dropdown(options, flag)
        if flag then ConfigManager:Register(flag, element, "Dropdown") end
        return element
    end

    function UI.Input(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Input(options, flag)
        if flag then ConfigManager:Register(flag, element, "Input") end
        return element
    end

    function UI.Colorpicker(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Colorpicker(options, flag)
        if flag then ConfigManager:Register(flag, element, "Colorpicker") end
        return element
    end

    function UI.Keybind(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Keybind(options, flag)
        if flag then ConfigManager:Register(flag, element, "Keybind") end
        return element
    end

    function UI.MultiSlider(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:MultiSlider(options, flag)
        if flag then ConfigManager:Register(flag, element, "MultiSlider") end
        return element
    end

    function UI.Stepper(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:Stepper(options, flag)
        if flag then ConfigManager:Register(flag, element, "Stepper") end
        return element
    end

    function UI.RadioGroup(section, options, flag)
        options.Callback = UI.WrapCallback(options.Callback)
        local element = section:RadioGroup(options, flag)
        if flag then ConfigManager:Register(flag, element, "RadioGroup") end
        return element
    end

    function UI.ProgressBar(section, options, flag)
        return section:ProgressBar(options, flag)
    end

    function UI.Label(section, options, flag)
        local element = section:Label(options, flag)
        return element
    end

    function UI.SubLabel(section, options, flag)
        local element = section:SubLabel(options, flag)
        return element
    end

    function UI.Paragraph(section, options, flag)
        local element = section:Paragraph(options, flag)
        return element
    end

    function UI.Divider(section, settings)
        return section:Divider(settings)
    end

    function UI.Spacer(section)
        return section:Spacer()
    end

    local Window = MacLib:Window({
        Title = scriptName,
        Subtitle = "Template",
        Size = UDim2.fromOffset(868, 650),
        AutoAdjustSize = true,
        DragStyle = 1,
        DisabledWindowControls = {},
        ShowUserInfo = GlobalConfig.Data.UserInfo,
        Keybind = Enum.KeyCode.RightControl,
        AcrylicBlur = GlobalConfig.Data.UIBlur,
    })

    Window:SetScale(GlobalConfig.Data.UIScale)

    do
        local keyName = GlobalConfig.Data.UIKeybind
        if keyName then
            local ok, key = pcall(function() return Enum.KeyCode[keyName] end)
            if ok and key then Window:SetKeybind(key) end
        end
    end

    Window:GlobalSetting({
        Name = "UI Blur",
        Default = GlobalConfig.Data.UIBlur,
        Callback = function(state)
            Window:SetAcrylicBlurState(state)
            GlobalConfig.Data.UIBlur = state
            GlobalConfig:Save()
        end
    })

    Window:GlobalSetting({
        Name = "Notifications",
        Default = GlobalConfig.Data.Notifications,
        Callback = function(state)
            Window:SetNotificationsState(state)
            GlobalConfig.Data.Notifications = state
            GlobalConfig:Save()
        end
    })

    Window:GlobalSetting({
        Name = "Show User Info",
        Default = GlobalConfig.Data.UserInfo,
        Callback = function(state)
            Window:SetUserInfoState(state)
            GlobalConfig.Data.UserInfo = state
            GlobalConfig:Save()
        end
    })

    local function Unload()
        for _, module in pairs(SharedState.Modules) do
            if type(module) == "table" and module.Cleanup then
                pcall(module.Cleanup)
            end
        end
        for _, conn in ipairs(SharedState.Connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
        table.clear(SharedState.Connections)
        
        -- Enhanced Cleanup
        ConnectionManager:Clean()

        if Window then
            pcall(function() Window:SetState(false) end)
            Window:Unload()
        end
        getgenv()[unloadName] = nil
    end
    
    function ConfigManager:BuildSettingsTab(SettingsTab, options)
        options = options or {}
        local SettingsLeft = SettingsTab:Section({ Side = "Left" })
        local SettingsRight = SettingsTab:Section({ Side = "Right" })

        local ConfigDropdown
        local ActiveConfigLabel
        local pendingDelete = nil
        local pendingDeleteTask = nil

        local function SetActiveConfigLabel(name)
            if ActiveConfigLabel then
                local label = name or (type(self.CurrentConfig) == "string" and self.CurrentConfig) or "default"
                ActiveConfigLabel:UpdateName("Active: " .. label)
            end
        end

        local function RefreshConfigs()
            if ConfigDropdown then
                pendingDelete = nil
                if pendingDeleteTask then pcall(function() task.cancel(pendingDeleteTask) end) end
                pendingDeleteTask = nil
                local configs = self:GetConfigs()
                if #configs == 0 then configs = {"default"} end
                ConfigDropdown:ClearOptions()
                ConfigDropdown:InsertOptions(configs)
                local current = (type(self.CurrentConfig) == "string" and self.CurrentConfig) or "default"
                local foundCurrent = false
                for _, v in ipairs(configs) do if v == current then foundCurrent = true break end end
                if not foundCurrent then current = "default"; self.CurrentConfig = "default" end
                ConfigDropdown:UpdateSelection(current)
            end
        end

        SettingsLeft:Header({ Text = "Configuration" })
        ActiveConfigLabel = SettingsLeft:SubLabel({ Text = "Active: default" })

        local function SanitiseConfigName(raw)
            local s = (raw or ""):gsub("[^%w%s%-%_]", "")
            return s:match("^%s*(.-)%s*$")
        end

        local ConfigNameInput = UI.Input(SettingsLeft, {
            Name = "Config Name",
            Placeholder = "Enter config name...",
            AcceptedCharacters = "All",
            Callback = function() end
        })

        ConfigDropdown = UI.Dropdown(SettingsLeft, {
            Name = "Select Config",
            Options = {"default"},
            Default = GlobalConfig.Data.AutoLoadConfig or "default",
            Callback = function(value)
                pendingDelete = nil
                if pendingDeleteTask then task.cancel(pendingDeleteTask) end
                pendingDeleteTask = nil
                self.CurrentConfig = value
            end
        })

        RefreshConfigs()

        SettingsLeft:Button({
            Name = "Create Config",
            Callback = function()
                local name = SanitiseConfigName(ConfigNameInput.Value or ConfigNameInput.Text)
                if name and name ~= "" then
                    if #name > 32 then
                        Window:Notify({ Title = "Name Too Long", Description = "Config names must be 32 characters or fewer.", Lifetime = 3 })
                        return
                    end
                    if isfile(self:GetPath(name)) then
                        Window:Notify({ Title = "Already Exists", Description = "\"" .. name .. "\" already exists. Use Save Config to overwrite.", Lifetime = 3 })
                        return
                    end
                    self:Save(name)
                    RefreshConfigs()
                    ConfigDropdown:UpdateSelection(name)
                    self.CurrentConfig = name
                    SetActiveConfigLabel(name)
                    Window:Notify({ Title = "Config Created", Description = "Created: " .. name, Lifetime = 3 })
                end
            end
        })

        SettingsLeft:Button({
            Name = "Save Config",
            Callback = function()
                local name = ConfigDropdown.Value or self.CurrentConfig or "default"
                if name and name ~= "" then
                    self:Save(name)
                    SetActiveConfigLabel(name)
                    Window:Notify({ Title = "Config Saved", Description = "Saved: " .. name, Lifetime = 3 })
                end
            end
        })

        SettingsLeft:Button({
            Name = "Load Config",
            Callback = function()
                local name = ConfigDropdown.Value or self.CurrentConfig or "default"
                if name and name ~= "" then
                    local notif = Window:Notify({ Title = "Loading Config", Description = "Loading: " .. name, Lifetime = 10, Progress = true })
                    if notif then notif:SetProgress(0.6) end
                    self:Load(name)
                    ConfigDropdown:UpdateSelection(name)
                    SetActiveConfigLabel(name)
                    if notif then notif:Cancel() end
                    Window:Notify({ Title = "Config Loaded", Description = "Loaded: " .. name, Lifetime = 3 })
                end
            end
        })

        SettingsLeft:Button({
            Name = "Set as Auto Load",
            Callback = function()
                local name = ConfigDropdown.Value or self.CurrentConfig or "default"
                if name and name ~= "" then
                    GlobalConfig.Data.AutoLoadConfig = name
                    GlobalConfig:Save()
                    Window:Notify({ Title = "Auto Load Set", Description = "\"" .. name .. "\" will auto-load on startup", Lifetime = 3 })
                end
            end
        })

        SettingsLeft:Button({
            Name = "Delete Config",
            Callback = function()
                local name = ConfigDropdown.Value or self.CurrentConfig or "default"
                if name and name ~= "" and name ~= "default" then
                    if pendingDelete == name then
                        if pendingDeleteTask then task.cancel(pendingDeleteTask) end
                        pendingDelete = nil
                        pendingDeleteTask = nil
                        self:Delete(name)
                        RefreshConfigs()
                        ConfigDropdown:UpdateSelection("default")
                        self.CurrentConfig = "default"
                        SetActiveConfigLabel("default")
                        Window:Notify({ Title = "Config Deleted", Description = "Deleted: " .. name, Lifetime = 3 })
                    else
                        pendingDelete = name
                        if pendingDeleteTask then task.cancel(pendingDeleteTask) end
                        pendingDeleteTask = task.delay(5, function() pendingDelete = nil; pendingDeleteTask = nil end)
                        Window:Notify({ Title = "Confirm Delete", Description = "Click Delete Config again to confirm deleting \"" .. name .. "\"", Lifetime = 5 })
                    end
                end
            end
        })

        SettingsLeft:Divider()

        SettingsLeft:Button({
            Name = "Copy Config",
            Callback = function()
                local name = ConfigDropdown.Value or self.CurrentConfig or "default"
                if name and name ~= "" then
                    local path = self:GetPath(name)
                    if isfile(path) then
                        local ok = pcall(setclipboard, readfile(path))
                        if ok then
                            Window:Notify({ Title = "Copied", Description = "\"" .. name .. "\" copied to clipboard", Lifetime = 3 })
                        else
                            Window:Notify({ Title = "Copy Failed", Description = "setclipboard is not supported", Lifetime = 3 })
                        end
                    else
                        Window:Notify({ Title = "Not Saved", Description = "Save the config first before copying", Lifetime = 3 })
                    end
                end
            end
        })

        SettingsLeft:Button({
            Name = "Paste Config",
            Callback = function()
                  local ok, content = pcall(getclipboard)
                  if not ok or type(content) ~= "string" or content == "" then
                      Window:Notify({ Title = "Paste Failed", Description = "Nothing valid in clipboard", Lifetime = 3 })
                      return
                  end
                  if #content > 102400 then
                      Window:Notify({ Title = "Paste Failed", Description = "Config data exceeds 100 KB limit", Lifetime = 3 })
                      return
                  end
                  local valid, decoded = pcall(function() return HttpService:JSONDecode(content) end)
                  if not valid or type(decoded) ~= "table" then
                      Window:Notify({ Title = "Invalid Config", Description = "Clipboard doesn't contain valid config JSON", Lifetime = 3 })
                      return
                  end
                  local embeddedName = type(decoded.__CONFIG_NAME) == "string" and decoded.__CONFIG_NAME:match("^%s*(.-)%s*$") or ""
                  local name = (embeddedName ~= "" and embeddedName) or ConfigDropdown.Value or self.CurrentConfig or "default"
                  writefile(self:GetPath(name), content)
                  self:Load(name)
                  SetActiveConfigLabel(name)
                  RefreshConfigs()
                  Window:Notify({ Title = "Config Pasted", Description = "Loaded \"" .. name .. "\" from clipboard", Lifetime = 3, Type = "Success" })
            end
        })

        SettingsRight:Header({ Text = "System" })

        local UIScaleMap = { ["50%"]=0.5, ["75%"]=0.75, ["100%"]=1, ["125%"]=1.25, ["150%"]=1.5, ["175%"]=1.75, ["200%"]=2 }
        local function scaleToOption(s)
            for label, val in pairs(UIScaleMap) do
                if math.abs(val - s) < 0.01 then return label end
            end
            return "100%"
        end

        UI.Dropdown(SettingsRight, {
            Name = "UI Scale",
            Options = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
            Default = scaleToOption(GlobalConfig.Data.UIScale or 1),
            Callback = function(value)
                local scale = UIScaleMap[value] or 1
                Window:SetScale(scale)
                GlobalConfig.Data.UIScale = scale
                GlobalConfig:Save()
            end
        })

        UI.Keybind(SettingsRight, {
            Name = "Toggle UI Keybind",
            Default = (function()
                local ok, key = pcall(function() return Enum.KeyCode[GlobalConfig.Data.UIKeybind or "RightControl"] end)
                return (ok and key) or Enum.KeyCode.RightControl
            end)(),
            Callback = function(key)
                if options.OnUIKeybindChanged then options.OnUIKeybindChanged(key) end
                Window:SetKeybind(key)
                GlobalConfig.Data.UIKeybind = key.Name
                GlobalConfig:Save()
            end
        }, "UIKeybind")

        SettingsRight:Divider()

        UI.Toggle(SettingsRight, {
            Name = "Auto Save Configs",
            Default = self.AutoSave,
            Callback = function(state)
                self.AutoSave = state
            end
        }, "AutoSaveConfigs")

        if options.MobileButtonCallback then
            UI.Toggle(SettingsRight, {
                Name = "Mobile UI Button",
                Default = true,
                Callback = options.MobileButtonCallback
            }, "MobileUIButton")
        end

        SettingsRight:Divider()

        SettingsRight:Button({
            Name = "Clear Notifications",
            Callback = function()
                Window:ClearNotifications()
            end
        })

        SettingsRight:Button({
            Name = "Unload Script",
            Callback = options.UnloadCallback or Unload
        })

        return {
            SetActiveConfigLabel = SetActiveConfigLabel,
            RefreshConfigs = RefreshConfigs
        }
    end

    getgenv()[unloadName] = Unload

    return {
        Window = Window,
        ConfigManager = ConfigManager,
        UI = UI,
        SharedState = SharedState,
        GlobalConfig = GlobalConfig,
        LoadModule = LoadModule,
        Unload = Unload
    }
end

return TemplateCore

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SlimesConfig = require(ReplicatedStorage.Shared.Config.Slimes)

local SlimeService = {}

-- Konstante za praćenje i izgled
local FOLLOW_OFFSET = Vector3.new(3, 0, 3) -- Pomeraj u odnosu na igrača (desno i nazad)
local LERP_SPEED = 10 -- Brzina interpolacije kretanja slime-a

local activeSlimes = {} -- [player] = { part = Part, data = table }
local folder = nil
local heartbeatConnection = nil

local function getOrCreateFolder()
	if not folder then
		folder = Workspace:FindFirstChild("PlayerSlimes")
		if not folder then
			folder = Instance.new("Folder")
			folder.Name = "PlayerSlimes"
			folder.Parent = Workspace
		end
	end
	return folder
end

local function createSlimeForPlayer(player)
	if activeSlimes[player] then return end

	local slimeConfig = SlimesConfig.BasicSlime
	
	-- TODO: Zameniti privremeni Part sa pravim modelom slime-a u kasnijim fazama
	local part = Instance.new("Part")
	part.Name = player.Name .. "_Slime"
	part.Shape = Enum.PartType.Ball
	part.Size = Vector3.new(3, 3, 3)
	part.Color = Color3.fromRGB(0, 255, 128) -- Zelena sfera
	part.Anchored = true
	part.CanCollide = false
	part.Parent = getOrCreateFolder()

	activeSlimes[player] = {
		part = part,
		data = {
			config = slimeConfig,
			hp = slimeConfig.MaxHealth
		}
	}
end

local function removeSlimeForPlayer(player)
	local record = activeSlimes[player]
	if record then
		if record.part then
			record.part:Destroy()
		end
		activeSlimes[player] = nil
	end
end

function SlimeService:Init()
	getOrCreateFolder()

	-- Obrada igrača koji su već u igri
	for _, player in ipairs(Players:GetPlayers()) do
		createSlimeForPlayer(player)
	end

	-- Praćenje dolaska i odlaska igrača
	Players.PlayerAdded:Connect(function(player)
		createSlimeForPlayer(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		removeSlimeForPlayer(player)
	end)

	-- Jedinstvena Heartbeat petlja za sve slimeove
	heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
		for player, record in pairs(activeSlimes) do
			local character = player.Character
			if character then
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
				if humanoidRootPart and record.part and record.part.Parent then
					local targetCFrame = humanoidRootPart.CFrame * CFrame.new(FOLLOW_OFFSET)
					local currentCFrame = record.part.CFrame
					
					-- Glatko praćenje igrača pomoću Lerp-a
					record.part.CFrame = currentCFrame:Lerp(targetCFrame, math.clamp(dt * LERP_SPEED, 0, 1))
				end
			end
		end
	end)
end

return SlimeService

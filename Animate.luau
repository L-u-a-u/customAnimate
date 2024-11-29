function waitForChild(parent, childName)
	local child = parent:findFirstChild(childName)
	if child then return child end
	while true do
		child = parent.ChildAdded:wait()
		if child.Name==childName then return child end
	end
end

-- ANIMATION

-- declarations
local waittime = 1/12 -- set this to nil or 0 for smooth anims
local transition = 0.1
transition *= 10
local Figure = script.Parent
local Torso = waitForChild(Figure, "Torso")
local Root = Figure.HumanoidRootPart.RootJoint
local RightShoulder = waitForChild(Torso, "Right Shoulder")
local LeftShoulder = waitForChild(Torso, "Left Shoulder")
local RightHip = waitForChild(Torso, "Right Hip")
local LeftHip = waitForChild(Torso, "Left Hip")
local Neck = waitForChild(Torso, "Neck")
local Humanoid = waitForChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0
local isCrouch = true

-- functions
local speedy = 0
function onRunning(speed)
	speedy = speed
	if speed>0 then
		pose = "Running"
	else
		pose = "Standing"
	end
end

function onDied()
	pose = "Dead"
end

function onJumping()
	pose = "Jumping"
end

function onClimbing()
	pose = "Climbing"
end

function onGettingUp()
	pose = "GettingUp"
end

function onFreeFall()
	pose = "FreeFall"
end

function onFallingDown()
	pose = "FallingDown"
end

function onSeated()
	pose = "Seated"
end

function onPlatformStanding()
	pose = "PlatformStanding"
end
RightHip.MaxVelocity = transition -- 0.5
LeftHip.MaxVelocity = transition -- 0.5

function moveJump()
	--RightShoulder.MaxVelocity = transition -- 0.5
	--LeftShoulder.MaxVelocity = transition -- 0.5
	--RightShoulder.DesiredAngle = math.pi/2
	--LeftShoulder.DesiredAngle = -math.pi/2
	--RightHip.DesiredAngle = 0
	--LeftHip.DesiredAngle = 0
end


-- same as jump for now

function moveFreeFall()
	RightShoulder.MaxVelocity = transition -- 0.5
	LeftShoulder.MaxVelocity = transition -- 0.5
	RightShoulder.DesiredAngle = math.pi
	LeftShoulder.DesiredAngle = -math.pi
	RightHip.DesiredAngle = 0
	LeftHip.DesiredAngle = 0
end

function moveSit()
	RightShoulder.MaxVelocity = transition -- 0.15
	LeftShoulder.MaxVelocity = transition -- 0.15
	RightShoulder.DesiredAngle = math.pi /2
	LeftShoulder.DesiredAngle = -math.pi /2
	RightHip.DesiredAngle = math.pi /2
	LeftHip.DesiredAngle = -math.pi /2
end

function getTool()	
	for _, kid in ipairs(Figure:GetChildren()) do
		if kid.className == "Tool" then return kid end
	end
	return nil
end

function getToolAnim(tool)
	for _, c in ipairs(tool:GetChildren()) do
		if c.Name == "toolanim" and c.className == "StringValue" then
			return c
		end
	end
	return nil
end

function animateTool()

	if (toolAnim == "None") then
		RightShoulder.DesiredAngle = 1.57
		return
	end

	if (toolAnim == "Slash") then
		RightShoulder.MaxVelocity = transition -- 0.5
		RightShoulder.DesiredAngle = 0
		return
	end

	if (toolAnim == "Lunge") then
		RightShoulder.MaxVelocity = transition -- 0.5
		LeftShoulder.MaxVelocity = transition -- 0.5
		RightHip.MaxVelocity = transition -- 0.5
		LeftHip.MaxVelocity = transition -- 0.5
		RightShoulder.DesiredAngle = 1.57
		LeftShoulder.DesiredAngle = 1.0
		RightHip.DesiredAngle = 1.57
		LeftHip.DesiredAngle = 1.0
		return
	end
end
local even = false
local currrot = 0
local stime = 0
local ltick = tick()
function move(time)
	local amplitude
	local frequency

	if (pose == "Jumping") then
		moveJump()
		return
	end

	if (pose == "FreeFall") then
		--moveFreeFall()
		RightShoulder.MaxVelocity = transition -- 0.5
		LeftShoulder.MaxVelocity = transition -- 0.5
		RightShoulder.DesiredAngle = ((RightShoulder.DesiredAngle+(math.pi*2)) * 0.3) + (0.1 * math.sin(time*2))
		LeftShoulder.DesiredAngle = (-(RightShoulder.DesiredAngle+(math.pi*2)) * 0.3) + (0.1 * math.sin(time*2))
		RightHip.DesiredAngle = -(0.2 * math.sin(time*2))
		LeftHip.DesiredAngle = -(0.2 * math.sin(time*2))
		RightHip.C0 = CFrame.new(1, -1, 0) * CFrame.Angles(0, math.rad(87), 0)
		LeftHip.C0 = CFrame.new(-1, -1, 0) * CFrame.Angles(0, math.rad(-87), 0)
		return
	end
	local rad = math.rad
	if (pose == "Seated") then
		RightShoulder.MaxVelocity = transition -- 0.15
		LeftShoulder.MaxVelocity = transition -- 0.15
		RightShoulder.DesiredAngle = math.pi /2
		LeftShoulder.DesiredAngle = -math.pi /2
		RightHip.DesiredAngle = math.pi /2
		LeftHip.DesiredAngle = -math.pi /2
		RightShoulder.C0 = CFrame.new(1, 0.5, 0, -0.219846368, 0.604022801, 0.766044438, -0.262002647, 0.719846308, -0.642787635, -0.939692616, -0.342020184, -3.34848664e-08) -- CFrame.new(1, 0.5, 0) * CFrame.Angles(rad(40), rad(90), rad(-20))
		LeftShoulder.C0 = CFrame.new(-1, 0.5, 0, -0.219846368, -0.604022801, -0.766044438, 0.262002647, 0.719846308, -0.642787635, 0.939692616, -0.342020184, -3.34848664e-08) --CFrame.new(-1, 0.5, 0) * CFrame.Angles(rad(40), rad(-90), rad(20))
		return
	else
		RightShoulder.C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, rad(90), 0)
		LeftShoulder.C0 = CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, rad(-90), 0)
	end

	local climbFudge = 0
	local stand = false
	if (pose == "Running") then
		RightShoulder.MaxVelocity = transition -- 0.15
		LeftShoulder.MaxVelocity = transition -- 0.15
		amplitude = 1
		frequency = 9
		stime = 0
	elseif (pose == "Climbing") then
		RightShoulder.MaxVelocity = transition -- 0.5 
		LeftShoulder.MaxVelocity = transition -- 0.5
		amplitude = 1
		frequency = 9
		climbFudge = math.pi
		stime = 0
	elseif pose == "Dead" then
		RightShoulder.MaxVelocity = transition -- 0.5 
		LeftShoulder.MaxVelocity = transition -- 0.5
		amplitude = 1
		frequency = 9
		climbFudge = time * 4
		stime = 0
	else
		amplitude = 0.05
		frequency = 2
		stand = true
		stime += time-ltick
	end
	ltick = time
	local desiredAngle = amplitude * math.sin(time*frequency)

	RightShoulder.DesiredAngle = (desiredAngle/1.5) + climbFudge
	LeftShoulder.DesiredAngle = (desiredAngle/1.5) - climbFudge
	RightHip.DesiredAngle = (-desiredAngle) + if isCrouch then -0.8 else 0 --1, -0.31, -1
	LeftHip.DesiredAngle = -desiredAngle + if isCrouch then 0.8 else 0 
	local val = -math.clamp(math.abs(desiredAngle)*1.2, 0.65, 1.3) - 0.2
	if stand then
		val = -(math.sin(time)/10) + -1  ---1
	else
		--currrot += 1
		--if currrot > 7 then
		--	currrot = 7
		--end
		--Root.C0 = CFrame.Angles(rad(-7), 0, 0)
	end
	--print(val)
	RightHip.C0 = CFrame.new(1, val + if isCrouch then 0.4 else 0, -math.abs(desiredAngle/6) + if isCrouch then -0.7 else 0) * CFrame.Angles(0, rad(87), 0)
	LeftHip.C0 = CFrame.new(-1, val + if isCrouch then 0.4 else 0, -math.abs(desiredAngle/6) + if isCrouch then -0.7 else 0) * CFrame.Angles(0, rad(-87), 0)
	RightShoulder.C0 = CFrame.new(1, (val/1.6) + 1.125, 0) * CFrame.Angles(0, rad(if getTool() then 90 else 80), 0)
	LeftShoulder.C0 = CFrame.new(-1, (val/1.6) + 1.125, 0) * CFrame.Angles(0, rad(-80), 0)
	currrot = math.clamp(currrot+if stand then -2.4 else 2.4, 0, 7)
	if pose == "Dead" then
		currrot = -90
	elseif isCrouch == true then
		currrot += 20
	end
	Root.C0 = CFrame.new(0, ((val/2)+0.55) + if isCrouch then -1.17 else 0, 0) * CFrame.Angles(rad(-currrot), 0, 0)
	if stime >= 15 then
		task.spawn(function()
			stime = 0
			Neck.MaxVelocity = 0.1
			Neck.DesiredAngle = math.rad(30)
			task.wait(1)
			Neck.DesiredAngle = math.rad(-30)
			task.wait(1)
			Neck.DesiredAngle = 0
			stime = 0
		end)
	else
		--Neck.MaxVelocity = transition
		--Neck.DesiredAngle = 0
	end

	local tool = getTool()

	if tool then

		local animStringValueObject = getToolAnim(tool)

		if animStringValueObject then
			toolAnim = animStringValueObject.Value
			-- message recieved, delete StringValue
			animStringValueObject.Parent = nil
			toolAnimTime = time + .17
		end

		if time > toolAnimTime then
			toolAnimTime = 0
			toolAnim = "None"
		end

		animateTool()


	else
		toolAnim = "None"
		toolAnimTime = 0
	end
end


-- connect events

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping) --onJumping
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.PlatformStanding:connect(onPlatformStanding)

-- main program

local runService = game:service("RunService");
local time = 0
while Figure.Parent~=nil do
	if Humanoid.Sit then
		onSeated()
	end
	isCrouch = script:GetAttribute("CROUCH")
	--print("help")
	--local velo = 2
	--local tor = Figure.Torso
	--velo = (math.abs(tor.Velocity.X) + math.abs(tor.Velocity.Z)) -- - 6.55
	--print(velo)
	local wow = Figure.Torso.Velocity
	local speedy = Vector3.new(wow.X, 0, wow.Z).Magnitude
	if pose ~= "Running" then speedy = 15 end
	time += task.wait(waittime)*(0.0666666666666667*speedy)
	--print(time)
	move(time)
end

-- Add this under "pluginList = {}"
playerCells = {}


-- Should be under LoadPluginList()
function LoadPlayerCells()
	playerCells = jsonInterface.load("playerCells.json")
	
	if playerCells == nil then
		playerCells.cells = {}
	end
end

-- Code in server.lua
function OnServerInit()

    local version = tes3mp.GetServerVersion():split(".") -- for future versions

    if tes3mp.GetServerVersion() ~= "0.6.1" then
        tes3mp.LogMessage(3, "The server or script is outdated!")
        tes3mp.StopServer(1)
    end

    myMod.InitializeWorld()
    myMod.PushPlayerList(Players)

    LoadBanList()
    LoadPluginList()
	  LoadPlayerCells() --Add function here.
end



-- Add this on the "OnMessage" command block
elseif cmd[1] == "registerCell" and moderator then
			if myMod.CheckPlayerValidity(pid, cmd[2]) then
				local targetpid = tonumber(cmd[2])
				local playerName = Players[targetpid].name
				local cellName = tes3mp.GetCell(targetpid)
			
				if playerCells[cellName] == nil then
					local cell = {}
					cell.owner = playerName
					cell.members = {}
					
					playerCells.cells[cellName] = cell
					
					 jsonInterface.save("playercells.json", playerCells)
					
				else
					tes3mp.SendMessage(pid, "The chosen cell is already taken. \n", false)
				end
			end
		
		elseif cmd[1] == "lock" or cmd[1] == "unlock" then
			local cellName = tes3mp.GetCell(pid)
			local name = Players[pid].name
			
			if playerCells.cells[cellName] ~= nil and playerCells.cells[cellName].owner == name then
				if cmd[1] == "lock" then
					playerCells.cells[cellName].locked = 1;
					tes3mp.SendMessage(pid, "Cell locked. \n", false)
				elseif cmd[1] == "unlock" then
					playerCells.cells[cellName].locked = 0;
					tes3mp.SendMessage(pid, "Cell unlocked. \n", false)
				end
				jsonInterface.save("playercells.json", playerCells)
			else
				tes3mp.SendMessage(pid, "You do not own this cell. \n", false)
			end
		
		elseif cmd[1] == "addCellMember" then
			if myMod.CheckPlayerValidity(pid, cmd[2]) then
				local targetpid = tonumber(cmd[2])
				
				local name = Players[pid].name
				local targetName = Players[targetpid].name
				local cellName = tes3mp.GetCell(pid)
				if playerCells.cells[cellName] ~= nil and playerCells.cells[cellName].owner == name then
					if tableHelper.containsValue(playerCells.cells[cellName].members, targetName) == false then
						table.insert(playerCells.cells[cellName].members, targetName)
						jsonInterface.save("playercells.json", playerCells)
						tes3mp.SendMessage(pid, "Player added. \n", false)
					else
						tes3mp.SendMessage(pid, "User is already a member. \n", false)
					end
					
				else
					tes3mp.SendMessage(pid, "You do not own this cell. \n", false)
				end
				
			end
			
			elseif cmd[1] == "removeCellMember" then
			if myMod.CheckPlayerValidity(pid, cmd[2]) then
				local targetpid = tonumber(cmd[2])
				
				local name = Players[pid].name
				local targetName = Players[targetpid].name
				local cellName = tes3mp.GetCell(pid)
				if playerCells.cells[cellName] ~= nil and playerCells.cells[cellName].owner == name then
					if tableHelper.containsValue(playerCells.cells[cellName].members, targetName) == true then
						tableHelper.removeValue(playerCells.cells[cellName].members, targetName)
						jsonInterface.save("playercells.json", playerCells)
						tes3mp.SendMessage(pid, "Player removed. \n", false)
					else
						tes3mp.SendMessage(pid, "User is not a member. \n", false)
					end
					
				else
					tes3mp.SendMessage(pid, "You do not own this cell. \n", false)
				end
				
			end



















--Add this where original function is located
function OnPlayerCellChange(pid)
	local cellName = tes3mp.GetCell(pid)
	local playerName = tes3mp.GetName(pid)
	if playerCells.cells[cellName] ~= nil then
		if playerCells.cells[cellName].owner == playerName then
			
		elseif tableHelper.containsValue(playerCells.cells[cellName].members, playerName) == true then
		
		elseif playerCells.cells[cellName].locked == 1 then
			--tes3mp.SetHealthCurrent(pid, 0)
			--tes3mp.SendStatsDynamic(pid)
			Players[pid]:LoadCell()
			tes3mp.SendMessage(pid, "This cell is current locked, contact ".. playerCells.cells[cellName].owner .." to be whitelisted \n", false)
		end
		

	end
	
	myMod.OnPlayerCellChange(pid)
end


-- TDG Pathfinding Project
-- Based on A* method
-- tdgunes.org

function love.load()
    player = {
        grid_x = 128,
        grid_y = 128,
        act_x = 64,
        act_y = 64,
        speed = 10,
        coords = {4,4},
        oldcoords = {0,0}
    }
    goal = {13,1}
    map = {
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
        { 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 2, 1 },
        { 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1 },
        { 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1 },
        { 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1 },
        { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
    }    
end

function love.update(dt)
    player.act_y = player.act_y - ((player.act_y - player.grid_y) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.grid_x) * player.speed * dt)
end

function love.draw()
    love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)
  ---  love.graphics.print(tostring(player.act_x), player.act_x, player.act_y)
    love.graphics.print(tostring(player.coords[1]), 300, 575)
    love.graphics.print(tostring(player.coords[2]), 350, 575)

    for y=1, #map do
        for x=1, #map[y] do
            if map[y][x] == 1 then
                love.graphics.setColor(255, 0, 0)  
                love.graphics.rectangle("line", x * 32, y * 32, 32, 32)
            end
            if map[y][x] == 2 then
               love.graphics.setColor(0, 0, 255)          
               love.graphics.rectangle("fill", x * 32, y * 32, 32, 32)
            end
            
        end
    end
    love.graphics.print("TDG A* Pathfinding Project", 40,575)
    love.graphics.print(tostring(calculateH(player.coords[1],player.coords[2], goal[1], goal[2])),  400, 575)


    love.graphics.print(tostring(calculateH(player.coords[1],player.coords[2]-1, goal[1],goal[2])), player.act_x, player.act_y-20)
    love.graphics.print(tostring(calculateH(player.coords[1],player.coords[2]+1, goal[1],goal[2])), player.act_x, player.act_y+40)
    love.graphics.print(tostring(calculateH(player.coords[1]-1,player.coords[2], goal[1],goal[2])), player.act_x-30, player.act_y)
    love.graphics.print(tostring(calculateH(player.coords[1]+1,player.coords[2], goal[1],goal[2])), player.act_x+40, player.act_y)

end

function calculateH(playerx, playery, goalx, goaly)
    H = 0
    xDistance = math.abs(playerx-goalx)
    yDistance = math.abs(playery-goaly)
    if xDistance > yDistance then
        H = 14*yDistance + 10*(xDistance-yDistance)
    else
        H = 14*xDistance + 10*(yDistance-xDistance)
    end
    return H
end

function bestPossibleNearPlaces()
    available = {}
    modes = {}
    -- If upper   y               
    print(tostring(map[player.coords[2]][player.coords[1]]))
    if map[player.coords[2]-1][player.coords[1]] == 0 then
        print("up ok")
        print(tostring(calculateH(player.coords[1],player.coords[2]-1, goal[1],goal[2])))
        available[1] = calculateH(player.coords[1],player.coords[2]-1, goal[1],goal[2])
        modes[1] = "up"
     else
        available[1]=9999999

     end
     if  map[player.coords[2]+1][player.coords[1]] == 0 then
        print("down ok")
        print(tostring(calculateH(player.coords[1],player.coords[2]+1, goal[1],goal[2])))
        available[2] = calculateH(player.coords[1],player.coords[2]+1, goal[1],goal[2])
        modes[2] = "down"
     else
        available[2]=9999999

     end
 
    if  map[player.coords[2]][player.coords[1]-1] == 0 then
        print("left ok")
        print(tostring(calculateH(player.coords[1]-1,player.coords[2], goal[1],goal[2])))
        available[3] = calculateH(player.coords[1]-1,player.coords[2], goal[1],goal[2])
        modes[3] = "left"
     else
        available[3]=9999999
     end

    if  map[player.coords[2]][player.coords[1]+1] == 0 then
        print("right ok")
        print(tostring(calculateH(player.coords[1]+1,player.coords[2], goal[1],goal[2])))
        available[4] = calculateH(player.coords[1]+1,player.coords[2], goal[1],goal[2])
        modes[4] = "right"
    else
        available[4]=9999999

    end
    mode = ""
    num = 0
    mina = minL(available)
    for i=1, 5 do
        if available[i] == mina then
            mode = modes[i]
            num = i
            break
        end
    end
    print(mode)
    print(tostring(mina))

    if goingBack(mode) == true then
        available[num] = 99999
        mina = minL(available)
        for i=1, 5 do
            if available[i] == mina then
                mode = modes[i]
                num = i
            break
        end
    end

    end
    love.keypressed(mode)

end

function goingBack(key)
    x = player.coords[1]
    y = player.coords[2]
    if key == "up" then
       if testMap(0, -1) then
           y = y - 1
       end
    elseif key == "down" then
        if testMap(0, 1) then
            y = y + 1
        end
    elseif key == "left" then
        if testMap(-1, 0) then
            x = x - 1
        end
    elseif key == "right" then
        if testMap(1, 0) then
            x = x + 1
        end
    end
    if x == player.oldcoords[1] then
        if y == player.oldcoords[2] then
            return(true)
        end

    end
end
function love.keypressed(key)
    if key == "up" then
       if testMap(0, -1) then
           player.oldcoords[1] = player.coords[1]
           player.oldcoords[2] = player.coords[2]

           player.coords[2] = player.coords[2] - 1
           player.grid_y = player.grid_y - 32
       end
    elseif key == "down" then
        if testMap(0, 1) then
            player.oldcoords[1] = player.coords[1]
            player.oldcoords[2] = player.coords[2]

            player.coords[2] = player.coords[2] + 1
            player.grid_y = player.grid_y + 32
        end
    elseif key == "left" then
        if testMap(-1, 0) then
            player.oldcoords[1] = player.coords[1]
            player.oldcoords[2] = player.coords[2]

            player.coords[1] = player.coords[1] - 1
            player.grid_x = player.grid_x - 32
        end
    elseif key == "right" then
        if testMap(1, 0) then
            player.oldcoords[1] = player.coords[1]
            player.oldcoords[2] = player.coords[2]

            player.coords[1] = player.coords[1] + 1
            player.grid_x = player.grid_x + 32
        end
    elseif key == "w" then
       goingBack("left")
    
    elseif key == "q" then
     
       bestPossibleNearPlaces()
    end
end

function testMap(x, y)
    if map[(player.grid_y / 32) + y][(player.grid_x / 32) + x] == 1 then
        return false
    end
    return true
end

-- Personal Math
function minL(x)
  min=x[1]
  for i=2,#x do
    if min == nil then
        min=99999
    end
    if x[i] == nil then
        x[i] = 99999
    end
    if x[i]<min then
      min=x[i]
    end
  end
  return min
end

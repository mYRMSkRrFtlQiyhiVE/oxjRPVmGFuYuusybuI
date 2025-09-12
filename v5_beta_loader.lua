-- bro is this sython src code 🥺

if not getdeletedactors then getdeletedactors = function() return {}; end; end;

local ignore_actors = { "3837841034"; "16655848168"; "107003726343897"; "77748517039498"; "12144402492"; "119426593006199"; "80025211518856"; }

local find_actor = function()
    if table.find(ignore_actors, tostring(game.PlaceId)) then return; end;
    local del_actors = getdeletedactors();
    local actors = getactors();
    
    local actor = actors[1] or del_actors[1];
    for i, v in pairs(actors) do
        if v.Name == "frontlines_client_actor" then
            print("[*] found: frontlines_client_actor");
            actor = v;
        end;
    end;
    return actor;
end;

local load_script = function() 
    writefile("script_key", script_key);
    local actor = find_actor();

    if actor then
        run_on_actor(actor, [=[
            
            local uhhh_cool_var_name_here, r = pcall(function() 
                script_key = readfile("script_key");
                loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6ef6ee9a8c617afd255a34effaf97435.lua"))();
            end);

            if not uhhh_cool_var_name_here then setclipboard(r); game:GetService("Players").LocalPlayer:Kick("error while loading please notify funnyguy (set error to clipboard)"); end; 
        ]=])
        return;
    end;

    local uhhh_cool_var_name_here, r = pcall(function() 
        script_key = readfile("script_key");
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/6ef6ee9a8c617afd255a34effaf97435.lua"))();
    end);
    if not uhhh_cool_var_name_here then setclipboard(r); game:GetService("Players").LocalPlayer:Kick("error while loading please notify funnyguy (set error to clipboard)"); end; 
end;

load_script();

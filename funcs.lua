--[[
    utility for sython 
    no i dont care if your reading this

    most of this was made during a time when
    i had no motivation for developing
    and or during me being 
    very sleep deprived
]]

local funcs = {};


-- yeah lets not put the proper one on here... 
local safe_rclone = clonefunction;
local safe_clone = clonefunction;

local non_cloned_lighting   = game:GetService("Lighting");
local workspace 	        = cloneref(game:GetService("Workspace"));
local tween_service 	    = cloneref(game:GetService("TweenService"));
local replicated_storage    = cloneref(game:GetService("ReplicatedStorage"));
local replicated_first      = cloneref(game:GetService("ReplicatedFirst"));
local lighting              = cloneref(non_cloned_lighting);
local input_service 		= cloneref(game:GetService("UserInputService"));
local http_service          = cloneref(game:GetService("HttpService"));
local run_service           = cloneref(game:GetService("RunService"));
local players               = cloneref(game:GetService("Players"));
local starter_gui           = cloneref(game:GetService("StarterGui"));

local local_player          = players.LocalPlayer;
local mouse 			    = local_player:GetMouse();

--camera
local camera = workspace.CurrentCamera;

local viewport_size = camera.ViewportSize; -- yikes doesnt update if they change there display size (dont care)
local viewport_size_x = viewport_size.X;
local viewport_size_y = viewport_size.Y;

-- color
local color3_fromRGB            = safe_rclone(Color3.fromRGB);
local color3_fromHSV            = safe_rclone(Color3.fromHSV);
local color3_new                = safe_rclone(Color3.new);


--table
local table_insert              = safe_rclone(table.insert);
local table_freeze              = safe_rclone(table.freeze);
local table_clone               = safe_rclone(table.clone);
local table_find                = safe_rclone(table.find);
local table_remove              = safe_rclone(table.remove);


--math
local math_random               = safe_rclone(math.random);
local math_floor                = safe_rclone(math.floor);
local math_clamp                = safe_rclone(math.clamp);
local math_atan2                = safe_rclone(math.atan2);
local math_sqrt                 = safe_rclone(math.sqrt);
local math_ceil                 = safe_rclone(math.ceil);
local math_deg                  = safe_rclone(math.deg);
local math_max                  = safe_rclone(math.max);
local math_min                  = safe_rclone(math.min);
local math_abs                  = safe_rclone(math.abs);

local math_huge                 = math.huge;
local math_pi                   = math.pi
local nan                       = 0/0;


--string
local string_format             = safe_rclone(string.format);
local string_char               = safe_rclone(string.char);
local string_gsub               = safe_rclone(string.gsub);
local string_find               = safe_rclone(string.find);
local to_string                 = tostring;


-- vectors
local vector3                   = safe_rclone(Vector3.new);
local vector2                   = safe_rclone(Vector2.new);
local vector3_zero              = Vector3.zero;

local udim2                     = safe_rclone(UDim2.new);
local udim                      = safe_rclone(UDim.new);


-- Sequences
local color_sequence_keypoint   = safe_rclone(ColorSequenceKeypoint.new);
local color_sequence            = safe_rclone(ColorSequence.new);

local number_sequence_keypoint  = safe_rclone(NumberSequenceKeypoint.new);
local number_sequence           = safe_rclone(NumberSequence.new);


-- cframe
local cframe_lookat             = safe_rclone(CFrame.lookAt);
local cframe_new                = safe_rclone(CFrame.new)


-- fonts
local font_new                  = safe_rclone(Font.new);


--tween
local tween_info_new            = safe_rclone(TweenInfo.new);

--instance
local instance_new              = safe_rclone(Instance.new);

--files
local write_file                = safe_clone(writefile);
local list_files                = safe_clone(listfiles);
local read_file                 = safe_clone(readfile);
local del_file                  = safe_clone(delfile);
local is_file                   = safe_clone(isfile);
local wipe_file = function(name)
    if is_file(name) then
        write_file(name, "kind person hello!"); -- some files dont get wiped tbh to lazy to fix
    end;
end;

--debug
local debug_traceback           = safe_clone(debug.traceback);
local debug_info                = safe_clone(debug.info);


--metatables
local getrawmetatable           = safe_clone(getrawmetatable);
local setrawmetatable           = safe_clone(setrawmetatable);
local raw_get                   = safe_rclone(rawget);
local raw_set                   = safe_rclone(rawset);

local getcustomasset            = safe_clone(getcustomasset);

--os
local os_clock                  = safe_clone(os.clock)



do -- connections
    local unload_connections = {};
    function funcs:removed_connections()
        for i, v in pairs(unload_connections) do
            if v.func then v.func(); end;
            if v.connection then v.connection:Disconnect(); end;
        end;
        return;
    end;

    function funcs:bind_unload_event(connection, func)

        table_insert(unload_connections, {connection = connection; func = func;});
        
        return connection;
    end;
    
    local run_service_func;
    local run_connection;
    function funcs:set_run_service_func(func)
        run_service_func = func
    end;

    function funcs:disable_run_service_func()
        if run_connection then run_connection:Disconnect(); end;  
    end;

    function funcs:set_run_service_type(service_type)
        if run_connection then run_connection:Disconnect(); end;  

        run_connection = run_service[service_type]:Connect(run_service_func);
    end;
end;

do -- instance
    local cached_instances = {};
    function funcs:set_cache_prop(hash, prop, value)
        local list = cached_instances[hash];
        if list then 
            for index, instance in pairs(list) do
                if instance[prop] ~= nil then
                    instance[prop] = value;
                else
                    instance:set_prop(prop, value);
                end;
            end;
        end;
    end;

    function funcs:create(instance_name, props, isui)
        local _instance = instance_new(instance_name);
        if not _instance then return; end;
        if not props.Parent then _instance.Parent = getgenv().screen_gui; end;
        if not props.Name then _instance.Name = funcs:get_random_str(3); end;
        local self = {};
        
        
        --{instance = _instance};

        do -- set props
            for i, v in pairs(props) do
                _instance[i] = v;
            end;
        end;

        function self:visible(visible)
            _instance.Visible = visible;
        end;

        function self:get_instance()
            return _instance;
        end;

        function self:clear()
            _instance:ClearAllChildren();
        end;

        function self:delete()
            _instance:Destroy();
        end;

        function self:prop_changed(prop)
            return _instance:GetPropertyChangedSignal(prop);
        end;

        function self:get_prop(prop)
            return _instance[prop]
        end;

        function self:set_prop(prop, value)
            if _instance[prop] == nil then return false; end;

            _instance[prop] = value;

            return true;
        end;

        function self:fast_get_textbounds()
            return _instance.TextBounds;
        end;

        function self:set_pos(x, y, z, w)
            if isui then
                if w ~= nil then
                    _instance.Position = udim2(x, y ,z, w);
                else
                    _instance.Position = udim(x, y);
                end;
            else
                if z ~= nil then
                    _instance.Position = vector3(x, y ,z);
                else
                    _instance.Position = vector2(x, y ,z);
                end;
            end;
        end;

        if isui then
            function self:set_dragable(value)
                _instance.Selectable = value;
                _instance.Draggable = value;
                _instance.Active = value;

                return self;
            end;
        end;

        function self:set_size(x, y, z, w)
            if isui then
                if w ~= nil then
                    _instance.Size = udim2(x, y ,z, w);
                else
                    _instance.Size = udim(x, y);
                end;
            else
                if z ~= nil then
                    _instance.Size = vector3(x, y ,z);
                else
                    _instance.Size = vector2(x, y ,z);
                end;
            end;
        end;

        function self:rot_line(Thickness, From, To)
            local X1, Y1, X2, Y2 = From.X, From.Y, To.X, To.Y;

            local CenterX = (X1 + X2) / 2;
            local CenterY = (Y1 + Y2) / 2;

            local DeltaX = math_abs(X1 - X2) ^ 2;
            local DeltaY = math_abs(Y1 - Y2) ^ 2;

            local Distance = math_sqrt(DeltaX + DeltaY);
            local Rotation = math_deg(math_atan2(Y1 - Y2, X1 - X2));


            _instance.AnchorPoint = vector2(.5, .5);
            _instance.Position = UDim2.fromOffset(CenterX, CenterY);
            _instance.Size = UDim2.fromOffset(Distance, Thickness);
            _instance.Rotation = Rotation;
        end;

        function self:tween(tweeninfo, args)
            tween_service:Create(_instance, tweeninfo, args):Play();
        end;
        
        function self:play()
            return _instance:Play();
        end;

        function self:set_zindex(num)
            _instance.ZIndex = num;
        end;

        function self:get_zindex()
            return _instance.ZIndex;
        end;

        function self:w2sp()
            self.screen_pos, self.on_screen = camera:WorldToScreenPoint(self:get_pos());
            return {self.screen_pos; self.on_screen};
        end;

        function self:cache(hash)
            if cached_instances[hash] == nil then cached_instances[hash] = {}; end;
            table_insert(cached_instances[hash], self);
            return self;
        end;

        return self;
    end;

    function funcs:cache(hash, instance)
        if cached_instances[hash] == nil then cached_instances[hash] = {}; end;
        table_insert(cached_instances[hash], instance);
        return instance;
    end;

    function funcs:create_simple_instance(class_name, props, cache)
        local parent = props.Parent;
        if not parent then parent = getgenv().safe_folder; end;
        local instance = instance_new(class_name, parent);

        for prop, value in pairs(props) do
            instance[prop] = value;
        end

        if cache then 
            for prop, value in pairs(cache) do
                funcs:cache(value, instance)
            end
        end;

        return instance;
    end;

    function funcs:get_textbounds(instance)
        if instance.get_instance then
            instance = instance:get_instance();
        end;
        local bounds = instance.TextBounds;
        wait();
        bounds = instance.TextBounds;
        wait();
        bounds = instance.TextBounds;
        return bounds;
    end;
end;

do -- raycast (still have 0 clue why i made like 30 of these
    local ignore = {};
    function funcs:set_ignore(list)
        ignore = list;
    end;

    function funcs:is_visible(object, part_name, origin)
        local Params = RaycastParams.new();
        Params.CollisionGroup = "WeaponRaycast";
        Params.IgnoreWater = true;
        Params.FilterDescendantsInstances = {object, ignore};
        local RayCastResults = workspace:Raycast(origin.Position, object[part_name].Position - origin.Position, Params);

        return not RayCastResults
    end;

    function funcs:is_pos_visible(object, origin, destination)
        local Params = RaycastParams.new();
        Params.CollisionGroup = "WeaponRaycast";
        Params.IgnoreWater = true;
        Params.FilterDescendantsInstances = {object};
        local RayCastResults = workspace:Raycast(origin, destination - origin, Params);

        return not RayCastResults
    end;

    function funcs:is_pos_visible_full(object, origin, destination)
        local Params = RaycastParams.new();
        Params.CollisionGroup = "WeaponRaycast";
        Params.IgnoreWater = true;
        Params.FilterDescendantsInstances = {object, ignore};
        local RayCastResults = workspace:Raycast(origin, destination - origin, Params);

        return {
            is_visible = not RayCastResults;
            ray_results = RayCastResults;
        }
    end;

    function funcs:weapon_raycast(ignore, origin, orientation)
        local Params = RaycastParams.new();
        Params.CollisionGroup = "WeaponRaycast";
        Params.FilterDescendantsInstances = ignore;
        Params.IgnoreWater = true;

        return workspace:Raycast(origin, orientation, Params);
    end;
end;

do -- ui shit
    function funcs:round(args, value)
        if args["notrounded"] then return (math_floor(value * 100) / 100); end;
        return math_floor(value);
    end;

    function funcs:mapvalue(Value, MinA, MaxA, MinB, MaxB) -- thank you linoria for the math that i couldnt be fucked doing
        return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB;
    end;

    function funcs:to_rich_color(color3)
        local r = (color3.R * 255);
        local g = (color3.G * 255);
        local b = (color3.B * 255);
        
        return string_format("rgb(%d, %d, %d)", r, g, b);
    end;

    function funcs:rich_text(string_data, spacer, ignore_last_index)
        local compiled_string = "";
        if not spacer then
            spacer = ""
        end;
        
        for i, data in pairs(string_data) do
            local color = data.color;
            local string = data.string;
            if ignore_last_index and i == #string_data then spacer = ""; end;
            compiled_string = compiled_string..[[<font color="]]..funcs:to_rich_color(color)..[[">]]..string.."</font>"..spacer;
        end;

        return compiled_string;
    end;
     
     -- prob better ways of doing it but dont care
    function funcs:is_key_code(key)
        for i, v in Enum.KeyCode:GetEnumItems() do 
            if v.Name == key then return true; end; 
        end;
        return false;
    end;
    
    function funcs:is_user_input_type(key)
        for i, v in Enum.UserInputType:GetEnumItems() do 
            if v.Name == key then return true; end; 
        end;
        return false;
    end;
end;


do -- uh stuff ig
    function funcs:w2sp(pos)
        local data = {screen_pos; on_screen};
        data.screen_pos, data.on_screen = camera:WorldToViewportPoint(pos);
        return data;
    end;

    function funcs:distance(pos)
        return (pos - camera.CFrame.Position).Magnitude;
    end;
end;

do -- rng
    function funcs:get_random_str(length)
        local str = to_string(math_random(0, 9));
        if length > 1 then
            str = str .. to_string(math_random(0, 9))
        end;
        return str;
    end;
end;

do --custom assets
    function funcs:create_image(name, asset)
        name = name..".png";
        if is_file(name) then del_file(name); end;
        write_file(name, asset);

        local asset = getcustomasset(name);

        wipe_file(name);
        return asset;
    end

    function funcs:create_font(name, weight, style, asset)
        local id = asset.Id;
        
        if not is_file(id) then write_file(id, asset.Font); end;
        if is_file(name .. ".font") then del_file(name .. ".font"); end;
        local data = {
            name = name,
            faces = {
                {
                    name = "Regular",
                    weight = weight,
                    style = style,
                    assetId = getcustomasset(id),
                },
            },
        }
        write_file(name .. ".font", http_service:JSONEncode(data));
        local asset = font_new(getcustomasset(name .. ".font"));
        wipe_file(name .. ".font");
        return asset;
    end;
end;

do --meta
    -- dont ask why i dont namecall this tbh i forgot and was to lazy to change it
    funcs.hook_metamethod = newcclosure(function(obj, method, func)
        local metatable = getrawmetatable(obj);
        metatable = table_clone(metatable);
        local old = raw_get(metatable, method);
        setreadonly(metatable, false);
        raw_set(metatable, method, func);
        table_freeze(metatable);
        setrawmetatable(obj, metatable)
        return old;
    end);
end;

return funcs;

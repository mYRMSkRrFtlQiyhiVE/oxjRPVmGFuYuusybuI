local funcs = {};

-- yeah lets not put the proper one on here... 
local safe_rclone = clonefunction;
local safe_clone = clonefunction;

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


--files
local write_file                = safe_clone(writefile);
local list_files                = safe_clone(listfiles);
local read_file                 = safe_clone(readfile);
local del_file                  = safe_clone(delfile);
local is_file                   = safe_clone(isfile);


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
end;

return funcs;

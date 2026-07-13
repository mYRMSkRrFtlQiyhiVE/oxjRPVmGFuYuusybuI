local funcs = {};

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

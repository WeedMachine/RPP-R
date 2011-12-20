RPP_var_object_isPlacing = false;
RPP_var_object_rotation = 0;
RPP_var_object_height = 0;
RPP_var_object_bend = false;
RPP_var_object_distance = 0;

RPP_var_object_serverObjects = [];

RPP_var_object_playerObjects = [];

RPP_fnc_object_getArray = 
{
    private ["_class", "_return"];
    _class = _this;
    _return = [];
    
    {
        if (_x select 0 == _class) exitwith
        {
            _return = _x;
        };
    } forEach RPP_var_object_positions;
    
    _return
};

RPP_fnc_object_pickup = 
{
    private ["_object", "_class"];
    _object = _this;
    _class = typeOf _object;
    
    if ([_class, 1] call RPP_fnc_addInventoryItem) then
    {
        (format[localize "STRS_object_pickup", _class call RPP_fnc_itemGetName]) call RPP_fnc_hint;
        [{ (_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic"; }, [player]] call RPP_fnet_execPublic;
        
        _index = RPP_var_object_playerObjects find _object;
        
        if (_index >= 0) then
        {
            RPP_var_object_playerObjects set[_index, "REMOVE"];
            RPP_var_object_playerObjects = RPP_var_object_playerObjects - ["REMOVE"];
        };
        deleteVehicle _object;
    }
    else
    {
    
    };
};

RPP_fnc_object_startPlacing = 
{
    private ["_class", "_position", "_object", "_varName", "_boundingBox"];
    _class = _this;
    
    if (vehicle player != player) exitWith 
    {
    
    };
    
    _position = [0,0,0];
    _object = _class createVehicle _position;
    _varName = format["obj_%1_%2_%3_%4", (ceil (position player select 1)), (ceil (position player select 2)), (ceil (position player select 3)), (ceil time)];
    _object setVehicleInit format
    ["
        this setVehicleVarName ""%1"";
    ", _varName];
    processInitCommands; 
    
    _boundingBox = boundingBox _object;
    _object attachTo [player, [0,((_boundingBox select 1) select 1)+5,((getPosATL player) select 2)+((_boundingBox select 1) select 2)]];
    _object setDir getDir player;
    
    RPP_var_object_isPlacing = true;
    
    /* Add actions */
    RPP_action_placeObj = player addAction["<t color='#008000'>Place</t>", "core\actions\objects.sqf", ["PLACE"], 1, true, false];
    RPP_action_rotateLeft = player addAction["<t color='#4876FF'>Rotate Left</t>", "core\actions\objects.sqf", ["ROTATE_LEFT"], 1, true, false];
    RPP_action_rotateRight = player addAction["<t color='#4876FF'>Rotate Right</t>", "core\actions\objects.sqf", ["ROTATE_RIGHT"], 1, true, false];
    RPP_action_increaseHeight = player addAction["<t color='#EEC900'>Raise</t>", "core\actions\objects.sqf", ["RAISE"], 1, true, false];
    RPP_action_lowerHeight = player addAction["<t color='#EEC900'>Lower</t>", "core\actions\objects.sqf", ["LOWER"], 1, true, false];
    RPP_action_push = player addAction["<t color='#B0171F'>Push</t>", "core\actions\objects.sqf", ["PUSH"], 1, true, false];
    RPP_action_pull = player addAction["<t color='#B0171F'>Pull</t>", "core\actions\objects.sqf", ["PULL"], 1, true, false];
    RPP_action_bend = player addAction["<t color='#FFFFFF'>Terrain bending</t>", "core\actions\objects.sqf", ["BEND"], 1, true, false];
    
    while {RPP_var_object_isPlacing} do 
    {
        _object attachTo [player, [0,(((_boundingBox select 1) select 1)+5)+RPP_var_object_distance,(((getPosATL player) select 2)+((_boundingBox select 1) select 2))+RPP_var_object_height]];
        _object setDir RPP_var_object_rotation;
        
        if (RPP_var_object_bend) then
        {
            _object setVectorUp [0,0,1];
        };
        
        if (vehicle player != player) then
        {
            RPP_var_object_isPlacing = false;
        };
        
        if !(alive player) then
        {
            RPP_var_object_isPlacing = false;
        };
        
        sleep 0.001;
    };
    
    _position = getPosATL _object;
    _dir = getDir _object;
    
    detach _object;
    
    _object setPosATL _position;
    _object setDir _dir;
    
    player removeAction RPP_action_placeObj;
    player removeAction RPP_action_rotateLeft;
    player removeAction RPP_action_rotateRight;
    player removeAction RPP_action_increaseHeight;
    player removeAction RPP_action_lowerHeight;
    player removeAction RPP_action_push;
    player removeAction RPP_action_pull;
    player removeAction RPP_action_bend;
    
    RPP_var_object_playerObjects set[(count RPP_var_object_playerObjects), _object];
    
    _object setVariable ["isObject", true, true];
    [_class, -1] call RPP_fnc_addInventoryItem;
    (format[localize "STRS_object_place", _class call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    [{ (_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic"; }, [player]] call RPP_fnet_execPublic;
       
};
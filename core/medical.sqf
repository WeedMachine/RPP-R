player setVariable ["isAlive", true, true];
player setVariable ["stabilized", true, true];

RPP_fnc_medical_isAlive = 
{
    (_this getVariable ["isAlive", false])
};

RPP_fnc_medical_isStabilized = 
{
    (_this getVariable ["stabilized", false])
};

RPP_fnc_medical_toggleAlive = 
{
    player setVariable["isAlive", _this, true];
};

RPP_fnc_medical_toggleStable = 
{
    player setVariable["stabilized", _this, true];
};

RPP_fnc_medical_openMedicalBag = 
{
    private ["_dlg", "_numFound"];
    if (!isNull(findDisplay 3000)) exitWith
    {
        /* Do nothing */
    };
    
    _dlg = createDialog "RPP_Dlg_SelectPlayer";
    _numFound = 0;
    {
        _unit = call compile _x;
        
        if (!(_unit getVariable ["isAlive", true]) && (player distance _unit <= 10)) then
        {
            _index = lbAdd[2100, format["%1", name _unit]];
            lbSetData[2100,_index, _x];
            _numFound = _numFound + 1;
        };
    
    
    } forEach RPP_var_players;
    lbSetCurSel[2100,0];
    
    if (_numFound <= 0) exitWith 
    {
        //Debug:
       
        closeDialog 0;
    };

};

RPP_fnc_medical_carry = 
{
    private ["_target"];
    _target = _this select 0;
    
    if (RPP_var_medical_isCarrying) exitWith
    {
    
    };
    
    RPP_var_medical_isCarrying = true;
    ["RPP_fnc_serverSwitchAnimation", [_target, "AinjPpneMstpSnonWrflDb_grab"]] call RPP_fnet_execPublic;  
    
    ["RPP_fnc_serverAttachTo", [_target, player, [-0.25,-0.5,0]]] call RPP_fnet_execPublic;
    format[localize "STRS_medical_dragging_start", name _target] call RPP_fnc_hint;
    RPP_action_medical_stopCarrying = player addAction[format["Drop %1", name _target], "core\actions\useAction.sqf", ["medical_dragstop"]];
    
    while {RPP_var_medical_isCarrying} do
    {
        if !(alive _target) then
        {
            RPP_var_medical_isCarrying = false;
            //format[localize "STRS_medical_dragging_stop", name _target] call RPP_fnc_hint;
        };
        
        if !(alive player) then
        {
            RPP_var_medical_isCarrying = false;
            //format[localize "STRS_medical_dragging_stop", name _target] call RPP_fnc_hint;
        };
        
        if (player != vehicle player) then
        {
            RPP_var_medical_isCarrying = false;
            
            /* Put person into vehicle */
             [{ (_this select 0) moveInCargo (_this select 1); }, [_target, (vehicle player)]] call RPP_fnet_execPublic;
        };
    
        sleep 1;
    };
    
    ["RPP_fnc_serverDetach", [_target]] call RPP_fnet_execPublic;
    
    player removeAction  RPP_action_medical_stopCarrying;
    
    if (vehicle _target == _target) then
    {
        format[localize "STRS_medical_dragging_stop", name _target] call RPP_fnc_hint;
        ["RPP_fnc_serverSwitchAnimation", [_target, "AdthPercMstpSlowWrf_beating"]] call RPP_fnet_execPublic;  
    }
    else
    {
        format[localize "STRS_medical_dragging_vehicle", name _target] call RPP_fnc_hint;
    };
};

RPP_fnc_medical_stabilize = 
{
    private ["_target", "_itemAmount", "_worldPos", "_ticks"];
    _target = _this select 0;
    
    if (RPP_var_medical_isReviving) exitWith
    {
        /* Already reviving someone */
    };
    
    _itemAmount = "MedicalBag" call RPP_fnc_itemGetAmount;
    
    if (_itemAmount <= 0) exitWith
    {
        format[localize "STRS_medical_revive_require", "MedicalBag" call RPP_fnc_itemGetName] call RPP_fnc_hint;
    };
    
    ['MedicalBag', -1] call RPP_fnc_addInventoryItem;
    
    RPP_var_medical_isReviving = true;
    
    ["RPP_fnc_serverSwitchAnimation", [_target, "AinjPpneMstpSnonWrflDnon_rolltoback"]] call RPP_fnet_execPublic;  
    ["RPP_fnc_serverPlayMove", [player, "AinvPknlMstpSnonWrflDnon_medic"]] call RPP_fnet_execPublic;  

    _worldPos = _target modelToWorld[-0.85,0,0];
    player attachTo[_target,[0.80,0.40,0]];
    
    [{ (_this select 0) setdir 180; }, [_target]] call RPP_fnet_execPublic;
    player setDir 270;
    
    _ticks = 0;
    format[localize "STRS_medical_revive_start", name _target] call RPP_fnc_hint;
    while {RPP_var_medical_isReviving} do
    {
        if !(alive _target) then
        {
            /* Target dead */
            RPP_var_medical_isReviving = false;
            localize "STRS_medical_revive_fail" call RPP_fnc_hint;
        };
        
        if !(alive player) then
        {
            RPP_var_medical_isReviving = false;
        };
        
        if ((_ticks % 120 == 0) && (_ticks != 0)) then
        {
            /* End of reviving */
            RPP_var_medical_isReviving = false;
            localize "STRS_medical_revive_success" call RPP_fnc_hint;
            _target setVariable["stabilized", true, true];
        };
        
        if ((_ticks % 5 == 0) && (_ticks != 120)) then
        {
            /* Switch reviving animation */
            _randomAnimation = RPP_var_medical_animations select (random (count RPP_var_medical_animations-1));
            ["RPP_fnc_serverSwitchAnimation", [player, _randomAnimation]] call RPP_fnet_execPublic;  
            
            /* Random chance of being revived here */
            _chance = 2;
            _roll = random 100;
            
            if (_roll < _chance) then
            {
                RPP_var_medical_isReviving = false;
                localize "STRS_medical_revive_success" call RPP_fnc_hint;
                _target setVariable["stabilized", true, true];
            };
        
        };
    
        _ticks = _ticks + 1;
        sleep 1;
    };
    
    ["RPP_fnc_serverPlayMove", [player, "AinvPknlMstpSnonWrflDnon_medicEnd"]] call RPP_fnet_execPublic;  
    
    if ((alive _target) && (alive player)) then
    {
        ["RPP_fnc_medical_clientStabilized", [_target, player]] call RPP_fnet_execPublic;
    };
    
    
    detach player;
    detach _target;    
    

};

RPP_fnc_medical_clientStabilized = 
{
    private ["_unit", "_from"];
    _unit = _this select 0;
    _from = _this select 1;
    
    if (player != _unit) exitWith {};
    
    format[localize "STRS_medical_revive_stabilized", name _from] call RPP_fnc_hint;
    cutText ["","BLACK IN", 0.1];

};

RPP_fnc_medical_dead = 
{
    private ["_alive", "_weapons", "_magazines"];
    _alive = player call RPP_fnc_medical_isAlive;
    
    if !(_alive) exitWith 
    {
        
    };
    
    false call RPP_fnc_medical_toggleAlive;
    false call RPP_fnc_medical_toggleStable;
    
    player setDamage 0.9;

    [position player] spawn RPP_fnc_dropInventory;
    _weapons = weapons player;
    _magazines = magazines player;
    
    if (RPP_var_holstered) then
    {
        _weapons set[(count _weapons), RPP_var_holsteredWeapon];
        RPP_var_holstered = false;
    };
    
    [player, _magazines, _weapons] call RPP_fnc_dropWeapons;
 
    cutText ["You have died, please wait to be revived.","BLACK OUT",30];
    
    if (vehicle player != player) then
    {
        waitUntil {(speed vehicle player <= 3)};
        player action["eject", vehicle player];
        sleep 1;
    };
    ["RPP_fnc_serverSwitchAnimation", [player, "AdthPercMstpSlowWrf_beating"]] call RPP_fnet_execPublic;  
    _time = time+RPP_var_deathTime;
    
    /* Contact EMS here */
    //TODO
    
    _ticks = 0;
    _in = false;
    while {_alive} do
    {
        if ((time >= _time) && !(player call RPP_fnc_medical_isStabilized))  then
        {
            /* You have died */
            player setDamage 1;
        };
        
        if (_ticks % 15 == 0) then
        {
            
            
            if !(player call RPP_fnc_medical_isStabilized) then
            {
                _black = "";
                
                if (_in) then
                {
                    _black = "BLACK IN";
                }
                else
                {
                    _black = "BLACK OUT";
                };
                cutText ["",_black,7.5];

                _in = !_in;
                
                titleText [format["You are dying! Please wait to be revived. \nYou have %1 minutes left before your life fades away.", ceil((_time - time)/60)], "PLAIN",0];
            }
            else
            {
                titleText ["You have been stabilized, you will be taken to hospital to be revived shortly", "PLAIN", 0];
            };
        };
            
        
        _ticks = _ticks + 1;
        sleep 1;
    };
};
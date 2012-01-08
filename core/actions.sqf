/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

if (isNil "RPP_var_keyActions") then 
{
    RPP_var_keyActions = [];
};

if (isNil "RPP_var_actionArr") then
{
    RPP_var_actionArr = [];
};

RPP_fnc_onKeyPress =
{
    private ["_ctrl", "_key", "_shift", "_ctrl", "_alt", "_foundInActionKey"];
    _ctrl = _this select 0;
    _key = _this select 1;
    _shift = _this select 2;
    _ctrl = _this select 3;
    _alt = _this select 4;
    
    if (not alive player) exitWith {};
    if (RPP_var_isRestrained) exitWith {};
    if !(player call RPP_fnc_medical_isAlive) exitWith {};
    if (RPP_var_medical_isReviving) exitWith {};
    
    _foundInActionKey = false;
    {
        _fKey = _x select 0;
        _fCode = _x select 1;
        _fCtrl = _x select 2;
        _fShift = _x select 3;
        _fAlt = _x select 4;
        
        if ((_fKey == _key) && (str _fCtrl == str _ctrl) && (str _fShift == str _shift) && (str _fAlt == str _alt)) exitWith
        {
            _foundInActionKey = true;
            
            if (typeName _fCode == "STRING") then
            {
                _fCode = compile _fCode;
            };
           
            [] call _fCode;
        };
    } forEach RPP_var_keyActions;
    
    
    if (_foundInActionKey) exitWith {}; 
    
    if ((_key == 18) && (vehicle player != player)) exitWith
    {
        /* Increase speed */
        _boost = (typeOf vehicle player) call RPP_fnc_getVehicleBoost;
        
        if (typeName _boost != "ARRAY") exitWith {};
        
        _maxSpeed = _boost select 1;
        _increase = _boost select 0;
        _onRoad = isOnRoad getPos (vehicle player);
        _velocity = velocity vehicle player;
        
        if (_onRoad) then
        {
            if (speed (vehicle player) <= _maxSpeed) then
            {
                (vehicle player) setVelocity [(_velocity select 0) * _increase, (_velocity select 1) * _increase, (_velocity select 2) * 0.99];
            };
        };
    };
    
    if (_key == 57 && (player != vehicle player)) then
    {
        (vehicle player) call RPP_fsiren_toggle;
    };
    
    if (_key == 23) then //Inventory
    {
        [] call RPP_fnc_openInventory;
    };
    
    if ((_key == 2) && !(_ctrl)) then /* Stats */
    {
        [] spawn RPP_fnc_openStatsMenu;
    };
    
    if ((_key == 2) && (_ctrl)) then /* Arrest */
    {
        if ((vehicle player distance arrest_point <= 7) && (vehicle player != player)) then
        {
            [] call RPP_fnc_pol_openArrest;
        };
    };
    
    if ((_key == 15) && (not _alt)) then /* Hide Text */
    {
        RPP_var_hideText = !RPP_var_hideText;
        
        if (RPP_var_hideText) then
        {
            localize "STRS_ui_hideText" call RPP_fnc_hint;
        }
        else
        {
            localize "STRS_ui_revealText" call RPP_fnc_hint;
        };
    };
    
    if (_key == 3) then /* Animations */
    {
        [] spawn RPP_fnc_openAnimations;
    };
    
    if (_key == 35) then /* Holster/Unholster */
    {
        [] spawn RPP_fnc_holsterPistol;
    };
    
    /* Lets do some checks anyway for vehicles and players */
    _curTarget = cursorTarget;
    
    if (_curTarget getVariable["isObject", false]) then
    {
        if (_key == 48) then
        {
            _curTarget spawn RPP_fnc_object_pickup;
        };
    };
    
    if (vehicle player != player) then
    {
        _curTarget = vehicle player;
    };
    
    if ((_curTarget getVariable["hasActions", false]) || (str _curTarget in RPP_var_players)) then
    {
        /* Lets find out if its a vehicle or not */
        if (_curTarget isKindOf "Man") then
        {
            /* Must be one of our men with actions */
            if (_key == 33) then
            {
                if (player distance (_curTarget) <= 5) then
                {
                    if ((!isNull(findDisplay 1800)) || (!isNull(findDisplay 1100))) exitWith
                    {
                        /* Do nothing */
                    };
                    
                    if (player call RPP_fnc_isCop) then
                    {
                        createDialog "RPP_Dlg_InteractCop";
                        ((findDisplay 1800) displayCtrl 1203) ctrlSetStructuredText parseText (name _curTarget);
                        buttonSetAction [1600, format["%1 call RPP_fnc_trading_open;", _curTarget]];
                        buttonSetAction [1603, format["[%1] call RPP_fnc_pol_disarmAction;", _curTarget]];
                        buttonSetAction [1604, format["[%1] call RPP_fnc_pol_arrest;", _curTarget]];
                        buttonSetAction [1602, format["%1 call RPP_fnc_search_openDialog;", _curTarget]];
                    }
                    else
                    {
                        createDialog "RPP_Dlg_InteractCiv";
                        ((findDisplay 1100) displayCtrl 1203) ctrlSetStructuredText parseText (name _curTarget);
                        buttonSetAction [1600, format["%1 call RPP_fnc_trading_open;", _curTarget]];
                        buttonSetAction [1602, format["%1 call RPP_fnc_search_openDialog;", _curTarget]];
                    };
                };
            };
        }
        else /* Must be one of our vehicles with actions */
        {
            /* Check for bush actions */
            if (toLower(typeOf _curTarget) in RPP_var_forestry_typeBushes) exitWith
            {
                if (_key == 33) then /* Harvest */
                {
                    [_curTarget] spawn RPP_fnc_forestry_harvestBush;
                };
                
                if (_key == 20) then /* Pick sprouts */
                {
                    [_curTarget] call RPP_fnc_forestry_pickSprout;
                };
                
                if (_key == 48) then /* Check */
                {
                    [_curTarget] call RPP_fnc_forestry_checkBush;
                };
            };
            
            /* Check for tree actions */
            if (toLower(typeOf _curTarget) in RPP_var_forestry_typeTrees) exitWith
            {
                if (_key == 33) then /* Harvest */
                {
                    [_curTarget] spawn RPP_fnc_forestry_cutTree;
                };
                
                if (_key == 20) then /* Pick sprouts */
                {
                    [_curTarget] call RPP_fnc_forestry_pickSprout;
                };
            };
            
            try
            {
                /* Check for trunk actions */
                if ((toLower(typeOf _curTarget) in RPP_var_forestry_typeTrunks)) exitWith
                {
                    if (_key == 33) then /* Chop up */
                    {
                        [_curTarget] spawn RPP_fnc_forestry_chopTreeTrunk;
                    };
                };
            }
            catch 
            { 
                player groupchat format["%1", _exception]; 
            };
             
            if (_curTarget isKindOf "Suitcase") then /* Suitcase actions */
            {
                if (_key == 33) then /* Open trunk */
                {
                    [_curTarget] call RPP_fnc_openStorage;
                };
            
            }
            else
            {
                if (_key == 33) then /* Lock/Unlock */
                {
                    [_curTarget] call RPP_fnc_lockVehicle;
                };
				
				if (_key == 22) then /* Unflip Car */
				{
					[_curTarget] call ALR_fnc_unflip;
				};

                if (_key == 20) then /* Menu */
                {
                    _curTarget call RPP_fnc_openVehicleMenu;
                };

                if (_key == 48) then /* Pullout */
                {
                    if (vehicle player == player) then
                    {
                        [_curTarget, player] execVM "core\pullout.sqf";
                    }
                    else
                    {
                        [] call RPP_fnc_toggleSeatbelt;
                    };
                };
                
                if (_key == 18) then /* Getin vehicle */
                {
                    if ((vehicle player == player) && (player distance _curTarget <= 7)) then
                    {
                        if (isNull driver _curTarget) then
                        {
                            player action ["getInDriver", _curTarget];
                        }
                        else
                        {
                            player action ["getInCargo", _curTarget];
                        };
                    
                    };
                };
            };
        };
    }
    else
    {
       
    };
 
    
};

RPP_fnc_addKeyAction = 
{
    private ["_key", "_code", "_ctrl", "_shift", "_alt"];
    _key = _this select 0;
    _code = _this select 1;   
    _ctrl = _this select 2;
    _shift = _this select 3;
    _alt = _this select 4;
    
    _foundAt = (count RPP_var_keyActions);
    _foundInActionKey = false;
    _i = 0;
     {
        _fKey = _x select 0;
        _fCtrl = _x select 2;
        _fShift = _x select 3;
        _fAlt = _x select 4;
        
        if ((_fKey == _key) && (str _fCtrl == str _ctrl) && (str _fShift == str _shift) && (str _fAlt == str _alt)) exitWith
        {
            _foundInActionKey = true;
            _foundAt = _i;
        };
        _i = _i + 1;
    } forEach RPP_var_keyActions;

    RPP_var_keyActions set[_foundAt, [_key,_code,_ctrl,_shift,_alt]];
};

RPP_fnc_remKeyAction =
{
   private ["_key", "_code", "_ctrl", "_shift", "_alt"]; 
    _key = _this select 0;
    _ctrl = _this select 1;
    _shift = _this select 2;
    _alt = _this select 3;
    
    _foundAt = 0;
    _foundInActionKey = false;
    _i = 0;
     {
        _fKey = _x select 0;
        _fCtrl = _x select 2;
        _fShift = _x select 3;
        _fAlt = _x select 4;
        
        if ((_fKey == _key) && (str _fCtrl == str _ctrl) && (str _fShift == str _shift) && (str _fAlt == str _alt)) exitWith
        {
            _foundInActionKey = true;
            _foundAt = _i;
        };
        _i = _i + 1;
    } forEach RPP_var_keyActions;
    
    if (_foundInActionKey) then
    {
        RPP_var_keyActions set[_foundAt, "-REMOVE-"];
        RPP_var_keyActions = RPP_var_keyActions - ["-REMOVE-"];
    };
    
};

RPP_fnc_addAction =
{
    private ["_id", "_target", "_addTo", "_condition", "_code"];
    _target = (_this select 0);
    _addTo = (_this select 1);
    _condition = (_this select 2);
    _code = (_this select 3);
    _id = (_this select 4);
    _onDel = (_this select 5);
       
    call compile format["action_id_%1 = 0;", _id];
    RPP_var_actionArr set[(count RPP_var_actionArr), [_id, _target, _addTo, _condition, _code, _onDel]];
};

RPP_fnc_actionCheck =
{
    while {true} do
    {
        {
            _id = (_x select 0);
            _target = (_x select 1);
            _addTo = (_x select 2);
            _condition = (_x select 3);
            _code = (_x select 4);
            _onDel = (_x select 5);
            _added = 0;
            call compile format["_added = action_id_%1;", _id];
            
            if (typeName _code == "STRING") then
            {
                _code = compile _code;
            };
            
            if (typeName _condition == "STRING") then
            {
                _condition = compile _condition;
            };
            
            if (typeName _onDel == "STRING") then
            {
                _onDel = compile _onDel;
            };
            
            if ((call _condition) && (_added == 0)) then
            {
                call compile format["action_id_%1 = 1;",_id];
                
                call _code;
            };
                        
            if ((not (call _condition)) && (_added == 1)) then
            {
                call compile format["action_id_%1 = 0;",_id];
                
                call _onDel;
            };
        
        } forEach RPP_var_actionArr;
    
        sleep 0.1;
    };
};
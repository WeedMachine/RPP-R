/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_miningDefine = 
[
    /* Mines */
    //[ 2, [copperrock1, ironrock2, ironrock3, ironrock4], "Mine Copper", [ ["mining", 1], 4, 180, "Pickaxe", "CopperOre", 25, 1]],
	//[ 3, [sandrock1, sandrock2, sandrock3, sandrock4], "Mine Sand", [ ["mining", 1], 4, 180, "Pickaxe", "Sand", 25, 1]],
	//[ 4, [saltrock1, saltrock2, saltrock3, saltrock4], "Mine Salt", [ ["mining", 1], 4, 180, "Pickaxe", "Salt", 25, 1]],
	//[ 5, [clayrock1, clayrock2, clayrock3, clayrock4], "Mine Clay", [ ["mining", 1], 4, 180, "Pickaxe", "Clay", 25, 1]],
	//[ 6, [coalrock1, coalrock2, coalrock3, coalrock4], "Mine Coal", [ ["mining", 1], 4, 180, "Pickaxe", "Coal", 25, 1]],
	//[ 7, [Siliconrock1, Siliconrock2, Siliconrock3, Siliconrock4], "Mine Silicon", [ ["mining", 1], 4, 180, "Pickaxe", "Silicon", 25, 1]],
	[ 0, [goldrock1, goldrock2, goldrock3, goldrock4, goldrock5], "Gold Ore", [ ["mining", 5], 17, 8200, "Pickaxe", "GoldOre", 16, 1]],
    [ 1, [ironrock1, ironrock2, ironrock3, ironrock4], "Mine Iron", [ ["mining", 1], 4, 180, "Pickaxe", "IronOre", 25, 1]]

];

RPP_fnc_miningGetArray = 
{
    private ["_id", "_arr"];
    _id = _this;
    _arr = [];
    {
        if (_id == (_x select 0)) exitWith
        {
            _arr = _x;
        };
    } forEach RPP_var_miningDefine;
    
    _arr
};

RPP_var_isMining = false;

RPP_fnc_mineResource = 
{
    private ["_id", "_obj", "_arr", "_statsArray", "_skill", "_reqSkill", "_time", "_exp", "_reqClass", "_amount", "_oldTime", "_getRsc", "_level"];
    _id = _this select 0;
    _obj = _this select 1;
    _arr = _id call RPP_fnc_miningGetArray;
    _statsArray = (_arr select 3);
    _skill = ((_statsArray select 0) select 0);
    _reqSkill = ((_statsArray select 0) select 1);
    _time = _statsArray select 1;
    _exp = _statsArray select 2;
    _reqClass = _statsArray select 3;
    _getRsc = _statsArray select 4;
    _failChance = _statsArray select 5;
    _amount = _reqClass call RPP_fnc_itemGetAmount; 
    _reqName = _reqClass call RPP_fnc_itemGetName;
    _getRscName = _getRsc call RPP_fnc_itemGetName;
    _earlyChance = _statsArray select 6;
    _success = true;

    if (RPP_var_isMining) exitWith /* Already mining */
    {
        localize "STRS_mine_alreadyMining" call RPP_fnc_hint;
    };
    
    if (_amount <= 0) exitWith /* No pickaxe */
    {
        (format[localize "STRS_mine_requireTool", _reqName]) call RPP_fnc_hint;
    };
    
    if (not([_getRsc, 1] call RPP_fnc_addInventoryItem)) exitWith /* Not enough space */
    {    
        localize "STRS_mine_noRoom" call RPP_fnc_hint;
    };
    
    _level = (_skill call RPP_fnc_getExperience) call RPP_fnc_calculateLevel;
    
    if (_level < _reqSkill) exitWith /* Not high enough level */
    {
        (format[localize "STRS_mine_noEnoughSkill", _reqSkill]) call RPP_fnc_hint;
    };
    
    _failChance = _failChance - ((_level - _reqSkill) * 1.25); 
    _earlyChance = ((_level - _reqSkill)) * _earlyChance;
    
    if (_failChance <= 0) then
    {
        _failChance = 0;
    };

    [_getRsc, -1] call RPP_fnc_addInventoryItem;
    RPP_var_isMining = true;
    
    [{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon_sekani2";}, [player]] call RPP_fnet_execPublic;
    
    
    (format[localize "STRS_mine_startMining", _time]) call RPP_fnc_hint;
    _oldTime = time;
    _remainingTime = 0;
    _earlyRoll = 100;
    while {RPP_var_isMining} do /* Loop check */
    {
        _timeLeft = time - _oldTime;
        
        _remainingTime = (round(_time - _timeLeft));
        
        if ((_remainingTime % 8 == 0) && (_remainingTime != 0) && (_remainingTime != _time)) then
        {
            [{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon_sekani2";}, [player]] call RPP_fnet_execPublic;
        };

        if (_remainingTime <= 0) then
        {
            RPP_var_isMining = false;
        };
        
        _earlyRoll = random 100;
        if (_earlyRoll <= _earlyChance) then
        {
            _success = true;
            RPP_var_isMining = false;
        };
        
        if (player distance _obj >= 15) then
        {
            _success = false;
            RPP_var_isMining = false;
        };
        
        if (vehicle player != player) then
        {
            _success = false;
            RPP_var_isMining = false;
        };
        
        //((RPP_display_progress select 0) displayCtrl 1) ctrlSetStructuredText parseText format["<t shadow='true'><t shadowColor='#EEC900'><t size='1.35' color='#4876FF'>Remaining time: %1 seconds</t></t></t>", (round(_time - _timeLeft))];
        sleep 1;
    };
    [{(_this select 0) switchMove "Normal";}, [player]] call RPP_fnet_execPublic;
    
    if (_remainingTime > 0 && (not(_earlyRoll <= _earlyChance))) then
    {
        _success = false;
    };
    
    if (_success) then
    {
        /* Do a roll */
        _roll = random 100;
        
        if (_roll <= _failChance) exitWith
        {
            (format[localize "STRS_mine_mineFail", _getRscName]) call RPP_fnc_hint;
        };
            
        /* Add up experience, get item and such. */
        if (not([_getRsc, 1] call RPP_fnc_addInventoryItem)) exitWith
        {
            localize "STRS_mine_noRoom" call RPP_fnc_hint;
        };

        if (_earlyRoll <= _earlyChance) then
        {
            (format[localize "STRS_mine_mineSuccessEarly", _getRscName, (_time - _remainingTime)]) call RPP_fnc_hint;
        }
        else
        {
            (format[localize "STRS_mine_mineSuccess", _getRscName]) call RPP_fnc_hint;
        };
        [_skill, _exp] call RPP_fnc_increaseSkill;
    };
};

RPP_fnc_cancelMining = 
{
    RPP_var_isMining = false;
    localize "STRS_mine_stopMining" call RPP_fnc_hint;
};

RPP_fnc_setupMines =
{
    {
        _mineID = _x select 0;
        _objects = _x select 1;
        _name = _x select 2;
        _itemClass = (_x select 3) select 4;
        _itemName = _itemClass call RPP_fnc_itemGetName;
        _itemSize = _itemClass call RPP_fnc_itemGetMass;

        _text = format["<t size='0.55' color='#EEC900'>%1</t><br/><t size='0.475'>%2 - %3 sz</t><br/><t size='0.32'>(Help: Zoom in (RMB))<br/></t><t size='0.4'>(Press F to mine)<br/></t><t size='0.4'>(Press T to stop)</t>", _name, _itemName, _itemSize];
        {
            _obj = _x;
            _id = [] call RPP_fnc_generateID;
        
            _onAdd = format[
            '
                [%2, "%1", %3, 0.9, 20, false] call RPP_fnc_create3DText;
                [%3, %4] spawn
                {
                    _onTarget = false;
                    while {player distance (_this select 0) <= 20} do
                    {
                        if (cursorTarget == (_this select 0)) then
                        {
                            [33, "[%4, %3] spawn RPP_fnc_mineResource;", false, false, false] spawn RPP_fnc_addKeyAction;
                            [20, "[] spawn RPP_fnc_cancelMining;", false, false, false] spawn RPP_fnc_addKeyAction;
                            _onTarget = true;
                        }
                        else
                        {
                            if (_onTarget && (cursorTarget != (_this select 0))) then
                            {
                                _onTarget = false;
                                [33, false, false, false ] spawn RPP_fnc_remKeyAction;
                                [20, false, false, false ] spawn RPP_fnc_remKeyAction;
                            };
                        };
                        sleep 0.001;
                    };
                    [33, false, false, false ] spawn RPP_fnc_remKeyAction;
                    [20, false, false, false ] spawn RPP_fnc_remKeyAction;
                };

            ', _text, _id, _obj, _mineID];

            _onRem = format[
            '
                 %1 call RPP_fnc_disable3DText;
            ', _id];

            [player, vehicle player, compile format['(player distance %1 <= 20)', _obj], _onAdd, _id, _onRem] call RPP_fnc_addAction;
        } forEach _objects;
    } forEach RPP_var_miningDefine;
};
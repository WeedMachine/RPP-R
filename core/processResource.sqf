/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_RPP_var_smeltIron = [ ["IronOre", 2], ["IronBar", 1], ["IronOre", 1] ];
_RPP_var_cookBluegill = [ ["Bluegill", 1], ["Cooked_Bluegill", 1], [] ];
_RPP_var_processPopulus = [ ["Populus_Log", 6], ["Wood", 2], [] ];
_ALR_var_processPine = [ ["pine_log", 4], ["Wood", 2], [] ];
_ALR_var_processAlder = [ ["alder_log", 5], ["Wood", 3], [] ];
_ALR_var_processLarix = [ ["larix_log", 3], ["Wood", 3], [] ];
_ALR_var_processMaple = [ ["maple_log", 2], ["Wood", 4], [] ];
_ALR_var_processSand = [ ["Sand", 2], ["Glass", 4], [] ];

RPP_var_processDelay = 1;
RPP_var_processLastUsed = time;

RPP_var_processLocations = 
[
    [process_iron1, "Smelt Iron Ore", "Process", _RPP_var_smeltIron, ["manufacture", 1, 240, 110], 25],
	[process_sand, "Process Sand", "Process", _RPP_var_precessSand, ["manufacture", 1, 240, 110], 25],
    [process_populus, "Saw Populus Log", "Process", _RPP_var_processPopulus, ["manufacture", 1, 240, 110], 25],
	[process_alder, "Saw Alder Log", "Process", _ALR_var_processAlder, ["manufacture", 10, 380, 230], 25],
	[process_pine, "Saw Pine Log", "Process", _ALR_var_processPine, ["manufacture", 20, 340, 280], 25],
	[process_larix, "Saw Larix Log", "Process", _ALR_var_processLarix, ["manufacture", 30, 480, 330], 30],
	[process_maple, "Saw Maple Log", "Process", _ALR_var_processMaple, ["manufacture", 70, 800, 650], 33]
];

RPP_fnc_setupProcessing =
{
    {
        _array = (_x select 3);
        _name = (_x select 1);
        _type = (_x select 2);
        _id = [] call RPP_fnc_generateID;
        _obj = _x select 0;
        
        _reqItem = (_array select 0) select 0;
        _reqAmount = (_array select 0) select 1;
        
        _gainItem = (_array select 1) select 0;
        _gainAmount = (_array select 1) select 1;
        
        _skill = (_x select 4) select 0;
        _reqSkill = (_x select 4) select 1;
        
        _text = format["<t size='0.55' color='#CCCC00'>%1</t><br/><t size='0.425'>%2x %3 = %4x %5</t><br/><t size='0.365'>%7 - Level: %8</t><br/><t size='0.4'>(Press F to %6)<br/></t><t size='0.4'></t>", _name, _reqAmount, _reqItem call RPP_fnc_itemGetName, _gainAmount, _gainItem call RPP_fnc_itemGetName,  _type, _skill call RPP_fnc_getSkillName, _reqSkill];
        _onKeyAccess = "";
        
        _onAdd = format[
        '
            [%2, "%1", %3, 0.9, 20, false] call RPP_fnc_create3DText;
            [%3] spawn
            {
                _onTarget = false;
                while {player distance (_this select 0) <= 20} do
                {
                    if (cursorTarget == (_this select 0)) then
                    {
                        [33, "[%3] call RPP_fnc_processResource;", false, false, false] spawn RPP_fnc_addKeyAction;
                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (cursorTarget != (_this select 0))) then
                        {
                            _onTarget = false;
                            [33, false, false, false ] spawn RPP_fnc_remKeyAction;
                        };
                    };
                    sleep 0.001;
                };
                [33, false, false, false ] spawn RPP_fnc_remKeyAction;
            };

        ', _text, _id, _obj];

        _onRem = format[
        '
             %1 call RPP_fnc_disable3DText;
        ', _id];

        [player, vehicle player, compile format['(player distance %1 <= 20)', _obj], _onAdd, _id, _onRem] call RPP_fnc_addAction;
    } forEach RPP_var_processLocations;
};

RPP_fnc_processResource = 
{
    private ["_obj", "_processArray", "_reqItem", "_reqAmount", "_gainItem", "_gainAmount", "_skill", "_reqSkill", "_failChance", "_failItem", "_failAmount"];
    _obj = _this select 0;
    _processArray = _obj call RPP_fnc_processGetArray;
    _array = _processArray select 3;
    
    _reqItem = (_array select 0) select 0;
    _reqAmount = (_array select 0) select 1;

    _gainItem = (_array select 1) select 0;
    _gainAmount = (_array select 1) select 1;

    _skill = (_processArray select 4) select 0;
    _reqSkill = (_processArray select 4) select 1;
    _skillGained = (_processArray select 4) select 2;
    _skillFailed = (_processArray select 4) select 3;
    
    _failChance = (_processArray select 5);
    
    _failItem = "";
    _failAmount = 0;
    
    if (count (_array select 2) > 0) then
    {
        _failItem = (_array select 2) select 0;
        _failAmount = (_array select 2) select 1;
    };
    
    if (((RPP_var_processLastUsed)+RPP_var_processDelay) > time) exitWith
    {
        localize "STRS_process_cantDo" call RPP_fnc_hint;
    };
    
    RPP_var_processLastUsed = time;
    
    _level = ((_skill call RPP_fnc_getExperience) call RPP_fnc_calculateLevel);
    _failChance = _failChance - ((_level - _reqSkill) * 1.25); 
    
    if (_level < _reqSkill) exitWith
    {
        localize "STRS_process_lowlevel" call RPP_fnc_hint;
    };
    
    if (_reqItem call RPP_fnc_itemGetAmount < _reqAmount) exitWith
    {
        (format[localize "STRS_process_noMaterials", _reqAmount, _reqItem call RPP_fnc_itemGetName]) call RPP_fnc_hint;
    };
    
    ["RPP_fnc_serverSwitchAnimation", [player, "AinvPknlMstpSlayWrflDnon_AmovPercMstpSnonWnonDnon"]] call RPP_fnet_execPublic;
    
    _roll = random 100;
    if (_roll <= _failChance) exitWith
    {
        if (_failItem != "") then
        {
            [_failItem, -_failAmount] call RPP_fnc_addInventoryItem;
            (format[localize "STRS_process_failedItem", _failAmount, _failItem call RPP_fnc_itemGetName]) call RPP_fnc_hint;
        }
        else
        {
            localize "STRS_process_failed" call RPP_fnc_hint;
        };
        
        [_reqItem, -_reqAmount] call RPP_fnc_addInventoryItem;
        
        [_skill, _skillFailed] call RPP_fnc_increaseSkill;
    };
    
    [_reqItem, -_reqAmount] call RPP_fnc_addInventoryItem;
    if ([_gainItem, _gainAmount] call RPP_fnc_addInventoryItem) then
    {
        (format[localize "STRS_process_success", _gainAmount, _gainItem call RPP_fnc_itemGetName, _reqAmount, _reqItem call RPP_fnc_itemGetName]) call RPP_fnc_hint;
        
        /* Gain experience */
        [_skill, _skillGained] call RPP_fnc_increaseSkill;
    }
    else
    {
        /* No room */
        [_reqItem, +_reqAmount] call RPP_fnc_addInventoryItem;
        localize "STRS_process_noSpace" call RPP_fnc_hint;        
    };
       

};

RPP_fnc_processGetArray = 
{
    private ["_obj", "_return"];
    _obj = _this;
    _return = [];
    
    {
        if (_x select 0 == _obj) exitWith
        {
            _return = _x;
        };  
    } forEach RPP_var_processLocations;
    
    _return
};
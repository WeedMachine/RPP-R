/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

//Class, Bait, Required Level, [Min Depth, Max Depth], Chance, Exp
RPP_var_fishingRod_define =
[
    ["Minnow", "", 1, [0, 100], 25, 160], 
    ["Bluegill", "Worm", 1, [0, 100], 17, 220],
    ["Catfish", "Minnow", 20, [0, 100], 6, 280],
	["Perch", "Worm", 10, [0, 100], 10, 230],
	["Trout", "Worm", 15, [0, 100], 8, 210],
	["RockBass", "Minnow", 25, [0, 100], 4, 310]
];

ALR_var_fishingnet_define =
[
    ["Shrimp", "", 1, [100, 200], 25, 180], 
    ["Sardine", "Worm", 10, [100, 200], 17, 250],
    ["Monkfish", "Minnow", 60, [100, 200], 2, 600],
	["Salmon", "Worm", 30, [100, 200], 4, 370]
];

ALR_var_harpoon_define =
[
	["Shark", "", 65, [200, 400], 2, 620], 
    ["Tuna", "", 25, [200, 400], 4, 350],
    ["Whale", "", 99, [200, 600], 1, 1200],
	["Swordfish", "", 50, [200, 400], 10, 500]
];
	

RPP_var_fishing_items = 
[
    "Fishing_rod",
	"Fishing_net",
	"Harpoon"
];

RPP_var_fishingExp = 24;

RPP_var_fishing_define = 
[
    ["Fishing_rod", RPP_var_fishingRod_define, "CtsDoktor_Vojak_uder1"],
	["Fishing_net", ALR_var_fishingnet_define, "CtsDoktor_Vojak_uder1"],
	["Harpoon", ALR_var_harpoon_define, "CtsDoktor_Vojak_uder1"]
];

RPP_var_isFishing = false;

RPP_fnc_startFishing = 
{
    private ["_item", "_ticks", "_position", "_fishingArray", "_animation"];
    _item = _this select 0;
    
    if (not(surfaceIsWater position (vehicle player))) exitWith
    {
        /* Cannot fish here */
        localize "STRS_fishing_notWater" call RPP_fnc_hint;
    };
    
    /* Can stop fishing now */
    [46, "RPP_var_isFishing = false;", false, false, false] spawn RPP_fnc_addKeyAction;
    
    RPP_var_isFishing = true;
    _ticks = 0;
    _position = getpos player;
    _fishingArray = _item call RPP_fnc_fishingGetArray;
    _animation = _fishingArray select 2;
    
    if (vehicle player == player) then
    {
        ["RPP_fnc_serverSwitchAnimation", [player, _animation]] call RPP_fnet_execPublic;
    };
    
    (localize "STRS_fishing_startFishing") call RPP_fnc_hint;
    
    while {RPP_var_isFishing} do
    {          
        if ((vehicle player == player) && (player distance _position >= 5)) then
        {
            /* Player moved too far */
            RPP_var_isFishing = false;
        };
        
        if ((_ticks % 240 == 0) && (_ticks != 0)) then /* Stop idle people */
        {
            RPP_var_isFishing = false;
        };
        
        _aCatchChance = 15;
        _aCatchRoll = random 100;
        
        if (_aCatchRoll <= _aCatchChance) then
        {
            _randomFish = ((_fishingArray select 1) select (random(count (_fishingArray select 1)-1)));
            _fishClass = _randomFish select 0;
            _bait = _randomFish select 1;
            _reqLevel = _randomFish select 2;
            _depths = _randomFish select 3;
            _minDepth = _depths select 0;
            _maxDepth = _depths select 1;
            _chance = _randomFish select 4;
            _roll = random 100;
            _level = ("fishing" call RPP_fnc_getExperience) call RPP_fnc_calculateLevel;
            _chance = _chance + ((_level - _reqLevel) * 1.25); 
            _gainExp = _randomFish select 5;
            
            if (_roll <= _chance) then /* Catch a fish if level is ok and depth is ok */
            {
                _playerHeight = abs (getTerrainHeightASL position vehicle player);
                if (_playerHeight >= _minDepth && _playerHeight <= _maxDepth) then
                {
                    /* We are the ok depth, lets check we have the right level */
                    if (_level >= _reqLevel) then /* Required level is ok, lets catch it if we have the right bait */
                    {
                        if ((_bait call RPP_fnc_itemGetAmount >= 1) || (_bait == "")) then
                        {    
                            if ([_fishClass, 1] call RPP_fnc_addInventoryItem) then
                            {
                                /* Everything ok */
                                
                                if (_bait != "") then
                                {
                                    [_bait, -1] call RPP_fnc_addInventoryItem;
                                };
                                
                                /* Add experience */
                                ["fishing", _gainExp] call RPP_fnc_increaseSkill;
                                
                                (format[localize "STRS_fishing_catch", _fishClass call RPP_fnc_itemGetName]) call RPP_fnc_hint;
                            }
                            else
                            {
                                /* Not enough space */
                                (localize "STRS_fishing_noSpace") call RPP_fnc_hint;
                            };
                        }
                        else
                        {
                            (localize "STRS_fishing_failCatchBait") call RPP_fnc_hint;
                        };
                    }
                    else
                    {
                        (localize "STRS_fishing_failCatchLevel") call RPP_fnc_hint;
                    
                    };
                };
            
            };
        };
        
        if (_ticks % 6 == 0) then
        {
            if (vehicle player == player) then
            {
                ["RPP_fnc_serverSwitchAnimation", [player, _animation]] call RPP_fnet_execPublic;
            };
        };
        
        ["fishing", RPP_var_fishingExp] call RPP_fnc_increaseSkill;
                         
        _ticks = _ticks + 1;
        sleep 1;
    };
    
    if (vehicle player == player) then
    {
        ["RPP_fnc_serverSwitchAnimation", [player, "normal"]] call RPP_fnet_execPublic;
    };
    
    (localize "STRS_fishing_stopFishing") call RPP_fnc_hint;
    
    
    [46, false, false, false] spawn RPP_fnc_remKeyAction;
};

RPP_fnc_fishingGetArray = 
{
    private ["_item", "_return"];
    _item = _this;
    _return = [];
    
    {
        if ((_x select 0) == _item) exitWith
        {
            _return = _x;
        };
    } forEach RPP_var_fishing_define;
    
    _return
};
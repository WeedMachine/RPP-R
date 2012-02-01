/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/


/*
	* Description: The array of all the different sprout classes and there values
	* Parameters:
		(0) Sprout class (string)
		(1) Type the sprout is (string)
		(2) Class that the sprout grows into (string)
		(3) Model class that it grows into (string)
		(4) Time it takes to grow (integer)
		(5) Parameters:
			(0) Sprout class that grows on it (string)
			(1) Chance of a sprout to grow on it per growth cycle (integer)
			(2) Item class required to pick sprout (string)
			(3) Sprout picking animation (string)
        (6) Chance of it dying
        (7) String name
		(8) Parameters:
                        (0) Skill 
                        (1) Required Level
                        (2) Experience gained
*/
RPP_var_forestry_sprouts = 
[
    //TIER 1
    ["populus_seed", "TREE", "populus_tree", "AS_t_populusF2s_EP1", 10, ["populus_seed", 8, "", "normal"], 20, "Populus Tree", ["forestry", 1, 280]],
	["cabbage_seed", "BUSH", "cabbage_patch", "MAP_p_urtica", 13, ["cabbage_seed", 5, "", "normal"], 35, "Cabbage Patch", ["forestry", 1, 280]],
	//["wheat_seed", "BUSH", "wheat_plant", "AS_p_wheat_EP1", 600, ["", 0, "", "normal"], 40, "Wheat"]
	["apple_seed", "BUSH", "apple_bush", "MAP_t_betula1f", 20, ["apple_seed", 5, "sickle", "normal"], 35, "Apple Tree", ["forestry", 5, 410]],

	//TIER 2
	["potato_sprouts", "BUSH", "potato_patch", "MAP_c_fern", 20, ["patato_sprouts", 5, "", "normal"], 35, "Pumpkin Patch", ["forestry", 10, 820]],
	["alder_seed", "TREE", "alder_tree", "MAP_t_pinusN2s", 10, ["alder_seed", 8, "sickle", "normal"], 20, "Alder Tree", ["forestry", 20, 980]],
	["rubber_seed", "TREE", "rubber_tree", "MAP_t_pyrus2s", 10, ["rubber_seed", 8, "", "normal"], 20, "Ruber Tree", ["forestry", 10, 720]], 
	
	//TIER 3
	["pumpkin_seed", "BUSH", "pumpkin_patch", "MAP_p_urtica", 20, ["pumpkin_seed", 5, "", "normal"], 35, "Pumpkin Patch", ["forestry", 25, 1240]],
	["pine_seed", "TREE", "pine_tree", "MAP_t_picea2s", 30, ["pine_seed", 12, "sickle", "normal"], 20, "Pine Tree", ["forestry", 40, 1650]],
	["mari_seed", "BUSH", "mari_bush", "AS_p_fiberPlant_EP1", 20, ["mari_seed", 5, "", "normal"], 35, "Marihuana Bush", ["forestry", 40, 1650]],	
	
	//TIER 4
	["cocaine_seed", "BUSH", "cocaine_bush", "as_t_JuniperusC2s_EP1", 40, ["cocaine_seed", 12, "sickle", "normal"], 40, "Cocaine Bush", ["forestry", 45, 2350]],
	["larix_seed", "TREE", "larix_tree", "MAP_t_larix3s", 20, ["larix_seed", 8, "sickle", "normal"], 15, "Larix Tree", ["forestry", 50, 3250]],
	
	//TIER 5
	["maple_seed", "TREE", "maple_tree", "MAP_t_carpinis2s", 40, ["maple_seed", 8, "sickle", "normal"], 15, "Maple Tree", ["forestry", 70, 8000]]
	
];

if (isServer) then
{
    RPP_var_forestry_serverBushes = [];
};

/* We use this for actions, Note: Case sensitive */ 
RPP_var_forestry_typeBushes = [ "as_p_fiberPlant_EP1", "MAP_p_urtica", "MAP_t_betula1f", "MAP_c_fern", "as_t_JuniperusC2s_EP1"];
{ RPP_var_forestry_typeBushes set[_forEachIndex, toLower _x]; } forEach RPP_var_forestry_typeBushes;
RPP_var_forestry_typeTrees = [ "as_t_PopulusF2s_EP1", "MAP_t_larix3s", "MAP_t_carpinis2s", "MAP_t_picea2s", "MAP_t_pinusN2s", "MAP_t_pyrus2s" ];
{ RPP_var_forestry_typeTrees set[_forEachIndex, toLower _x]; } forEach RPP_var_forestry_typeTrees;
RPP_var_forestry_typeTrunks = [ "as_Misc_trunk_torzo_ep1", "MAP_misc_FallenTree2" ];
{ RPP_var_forestry_typeTrunks set[_forEachIndex, toLower _x]; } forEach RPP_var_forestry_typeTrunks;
RPP_var_cuttingTree = false;


/*
	* Description: An array of all the surface types that can have things planted on them
*/
RPP_var_plantableSurfaceTypes = 
[
    "#cmmGrass1"
];
 
/* Number of times that the tree/bush will grow */
RPP_var_forestry_growthCycles = 30;

/* Starting height of the plants underground */	
RPP_var_forestry_startHeight = -20;

/*
	* Description: The array of all the tree values for forestry
	* Parameters:
		(0) Tree Class (string)
		(1) Parameters:
			(0) Model class for fallen tree (string)
		(2)  Damage until tree is cut down (integer)
		(3) Parameters:
			(0) Class of item gathered from fallen tree (string)
			(1) Minimum the tree will produce (integer)
			(2) Maximum the tree will produce (integer)
		(4) Parameters:
			(0) Skill class used (string)
			(1) Experience Gained
			(2) Normal damage done to tree (integer)
		(5) Time it takes to chip at the tree (integer)
		(6) Item class required to cut it down (string)
		(7) Parameters:
			(0) Cutting animation (string)
			(1) Sawing animation (string)
*/
RPP_var_forestry_trees = 
[
	["populus_tree", ["AS_Misc_trunk_torzo_ep1"], 10, ["populus_log", 2, 6], ["forestry", 220, 50], 7, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]],
	["alder_tree", ["MAP_misc_FallenTree2"], 10, ["alder_log", 2, 6], ["forestry", 480, 50], 9, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]],
	["pine_tree", ["AS_Misc_trunk_torzo_ep1"], 20, ["pine_log", 2, 6], ["forestry", 670, 50], 13, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]],
	["larix_tree", ["MAP_misc_FallenTree2"], 20, ["larix_log", 3, 8], ["forestry", 720, 50], 15, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]],
	["maple_tree", ["MAP_misc_FallenTree2"], 30, ["maple_log", 4, 8], ["forestry", 890, 50], 20, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]],
	["rubber_tree", ["MAP_misc_FallenTree2"], 10, ["rubber_log", 2, 6], ["forestry", 480, 50], 9, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]]
];

/*
	* Description: The array of all the bush values for gathering
	* Parameters:
		(0) Bush Class (string)
		(1) Parameters:
			(0) Minimum possibility for gather capacity (integer)
			(1) Maximum possibilty for gather capacity (integer)
			(2) Class of the item gathered from the bush (string)
		(2) Parameters:
			(0) Maximum can be gathered from the bush before it dies (integer)
		(3) Time it takes to gather from the bush (integer)
		(4) Time decrease per ever 1 skill (integer) OBSOLETE
		(5) Parameters:
			(0) Time until the harvest grows back on it in seconds (integer)
			(1) Minimum that will grow back on it (integer)
			(2) Maximum that will grow back on it (integer)
                (6) Parameters:
                        (0) Skill Used
                        (1) Experience Gained
		(7) Item class required to harvest (string)
		(8) Harvesting animation (string)
*/
RPP_var_forestry_bushes = 
[
	["apple_bush", [3,7, "Apple"], [12], 18, 0.5, [300, 0,10], ["forestry", 240], "", "AinvPknlMstpSlayWrflDnon_medic"],
	["potato_patch", [4,7, "Potato"], [12], 18, 0.5, [300, 0,10], ["forestry", 160], "", "AinvPknlMstpSlayWrflDnon_medic"],
	["pumpkin_patch", [1,3, "Pumpkin"], [12], 18, 0.5, [300, 0,10], ["forestry", 180], "", "AinvPknlMstpSlayWrflDnon_medic"],
	["cabbage_patch", [1,3, "Cabbage"], [12], 18, 0.5, [300, 0,10], ["forestry", 80], "", "AinvPknlMstpSlayWrflDnon_medic"],
	["cocaine_seed", [1,3, "cocaine"], [12], 18, 0.5, [300, 0,10], ["forestry", 480], "", "AinvPknlMstpSlayWrflDnon_medic"],
    ["mari_bush", [1,3, "mari"], [3], 20, 0.5, [300, 0,10], ["forestry", 440], "", "AinvPknlMstpSlayWrflDnon_medic"]
	
];

RPP_fnc_forestry_plantSprout = 
{
    private ["_sproutClass", "_sproutType", "_growClass", "_surfaceType", "_modelClass", "_random", "_deathChance", "_nearestObjects"];
    _sproutClass = (_this select 0);
    _sproutType = _sproutClass call RPP_fnc_sprout_getType;
    _growClass = _sproutClass call RPP_fnc_sprout_getGrowClass;
    _surfaceType = surfaceType getpos player;
    _modelClass = _sproutClass call RPP_fnc_sprout_getModelClass;
    _random = (random 100);
    _deathChance = _sproutClass call RPP_fnc_sprout_getDeathChance;
    _nearestObjects = nearestObjects [player, [_modelClass], 6];
    _skill = _sproutClass call RPP_fnc_sprout_getSkill;
    _requiredLevel = _sproutClass call RPP_fnc_sprout_getRequiredLevel;
    _experience = _sproutClass call RPP_fnc_sprout_getExperience;
    _position = getPosATL player;
    
    closeDialog 0;
    
    _level = (_skill call RPP_fnc_getExperience) call RPP_fnc_calculateLevel;
    
    if (_level < _requiredLevel) exitWith
    {
        (format[localize "STRS_forestry_levelNo", _requiredLevel, _skill call RPP_fnc_getSkillName]) call RPP_fnc_hint;
    };

    if (count _nearestObjects <= 0) then
    {	
        if (vehicle player == player) then
        {
            if (_surfaceType in RPP_var_plantableSurfaceTypes) then
            {
                [_sproutClass, -1] call RPP_fnc_addInventoryItem;
                if (_random > _deathChance) then
                {
                     [_skill, _experience] call RPP_fnc_increaseSkill;
                    _varName = format["plant_%1_%2_%3_%4", (round(position player select 0)), (round(position player select 1)), (round(position player select 2)), _sproutClass];
                    _object = _modelClass createVehicle position player;
                    _object setPos [position player select 0, position player select 1, RPP_var_forestry_startHeight];
                    call compile format
                    ['
                        _object setVehicleInit "this setVehicleVarName ""%1""; 
                        _object = this; 
                    ";', _varName];
                    processInitCommands;	
                    [_object, (_sproutClass) call RPP_fnc_sprout_getGrowTime, _sproutClass, (_sproutClass) call RPP_fnc_sprout_getSproutchance, _position] spawn RPP_fnc_forestry_growthCycle;
                    format[localize "STRS_forestry_planted", (_sproutClass) call RPP_fnc_itemGetName] call RPP_fnc_hint;
                }	
                else
                {
                   localize "STRS_forestry_plantDied" call RPP_fnc_hint;
                };
            }	
            else
            {
               localize "STRS_forestry_wrongTerrain" call RPP_fnc_hint;
            };
        }
        else
        {
            localize "STRS_forestry_inVehicle" call RPP_fnc_hint;
        };
    }
    else
    {
        localize "STRS_forestry_tooClose" call RPP_fnc_hint;
    };
};

RPP_fnc_forestry_growthCycle = 
{
    private ["_object", "_growthTime", "_sproutClass", "_growthChance", "_sproutType", "_plantName", "_growthSproutClass", "_itemReq", "_growCycleTime", "_increasedHeightAmount", "_i"];
    _object = (_this select 0);
    _growthtime = (_this select 1);
    _sproutClass = (_this select 2);
    _growthChance = (_this select 3);
    _position = (_this select 4);
    _sproutType = (_sproutClass) call RPP_fnc_sprout_getType;
    _plantName = (_sproutClass) call RPP_fnc_sprout_getName;
    _growthSproutClass = (_sproutClass) call RPP_fnc_sprout_getGrowthClass;
    _itemReq = (_sproutClass) call RPP_fnc_sprout_getItemForSprout;

    private ["_growCycleTime", "_increaseHeightAmount"];
    _growCycleTime = _growthTime / RPP_var_forestry_growthCycles;
    _increaseHeightAmount = RPP_var_forestry_startHeight / RPP_var_forestry_growthCycles;

    private ["_i"];
    _i = 0;

    _object setVariable["numSprouts", 0, true];
    _object setVariable["sproutType", _growthSproutClass, true];
    _object setVariable["sproutReqItem", _itemReq, true];

    while {_i < RPP_var_forestry_growthCycles} do 
    {
        sleep _growCycleTime;
        _rand = (random 100);
        if (_rand <= _growthChance) then { _object setVariable["numSprouts", (_object getVariable "numSprouts")+1, true]; };

        if ((getTerrainHeightASL (getPosASL _object)) < ((getposASL _object) select 2)) then
        {
            _increaseHeightAmount = 0;
        }
        else
        {
            _object setpos [position _object select 0, position _object select 1, (position _object select 2)+ (abs _increaseHeightAmount)];
        };
        _i = _i + 1;
    };
    
    
    _object setPos _position;
    
    if (_sproutType == "TREE") then
    {
        [_object, _sproutClass] call RPP_fnc_forestry_setupTree;
    }
    else
    {
        [_object, _sproutClass] call RPP_fnc_forestry_setupBush;
    };
};

RPP_fnc_forestry_chopTreeTrunk = 
{
    private ["_object", "_treeClass", "_anims", "_requiredItem", "_itemAmount"];
    _object = (_this select 0);
    _treeClass = (_object) getVariable "class";
    _anims = (_treeClass) call RPP_fnc_tree_getAnimations;
    _requiredItem = (_treeClass) call RPP_fnc_tree_getRequiredItem;;
    _itemAmount = 0;

    if (_requiredItem != "") then
    {
        _itemAmount = (_requiredItem) call RPP_fnc_itemGetAmount;
    };

    if !(RPP_var_cuttingTree) then
    {
        if ((_itemAmount > 0) || (_requiredItem == "")) then
        {
            localize "STRS_forestry_chopTrunk" call RPP_fnc_hint;
            RPP_var_cuttingTree = true;
            [{ (_this select 0) switchMove (_this select 1); }, [player, (_anims select 1)]] call RPP_fnet_execPublic;
            sleep 2;
            RPP_var_cuttingTree = false;
            _numResources = (_object) getVariable "numResources";
            _resourceClass = (_object) getVariable "resourceClass";

            if ([_resourceClass,1] call RPP_fnc_addInventoryItem) then
            {
                format[localize "STRS_forestry_chopTrunkDone", (_resourceClass) call RPP_fnc_itemGetName] call RPP_fnc_hint;
                _object setVariable ["numResources", ((_numResources)-1), true];

                if (((_numResources)-1) <= 0) then
                {
                    deleteVehicle _object;
                };
            };
        };
    }
    else
    {
        localize "STRS_forestry_doingAction" call RPP_fnc_hint;
    };
			

};

RPP_fnc_forestry_setupTree = 
{
	private ["_object", "_sproutClass", "_plantName", "_growClass", "_gatherValues", "_skillUsed", "_decreasedDamagePerSkill", "_skillAmount", "_totalDamage", "_itemClass", "_minAmount", "_maxAmount", "_total"];
	_object = (_this select 0);
	_sproutClass = (_this select 1);
	_plantName = (_sproutClass) call RPP_fnc_sprout_getName;
	_growClass = (_sproutClass) call RPP_fnc_sprout_getGrowClass;
	_gatherValues = (_growClass) call RPP_fnc_tree_getGatherValues;
	_totalDamage = 100;
	_itemClass = (_gatherValues select 0);
	_minAmount = (_gatherValues select 1);
	_maxAmount = (_gatherValues select 2);
	_total = (floor(random((_maxAmount - _minAmount)+ _minAmount)));
	if (_total <= 0) then { _total = 1; };
	_object setVariable["grownFrom", _sproutClass, true];
	_object setVariable["class", _growClass, true];
	_object setVariable["numResources", _total, true];
	_object setVariable["resourceClass", _itemClass, true];
	_object setVariable["damage", _totalDamage, true];
        
        _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.4'>(Press F to cutdown)<br/></t><t size='0.4'>(Press T to pick sprouts)<br/>", _plantName];
	
	call compile format['
		_object setVehicleInit "
                    [this, ""%2""] spawn
                    {
                        if (isNil ""RPP_fnc_create3DText"") then
                        {
                            _script = [] execVM ""core\text3D.sqf"";
                            waitUntil {scriptDone _script};
                        };

                        [[] call RPP_fnc_generateID, (_this select 1), (_this select 0), 0.8, 5, true] spawn RPP_fnc_create3DText;
                    };
                    this setVariable [""hasActions"", true, false];
                ";', _plantName, _text];
	processInitCommands;
};

RPP_fnc_forestry_setupBush = 
{
	private ["_object", "_sproutClass", "_plantName", "_plantName", "_growClass", "_gatherValues", "_deathValues", "_usedSkill"]; 
        private ["_harvestValues", "_skillAmount", "_minAmount", "_maxAmount", "_itemClass", "_total", "_maxGatheredTillDeath", "_deathLimitIncreasesBy", "_perSkillDeathLimitIncreases", "_increase", "_totalIncrease"];
	_object = (_this select 0);
	_sproutClass = (_this select 1);
	_plantName = (_sproutClass) call RPP_fnc_sprout_getName;
	_growClass = (_sproutClass) call RPP_fnc_sprout_getGrowClass;
	_gatherValues = (_growClass) call RPP_fnc_bush_getGatherValues;
	_deathValues = (_growClass) call RPP_fnc_bush_getDeathValues;
	_usedSkill = (_growClass) call RPP_fnc_bush_getSkill;
	_harvestValues = (_growClass) call RPP_fnc_bush_getHarvestValues;
	_minAmount = (_gatherValues select 0);
	_maxAmount = (_gatherValues select 1);
	_itemClass = (_gatherValues select 2);
	_total = (floor(random((_maxAmount - _minAmount)+ _minAmount)));
	_maxGatheredTillDeath = (_deathValues select 0);
	if (_total <= 0) then { _total = 1; };
	
	[{ if (isServer) then { RPP_var_forestry_serverBushes = RPP_var_forestry_serverBushes + [ [(_this select 0), (_this select 1), (_this select 2), (_this select 3), time] ]; }; }, [_object, (_harvestValues select 0), (_harvestValues select 1), (_harvestValues select 2)]] call RPP_fnet_execPublic;
	
	_totalIncrease = _maxGatheredTillDeath;

	_object setVariable["grownFrom", _sproutClass, true];
	_object setVariable["class", _growClass, true];
	_object setVariable["deathMax", _totalIncrease, true];
	_object setVariable["curHarvested", 0, true];
	_object setVariable["maxCapacity", _total, true];
	_object setVariable["resourceClass", _itemClass, true];
	_object setVariable["numResources", 0, true];
        
        _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.4'>(Press F to harvest)<br/></t><t size='0.4'>(Press T to pick sprouts)<br/></t><t size='0.4'>(Press B to check)<br/></t>", _plantName];

	call compile format['
		_object setVehicleInit 
                "
                    [this, ""%2""] spawn
                    {
                        if (isNil ""RPP_fnc_create3DText"") then
                        {
                            _script = [] execVM ""core\text3D.sqf"";
                            waitUntil {scriptDone _script};
                        };

                        [[] call RPP_fnc_generateID, (_this select 1), (_this select 0), 0.8, 5, true] spawn RPP_fnc_create3DText;
                    };
                    this setVariable [""hasActions"", true, false];
                ";
        ', _plantName, _text];
	processInitCommands;
};

RPP_fnc_forestry_checkBush =
{
    private ["_object", "_numResources", "_resourceClass", "_sproutclass", "_plantName", "_numSprouts"];
    _object = (_this select 0);
    _numResources = _object getVariable "numResources";
    _resourceClass = _object getVariable "resourceClass";
    _sproutClass = (_object) getVariable "grownFrom";
    _plantName = (_sproutClass) call RPP_fnc_sprout_getName;
    _numSprouts = _object getVariable "numSprouts";
    
    if (_numResources > 0) then
    {
        if (_numSprouts > 0) then
        {
            format[localize "STRS_forestry_checkHasStuffS", _numResources, (_resourceClass) call RPP_fnc_itemGetName, _plantName, (_object getVariable "sproutType") call RPP_fnc_itemGetName, _numSprouts] call RPP_fnc_hint;
        }
        else
        {
            format[localize "STRS_forestry_checkHasStuff", _numResources, (_resourceClass) call RPP_fnc_itemGetName, _plantName] call RPP_fnc_hint;
        };
    }
    else
    {
        if (_numSprouts <= 0) then
        {
            format[localize "STRS_forestry_checkNothing", _plantName] call RPP_fnc_hint;
        }
        else
        {
            format[localize "STRS_forestry_checkNothingS", _plantName, (_object getVariable "sproutType") call RPP_fnc_itemGetName, _numSprouts] call RPP_fnc_hint;
        };
    };
};

RPP_fnc_forestry_cutTree =
{
    private ["_object", "_damage", "_resourceAmount", "_resourceClass", "_treeClass", "_plantName", "_requiredItem", "_timeToCut"];
    private ["_damagePerHit", "_skill", "_experience", "_itemAmount", "_totalTime", "_anims"];
    _object = (_this select 0);
    _resourceAmount = (_object) getVariable "numResources";
    _resourceClass = (_object) getVariable "resourceClass";
    _treeClass = (_object) getVariable "class";
    _plantName = (_object getVariable "grownFrom") call RPP_fnc_sprout_getName;
    _requiredItem = (_treeClass) call RPP_fnc_tree_getRequiredItem;
    _timeToCut = (_treeClass) call RPP_fnc_tree_getCuttingTime;
    _damagePerHit = (_treeClass) call RPP_fnc_tree_getDamagePerHit;
    _skill = _treeClass call RPP_fnc_tree_getSkill;
    _experience = _treeClass call RPP_fnc_tree_getExperience;
    _itemAmount = 0;
    _totalTime = _timeToCut;
    _anims = (_treeClass) call RPP_fnc_tree_getAnimations;

    if (_totalTime < 0) then { _totalTime = 0; };

    if (_requiredItem != "") then
    {
        _itemAmount = (_requiredItem) call RPP_fnc_itemGetAmount;
    };

    if ((_itemAmount > 0) || (_requiredItem == "")) then
    {
        if !(RPP_var_cuttingTree) then
        {
            RPP_var_cuttingTree = true;

            [{ (_this select 0) switchMove (_this select 1); }, [player, (_anims select 0)]] call RPP_fnet_execPublic;

            format[localize "STRS_forestry_cutTree", ((round(_totalTime * 100))/100)] call RPP_fnc_Hint;
            sleep _totalTime;
            _damage = (_object) getVariable "damage";
            _totalDamage = ((_damage) - (random(_damagePerHit)));
            [_skill, _experience] call RPP_fnc_increaseSkill;

            if (player distance _object <= 12) then
            {
                if (_totalDamage <= 0) then
                {
                    _trunkClass = (_treeClass) call RPP_fnc_tree_getTrunkClass;
                    _trunk = _trunkClass createVehicle getpos _object;
                    waitUntil {alive _trunk};
                    _trunk setPos getPosATL _object;
                   // _trunk setpos [position _object select 0, position _object select 1, _height];
                    format[localize "STRS_forestry_cutDown", _resourceAmount] call RPP_fnc_hint;
                    deleteVehicle _object;
                    
                     _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.4'>(Press F to chop up)<br/></t>", _plantName];

                    _varName = format["treetrunk_%1_%2_%3", (round(position player select 0)), (round(position player select 1)), (round(position player select 2))];
                    call compile format['
                            _trunk setVehicleInit "this setVehicleVarName ""%1""; 
                            [this, ""%2""] spawn
                            {
                                if (isNil ""RPP_fnc_create3DText"") then
                                {
                                    _script = [] execVM ""core\text3D.sqf"";
                                    waitUntil {scriptDone _script};
                                };

                                [[] call RPP_fnc_generateID, (_this select 1), (_this select 0), 0.8, 5, true] spawn RPP_fnc_create3DText;
                            };
                            this setVariable [""hasActions"", true, false];
                            
                    ";', _varName, _text];
                    player reveal _trunk;
                    processInitCommands;

                    _trunk setVariable["resourceClass", _resourceClass, true];
                    _trunk setVariable["numResources", _resourceAmount, true];
                    _trunk setVariable["class", _treeClass, true];

                }
                else
                {
                    format[localize "STRS_forestry_chipTree", ((round(_totalDamage * 100))/100)] call RPP_fnc_hint;
                    _object setVariable["damage", _totalDamage, true];
                };
            }
            else
            {
                localize "STRS_forestry_movedAway" call RPP_fnc_hint;
            };
        RPP_var_cuttingTree = false;
        }
        else
        {
            localize "STRS_forestry_doingAction" call RPP_fnc_hint;
        };	
    }
    else
    {
        format[localize "STRS_forestry_reqItem", (_requiredItem) call RPP_fnc_itemGetName] call RPP_fnc_hint;
    };
};

RPP_fnc_forestry_harvestBush = 
{
    private ["_object", "_resourceAmount", "_resourceClass", "_bushClass", "_requiredItem", "_timeToHarvest", "_timeDecreasePerSkill", "_usedSkill", "_skillAmount", "_harvestAnim", "_optimalSkillRange", "_itemAmount", "_sproutClass", "_plantName", "_totalTime"];
    _object = (_this select 0);
    _resourceAmount = (_object) getVariable "numResources";
    _resourceClass = (_object) getVariable "resourceClass";
    _bushClass = (_object) getVariable "class";
    _requiredItem = (_bushClass) call RPP_fnc_bush_getRequiredItem;
    _timeToHarvest = (_bushClass) call RPP_fnc_bush_getHarvestTime;
    _usedSkill = (_bushClass) call RPP_fnc_bush_getSkill;
    _experience = _bushClass call RPP_fnc_bush_getExperience;
    _harvestAnim = (_bushClass) call RPP_fnc_bush_getHarvestAnim;
    _itemAmount = 0;
    _sproutClass = (_object) getVariable "grownFrom";
    _plantName = (_sproutClass) call RPP_fnc_sprout_getName;
    _totalTime = _timeToHarvest;
    
    if (_requiredItem != "") then
    {
        _itemAmount = (_requiredItem) call RPP_fnc_itemGetAmount;
    };

    if ((_itemAmount > 0) || (_requiredItem == "")) then
    {
        if !(RPP_var_cuttingTree) then
        {	
            if (_resourceAmount > 0) then
            {
                RPP_var_cuttingTree = true;
                format[localize "STRS_forestry_harvestStart", _plantName, ((round(_totalTime * 100))/100)] call RPP_fnc_hint;

                [{ (_this select 0) switchMove (_this select 1); }, [player, _harvestAnim]] call RPP_fnet_execPublic;

                sleep _totalTime;

                if (player distance _object <= 12) then
                {
                    if (((_object) getVariable "numResources") >= 1) then
                    {
                        if ([_resourceClass, 1] call RPP_fnc_addInventoryItem) then
                        {
                            [_usedSkill, _experience] call RPP_fnc_increaseSkill;
                            _object setVariable ["numResources",((_object getVariable "numResources")-1), true];
                            _object setVariable ["curHarvested", ((_object getVariable "curHarvested") +1), true];
                            format[localize "STRS_forestry_harvestDone", 1, (_resourceClass) call RPP_fnc_itemGetName, _plantName] call RPP_fnc_hint;

                            _deathMax = (_object) getVariable "deathMax";
                            _curHarvested = (_object) getVariable "curHarvested";

                            if (_deathMax <= _curHarvested) then
                            {
                                format[localize "STRS_forestry_hasDied", _plantName] call RPP_fnc_hint;
                                deleteVehicle _object;
                            };
                        };
                    };
                }
                else
                {
                    localize "STRS_forestry_movedAway" call RPP_fnc_hint;
                };
            }
            else
            {
                localize "STRS_forestry_noHarvest" call RPP_fnc_hint;
            };
            RPP_var_cuttingTree = false;
        }
        else
        {
            localize "STRS_forestry_doingAction" call RPP_fnc_hint;
        };
    }
    else
    {
       format[localize "STRS_forestry_noItem", (_requiredItem) call RPP_fnc_itemGetName] call RPP_fnc_hint;
    };
};

RPP_fnc_forestry_pickSprout = 
{
    private ["_object", "_sproutClass", "_requiredItem", "_numSprouts", "_sproutName", "_canPick"];
    _object = (_this select 0);
    _sproutClass = (_object) getVariable "sproutType";
    _requiredItem = (_object) getVariable "sproutReqItem";
    _numSprouts = (_object) getVariable "numSprouts";
    _sproutName = (_sproutClass) call RPP_fnc_itemGetName;
    _canPick = true;
    
    if (_requiredItem != "") then
    {
        if ((_requiredItem) call RPP_fnc_itemGetAmount <= 0) then
        {
                format[localize "STRS_forestry_sproutItem", ((_requiredItem) call RPP_fnc_itemGetName)] call RPP_fnc_hint;
                _canPick = false;
        };

    };

    if (_canPick) then
    {
        if (_numSprouts > 0) then
        {
            if ([_sproutClass,1] call RPP_fnc_addInventoryItem) then
            {
                    _object setVariable["numSprouts", (_object getVariable "numSprouts")-1, true];
                    format[localize "STRS_forestry_pickSprout", _sproutClass call RPP_fnc_itemGetName, (_numSprouts)-1] call RPP_fnc_hint;
            };
        }
        else
        {
            localize "STRS_forestry_noSprouts" call RPP_fnc_hint;
        };
    };

    if ((_object getVariable "numSprouts") <= 0) then
    {
        
    };
};

RPP_fnc_forestry_serverGrowth = 
{
    while {true} do
    {
        {
            _object = (_x select 0);
            _timeUntilHarvestGrowsBack = (_x select 1);
            _minGrow = (_x select 2);
            _maxGrow = (_x select 3);
            _lastGrowthTime = (_x select 4);

            if ((_lastGrowthTime + _timeUntilHarvestGrowsBack) <= time) then
            {
                _capacity = (_object) getVariable "maxCapacity";
                _randomIncrease = (floor(random((_maxGrow - _minGrow)+ _minGrow)));
                _resources = _object getVariable "numResources";
                _totalResources = (_randomIncrease + _resources);

                if ((_totalResources) > _capacity) then
                {
                    _totalResources = _capacity;
                };

                if (_totalResources <= 0) then { _totalResources = 1; };

                _object setVariable ["numResources", _totalResources, true];
                (_x) set[4,(time + _timeUntilHarvestGrowsBack)];
            };
        } forEach RPP_var_forestry_serverBushes;
        
        sleep 5;
    };
};


RPP_fnc_bush_getArray = 
{
    private ["_bushClass", "_return"];
    _bushClass = (_this);
    _return = [];

    {
        if ((_x select 0) == _bushClass) then 
        {
                _return = _x;
        };
    } forEach RPP_var_forestry_bushes;

    _return
};

RPP_fnc_sprout_getArray = 
{
    private ["_sproutClass", "_return"];
    _sproutClass = (_this);
    _return = [];

    {
            if ((_x select 0) == _sproutClass) then 
            {
                    _return = _x;
            };
    } forEach RPP_var_forestry_sprouts;

    _return
};

RPP_fnc_tree_getArray =
{
    private ["_treeClass", "_return"];
    _treeClass = (_this);
    _return = [];

    {
        if ((_x select 0) == _treeClass) then 
        {
                _return = _x;
        };
    } forEach RPP_var_forestry_trees;

    _return
};

RPP_fnc_tree_getTrunkClass = 
{
    (((_this call RPP_fnc_tree_getArray) select 1) select 0)
};

RPP_fnc_tree_getAnimations = 
{
    ((_this call RPP_fnc_tree_getArray) select 7)
};

RPP_fnc_tree_getDamagePerHit = 
{
    (((_this call RPP_fnc_tree_getArray) select 4) select 2)
};

RPP_fnc_tree_getCuttingTime = 
{
    ((_this call RPP_fnc_tree_getArray) select 5)
};

RPP_fnc_tree_getRequiredItem = 
{
    ((_this call RPP_fnc_tree_getArray) select 6)
};

RPP_fnc_tree_getSkill =
{
    (((_this call RPP_fnc_tree_getArray) select 4) select 0)
};

RPP_fnc_tree_getExperience = 
{
    (((_this call RPP_fnc_tree_getArray) select 4) select 1)
};

RPP_fnc_tree_getGatherValues = 
{
    ((_this call RPP_fnc_tree_getArray) select 3)
};

RPP_fnc_bush_getHarvestAnim = 
{
    ((_this call RPP_fnc_bush_getArray) select 8)
};

RPP_fnc_bush_getGatherValues = 
{
    ((_this call RPP_fnc_bush_getArray) select 1)
};

RPP_fnc_bush_getHarvestValues = 
{
    ((_this call RPP_fnc_bush_getArray) select 5)
};

RPP_fnc_bush_getSkill = 
{
    (((_this call RPP_fnc_bush_getArray) select 6) select 0)
};

RPP_fnc_bush_getExperience = 
{
    (((_this call RPP_fnc_bush_getArray) select 6) select 1)
};

RPP_fnc_bush_getDeathValues = 
{
    ((_this call RPP_fnc_bush_getArray) select 2)
};

RPP_fnc_bush_getHarvestTime = 
{
    ((_this call RPP_fnc_bush_getArray) select 3)
};

RPP_fnc_bush_getRequiredItem = 
{
    ((_this call RPP_fnc_bush_getArray) select 7)
};

RPP_fnc_sprout_getType = 
{
    ((_this call RPP_fnc_sprout_getArray) select 1)
};

RPP_fnc_sprout_getSproutchance = 
{
    (((_this call RPP_fnc_sprout_getArray) select 5) select 1)
};

RPP_fnc_sprout_getGrowClass = 
{
    ((_this call RPP_fnc_sprout_getArray) select 2)
};

RPP_fnc_sprout_getGrowthClass = 
{
    (((_this call RPP_fnc_sprout_getArray) select 5) select 0)
};

RPP_fnc_sprout_getItemForSprout = 
{
    (((_this call RPP_fnc_sprout_getArray) select 5) select 2)
};

RPP_fnc_sprout_getSkill = 
{
    (((_this call RPP_fnc_sprout_getArray) select 8) select 0)
};

RPP_fnc_sprout_getRequiredLevel = 
{
    (((_this call RPP_fnc_sprout_getArray) select 8) select 1)
};

RPP_fnc_sprout_getExperience = 
{
    (((_this call RPP_fnc_sprout_getArray) select 8) select 2)
};

RPP_fnc_sprout_getGrowTime = 
{
    ((_this call RPP_fnc_sprout_getArray) select 4)
};

RPP_fnc_sprout_getModelClass = 
{
    ((_this call RPP_fnc_sprout_getArray) select 3)
};

RPP_fnc_sprout_getName = 
{
    ((_this call RPP_fnc_sprout_getArray) select 7)
};

RPP_fnc_sprout_getDeathChance = 
{
    ((_this call RPP_fnc_sprout_getArray) select 6)
};
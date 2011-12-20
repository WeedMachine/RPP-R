/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

if (isServer) then /* Setup server variables */
{


};

RPP_var_civilians = 
[
    "Civ1", "Civ2", "Civ3", "Civ4",
    "Civ5", "Civ6", "Civ7", "Civ8",
    "Civ9", "Civ10", "Civ11", "Civ12",
    "Civ13", "Civ14", "Civ15", "Civ16"
];

RPP_var_cops = 
[
    "Cop1", "Cop2", "Cop3", "Cop4",
    "Cop5", "Cop6", "Cop7", "Cop8",
    "Cop9", "Cop10", "Cop11", "Cop12",
    "Cop13", "Cop14", "Cop15", "Cop16"
];

RPP_fnc_getNumberCops = 
{
    private ["_numCops"];
    _numCops = 0;
    {
        _unit = call compile _x;
        
        if (alive _unit) then
        {
            _numCops = _numCops + 1;
        
        };
    } forEach RPP_var_cops;

    _numCops
};


RPP_var_players = [];
{ RPP_var_players set[(count RPP_var_players), _x]; } forEach RPP_var_civilians;
{ RPP_var_players set[(count RPP_var_players), _x]; } forEach RPP_var_cops;

RPP_fnc_playerActions = 
{       
    {
        _unit = call compile _x;

        if (_unit != player) then
        {
            _unit addAction[format["Stabilize %1", name _unit], "core\actions\useAction.sqf", ["medical_stabilize", _unit], 1, false, true, "", format['((!(%1 getVariable "stabilized")) && (alive %1) && !(RPP_var_medical_isReviving))', _unit]];
            _unit addAction[format["Drag %1", name _unit], "core\actions\useAction.sqf", ["medical_carry", _unit], 1, false, true, "", format['((!(%1 getVariable "isAlive")) && (alive %1) && !(RPP_var_medical_isReviving))', _unit]];
        };
    } forEach RPP_var_players;
        
    while {true} do
    {
        {
            _id = _forEachIndex;
            _unit = call compile _x;
            _colour = "#AAAAAA";
            _text = format["<t size='0.55' color='%2'>%1</t><br/><t size='0.35'>(Press F to Interact)</t>", name _unit, _colour];

            if (_unit != player) then
            {
               // _id call RPP_fnc_disable3DText;
               // [_id, _text, _unit, 0.8, 5, true] spawn RPP_fnc_create3DText;
            };
        } forEach RPP_var_players;
        
        sleep 5;
    };
};

RPP_fnc_getOnlinePlayers = 
{
    private ["_arr"];
    _arr = [];
    
    {
        _player = call compile _x;
        
        if (alive _player) then
        {
            _arr set[(count _arr), name _player];
        };
    } forEach RPP_var_civilians;
    
    {
        _player = call compile _x;
        
        if (alive _player) then
        {
            _arr set[(count _arr), name _player];
        };
    } forEach RPP_var_cops;

    _arr
};

RPP_fnc_objIsType = 
{
    private ["_obj", "_arr", "_yes"];
    _obj = _this select 0;
    _arr = _this select 1;
    _yes = false;
    
    if (str _obj in _arr) then
    {
        _yes = true;
    };
    
    _yes
};


RPP_fnc_isCiv = 
{
    [_this, RPP_var_civilians] call RPP_fnc_objIsType;
};

RPP_fnc_isCop = 
{
    [_this, RPP_var_cops] call RPP_fnc_objIsType;
};

RPP_var_allowedNames = [];

RPP_fnc_changeUnit = 
{
    private ["_class", "_oldType", "_oldUnit", "_stored", "_dummyGroup", "_dummyUnit", "_newUnit"];
    _class = _this select 0;
    _oldtype = typeof player;
    _oldUnit = player;
    
     titleCut ["","black faded", 0];
     
     player removeEventHandler["killed", 0];
     
     _position = getpos player;

    
    _stored = 
    [
        weapons _oldUnit, 
        magazines _oldUnit, 
        rank _oldUnit, 
        score _oldUnit, 
        group _oldUnit, 
        getPos _oldUnit, 
        (leader _oldUnit) == _oldUnit, 
        vehicleVarName _oldUnit
    ];


    _dummyGroup = createGroup (side _oldUnit);
    _dummyUnit = (_stored select 4) createUnit [_class, [0,0,0], [], 0, "NONE"]; 
    [_oldUnit] join _dummyGroup;

    
    _newUnit = _dummyGroup createUnit [_class, _stored select 5, [], 0, "NONE"];
    
    [_newUnit] join GrpNull;
   
    addSwitchableUnit _newUnit;
 
    _newUnit setpos getpos player;
    player setpos getpos empty;
    
    sleep 1;

    _oldUnit setVehicleInit format["this setVehicleVarName 'old%1'; old%1 = this", _stored select 7];
    _newUnit setVehicleInit format["this setVehicleVarName '%1'; %1 = this;", _stored select 7];
    processInitCommands;
    
    selectPlayer _newUnit;
    removeAllWeapons _newUnit;
    
    _newUnit setpos _position;
    
    { _newUnit addMagazine _x } forEach (_stored select 1);
    { _newUnit addWeapon _x } forEach (_stored select 0);
    
    removeSwitchableUnit _newUnit;
    removeSwitchableUnit _oldUnit;
    
    ["RPP_fnc_serverChangeUnit", [_oldUnit, _dummyGroup]] call RPP_fnet_execPublic;
    
   // hideObject _oldUnit;
   // deleteVehicle _oldUnit;
    
    player addEventHandler ["killed", "[_this select 0, _this select 1] call RPP_fnc_killed;"];
    
    _newUnit setpos _position;

    titleCut["", "BLACK in",2];
};

RPP_fnc_serverChangeUnit = 
{
    private ["_oldUnit", "_dummyGroup"];
    _oldUnit = (_this select 0);
    _dummyGroup = (_this select 1);
    
    if (not isServer) exitWith {};

    _oldUnit disableAI "ANIM";
    _oldUnit disableAI "MOVE";
    [_oldUnit] join grpnull;
    hideObject _oldUnit;
    deleteGroup _dummyGroup; 
    deleteVehicle _oldUnit; 

    //RPP_var_serverUnits set[(count RPP_var_serverUnits), _oldUnit];
};

RPP_var_keyChain = [];

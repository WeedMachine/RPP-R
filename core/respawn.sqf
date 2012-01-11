/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_respawnTime = 30; //Default time until player respawns
RPP_var_maxRespawnTime = 300; //Maximum respawn time, respawn time cannot be increased above this value
RPP_var_respawnIncrease = 5;
RPP_var_deaths = 0;
RPP_var_kills = 0;

RPP_var_respawnCam = 
[
    [[106019.98,9611.79,33.49], [6161.17,4322.43,23.63], 1.251],
    [[-85187.31,6191.49,-40589.03], [6161.17,4322.43,23.63], 1.251],
    [[-58451.36,58508.94,-53770.88], [6108.01,4330.40,18.66], 1.251],
    [[1294.85,104225.87,381.26], [6090.43,4341.53,1.22], 1.251],
    [[-91515.02,-17379.48,219.96], [6091.31,4368.34,1.62], 1.251],
    [[9626.34,-95568.91,221.46], [6079.35,4369.17,5.32], 1.251],
    [[9626.34,-95568.91,221.49], [6079.35,4369.17,14.90], 1.251],
    [[9626.15,-95562.71,-1792.44], [6078.99,4356.45,23.38], 1.251],
    [[5313.61,44925.20,-91332.56], [6079.40,4349.25,31.13], 1.251],
    [[-58610.37,1806.62,-76116.31], [6108.93,4353.86,42.08], 1.251]
];

RPP_fnc_killed = 
{
    private ["_victim", "_killer"];
    _victim = (_this select 0);
    _killer = (_this select 1);
    
    closeDialog 0;
    
    if ((player == _killer) && (_killer != _victim)) then
    {
        /* Killed someone */
        RPP_var_kills = RPP_var_kills + 1;
        
    };
    
    if (_victim == _killer) then
    {
        /* Killed himself*/
    };
  
    if (player == _victim) then
    {
        RPP_var_deaths = RPP_var_deaths + 1;
        
            
        if (isNil "RPP_var_hasRespawned") then
        {
            RPP_var_hasRespawned = false;
        };

        if (isNil "RPP_var_beenKilled") then
        {
            RPP_var_beenKilled = false;
        };
        
        if (!RPP_var_beenKilled) then
        {
 
            RPP_var_beenKilled = true;
            
            [position _victim] spawn RPP_fnc_dropInventory;
            [] spawn RPP_fnc_respawnCam;
            
            RPP_var_respawnTime = RPP_var_respawnTime + RPP_var_respawnIncrease;
            if (RPP_var_respawnTime >= RPP_var_maxRespawnTime) then 
            {
                RPP_var_respawnTime = RPP_var_maxRespawnTime; 
            };
        
        };
    };
    
    if (isServer) then
    {
       ["RPP_fnc_serverDeleteBody", [_victim, RPP_var_respawnTime]] spawn RPP_fnet_execPublic;
    };

};

RPP_fnc_serverDeleteBody = 
{
    private ["_victim", "_respawnTime"];
    _victim = _this select 0;
    _respawnTime = _this select 1;
    
    if (!isServer) exitWith {};
    
    [_victim, _respawnTime] spawn
    {
        sleep (_this select 1);
        deleteVehicle (_this select 0);
    };
};

RPP_fnc_dropInventory = 
{
    private ["_items", "_player"];
    _items = [];
    _player = _this select 0;
    
    {
        if ((_x select 0) call RPP_fnc_itemGetCanDrop) then
        {
            _items set[(count _items), [(_x select 0), (_x select 1)]];
            [(_x select 0), -(_x select 1)] call RPP_fnc_addInventoryItem;
        };
       
    } forEach RPP_var_inventory;
    
    [_items, _player] spawn RPP_fnc_dropItem;
};

RPP_fnc_respawn = 
{   
    waitUntil {alive player};
	
    RPP_var_beenKilled = false;
    RPP_var_hasRespawned = true;
    
    _spawn = "";
    
    if (player call RPP_fnc_isCiv) then
    {
        if (RPP_var_isArrested) then
        {
            _spawn = [] call RPP_fnc_pol_getRandomCell;
        }
        else
        {
            _spawn = "civ_respawn";
        };
        
        if !(player call RPP_fnc_isCop) then
        {
            _amount = ceil(RPP_var_bankAmount * 0.05);
            RPP_var_bankAmount = RPP_var_bankAmount - _amount;

            if (RPP_var_bankAmount <= 0) then
            {
                RPP_var_bankAmount = 0;
            };
            
            
            format[localize "STRS_respawn_emsLoss", _amount] call RPP_fnc_hint;
            [RPP_var_saving_tableBanks, ["RPP_var_bankAmount", RPP_var_acc_login], RPP_var_bankAmount] call RPP_fsav_clientRequestSave;
        };
    }
    else
    {
        if (player call RPP_fnc_isCop) then
        {
            _spawn = "cop_respawn";
        };
    };
    
    player setPos getMarkerpos _spawn;
    
    [] spawn RPP_fnc_respawnEffect;
};

RPP_fnc_respawnEffect = 
{
    titleCut ["","WHITE IN",1];
    titleText ["", "WHITE IN", 1];
	
    localize "STRS_player_respawn" call RPP_fnc_hint;

	RPP_var_holstered = false;
	removeAllWeapons player;
    player addweapon "ItemMap";
	["hunger", 100] call RPP_fnc_setDynamic;
    ["thirst", 100] call RPP_fnc_setDynamic;
    

    "dynamicBlur" ppEffectEnable true;
    _i = 10;
    while {_i != -1} do
    {
            "dynamicBlur" ppEffectAdjust[_i];
            "dynamicBlur" ppEffectCommit 2;

            _i = _i - 1;
            sleep 2;
    };

    sleep 1;


    "dynamicBlur" ppEffectEnable false;
};

RPP_fnc_respawnCam =
{
    private ["_respawnTime", "_time", "_camera", "_i"];
    _respawnTime = (time + RPP_var_respawnTime);
    _time = time;
    RPP_var_hasRespawned = false;

    ["hunger", 75] call RPP_fnc_setDynamic;
    ["thirst", 75] call RPP_fnc_setDynamic;

    playMusic "Ambient02_Vague_Shapes";
    2 fadeSound 0;
    10 fadeMusic 1;

    _camera = "camera" camcreate [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2)+5];
    _camera camSetPos [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2)+5];
    _camera cameraEffect ["internal", "back"];
    _camera camSetTarget player;
    _camera camSetFOV 0.700;
    _camera camCommit 0;
    waitUntil {camCommitted _camera};
    _camera camSetPos [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2)+20];
    _camera camSetTarget (player);
    _camera camSetFOV 0.700;
    _camera camCommit 10;
    waitUntil {camCommitted _camera};
    _camera camPreload 5;
    waitUntil {camPreloaded _camera};


    _i = 0;
    while {_respawnTime >= _time} do 
    {	
        _cameraTarget = ((RPP_var_respawnCam select _i) select 0);
        _cameraPos = ((RPP_var_respawnCam select _i) select 1);
        _cameraFov = ((RPP_var_respawnCam select _i) select 2);

        _camera camSetPos _cameraPos;							
        _camera camSetTarget _cameraTarget;											
        _camera camSetFOV _cameraFov;				
        _camera camCommit 10;		


        if (_i >= (count RPP_var_respawnCam)) then
        {
            _i = 0;
        };

        waitUntil {camCommitted _camera};
        _i = _i + 1;
        _time = time;
    };

    2 fadeSound 1;
    10 fadeMusic 0;
    _camera cameraEffect ["terminate","back"];
    titleCut [" ","Black in",1];
    camDestroy _camera;
    [] spawn RPP_fnc_respawn;
};
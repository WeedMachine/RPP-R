/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_Debug = true;
RPP_Mission_Version = 0.4;
RPP_Intro = true;
RPP_QuickTest = false;
RPP_Saving = true;
RPP_isServer = ((isDedicated) && (isServer));
RPP_AcreEnabled = true;

#define __isServer ((isDedicated) && (isServer))

if (RPP_Debug) then
{
    onMapSingleClick "vehicle player setPos _pos";
};

sleep 0.1;

if (RPP_QuickTest) exitWith
{
   sleep 2;
    //ems1 switchMove "AcinPknlMwlkSrasWrflbd";
    //dummy switchMove "AinjPpneMstpSnonWrflDb_grab";
    
    //dummy attachTo[player, [-0.25,-0.5,0]];

	/* Testing stuff */

   //player setDir (_playerDir - _dir);
};

startLoadingScreen ["Initializing...", "RscDisplayStart"];

_script = [] execVM "briefing.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\net.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\defines.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\goods.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\inventory.sqf";
waitUntil {scriptDone _script};
    
_script = [] execVM "core\text3D.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\actions.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\shops.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\extHint.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\weapons.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\players.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\vehicles.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\banks.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\skills.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\mining.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\dynamicStats.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\licenses.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\storages.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\weather.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\time.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\fishing.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\stats.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\processResource.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\respawn.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\gasStations.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\forestry.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\intro.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\markers.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\factory.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\animations.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\delivery.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\paycheck.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\invest.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\gathering.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\objPlace.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\trading.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\account.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\restrain.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\police.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\events.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\siren.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\restrictions.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\search.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\phone.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\rte.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\monitor.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\medical.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "core\saving.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "database\databaseDefine.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "database\tableNames.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "database\databaseFunctions.sqf";
waitUntil {scriptDone _script};

_script = [] execVM "database\SQLite.sqf";
waitUntil {scriptDone _script};

progressLoadingScreen 0.50;

	

if (isServer) then
{
  
	{
        (_x select 0) spawn RPP_fnc_freezeObject;
    } forEach RPP_var_shops;
	 
	{
        (_x select 2) spawn RPP_fnc_freezeObject;
    } forEach RPP_var_banks;
    
    {
        (_x select 0) spawn RPP_fnc_freezeObject;
    } forEach RPP_var_deliveryStarts;
    
    {
        (_x select 0) spawn RPP_fnc_freezeObject;
    } forEach RPP_var_investLocations;
        
    /* Freeze everything in place so people cant move or destroy them */
    [] spawn RPP_fnc_freezeLoop;
    
    /* Start Loading */
    [] call RPP_fnc_acc_serverStart;
};

progressLoadingScreen 0.75;
endLoadingScreen;

if (RPP_isServer) then
{
	{
		_object = (_x select 0);
		_stock = (_x select 5);
		_object setVariable ["stock", _stock, true];
    } forEach RPP_var_shops;
};

if (!__isServer) then
{  

	waitUntil{alive player};
    /* Init action checker */
    [] spawn RPP_fnc_actionCheck;
    [] spawn RPP_fnc_runPaycheck;
    [] spawn RPP_fnc_offroad; /* Damage from driving offroad*/
	  
    _script = [] execVM "core\ui.sqf";
    waitUntil {scriptDone _script}; 

    /* Setup all shops */
    [] spawn RPP_fnc_setupShops;

    /* Setup all banks */
    [] spawn RPP_fnc_setupBanks;

    /* Setup skills */
    [] call RPP_fnc_generateExperienceTable;

    /* Setup mines */
    [] call RPP_fnc_setupMines;

    /* Setup factories */
    [] call RPP_fnc_setupFactories;

    /* Init dynamic vars (hunger/thirst) */
    [] spawn RPP_fnc_dynamicValLoop;

    /* Setup license shops */
    [] spawn RPP_fnc_setupLicenseShops;

    /* Setup storages */
    [] spawn RPP_fnc_setupStorages;

    /* Setup processing of resources */
    [] spawn RPP_fnc_setupProcessing;

    /* Setup gas stations */
    [] spawn RPP_fnc_setupGasStations;

    /* Setup police markers */
    [] spawn RPP_fnc_setupMarkers;

    /* Setup delivery */
    [] spawn RPP_fnc_setupDelivery;

    /* Setup investing */
    [] spawn RPP_fnc_setupInvesting;
    
    /* Start gathering loop */
    [] spawn RPP_fnc_gatherClientLoop;
    
    /* Start player actions */
    [] spawn RPP_fnc_playerActions;
    
    /* Start skill saving */
    [] spawn RPP_fnc_skillsSaving;
    
    [] spawn RPP_fnc_restrictionLoop;
    [] spawn RPP_fnc_monitor;
	
};


if (!__isServer) then
{  
    [] spawn RPP_fnc_clientRefuelCheck;
    
    
    /* Begin login */
    if !(RPP_Debug) then
    {  
        [] spawn RPP_fnc_acc_start;
    };
};


if (RPP_Debug) then
{
    ['money', 25000] call RPP_fnc_addInventoryItem;
    ['Phone', 1] call RPP_fnc_addInventoryItem;
    ['MedicalBag', 1] call RPP_fnc_addInventoryItem;

};


/* Start weather & time */
if (isServer) then
{
    [] spawn RPP_fnc_weatherLoop;
    [] spawn RPP_fnc_timeLoop;
    [] spawn RPP_fnc_forestry_serverGrowth;
    [] spawn RPP_fnc_importAll;
};

onPlayerConnected "_this call RPP_fnc_event_onPlayerConnect;";
onPlayerDisconnected "_this call RPP_fnc_event_onPlayerDisconnect;";
sleep 2.5;

[[] call RPP_fnc_generateID, "<img image='images\aussielife_logo.paa' /><br/><t size='0.55' color='#4876FF'>Mission brought to you by aussielifereloaded.com</t><br/>", rpproject, 0.8, 8, false] call RPP_fnc_create3DText;
[[] call RPP_fnc_generateID, "<t size='0.75' color='#4876FF'>Arrest Suspects</t><br/><t size='0.55'>(Ctrl+1 to arrest)</t>", arrest_point, 0.8, 8, false] call RPP_fnc_create3DText;


(findDisplay 46) displaySetEventHandler ["KeyDown","_this call RPP_fnc_onKeyPress;"];
player addMPEventHandler ["MPKilled", "[_this select 0, _this select 1] call RPP_fnc_killed;"];
player addEventHandler ["handleDamage",  "_this call RPP_fnc_hit;"];

[] spawn ALR_acre_radios;
progressLoadingScreen 0.99;
endLoadingScreen;
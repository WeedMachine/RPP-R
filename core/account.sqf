

RPP_fnc_acc_login = 
{
    private ["_id", "_exists", "_password"];
    createDialog "RPP_Dlg_Login";
    _id = getPlayerUID player;
    _exists = _this select 0;
    _password = _this select 1;
    
    [_exists, _password] spawn
    {
        while {!RPP_var_isLoggingIn} do
        {
            if (isNull(findDisplay 1400)) then
            {
                _this call RPP_fnc_acc_login;
            };  
        
            sleep 1;
        };
    };

    if (_exists) then
    {
        ((findDisplay 1400) displayCtrl 5) ctrlSetStructuredText parseText localize "STRS_login_exists";
        ((findDisplay 1400) displayCtrl 8) ctrlSetStructuredText parseText "By clicking Login you agree to the server rules below.";
        ctrlSetText[10, "Login"];
        buttonSetAction[10, format["[""%1""] spawn RPP_fnc_acc_clientLogin;", _password]];
    }
    else
    {   
        ((findDisplay 1400) displayCtrl 5) ctrlSetStructuredText parseText localize "STRS_login_new";
        ((findDisplay 1400) displayCtrl 8) ctrlSetStructuredText parseText "By clicking Register you agree to the server rules below.";
        ctrlSetText[10, "Register"];
        buttonSetAction[10, "[] call RPP_fnc_acc_clientRegister;"];
    };
    
    
    ctrlSetText[4,getPlayerUID player];
    ctrlEnable [4,false];
    
    {
        _index = lbAdd[11,_x];
    } forEach RPP_var_serverRules;
};

RPP_fnc_acc_clientRegister = 
{
    private ["_id", "_password"];
    _id = getPlayerUID player;
    _password = ctrlText 7;
    
    if (_password == "") exitWith {};
    if (_password == " ") exitWith {};
   
    
    ["RPP_fnc_acc_serverCreate", [_id,_password, name player]] call RPP_fnet_execPublic;
    closeDialog 0;
    cutText ["Registering account, please wait...", "PLAIN DOWN", 8];
    RPP_var_isLoggingIn = true;
   
};

RPP_fnc_acc_clientLoginFirst = 
{
    private ["_id"];
    _id = _this select 0;
    
    if (getPlayerUID player != _id) exitWith {};
    
    RPP_var_acc_login = _id;
    RPP_var_loggedIn = true;
    RPP_var_firstConnect = true;

};

RPP_fnc_acc_serverCreate =
{
    private ["_id", "_password", "_name"];
    _id = _this select 0;
    _password = _this select 1;
    _name = _this select 2;
    
    server globalchat format["Player: %1 has just joined the server for the first time!", _name];
    
    if !(isServer) exitWith {};
    
    RPP_var_acc_users set[(count RPP_var_acc_users), [_id,_password]];
    [RPP_var_saving_tableUsers, ["RPP_var_acc_users"], RPP_var_acc_users] call RPP_fsav_clientRequestSave;
    
    /* Created...let the client start */
    ["RPP_fnc_acc_clientLoginFirst", [_id]] call RPP_fnet_execPublic;
};

RPP_fnc_acc_clientLogin = 
{
    private ["_password", "_text", "_jailTime"];
    _password = _this select 0;
    _text = ctrlText 7;
    
    if (_text != _password) exitWith {};
    
    RPP_var_acc_login = getPlayerUID player;
    RPP_var_isLoggingIn = true;
    closeDialog 0;
    sleep 1;
    cutText ["Logging into account, please wait...", "PLAIN DOWN", 1];
    sleep 2;
    cutText ["Loading player data...", "PLAIN DOWN", 1];
    [{
        if (isServer) then
        {
            [(_this select 0), (_this select 1)] call RPP_fsav_clientRequestLoad; 
        };
    }, [RPP_var_acc_login, RPP_var_saving_clientToLoad]] call RPP_fnet_execPublic;
    sleep 4;
    cutText ["Loading storages...", "PLAIN DOWN", 1];
    [{  
        if (isServer) then 
        { 
            { 
                if (not (_x select 3)) then 
                { 
                    [str (_x select 0), (_this select 0), (_this select 1)] call RPP_fsav_clientLoadSetVariables; 
                }; 
            } forEach RPP_var_storages;
        }; 
    }, [RPP_var_acc_login, RPP_var_saving_localStorages]] call RPP_fnet_execPublic; 
    sleep 4;
    cutText ["Loading client variables", "PLAIN DOWN", 1];
    RPP_var_inventory = "RPP_var_inventory" call RPP_fnc_saving_loadVar;
    sleep 1;
    RPP_var_keyChain = "RPP_var_keyChain" call RPP_fnc_saving_loadVar;
    sleep 1;
    _jailTime = "RPP_var_jailTime" call RPP_fnc_saving_loadVar;
    if (count _jailTime > 0) then
    {
        RPP_var_jailTime = _jailTime select 0;
        
        if (RPP_var_jailTime > 0) then
        {
            [player,player,RPP_var_jailTime] call RPP_fnc_pol_clientArrest;
        };
    };
    sleep 2;
    cutText ["Logged in!", "PLAIN DOWN", 3];
    sleep 3;
    cutText ["", "PLAIN DOWN", 3];
    
    RPP_var_isLoggingIn = false;
    RPP_var_loggedIn = true;
};

RPP_fnc_acc_exists = 
{
    private ["_id", "_exists"];
    _id = _this;
    _exists = false;
    
    {
        if (_x select 0 == _id) exitWith
        {
            _exists = true;
        };
    } forEach RPP_var_acc_users;
    
    _exists
};

RPP_fnc_acc_getPassword = 
{
    private ["_id", "_password"];
    _id = _this;
    _password = "";
    
    {
        if (_x select 0 == _id) exitWith
        {
            _password = _x select 1;
        };
    } forEach RPP_var_acc_users;
    
    _password
};

RPP_fnc_acc_serverStart = 
{
    if (isNil "RPP_var_acc_users") then
    {
        RPP_var_acc_users = [];
    };
    
    if (RPP_Saving) then
    {
        [RPP_var_saving_serverToLoad] spawn RPP_fsav_serverLoad;
    };
    
    [] spawn
    {
        while {true} do
        {
            [] spawn RPP_fsav_serverCommit;
            sleep 1;
        };
    };
};

RPP_fnc_acc_serverLogin =
{
    private ["_id", "_exists", "_password"];
    _id = _this select 0;
    _password = _this select 1;
    
    if !(isServer) exitWith {};
    
    _exists = _id call RPP_fnc_acc_exists;
    
    [{ if ((getPlayerUID player) == (_this select 0)) then { [(_this select 1), (_this select 2)] call RPP_fnc_acc_login;  }; }, [_id, _exists, _password]] call RPP_fnet_execPublic;
};  

RPP_fnc_acc_serverGetPassword = 
{
    private ["_id", "_password"];
    _id = _this;
    
    if !(isServer) exitWith {};
    
    _password = _id call RPP_fnc_acc_getPassword;
    
    [{ if ((getPlayerUID player) == (_this select 0)) then { RPP_var_acc_password = (_this select 1); }; }, [_id, _password]] call RPP_fnet_execPublic;

};

RPP_fnc_acc_start = 
{
    playMusic "BAF_Track01";
    2 fadeSound 0;
    10 fadeMusic 1;
    
    if (isNil "RPP_var_acc_login") then
    {
        RPP_var_acc_login = 0;
    };
    
    sleep 0.5;
	
    _introCam = "camera" camCreate [10001.95,-95596.97,1013.62];
    _introCam cameraEffect ["Internal", "BACK"];

    _introCam camPrepareTarget [10001.95,-95596.97,1013.62];
    _introCam camPreparePos [6168.65,4325.08,38.35];
    _introCam camPrepareFOV 0.700;
    _introCam camCommitPrepared 0;

    waitUntil {camCommitted _introCam};
    showCinemaBorder false;
    sleep 2;
    cutText ["Welcome to The Roleplay Project: Reloaded!\nPlease wait while the server finishes loading.\nIt is expected to take a while, so please be patient.", "PLAIN DOWN", 25];
    enableEnvironment false;
    waitUntil {server getVariable ["loaded",false]};
    enableEnvironment true;
    
    sleep 2;
    
    ["RPP_fnc_acc_serverGetPassword", (getPlayerUID player)] call RPP_fnet_execPublic;
    
    waitUntil {RPP_var_acc_password != "@NO@"};
    /* Show login dialog */
    ["RPP_fnc_acc_serverLogin", [(getPlayerUID player), RPP_var_acc_password]] call RPP_fnet_execPublic;
    
    waitUntil {RPP_var_loggedIn};
    
    if (RPP_var_firstConnect) then
    {
        cutText ["You have logged in for the first time!", "PLAIN DOWN", 8];
        sleep 2;
    };
    
    
  
    2 fadeSound 1;
    10 fadeMusic 0;
    cutText  ["","PLAIN DOWN"];
    _introCam cameraEffect ["Terminate", "BACK"];
    camDestroy _introCam;
    
    if ((player call RPP_fnc_isCop)) then
    {
        if (RPP_var_firstConnect) then
        {
            "Cop" spawn RPP_fnc_runIntro;
        };
        
        [] spawn RPP_fnc_displayMarkers; 
         
        if (RPP_var_firstConnect) then
        {
            player addweapon "x26";
            player addmagazine "x26_mag";
            player addmagazine "x26_mag";
            player addmagazine "x26_mag";
            player addmagazine "x26_mag";
            ['Handcuffs', 1] call RPP_fnc_addInventoryItem;
            ['cl_Spikestrip', 1] call RPP_fnc_addInventoryItem;
						
        };
        
		player addweapon "ACRE_PRC119";
		_chanset = ["ACRE_PRC119", [80.000, 80.025, 80.050, 80.075, 80.100, 80.125] ] call acre_api_fnc_setDefaultChannels;
		_ret = [] call acre_api_fnc_getCurrentRadioList;
		player removeweapon (_ret select 0);
		_power = ["ACRE_PRC119", [20000, 20000, 20000, 20000, 2000, 2000] ] call acre_api_fnc_setDefaultPowers;
		
		player addweapon "ItemMap";
    }
    else
    {
        if (RPP_var_firstConnect) then
        {
            "Civ" spawn RPP_fnc_runIntro;
            
            if ((player call RPP_fnc_isEMS)) then
            {
                ['MedicalBag', 1] call RPP_fnc_addInventoryItem;
			};
			      
		}; 
    
	player addweapon "ACRE_PRC148";
	_chanset = ["ACRE_PRC148", [45.000, 14.025, 34.050, 41.075, 57.100, 64.125] ] call acre_api_fnc_setDefaultChannels;
	_ret = [] call acre_api_fnc_getCurrentRadioList;
	player removeweapon (_ret select 0);
	_power = ["ACRE_PRC148", [20000, 20000, 20000, 20000, 2000, 2000] ] call acre_api_fnc_setDefaultPowers;  

    };
};
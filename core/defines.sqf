/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

/* Setup player variables */
RPP_var_hasRespawned = true; /* Has player respawned */
RPP_var_isTazed = false; /* Is player tazed */
RPP_var_isRestrained = false;
RPP_var_tazedTime = 20;
RPP_var_isImmortal = false;
RPP_var_firstConnect = false;
RPP_var_loggedIn = false;
RPP_var_isLoggingIn = false;
RPP_var_acc_login = getPlayerUID player;
RPP_var_medical_isReviving = false;
RPP_var_medical_isCarrying = false;
RPP_var_acc_password = "@NO@";
RPP_var_deathTime = 900;
RPP_var_serverRules = 
[
    "[1.0] Compliance Rules",
    "[1.1]  Death-matching will not be tolerated",
	"[1.2]	Do Not Hack Or Exploit Bugs",
	"[1.3]  Common Decency and Respect",
	"[1.4]  Roleplay is Required",
	"[1.5]  Communication With Others",
	"[1.6]  ACRE MUST BE RUNNING",
    "Failure to comply with listed rule set stated above may result in temporary or permanent bans depending on the severity of your offence."
];
RPP_var_pol_maxArrest = 60;

ALR_var_acre_radio = [] call acre_api_fnc_getCurrentRadioList;

/* Jail variables */
RPP_var_isArrested = false;
RPP_var_jailTime = 0;
RPP_var_medical_animations = 
[
    "AinvPknlMstpSnonWrflDnon_medic0",
    "AinvPknlMstpSnonWrflDnon_medic1",
    "AinvPknlMstpSnonWrflDnon_medic2",
    "AinvPknlMstpSnonWrflDnon_medic3",
    "AinvPknlMstpSnonWrflDnon_medic4",
    "AinvPknlMstpSnonWrflDnon_medic5",
    "AinvPknlMstpSnonWrflDr_medic0",
    "AinvPknlMstpSnonWrflDr_medic1",
    "AinvPknlMstpSnonWrflDr_medic2",
    "AinvPknlMstpSnonWrflDr_medic3",
    "AinvPknlMstpSnonWrflDr_medic4",
    "AinvPknlMstpSnonWrflDr_medic5"

];

ALR_acre_radios =
[
	if ((player call RPP_fnc_isCop)) then 
	
	{
	player addweapon "ACRE_PRC119";
	_chanset = ["ACRE_PRC119", [80.000, 80.025, 80.050, 80.075, 80.100, 80.125] ] call acre_api_fnc_setDefaultChannels;
	_power = ["ACRE_PRC119", [50000, 50000, 50000, 50000, 50000, 50000] ] call acre_api_fnc_setDefaultPowers;
	}
	else
	{
	player addweapon "ACRE_PRC148";
	_chanset = ["ACRE_PRC148", [45.000, 14.025, 34.050, 41.075, 57.100, 64.125] ] call acre_api_fnc_setDefaultChannels;
	_power = ["ACRE_PRC148", [20000, 20000, 20000, 20000, 2000, 2000] ] call acre_api_fnc_setDefaultPowers;  
	};
	
	player removeweapon (ALR_var_acre_radio select 0);
	
];
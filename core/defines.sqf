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
    "Do not metagame!",
    "Use brackets around your text when talking out of character",
    "Global chat OOC use only"
];
RPP_var_pol_maxArrest = 60;

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
RPP_fnc_restrain_resClient =
{
    private ["_person", "_victim"];
    _person = _this select 0;
    _victim = _this select 1;

    if (player == _victim) then
    {
        if (RPP_var_isRestrained) then
        {
            format[localize "STRS_restrain_unrestrained", name _person] call RPP_fnc_hint;
            
            ["RPP_fnc_restrain_message", [_person, "release"]] call RPP_fnet_execPublic;
                
            RPP_var_isRestrained = false;
        }
        else
        {
            _animState = animationState _victim;
            if ((RPP_var_isTazed) || (_animState == "amovpercmstpssurwnondnon")) then
            {
                ["RPP_fnc_restrain_message", [_person, "restrain"]] call RPP_fnet_execPublic;
                format[localize "STRS_restrain_restrained", name _person] call RPP_fnc_hint;
                RPP_var_isRestrained = true;
                ["RPP_fnc_serverSwitchAnimation", [_victim, "civillying01"]] call RPP_fnet_execPublic; 
                [_person, _victim] spawn RPP_fnc_restrain_resLoop;
            }
            else
            {
                ["RPP_fnc_restrain_message", [_person, "unable"]] call RPP_fnet_execPublic;
            };
        };   
    };
};

RPP_fnc_restrain_message = 
{
    private ["_person", "_type"];
    _person = _this select 0;
    _type = _this select 1;
    
    if (player != _person) exitWith {};
    
    if (_type == "restrain") then
    {
        localize "STRS_restrain_personRestrain" call RPP_fnc_hint;
    };
    
    if (_type == "unable") then
    {
        localize "STRS_restrain_personUnable" call RPP_fnc_hint;
    };
    
    if (_type == "release") then
    {
        localize "STRS_restrain_personRelease" call RPP_fnc_hint;
    };

};

RPP_fnc_restrain_resLoop = 
{
    private ["_person", "_victim", "_ticks"];
    _person = _this select 0;
    _victim = _this select 1;

    _ticks = 0;
    while {RPP_var_isRestrained} do
    {
        if (_ticks == 300) then
        {
            RPP_var_isRestrained = false;
            localize "STRS_restrain_free" call RPP_fnc_hint;
        };
        
        if !(alive _victim) then
        {
            RPP_var_isRestrained = false;
        };
        
        if (RPP_var_isArrested) then
        {
            RPP_var_isRestrained = false;
        };
        
        
        
        _ticks = _ticks + 1;
        sleep 1;
    };
    
    if (vehicle player == player) then
    {
        ["RPP_fnc_serverSwitchAnimation", [_victim, "amovppnemstpsnonwnondnon"]] call RPP_fnet_execPublic;
    };
};
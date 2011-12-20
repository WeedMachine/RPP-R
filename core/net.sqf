/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

"RPP_net_publicExecVar" addPublicVariableEventHandler
{
    (_this select 1) call RPP_fnet_execCommand;	
};

RPP_fnet_execPublic =
{
    RPP_net_publicExecVar = _this;
    publicVariable "RPP_net_publicExecVar";
    _this call RPP_fnet_execCommand;
};

RPP_fnet_execCommand =
{
    private ["_function", "_params"];

    _function = _this select 0;

    if ((count _this) == 2) then
    {
        _params = _this select 1;
    }
    else
    {
        _params = [];
    };

    if ((typeName _function) == "STRING") then
    {
        _function = call compile (_this select 0);
    };

    _params call _function;
};

RPP_fnc_serverDetach =
{
    private ["_unit"];
    _unit = _this select 0;
    
    //if (player != _unit) exitWith {};
    
    detach _unit;
};

RPP_fnc_serverAttachTo = 
{
    private ["_unit", "_to", "_params"];
    _unit = _this select 0;
    _to = _this select 1;
    _params = _this select 2;
    
    //if (player != _unit) exitWith {};
    
    _unit attachTo [_to, _params];
};

RPP_fnc_serverSwitchAnimation =
{
    private ["_obj", "_anim"];
    _obj = _this select 0;
    _anim = _this select 1;
    
    _obj switchMove _anim;
};

RPP_fnc_serverPlayMove = 
{
    private ["_obj", "_anim"];
    _obj = _this select 0;
    _anim = _this select 1;
    
    _obj playMove _anim;

};
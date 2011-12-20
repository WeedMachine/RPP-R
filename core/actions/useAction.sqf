private ["_where", "_who", "_params"];
_where = _this select 0;
_who = _this select 1;
_params = _this select 3;

if ((_params select 0) == "medical_stabilize") then
{
    [_params select 1] spawn RPP_fnc_medical_stabilize;

};

if ((_params select 0) == "medical_carry") then
{
    [_params select 1] spawn RPP_fnc_medical_carry;
};

if ((_params select 0) == "medical_dragstop") then
{
    RPP_var_medical_isCarrying = false;
};
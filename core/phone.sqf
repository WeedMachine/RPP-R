RPP_fnc_phone_smsDlg = 
{
    createDialog "RPP_Dlg_SMS";
    
    {
        _player = call compile _x;
        
        if ((alive _player) && (_player != player)) then
        {
            _index = lbAdd[2100, name _player];
            lbSetData[2100, _index, str _player];
        };
    
    } forEach RPP_var_players;
    lbSetCurSel[2100,0];
    
};

RPP_fnc_phone_recieveSMS =
{
    private ["_message", "_player", "_from", "_phone"];
    _message = _this select 0;
    _player = _this select 1;
    _from = _this select 2;
    
    if (player != _player) exitWith {};
    
    _phone = "Phone" call RPP_fnc_itemGetAmount;
    
    if (_phone <= 0) exitWith
    { /* No phone */
        ["RPP_fnc_phone_failed", [_player, _from]] call RPP_fnet_execPublic;
    };

    format[localize "STRS_phone_sms_recieve", name _from, _message] call RPP_fnc_hint;
};

RPP_fnc_phone_sendSMS = 
{
    private ["_message", "_player"];
    _message = _this select 0;
    _player = _this select 1;
    
    if (alive _player) then
    {
        ["RPP_fnc_phone_recieveSMS", [_message, _player, player]] call RPP_fnet_execPublic;
    }
    else
    {
        [_player, player] call RPP_fnc_phone_failed;
    };
    
    ctrlSetText[1400, ""];
};

RPP_fnc_phone_failed = 
{
    private ["_player", "_from"];
    _player = _this select 0;
    _from = _this select 1;
    
    if (player == _from) then
    {
        format[localize "STRS_phone_sms_failed", name _player] call RPP_fnc_hint;
    };

};
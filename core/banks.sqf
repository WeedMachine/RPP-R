/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

if (isNil "RPP_var_bankAmount") then
{
    RPP_var_bankAmount = 12500;
};

RPP_var_banks = 
[
    ["Central Bank", [] call RPP_fnc_generateID, mainBank]
];

/* Open bank dialog */
RPP_fnc_openBank = 
{
    private ["_dlg", "_obj"];
    _obj = _this;
    
    if (!isNull(findDisplay 300)) exitWith
    {
        /* Do nothing */
    };
    
    if ((((RPP_var_bankRobTime)+RPP_var_bankDelay) >= time) && (_obj == mainBank)) exitWith
    {
        /* Cannot use yet */
        localize "STRS_bank_cannotUse" call RPP_fnc_hint;
    };
    
    _dlg = createDialog "RPP_Dlg_Bank";

    [] call RPP_fnc_updateBankDlg;
};

/* Do not call this manually outside of banking */
RPP_fnc_updateBankDlg = 
{
    private ["_money", "_bank", "_players", "_playerSel"];
    _money = "Money" call RPP_fnc_itemGetAmount;
    _bank = RPP_var_bankAmount;
    _players = [];
    _playerSel = lbCurSel 6;
    
    lbClear 6;
    {
        _civ = call compile _x;
        if (alive _civ && player != _civ && isPlayer _civ) then
        {
            _index = lbAdd[6, format["%1) %2", _x, name _civ]];
            lbSetData[6,_index, _x];
            _players set[(count _players), _civ];
        };
    } forEach RPP_var_players;
    
    if (_playerSel < 0) then
    {
        lbSetCurSel[6,0];
    }
    else
    {
        lbSetCurSel[6,_playerSel];
    };  
    
    ((findDisplay 300) displayCtrl 2) ctrlSetStructuredText parseText format["(Balance: $%1)", _bank];
    ((findDisplay 300) displayCtrl 3) ctrlSetStructuredText parseText format["(Cash: $%1)", _money];
};

/* Withdraw money from bank */
RPP_fnc_withdrawBnk = 
{
    private ["_amount"];
    _amount = round(_this);
    
    if (_amount <= 0) exitWith /* Invalid input */
    {
        "Invalid input" call RPP_fnc_hint;
    };
    
    if (RPP_var_bankAmount < _amount) exitWith /* Not enough money in bank */
    {
        (format[localize "STRS_bank_notEnoughWithdraw", _amount, RPP_var_bankAmount]) call RPP_fnc_hint;
    };
    
    if (["Money", _amount] call RPP_fnc_addInventoryItem) then /* If can add money then player will not be overweight */
    {
        (format[localize "STRS_bank_withdraw", _amount]) call RPP_fnc_hint;
        RPP_var_bankAmount = RPP_var_bankAmount - _amount;
        [RPP_var_saving_tableBanks, ["RPP_var_bankAmount", RPP_var_acc_login], RPP_var_bankAmount] call RPP_fsav_clientRequestSave;
    }
    else
    {
        localize "STRS_bank_overweight" call RPP_fnc_hint;
    };
 
    [] call RPP_fnc_updateBankDlg;
};

/* Deposit money into bank */
RPP_fnc_depositBnk = 
{
    private ["_amount", "_money"];
    _amount = round(_this);
    _money = "Money" call RPP_fnc_itemGetAmount;
    
    if (_amount <= 0) exitWith /* Invalid input */
    {
        "Invalid input" call RPP_fnc_hint;
    };
    
    if (_money < _amount) exitWith /* Not enough money in bank */
    {
        (format[localize "STRS_bank_notEnoughDeposit", _amount, _money]) call RPP_fnc_hint;
    };

    (format[localize "STRS_bank_deposit", _amount]) call RPP_fnc_hint;
    /* Add money to bank */
    ["Money", -_amount] call RPP_fnc_addInventoryItem;
    RPP_var_bankAmount = RPP_var_bankAmount + _amount;
    [RPP_var_saving_tableBanks, ["RPP_var_bankAmount", RPP_var_acc_login], RPP_var_bankAmount] call RPP_fsav_clientRequestSave;

    [] call RPP_fnc_updateBankDlg;
};

/* Client transfer money */
RPP_fnc_transferBnk =
{
    private ["_amount", "_player"];
    _amount = round(_this select 0);
    _player = _this select 1;
    
    if (_amount <= 0) exitWith /* Invalid input */
    {
        "Invalid input" call RPP_fnc_hint;
    };
    
    if (RPP_var_bankAmount < _amount) exitWith /* Not enough money in bank */
    {
        (format[localize "STRS_bank_notEnoughTransfer", _amount, RPP_var_bankAmount]) call RPP_fnc_hint;
    };
    
    if (not alive _player) exitWith /* Player does not exist */
    {
        localize "STRS_bank_transferNoExist" call RPP_fnc_hint;
    };
    
    /* Everything is ok, lets transfer the money */
    RPP_var_bankAmount = RPP_var_bankAmount - _amount;
    [RPP_var_saving_tableBanks, ["RPP_var_bankAmount", RPP_var_acc_login], RPP_var_bankAmount] call RPP_fsav_clientRequestSave;
    (format[localize "STRS_bank_transferSend", name _player, _amount]) call RPP_fnc_hint;
    ["RPP_fnc_serverTransferBnk", [_amount, player, _player]] call RPP_fnet_execPublic;

    [] call RPP_fnc_updateBankDlg;
};

/* Use like this: ["RPP_fnc_serverTransferBnk", [amount, from, sentTo]] call RPP_fnet_execPublic; */
RPP_fnc_serverTransferBnk = 
{
    private ["_amount", "_from", "_to"];
    _amount = _this select 0;
    _from = _this select 1;
    _to = _this select 2;
    
    if (player != _to) exitWith /* Not the right person who is retrieving */
    {
        /* Nothing */
    };
    
    (format[localize "STRS_bank_transferRetrieve", name _from, _amount]) call RPP_fnc_hint;
    RPP_var_bankAmount = RPP_var_bankAmount + _amount;
    [RPP_var_saving_tableBanks, ["RPP_var_bankAmount", RPP_var_acc_login], RPP_var_bankAmount] call RPP_fsav_clientRequestSave;
};

RPP_var_bankRobTime = time + RPP_var_bankDelay;
RPP_var_bankDelay = 600;
RPP_var_robAmount = 8000;
RPP_fnc_robBank = 
{
    private ["_robAmount", "_amount", "_onlinePlayers", "_robAmount", "_numCops"];
    if !(player call RPP_fnc_hasWeapon) exitWith
    {
        /* Player requires a weapon */
        localize "STRS_bank_needWeapon" call RPP_fnc_hint;
    };
    
    _robAmount = RPP_var_robAmount;
    _amount = _robAmount;
    _onlinePlayers = (count ([] call RPP_fnc_getOnlinePlayers))-1;
    _robAmount = _robAmount * _onlinePlayers;
    _numCops = [] call RPP_fnc_getNumberCops;
    
    if (_numCops < 2) exitWith
    {
        /* Not enough cops */
        localize "STRS_bank_cannotRob" call RPP_fnc_hint;
    };
    
    if (((RPP_var_bankRobTime)+RPP_var_bankDelay) >= time) exitWith
    {
        localize "STRS_bank_cannotUse" call RPP_fnc_hint;
    };
    
    RPP_var_bankRobTime = time;
      
    ["RPP_fnc_clientsRobBank", [_amount, player]] call RPP_fnet_execPublic;
    
    [_robAmount] spawn RPP_fnc_startRobbing; 
};

RPP_fnc_startRobbing = 
{
    private ["_amount", "_isRobbing", "_totalRobbed"];
    _amount = _this select 0;
    /* Message started robbing */
    
    (format[localize "STRS_bank_bankStarted", _amount]) call RPP_fnc_hint;
    
    _isRobbing = true;
    _totalRobbed = 0;
    while {((alive player) && (_isRobbing))} do
    {
        if ((_totalRobbed >= _amount) || (player distance mainBank >= 20)) exitWith
        {
            _isRobbing = false;
            ["Money", _totalRobbed] call RPP_fnc_addInventoryItem;
            
            [{ (format[localize "STRS_bank_bankEscaped", (_this select 0)]) call RPP_fnc_hint; }, [_totalRobbed]] call RPP_fnet_execPublic;
             cutText ["", "PLAIN DOWN"];
        };
            
        cutText [format["Total robbed: $%1/$%2", _totalRobbed, _amount], "PLAIN DOWN"];
        _totalRobbed = _totalRobbed + (RPP_var_robAmount/4);
        
        sleep 2;
    };
    
    if !(alive player) then
    {
        [{ localize "STRS_bank_bankStopped" call RPP_fnc_hint; }, []] call RPP_fnet_execPublic;
    };
    
};

RPP_fnc_clientsRobBank = 
{
    private ["_amount", "_robber", "_loseAmount"];
    _amount = _this select 0;
    _robber = _this select 1;
    
    player say3D "SndBankAlarm";
    
    if (player == _robber) exitWith {};
    
    RPP_var_bankRobTime = time;
    
    _loseAmount = (ceil(RPP_var_bankAmount / 8));
    
    RPP_var_bankAmount = RPP_var_bankAmount - _loseAmount;
    
    if (RPP_var_bankAmount <= 0) then
    {
        RPP_var_bankAmount = 0;
    };
    
    (format[localize "STRS_bank_bankRobbed", _loseAmount]) call RPP_fnc_hint;
};

/* Setup actions for banks */
RPP_fnc_setupBanks =
{
    {
        _name = _x select 0;
        _id = _x select 1;
        _obj = _x select 2;
        _text = "";
        
        if (_obj == mainBank) then
        {
            _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.4'>(Press F to access)<br/></t><t size='0.4'>(Press T to Rob)</t>", _name];
        }
        else
        {
            _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.4'>(Press F to access)<br/></t><t size='0.4'></t>", _name];
        };
        _onKeyAccess = "[] call RPP_fnc_openBank;";
         
        _onAdd = format[
        '
            [%2, "%1", %3, 0.9, 20, false] call RPP_fnc_create3DText;
            [%3] spawn
            {
                _onTarget = false;
                while {player distance (_this select 0) <= 20} do
                {
                    if (cursorTarget == (_this select 0)) then
                    {
                        [33, "%3 call RPP_fnc_openBank;", false, false, false] spawn RPP_fnc_addKeyAction;
                        
                        if ((_this select 0) == mainBank) then
                        {
                            [20, "[] spawn RPP_fnc_robBank;", false, false, false] spawn RPP_fnc_addKeyAction;
                        };
                        
                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (cursorTarget != (_this select 0))) then
                        {
                            _onTarget = false;
                            [33, false, false, false ] spawn RPP_fnc_remKeyAction;
                            
                            if ((_this select 0) == mainBank) then
                            {
                                [20, false, false, false ] spawn RPP_fnc_remKeyAction;   
                            };
                        };
                    };
                    sleep 0.001;
                };
                [33, false, false, false ] spawn RPP_fnc_remKeyAction;
            };

        ', _text, _id, _obj];

        _onRem = format[
        '
             %1 call RPP_fnc_disable3DText;
        ', _id];

        [player, vehicle player, compile format['(player distance %1 <= 20)', _obj], _onAdd, _id, _onRem] call RPP_fnc_addAction;
    } forEach RPP_var_banks;

};

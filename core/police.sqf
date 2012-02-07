RPP_var_pol_jail =
[
    "prison_spawn_jail1_cell1", "prison_spawn_jail1_cell2", "prison_spawn_jail1_cell3",
    "prison_spawn_jail2_cell1", "prison_spawn_jail2_cell2", "prison_spawn_jail2_cell3"
];

if (isServer) then
{
    server setVariable["prisoners", [], true];
};

RPP_fnc_pol_disarmAction = 
{
    private ["_victim"];
    _victim = _this select 0;
    
    ["RPP_fnc_pol_disarm", [_victim, player]] call RPP_fnet_execPublic;
};

RPP_fnc_pol_openTicketDlg = {
	if (!isNull(findDisplay 2300)) exitWith
    {
        /* Do nothing */
    };

	if !((player call RPP_fnc_isCop)) exitWith
    {
    
    };

	_dlg = createDialog "ALR_Dlg_Ticket";

	[] call RPP_fnc_pol_updateTicketDlg;
};

RPP_fnc_pol_updateTicketDlg = {
	private ["_numCivs"];
	lbClear 2100;
	_numCivs = 0;
	{
		_civ = call compile _x;
		
		if ((alive _civ) && (player distance _civ <= 15)) then {
			_index = lbAdd[2100, format["%1", name _civ]];
			lbSetData[2100, _index, str _civ];
			_numCivs = _numCivs + 1;
			
		};
	} forEach RPP_var_civilians;

	lbSetCurSel[2100,0];

	if (_numCivs <= 0) then {
		closeDialog 0;
	};

	
};

RPP_fnc_pol_sendTicket = {
	private ["_civ", "_amount", "_reason"];
	_civ = _this select 0;
	_amount = _this select 1;
	_reason = _this select 2;

	if (_amount <= 0) exitWith {};

	/* Message sent */
	format[localize "STRS_ticket_sentTicket", name _civ, _amount] call RPP_fnc_hint;

	["RPP_fnc_pol_recvTicket", [player, _civ, _amount, _reason]] call RPP_fnet_execPublic;

};

RPP_fnc_pol_recvTicket = {
	private ["_from", "_to", "_amount", "_reason"];
	_from = _this select 0;
	_to = _this select 1;
	_amount = _this select 2;
	_reason = _this select 3;

	if (player != _to) exitWith {
		
	};

	server globalChat format[localize "STRS_ticket_globalTicket", name _to, _amount, _reason];

	if (!isNull(findDisplay 2400)) then {
        closeDialog 0;
    };

	_dlg = createDialog "ALR_Dlg_payTicket";
	ctrlSetText[1000, format[localize "STRS_ticket_dlgMsgRecv", name player]];
	((findDisplay 2400) displayCtrl 2) ctrlSetStructuredText parseText format["%1", _reason];
	((findDisplay 2400) displayCtrl 3) ctrlSetStructuredText parseText format["Fine: $%1", _amount];
	((findDisplay 2400) displayCtrl 1600) buttonSetAction format["[%1, %2, %3] call RPP_fnc_pol_payTicket; closeDialog 0;", _amount, _to, _from];
	((findDisplay 2400) displayCtrl 1601) buttonSetAction format["closeDialog 0;", _amount, _to, _from];
};

RPP_fnc_pol_paidTicket = {
	private ["_success", "_cop", "_civ"];
	_success = _this select 0;
	_cop = _this select 1;
	_civ = _this select 2;

	if (player != _cop) exitWith {};
 
	if (_success) then {
		format[localize "STRS_ticket_copPaid", name _civ] call RPP_fnc_hint;
	} else {
		format[localize "STRS_ticket_copNoMoney", name _civ] call RPP_fnc_hint;

	};
};

RPP_fnc_pol_payTicket = {
	private ["_amount", "_to", "_from", "_money", "_success"];
	_amount = _this select 0;
	_to = _this select 1;
	_from = _this select 2;
	_money = 'Money' call RPP_fnc_itemGetAmount;
	_success = false;

	if (_money >= _amount) then {
		/* Player has enough money! */
		['Money', -_amount] call RPP_fnc_addInventoryItem;
		_success = true;

	} else {
		/* Check if player has money in bank */
		if (RPP_var_bankAmount >= _amount) then {
			RPP_var_bankAmount = RPP_var_bankAmount - _amount;
			_success = true;
		};
	};

	if !(_success) then {
		localize "STRS_ticket_cannotPay" call RPP_fnc_hint;
	} else {
		format[localize "STRS_ticket_paidFine", _amount] call RPP_fnc_hint;
	};

	["RPP_fnc_pol_paidTicket", [_success, _from, _to]] call RPP_fnet_execPublic;

};

RPP_fnc_pol_disarm = 
{
    private ["_victim", "_person"];
    _victim = _this select 0;
    _person = _this select 1;
    
    if (player == _victim) then
    {
        _weapons = weapons _victim;
        _magazines = magazines _victim;

        if (RPP_var_holstered) then
        {
            _weapons set[(count _weapons), RPP_var_holsteredWeapon];
            RPP_var_holstered = false;
        };

        [_victim, _magazines, _weapons] call RPP_fnc_dropWeapons;
        
        format[localize "STRS_disarm_victim", name _person] call RPP_fnc_hint;
    };
    
    if (player == _person) then
    {
        format[localize "STRS_disarm_person", name _victim] call RPP_fnc_hint;    
    };
};

RPP_fnc_pol_arrest = 
{
    private ["_victim", "_nearestVehicle"];
    _victim = _this select 0;
    _nearestVehicle = [] call RPP_fnc_getNearestVehicle;
    
    if ((_victim call RPP_fnc_isCop)) exitWith
    {
    
    };
    
    if (_nearestVehicle == empty) exitWith 
    {
        /* No nearby vehicle */
        localize "STRS_arrest_noVehicle" call RPP_fnc_hint;
    };
    
    if (_nearestVehicle distance player >= 7) exitWith
    {
        /* No nearby vehicle */
        localize "STRS_arrest_noVehicle" call RPP_fnc_hint;
    };
    
    [{ server globalchat format[localize "STRS_arrest_vehicleNotify", name(_this select 0), name(_this select 1)]; }, [_victim, player]] call RPP_fnet_execPublic;
    [{ (_this select 0) moveInCargo (_this select 1); }, [_victim, _nearestVehicle]] call RPP_fnet_execPublic;
    ["RPP_fnc_pol_vehicleInsert", [_victim, player]] call RPP_fnet_execPublic;
};

RPP_fnc_pol_vehicleInsert = 
{
    private ["_victim", "_person"];
    _victim = _this select 0;
    _person = _this select 1;
    
    if (player == _victim) then
    {
         format[localize "STRS_arrest_vehicleVictim", name _person] call RPP_fnc_hint;
    };
    
    if (player == _person) then
    {
        format[localize "STRS_arrest_vehiclePerson", name _victim] call RPP_fnc_hint;
    };
};

RPP_fnc_pol_openArrest = 
{
    if (!isNull(findDisplay 2100)) exitWith
    {
        /* Do nothing */
    };
    
    if !((player call RPP_fnc_isCop)) exitWith
    {
    
    };
    
    createDialog "RPP_Dlg_Arrest";
    
    [] call RPP_fnc_pol_populateArrest;

};

RPP_fnc_pol_populateArrest = 
{
    lbClear 2100;
    lbClear 2101;
    {
        _unit = _x;
        
        if (_unit call RPP_fnc_isCiv) then
        {
            _index = lbAdd[2100, format["%1", name _unit]];
            lbSetData[2100, _index, str _unit];
        };    
    } forEach (crew vehicle player);
    
    _prisoners = server getVariable "prisoners";
    {
        if (isNull _x) exitWith
        {
            _prisoners set[_forEachIndex, "REMOVE"];
        };
    
    } forEach _prisoners;
    _prisoners = _prisoners - ["REMOVE"];
    server setVariable["prisoners", _prisoners, true];
    
    {
        _unit = _x;
        _index = lbAdd[2101, format["%1", name _unit]];
        lbSetData[2101, _index, str _unit];
    } forEach (server getVariable "prisoners");
    
    sliderSetRange [1900, 1, RPP_var_pol_maxArrest];
    sliderSetSpeed [1900, 1, 50];
    sliderSetPosition [1900, 1];
    
    lbSetCurSel [2100,0];
    lbSetCurSel [2101,0];

    [] call RPP_fnc_pol_updateArrest;
};

RPP_fnc_pol_updateArrest = 
{
    private ["_pos"];
    _pos = sliderPosition 1900;
    
    ctrlSetText[5, format["Time: %1 minutes", round _pos]];
};

RPP_fnc_pol_arrestPlayer = 
{
    private ["_victim", "_player", "_arrest"];
    _victim = _this select 0;
    _player = _this select 1;
    _arrest = _this select 2;
    
    if (player == _victim) then
    {
        format[localize "STRS_arrest_arrested", _arrest] call RPP_fnc_hint;
    };
    
    server globalchat format[localize "STRS_arrest_arrestNotify", name _victim, _arrest];
    
    ["RPP_fnc_pol_clientArrest", [_victim, _player, _arrest]] call RPP_fnet_execPublic;
    closeDialog 0;
};

RPP_fnc_pol_clientArrest = 
{
    private ["_victim", "_player", "_arrest"];
    _victim = _this select 0;
    _player = _this select 1;
    _arrest = _this select 2;
    
    if (player != _victim) exitWith {};
    
    ["RPP_fnc_pol_disarm", [_victim, _player]] call RPP_fnet_execPublic;

    
    closeDialog 0;
    [] spawn
    {
        player action["eject", vehicle player];
        sleep 1;
        player setPos getMarkerPos ([] call RPP_fnc_pol_getRandomCell);
    };
    
    [] call RPP_fnc_removeIllegalItems;

    ["Hunger", 100] call RPP_fnc_setDynamic;
    ["Thirst", 100] call RPP_fnc_setDynamic;

    RPP_var_isArrested = true;
    RPP_var_jailTime = _arrest*60;
    ["RPP_var_jailTime", [RPP_var_jailTime]] call RPP_var_saving_saveVar;
    [] spawn RPP_fnc_pol_prisonLoop;
    
    _prisoners = server getVariable "prisoners";
    _prisoners set[(count _prisoners), player];
    server setVariable["prisoners", _prisoners, true];
    

};

RPP_fnc_pol_getRandomCell = 
{
    (RPP_var_pol_jail select (random (count RPP_var_pol_jail-1)));
};

RPP_fnc_pol_prisonLoop = 
{
    _markerPos = getMarkerPos ([] call RPP_fnc_pol_getRandomCell);
    _time = time;
    _releaseTime = (_time + RPP_var_jailTime);
    waitUntil {player distance _markerPos <= 10};
    while {RPP_var_isArrested} do
    {
        if ((player distance _markerPos >= 45) && (alive player)) then
        {
            /* Escaped */
             ["RPP_fnc_pol_prisonerEscaped", [player]] call RPP_fnet_execPublic;
        };
        
        if !(alive player) then
        {
            /* Killed */
			waitUntil {alive player};
			 _markerPos = getMarkerPos ([] call RPP_fnc_pol_getRandomCell);
			player setpos _markerPos;
        };
        
        if (time >= _releaseTime) then
        {
            /* Released */
             ["RPP_fnc_pol_prisonerReleased", [player]] call RPP_fnet_execPublic;
        };
        
    
        sleep 1;
    };
    
    RPP_var_jailTime = 0;
    ["RPP_var_jailTime", [RPP_var_jailTime]] call RPP_var_saving_saveVar;
    
    _prisoners = server getVariable "prisoners";
    {
        if (_x == player) exitWith
        {
            _prisoners set[_forEachIndex, "REMOVE"];
        };
    
    } forEach _prisoners;
    _prisoners = _prisoners - ["REMOVE"];
    server setVariable["prisoners", _prisoners, true];
     
};

RPP_fnc_pol_prisonerEscaped = 
{
    private ["_prisoner"];
    _prisoner = _this select 0;
    
    if (player == _prisoner) then
    {
         RPP_var_isArrested = false;
         localize "STRS_arrest_prisonerEscaped" call RPP_fnc_hint;
    };
    
    server globalchat format[localize "STRS_arrest_escaped", name _prisoner];

};

RPP_fnc_pol_prisonerReleased = 
{
    private ["_prisoner", "_person"];
    _prisoner = _this select 0;
    _person = _prisoner;
    if (count _this >= 2) then
    {
        _person = _this select 1;
    };
    
    if (_prisoner == _person) then
    {
        /* Released */
        server globalchat format[localize "STRS_arrest_released", name _prisoner];
		[] spawn ALR_acre_radios;

    }
    else
    {
        /* Released by person */
        server globalchat format[localize "STRS_arrest_earlyRelease", name _prisoner, name _person];
		[] spawn ALR_acre_radios;
    };
    
    if (_prisoner == player) then
    {
         RPP_var_isArrested = false;
         localize "STRS_arrest_release" call STRS_arrest_release;
         player setpos getMarkerPos "prison_release";
    };
};

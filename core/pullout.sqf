_who = _this select 1;
_car = _this select 0;
_rem = 0;
_pull = 0;
_num = 0;
_crew = crew _car;

if (typeName _car == "STRING") then
{
    _car = _car call RPP_fnc_findVehicle; 
};

if (typeName _who == "STRING") then
{
    _who = call compile _who;
};

closeDialog 0;

if ((count _crew) < 1) exitWith
{
    localize "STRS_pullout_empty" call RPP_fnc_hint;
};

if (vehicle player != player) exitWith
{
    localize "STRS_pullout_notPossible" call RPP_fnc_hint;
};

if (_who distance (_crew select 0) > 3) exitWith
{
    localize "STRS_pullout_tooFar" call RPP_fnc_hint;
};

if (alive _who) then
{
    format [localize "STRS_pullout_pullOut", name (_crew select 0)] call RPP_fnc_hint;
    [{ if (player == (_this select 0)) then { format [localize "STRS_pullout_pulledOut", (_this select 1)] call RPP_fnc_hint; }; }, [(_crew select 0), name _who]] call RPP_fnet_execPublic;

    _rem = 1;

    _said = 0;

    while {_num < 10} do
    {
        if (_who distance (_crew select 0) > 3) exitWith
        {
            localize "STRS_pullout_tooFar" call RPP_fnc_hint;
            _num = 11;
        };

        if (locked _car) then
        {
            if (_said == 0) then
            {
                _said = 1;
                localize "STRS_pullout_locked" call RPP_fnc_hint;
                sleep 0.3;
            };
        };

        sleep 0.3;
        _pull = _pull + 1;
        _num = _num + 1;
    };

	if (_pull == 10) then
	{
            [{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";},[_who]] call TNL_fnet_execPublic;
            sleep 0.4;

            [{
                if (player == (_this select 0)) then
                {
                    _car = vehicle player;
                    _victim = player;

                    player action ["eject", _car];
                };
                (_this select 0) switchmove "AmovPercMrunSlowWrflDf_AmovPpneMstpSrasWrflDnon";
            }, [(_crew select 0)]] call RPP_fnet_execPublic;
	};
}
else
{
    if ({!(_x in ["Throw", "Put", "NVGoggles", "Binocular"])} count (weapons _who) == 0 && (locked car)) exitWith
    {
        localize "STRS_pullout_lockedWeapon" call RPP_fnc_hint;
    };

    format [localize "STRS_pullout_pullOut", (_crew select 0)] call RPP_fnc_hint;
    (_crew select 0) groupChat format ["%1 is pulling you out of the car!", _who];
    _rem = 1;

    _said = 0;
    while {_num < 10} do
    {
        if (_who distance (_crew select 0) > 3) exitWith
        {
            localize "STRS_pullout_tooFar" call RPP_fnc_hint;
            _num = 11;
        };

        if ({!(_x in ["Throw", "Put", "NVGoggles", "Binocular"])} count (weapons _who) == 0 && (locked car)) exitWith
        {
            localize "STRS_pullout_lockedWeapon" call RPP_fnc_hint;
            _pull = -10;
        };		

        if (locked _car) then
        {
            if ({!(_x in ["Throw", "Put", "NVGoggles", "Binocular"])} count (weapons _who) == 0) exitWith
            {
                localize "STRS_pullout_lockedWeapon" call RPP_fnc_hint;
                _pull = -10;
            };

            if (_said == 0) then
            {
                _said = 1;
                localize "STRS_pullout_locked" call RPP_fnc_hint;
                sleep 0.5;
            };
        };

        sleep 0.25;
        _pull = _pull + 1;
        _num = _num + 1;
    };
    if (_pull == 10) then
    {
        [{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";},[_who]] call RPP_fnet_execPublic;
        sleep 0.4;

        [{
            if (player == (_this select 0)) then
            {
                _car = vehicle player;
                _victim = player;

                player action ["eject", _car];
            };
            (_this select 0) switchmove "AmovPercMrunSlowWrflDf_AmovPpneMstpSrasWrflDnon";
        }, [(_crew select 0)]] call RPP_fnet_execPublic;
    };
};

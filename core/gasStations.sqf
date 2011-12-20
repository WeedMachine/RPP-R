/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_gasStations = [ [gas1, "Arar Fuel"], [gas2, "Schnell Fuel"], [gas3, "Oxygen Fuel"], [gas4, "Schnell Fuel"], [gas5, "Schnell Fuel"]   ];
{ 
    _logic = (_x select 0);
    (_x select 0) setVariable["bill", 0, false]; 
    
    {
        _x setFuelCargo 0;
    } forEach (nearestObjects [_logic, ["Land_A_FuelStation_Feed", "Land_benzina_schnell", "Land_fuelstation", "Land_fuelstation_army"], 30]);

} forEach (RPP_var_gasStations);


RPP_var_gasPrice = 7;
RPP_var_isRefueling = false;

RPP_fnc_refuelPayBill = 
{
    private ["_station", "_money", "_bill"];
    _station = _this select 0;
    _money = "Money" call RPP_fnc_itemGetAmount;
    _bill = _station getVariable "bill";
    
    if (RPP_var_isRefueling) exitWith
    {
        RPP_var_isRefueling = false;
    };
    
    if (_bill <= 0) exitWith
    {
        localize "STRS_gasStations_noBill" call RPP_fnc_hint;
    
    };
    
    if (_money < _bill) exitWith
    {
        (format[localize "STRS_gasStations_noMoney", _bill]) call RPP_fnc_hint;
    };
    
    
    (format[localize "STRS_gasStations_paidBill", _bill]) call RPP_fnc_hint;
    _station setVariable["bill", 0, false];
    ["Money", -(_bill)] call RPP_fnc_addInventoryItem;
    RPP_var_other = RPP_var_other - _bill;
};

RPP_fnc_clientRefuelCheck = 
{
    while {true} do
    {
        {
            _station = (_x select 0);
            _bill = _station getVariable "bill";
            
            if ((player distance _station >= 40) && (_bill > 0)) then
            {
                /* Ran away without paying */
                _station setVariable ["bill", 0, false];
                (format[localize "STRS_gasStations_leftNoPay", _bill]) call RPP_fnc_hint;
                ["RPP_fnc_gasStationAlert", [player,_bill]] call RPP_fnet_execPublic;
            };
        } forEach RPP_var_gasStations;
    
        sleep 1;
    };
};

RPP_fnc_refuelVehicle = 
{
    private ["_vehicle", "_station", "_position", "_ok", "_bill", "_totalCost"];
    _vehicle = _this select 0;
    _station = _this select 1;
    _ok = true;

    if (RPP_var_isRefueling) exitWith 
    {
        RPP_var_isRefueling = false;
    };
    
    RPP_var_isRefueling = true;
    
    if (driver _vehicle != player) exitWith
    {
        localize "STRS_gasStations_notDriver" call RPP_fnc_hint;
        _ok = false;
    };
    
    _position = position _vehicle;
    _totalCost = 0;
    _bill = _station getVariable "bill";
    
    while {RPP_var_isRefueling} do
    {
        if ((fuel _vehicle) >= 0.995) exitWith
        {
            RPP_var_isRefueling = false;
        };
        
        if (_vehicle distance _position > 4) exitWith
        {
            RPP_var_isRefueling = false;
        };
        
        _totalCost = _totalCost + RPP_var_gasPrice;
        _bill = _bill + RPP_var_gasPrice;
        
        _vehicle setFuel (fuel _vehicle + 0.025);
        
        titleText [format["Refueling...\n\nFuel: %1\nPrice: $%2\nBill: $%3", fuel _vehicle, _totalCost, _bill], "PLAIN"];
    
    
        sleep 1;
    };
    titleText ["", "PLAIN"];
    _station setVariable["bill", _bill];
    
    if (_ok) then
    {
        (format[localize "STRS_gasStations_refueled", _totalCost, _bill]) call RPP_fnc_hint;
    };
    
    RPP_var_isRefueling = false;
};

RPP_fnc_gasStationAlert = 
{
    private ["_person", "_amount"];
    _person = _this select 0;
    _amount = _this select 1;
    
    if ((player call RPP_fnc_isCop)) then
    {
        format[localize "STRS_gasStations_police", name _person, _amount] call RPP_fnc_hint;    
    };

};

RPP_fnc_setupGasStations = 
{
    {
        _logic = _x select 0;
        _name = _x select 1;
        _bill = _logic getVariable "bill";

        _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.475'>Price per L: $%2</t><br/><t size='0.475'>Bill: $%3</t><br/><t size='0.4'>(Press R to refuel)<br/></t><t size='0.4'>(Press B to pay bill)</t>", _name, RPP_var_gasPrice, _bill];
        _id = [] call RPP_fnc_generateID;

        _onAdd = format[
        '
            [%2, "%1", %3, 0.9, 20, false] call RPP_fnc_create3DText;
            [%3, %2] spawn
            {
                _oldBill = (%3 getVariable "bill")-1;
                _onTarget = false;
                _updated = false;
                while {player distance (_this select 0) <= 10} do
                {
                    if ((vehicle player != player) || (not(_updated))) then
                    {
                        [19 , "[vehicle player, %3] spawn RPP_fnc_refuelVehicle;", false, false, false] spawn RPP_fnc_addKeyAction;
                        [48, "[%3] spawn RPP_fnc_refuelPayBill;", false, false, false] spawn RPP_fnc_addKeyAction;
                        
                        if ((_this select 0 getVariable "bill") != _oldBill) then
                        {
                            %2 call RPP_fnc_disable3DText;
                            _newBill = ((_this select 0) getVariable "bill");
                            _text = "<t size=""0.55"" color=""#008000"">%4</t><br/><t size=""0.475"">Price per L: $"+str RPP_var_gasPrice+"</t><br/><t size=""0.475"">Bill: $"+str _newBill+"</t><br/><t size=""0.4"">(Press R to refuel)<br/></t><t size=""0.4"">(Press B to pay bill)</t>";
                            [(_this select 1), _text, (_this select 0), 0.9, 20, false] call RPP_fnc_create3DText;
                            _oldBill = (_this select 0) getVariable "bill";
                            _updated = true;
                        };
                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (vehicle player == player)) then
                        {
                            _onTarget = false;
                            [48 , false, false, false] spawn RPP_fnc_remKeyAction;
                            [19, false, false, false] spawn RPP_fnc_remKeyAction;
                            RPP_var_isRefueling = false;
                        };
                    };
                    sleep 0.001;
                };
                [48 , false, false, false] spawn RPP_fnc_remKeyAction;
                [19, false, false, false] spawn RPP_fnc_remKeyAction;
                RPP_var_isRefueling = false;
            };

        ', _text, _id, _logic, _name];

        _onRem = format[
        '
             %1 call RPP_fnc_disable3DText;
        ', _id];

        [player, vehicle player, compile format['(player distance %1 <= 10)', _logic], _onAdd, _id, _onRem] call RPP_fnc_addAction;
    } forEach RPP_var_gasStations;
};
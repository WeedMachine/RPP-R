RPP_var_investLocations = 
[
    [car_dealer, "Car Dealer", [10000, 333]],
	[truck_dealer, "Truck Dealer", [20000, 667]],
	[bike_dealer, "Bike Dealer", [5000, 167]],
	[bike_dealer2, "2 Wheels Deals", [3000, 100]],
	[classic_dealer, "Classic Car Dealer", [35000, 1167]],
	[realestate_betty, "Farmer Betty", [50000,1667]],
    [farmer_joe, "Farmer Joe", [10000, 333]]
	
];

RPP_var_invested = [];

RPP_fnc_invest = 
{
    private ["_obj", "_money", "_price"];
    _obj = _this;
    
    if (str _obj in RPP_var_invested) exitWith
    {
        /* Already invested */
        localize "STRS_invest_already" call RPP_fnc_hint;
    };
    
    _money = "money" call RPP_fnc_itemGetAmount;
    _price = _obj call RPP_fnc_getInvestPrice;
    
    if (_money < _price) exitWith
    {
        /* Not enough money */
        localize "STRS_invest_notEnough" call RPP_fnc_hint;
    };
    
    ["money", -(_price)] call RPP_fnc_addInventoryItem;
    RPP_var_invested set[(count RPP_var_invested), str _obj];
    RPP_var_other = RPP_var_other - _price;
    
    /* You have invested into the shop */
    (format[localize "STRS_invest_done", _price, _obj call RPP_fnc_getInvestName]) call RPP_fnc_hint;
    [RPP_var_saving_tableInvest, ["RPP_var_invested", RPP_var_acc_login], RPP_var_invested] call RPP_fsav_clientRequestSave;
};

RPP_fnc_getInvestArray = 
{
    private ["_obj", "_return"];
    _obj = _this;
    _return = [];
    
    {
        if (_x select 0 == _obj) exitWith
        {
            _return = _x;
        };
    } forEach RPP_var_investLocations;

    _return
};

RPP_fnc_getInvestPrice = 
{
    (((_this call RPP_fnc_getInvestArray) select 2) select 0)
};

RPP_fnc_getInvestMoney = 
{
    (((_this call RPP_fnc_getInvestArray) select 2) select 1)
};

RPP_fnc_getInvestName = 
{
    ((_this call RPP_fnc_getInvestArray) select 1)
};

RPP_fnc_setupInvesting = 
{
    {
        _name = _x select 1;
        _obj = _x select 0;
        _price = (_x select 2) select 0;
        _id = [] call RPP_fnc_generateID;
        
        _text = format["<t size='0.55' color='#4876FF'>%1</t><br/><t size='0.45'>$%2</t><br/><t size='0.4'>(Press F to Invest)<br/>", _name, _price];
        _onKeyAccess = "";
        
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
                        [33, "%3 spawn RPP_fnc_invest;", false, false, false] spawn RPP_fnc_addKeyAction;
                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (cursorTarget != (_this select 0))) then
                        {
                            _onTarget = false;
                            [33, false, false, false ] spawn RPP_fnc_remKeyAction;
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
    } forEach RPP_var_investLocations;
};

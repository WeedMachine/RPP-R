/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_licenseShops = 
[
    [license_car, "car", 1200],
	[license_pistol, "pistol", 5000],
	[license_semiautogun, "semiautogun", 7200],
	[license_truck, "truck", 2400],
	[license_pilot, "pilot", 10000]
];

RPP_var_licenses =
[
    ["car", "Car License"],
	["pistol", "Pistol License"],
	["semiautogun", "Semi Automatic Rifle License"],
	["truck", "Truck License"],
	["pilot", "Pilot License"]
];

RPP_var_playerLicenses = [];

RPP_fnc_getLicenseName = 
{
    private ["_class", "_return"];
    _class = _this;
    _return = "";
    
    {
        if (_x select 0 == _class) exitWith
        {
            _return = (_x select 1);
        };
    } forEach RPP_var_licenses;

    _return
};

RPP_fnc_purchaseLicense =
{
    private ["_obj", "_class", "_price", "_money", "_name"];
    _obj = _this select 0;
    _class = _this select 1;
    _price = _this select 2;
    _money = "Money" call RPP_fnc_itemGetAmount;
    _name = _class call RPP_fnc_getLicenseName;
    
    if (_money < _price) exitWith
    {
        /* No money */
        (format[localize "STRS_license_noMoney", _name, _money]) call RPP_fnc_hint;
    };
    
    if (_class call RPP_fnc_hasLicense) exitWith
    {
        /* Already own license */
        localize "STRS_license_alreadyOwn" call RPP_fnc_hint;
    };
    
    /* Its ok to buy, remove money and add license */
    (format[localize "STRS_license_purchase", _name, _price]) call RPP_fnc_hint;
    ["Money", -(_price)] call RPP_fnc_addInventoryItem;
    _class call RPP_fnc_addLicense;
};

RPP_fnc_addLicense = 
{
    private ["_class"];
    _class = _this;
    
    if (not (_class call RPP_fnc_hasLicense)) then
    {
        RPP_var_playerLicenses set[(count RPP_var_playerLicenses), _class];
        [RPP_var_saving_tableLicenses, ["RPP_var_playerLicenses", RPP_var_acc_login], RPP_var_playerLicenses] call RPP_fsav_clientRequestSave;
    };
};

RPP_fnc_hasLicense = 
{
    private ["_class", "_found"];
    _class = _this;
    _found = false;
    
    _found = _class in RPP_var_playerLicenses;
    
    _found
};

RPP_fnc_setupLicenseShops = 
{
    {
        _price = _x select 2;
        _licenseID = (_x select 1);
        _name = _licenseID call RPP_fnc_getLicenseName;
        _id = [] call RPP_fnc_generateID;
        _obj = _x select 0;
        
        _text = format["<t size='0.55' color='#008000'>%1</t><br/><t size='0.45' color='#FEE5AC'>$%2</t><br/><t size='0.4'>(Press F to buy)<br/></t><t size='0.4'></t>", _name, _price];
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
                        [33, "[%3, ""%4"", %5] call RPP_fnc_purchaseLicense;", false, false, false] spawn RPP_fnc_addKeyAction;
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

        ', _text, _id, _obj, _licenseID, _price];

        _onRem = format[
        '
             %1 call RPP_fnc_disable3DText;
        ', _id];

        [player, vehicle player, compile format['(player distance %1 <= 20)', _obj], _onAdd, _id, _onRem] call RPP_fnc_addAction;
    } forEach RPP_var_licenseShops;
};
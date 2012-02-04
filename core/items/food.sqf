_class = _this select 0;
_amount = _this select 1;

_fillHunger = 0;
_text = "";

if (_class call RPP_fnc_itemGetAmount < _amount) exitWith 
{
    localize "STRS_food_notEnough" call RPP_fnc_hint;
};

closeDialog 0;


_foodArray =
[
    ["Minnow", 0.25, localize "STRS_food_minnow"],
    ["Bluegill", 6, localize "STRS_food_bluegill"],
	["Catfish", 7, "You ate the Catfish(s)"],
	["Perch", 7, "You ate the Perch(s)"],
	["Trout", 7.5, "You ate the Trout(s)"],
	["RockBass", 7.6, "You ate the RockBass(s)"],
	
	["Shrimp", 1, "You ate the Shrimp(s)"],
	["Sardine", 4, "You ate the Sardine(s)"],
	["Monkfish", 5, "You ate the Monkfish(s)"],
	["Salmon", 5, "You ate the Salmon(s)"],
	["Shark", 20, "You ate the Shark(s)"],	
	["Tuna", 15, "You ate the Tuna(s)"],	
	["Whale", 50, "You ate the Whale(s)"],	
	["Swordfish", 15, "You ate the Swordfish(s)"],	
	
	["Rabbit", 20, "You ate the Rabbit(s)"],	
	["Chicken", 15, "You ate the Tuna(s)"],	
	["Lamb", 50, "You ate the Lamb(s)"],	
	["Cow", 15, "You ate the Cow(s)"],
	["Boar", 15, "You ate the Boar(s)"],
	
	["Soup", 1, "You eat the Soup(s)"],
	["CookedMeat", 10, "You eat the Meat"],
    ["Sandwich", 10, "You eat the Sandwich(s)"],
    ["Bread", 8, "You eat the Bread"],
	["Apple", 20, "You eat the Apple(s)"],
	["Pumpkin", 10, "You ate the Pumpkin"],
    ["Cabbage", 10, "You ate the Cabbage(s)"],
    ["Potato", 8, "You ate the Potato"],
	["Meat", 10, "You eat the Meat"],
	
    ["Donut", 6, "You eat the Donut(s)"]
];

{
    if (_x select 0 == _class) exitWith
    {
        _fillHunger = _x select 1;
        _text = _x select 2;
    };
} forEach _foodArray;

["Hunger", _fillHunger * _amount] call RPP_fnc_increaseDynamic;

if (("Hunger" call RPP_fnc_getDynamicVal) > 100) then
{
    ["Hunger", 100] call RPP_fnc_setDynamic;
};

format["%1", _text] call RPP_fnc_hint;
[_class, -(_amount)] call RPP_fnc_addInventoryItem;

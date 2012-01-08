/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_goods =
[
    ["Money", ["ITEM", "SPECIAL"], ["Money", "No description"], [0,0], 0, "core\items\noUse.sqf", 0, true, [   ], false ],
    ["Keychain", ["ITEM", "SPECIAL"], ["Keychain", "No description"], [0,0], 0.0, "core\items\keychain.sqf", 0, false, [], false],
    ["MedicalBag", ["ITEM", "SPECIAL"], ["Medical Bag", "No description"], [0,0], 5.0, "core\items\medic.sqf", 0, true, [], false],

    /* Tools */
    ["Pickaxe", ["ITEM", "TOOL"], ["Pickaxe", localize "STRS_item_pickaxeDesc"], [200, 150], 12, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1]]], false],
    ["Hatchet", ["ITEM", "TOOL"], ["Hatchet", "No description"], [150, 75], 8, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1]]], false],

    /* Equipment */
    ["ItemMap", ["WEAPON", "ITEM"], ["Map", "No description"], [150,75], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemCompass", ["WEAPON", "ITEM"], ["Compass", "No description"], [40,20], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemWatch", ["WEAPON", "ITEM"], ["Watch", "No description"], [25,20], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemRadio", ["WEAPON", "ITEM"], ["Radio", "No description"], [100,50], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemGPS", ["WEAPON", "ITEM"], ["GPS", "No description"], [800,500], 0, "core\items\noUse.sqf", 0, true, [], false],
    
    ["Handcuffs", ["ITEM", "TOOL"], ["Handcuffs", "No description"], [0,0], 1, "core\items\handcuffs.sqf", 0, true, [], false],
    
    /* Lockpick & Crowbar */
    ["Lockpick", ["ITEM", "TOOL"], ["Lockpick", "No description"], [0,0], 1, "core\items\lockpick.sqf", 0, true, [], false],
    ["Crowbar", ["ITEM", "TOOL"], ["Crowbar", "No description"], [0,0], 1, "core\items\crowbar.sqf", 0, true, [], false],
    
    ["Phone", ["ITEM", "MOBILE"], ["Mobile Phone", "No description"], [200,75], 1, "core\items\phone.sqf", 0, true, [], false],
    ["RepairKit", ["ITEM", "ITEM"], ["RepairKit", "No description"], [300,150], 10, "core\items\repairKit.sqf", 0, true, [], false],
    ["RefuelCan", ["ITEM", "ITEM"], ["RefuelCan", "No description"], [200,100], 5, "core\items\refuelCan.sqf", 0, true, [], false],

    /* Farming */
    ["Wheat", ["ITEM", "RESOURCE"], ["Wheat", "No Desc"], [5,1], 1, "core\items\nouse.sqf", 0, true, [], false], 
    
    /* Objects */
    ["Land_Farm_Cowshed_c", ["ITEM", "OBJECT"], ["Cowshed", localize "STRS_object_desc"], [0,0], 5, "core\items\object.sqf", 0, true, [], false],
    ["cl_Spikestrip", ["ITEM", "OBJECT"], ["Spikestrip", localize "STRS_object_desc"], [0,0], 5, "core\items\object.sqf", 0, true, [], true],
    
    //["Wall_FenW2_6_EP1", ["ITEM", "OBJECT"], ["Fence", localize "STRS_object_desc"], [0,0], 5, "core\items\object.sqf", 0, true, []],
    
    /* Food & Drink */
    ["Soup", ["ITEM", "FOOD"], ["Soup", "No Desc"], [5,2], 0.1, "core\items\food.sqf", 0, true, [], false], 
    ["Sandwich", ["ITEM", "FOOD"], ["Sandwich", "No Desc"], [15,7], 0.1, "core\items\food.sqf", 0, true, [], false], 
    ["Bread", ["ITEM", "FOOD"], ["Bread", "No Desc"], [40,25], 0.1, "core\items\food.sqf", 0, true, [], false], 
    ["Donut", ["ITEM", "FOOD"], ["Donut", "No Desc"], [10,5], 0.1, "core\items\food.sqf", 0, true, [], false], 
    ["Low_bottleWater", ["ITEM", "DRINK"], ["Small Bottled Water", "No Desc"], [10,5], 1, "core\items\drink.sqf", 0, true, [], false],
    ["High_bottleWater", ["ITEM", "DRINK"], ["Bottled Water", "No Desc"], [25,20], 2, "core\items\drink.sqf", 0, true, [], false],
    ["Bottle", ["ITEM", "DRINK"], ["Bottle", "No Desc"], [50,25], 1, "core\items\nouse.sqf", 0, true, [], false],
    
    /* Boats */
    ["Fishing_Boat", ["VEHICLE", "BOAT"], ["Fishing Boat", "No Desc"], [6500,2500], 600, "core\items\noUse.sqf", 300, true, [], false],
    ["Smallboat_1", ["VEHICLE", "BOAT"], ["Small Boat 1", "No Desc"], [3250,1500], 160, "core\items\noUse.sqf", 80, true, [], false],
    ["Smallboat_2", ["VEHICLE", "BOAT"], ["Small Boat 2", "No Desc"], [3250,1500], 160, "core\items\noUse.sqf", 80, true, [], false],
    ["PBX", ["VEHICLE", "BOAT"], ["PBX", "No Desc"], [1750,800], 120, "core\items\noUse.sqf", 60, true, [], false],
    
    /* Fishing */
    ["Fishing_rod", ["ITEM", "TOOL"], ["Fishing rod", "No Desc"], [45, 20], 10, "core\items\fishingUse.sqf", 0, true, [2, [ ["IronBar", 1]]], false],
    ["Minnow", ["ITEM", "BAIT"], ["Minnow", "No Desc"], [20,10], 1, "core\items\food.sqf", 0, true, [], false],
    ["Worm", ["ITEM", "BAIT"], ["Worm", "No Desc"], [5,1], 0, "core\items\nouse.sqf", 0, true, [], false],
    
    ["Bluegill", ["ITEM", "FISH"], ["Bluegill", "No Desc"], [50,25], 0, "core\items\food.sqf", 0, true, [], false],
    
    /* Bushes/Seeds/Trees */
    ["mari_seed", ["ITEM", "SPROUT"], ["Marihuana Seed", "No Desc"], [5,1], 0, "core\items\sprout.sqf", 0, true, [], true],
    ["populus_seed", ["ITEM", "SPROUT"], ["Populus Seed", "No Desc"], [5,1], 0, "core\items\sprout.sqf", 0, true, [], false],
    
    ["mari", ["ITEM", "DRUG"], ["Marihuana", "No Desc"], [5,1], 1, "core\items\nouse.sqf", 0, true, [], true],
    
    ["populus_log", ["ITEM", "RESOURCE"], ["Populus Log", "No Desc"], [5,1], 25, "core\items\nouse.sqf", 0, true, [], false], 
    ["wood", ["ITEM", "RESOURCE"], ["Wood", "No Desc"], [5,1], 10, "core\items\nouse.sqf", 0, true, [], false],     

    //Cars
    ["Skoda", ["VEHICLE", "CAR"], ["Skoda White", "No Desc"], [750,450], 120, "core\items\noUse.sqf",60, true, [2, [ ["IronBar", 1]]], false, []],
    ["SkodaRed", ["VEHICLE", "CAR"], ["Skoda Red", "No Desc"], [750,450], 120, "core\items\noUse.sqf", 60, true, [], false, []],
    ["SkodaBlue", ["VEHICLE", "CAR"], ["Skoda Blue", "No Desc"], [750,450], 120, "core\items\noUse.sqf", 60, true, [], false, []],
    ["SkodaGreen", ["VEHICLE", "CAR"], ["Skoda Green", "No Desc"], [750,450], 120, "core\items\noUse.sqf", 60, true, [], false, []],
    ["VWGolf", ["VEHICLE", "CAR"], ["VW Golf", "No Desc"], [1650,800], 130, "core\items\noUse.sqf", 65, true, [], false, []],
    ["car_hatchback", ["VEHICLE", "CAR"], ["Hatchback", "No Desc"], [850,600], 100, "core\items\noUse.sqf", 50, true, [], false, []],
    ["car_sedan", ["VEHICLE", "CAR"], ["Sedan", "No Desc"], [1250,800], 65, "core\items\noUse.sqf", 65, true, [], false, []],
    ["Lada1_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Lada Green", "No Desc"], [400,190], 50, "core\items\noUse.sqf", 50, true, [], false, []],
    ["Lada2_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Lada Decorated", "No Desc"], [400,190], 50, "core\items\noUse.sqf", 50, true, [], false, []],
    ["Volha_1_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Car (Blue)", "No Desc"], [200,50], 60, "core\items\noUse.sqf", 30, true, [], false, []],
    ["Volha_2_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Car (White)", "No Desc"], [200,50], 60, "core\items\noUse.sqf", 30, true, [], false, []],
    
	//Police Cars
	["Copcar", ["VEHICLE", "CAR"], ["Holden Monaro Standard", "No Desc"], [7500,3000], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["CopcarAus", ["VEHICLE", "CAR"], ["Holden Monaro Blue", "No Desc"], [9500,3000], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["CopcarAusgreen", ["VEHICLE", "CAR"], ["Holden Monaro Green", "No Desc"], [9500,3000], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["Copcarhw", ["VEHICLE", "CAR"], ["Holden Monaro Highway Patrol", "No Desc"], [9500,3000], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["CopcarHW2", ["VEHICLE", "CAR"], ["Holden Monaro Highway Patrol", "No Desc"], [8000,3000], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["Paddy", ["VEHICLE", "CAR"], ["Holden Paddywagon WIP", "No Desc"], [17500,8500], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["SUV_TK_CIV_EP1", ["VEHICLE", "CAR"], ["SWAT SUV", "No Desc"], [17500,8500], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["Fordpatrolbasic", ["VEHICLE", "CAR"], ["Ford Falcon Standard WIP", "No Desc"], [17500,8500], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	["CopcarNZ", ["VEHICLE", "CAR"], ["Holden Monaro NZ", "No Desc"], [7500,3000], 65, "core\items\noUse.sqf", 65, true, [], false, []],
	
    //Pickups
    ["datsun1_civil_1_open", ["VEHICLE", "CAR"], ["Datsun Open (Blue)", "No Desc"], [1500,750], 150, "core\items\noUse.sqf", 75, true, [], false, []],
    ["datsun1_civil_2_covered", ["VEHICLE", "CAR"], ["Datsun Covered", "No Desc"], [1500,750], 150, "core\items\noUse.sqf", 75, true, [], false, []],
    ["datsun1_civil_3_open", ["VEHICLE", "CAR"], ["Datsun Tubeframe", "No Desc"], [1500,750], 150, "core\items\noUse.sqf", 75, true, [], false, []],
    ["hilux1_civil_1_open", ["VEHICLE", "CAR"], ["Hilux Open (Gold)", "No Desc"], [1950,900], 170, "core\items\noUse.sqf", 85, true, [], false, []],
    ["hilux1_civil_2_covered", ["VEHICLE", "CAR"], ["Hilux Covered (Red)", "No Desc"], [1950,900], 170, "core\items\noUse.sqf", 85, true, [], false, []],
    ["hilux1_civil_3_open", ["VEHICLE", "CAR"], ["Hilux Open (White)", "No Desc"], [1950,900], 170, "core\items\noUse.sqf", 85, true, [], false, []],
    ["LandRover_CZ_EP1", ["VEHICLE", "CAR"], ["Landrover", "No Desc"], [2500,1700], 200, "core\items\noUse.sqf", 100, true, [], false, []],
    ["LandRover_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Landrover (Red)", "No Desc"], [2500,1700], 200, "core\items\noUse.sqf", 100, true, [], false, []],
    
    //Bikes
    ["MMT_Civ", ["VEHICLE", "CAR"], ["Mountain bike", "No Desc"], [100,25], 5, "core\items\noUse.sqf", 2, true, [], false, []],
    ["Old_bike_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old bike", "No Desc"], [100,25], 5, "core\items\noUse.sqf", 2, true, [], false, []],
    ["Old_moto_TK_Civ_EP1", ["VEHICLE", "CAR"], ["Old motorbike", "No Desc"], [350,100], 20, "core\items\noUse.sqf", 10, true, [], false, []],
    ["M1030", ["VEHICLE", "CAR"], ["M1030", "No Desc"], [450,275], 30, "core\items\noUse.sqf", 15, true, [], false, []],
    ["TT650_Civ", ["VEHICLE", "CAR"], ["TT650", "No Desc"], [450,275], 30, "core\items\noUse.sqf", 15, true, [], false, []],
    ["TT650_Gue", ["VEHICLE", "CAR"], ["TT650 (Pattern)", "No Desc"], [450,275], 30, "core\items\noUse.sqf", 15, true, [], false, []],
    ["TT650_TK_CIV_EP1", ["VEHICLE", "CAR"], ["TT650 (Rusty)", "No Desc"], [450,275], 30, "core\items\noUse.sqf",15, true, [], false, []],
    ["ATV_US_EP1", ["VEHICLE", "CAR"], ["ATV", "No Desc"], [650,375], 40, "core\items\noUse.sqf", 20, true, [], false, []],
    
    //Trucks
    ["Kamaz", ["VEHICLE", "CAR"], ["Kamaz", "No Desc"], [8500,5500], 1400, "core\items\noUse.sqf", 700, true, [], false, []],
    ["KamazOpen", ["VEHICLE", "CAR"], ["Kamaz (Open)", "No Desc"], [8500,5500], 1400, "core\items\noUse.sqf", 700, true, [], false, []],
    ["UralCivil", ["VEHICLE", "CAR"], ["Ural Civil", "No Desc"], [7450,4000], 800, "core\items\noUse.sqf", 400, true, [], false, []],
    ["UralCivil2", ["VEHICLE", "CAR"], ["Ural Civil 2", "No Desc"], [7450,4000], 800, "core\items\noUse.sqf", 400, true, [], false, []],
    ["UralOpen_INS", ["VEHICLE", "CAR"], ["Ural Camo", "No Desc"], [7450,4000], 800, "core\items\noUse.sqf", 400, true, [], false, []],
    ["MTVR", ["VEHICLE", "CAR"], ["MTVR", "No Desc"], [5300,2550], 600, "core\items\noUse.sqf", 300, true, [], false, []],
    ["V3S_Salvage_TK_GUE_EP1", ["VEHICLE", "CAR"], ["V3S", "No Desc"], [4500,2000], 500, "core\items\noUse.sqf", 250, true, [], false, []],
    
    ["Tractor", ["VEHICLE", "CAR"], ["Tractor", "No Desc"], [400,190], 250, "core\items\noUse.sqf", 80, true, [], false, [true, "singleBlue", [[[0, 0.1, 0.3], [0, 0, 1], 0.04]]]],
    
    ["M9", ["WEAPON", "PISTOL"], ["M9", "No Desc"], [1000, 640], 5, "core\items\noUse.sqf", 0, true, [], false],
    ["15Rnd_9x19_M9", ["MAGAZINE", "PISTOL"], ["M9 Magazine", "No Desc"], [50, 25], 0.5, "core\items\noUse.sqf", 0, true, [], false],
    ["Colt1911", ["WEAPON", "PISTOL"], ["Colt 1911", "No Desc"], [1000, 640], 5, "core\items\noUse.sqf", 0, true, [], false],
    ["7Rnd_45ACP_1911", ["MAGAZINE", "PISTOL"], ["7Rnd M1911 .45 ACP Mag", "No Desc"], [50, 25], 0.5, "core\items\noUse.sqf", 0, true, [], false],
    ["x26", ["WEAPON", "PISTOL"], ["X26 Tazer", "No Desc"], [1000, 640], 5, "core\items\noUse.sqf", 0, true, [], false],
    ["x26_mag", ["MAGAZINE", "PISTOL"], ["X26 Cartridge", "No Desc"], [50, 25], 0.5, "core\items\noUse.sqf", 0, true, [], false],
    
    /* Resources */
    ["GoldOre", ["ITEM", "RESOURCE"], ["Gold Ore", "No desc"], [85, 25], 5, "core\items\noUse.sqf", 0, true, [], false],
    ["IronOre", ["ITEM", "RESOURCE"], ["Iron Ore", "No desc"], [85, 25], 10, "core\items\noUse.sqf", 0, true, [], false],
    ["IronBar", ["ITEM", "RESOURCE"], ["Iron Bar", "No desc"], [85, 25], 3, "core\items\noUse.sqf", 0, true, [], false]
];

RPP_fnc_itemGetArray =
{
    private ["_id", "_arr", "_getID"];
    _id = _this;
    _arr = [];
    
    {
        _getID = (_x select 0);
          
        if (_id == _getID) exitWith
        {
            _arr = _x;
        };
    } forEach RPP_var_goods;
    
    _arr
};

RPP_fnc_itemGetAmount = 
{
    private ["_class", "_amount"];
    _class = _this;
    _amount = 0;
    {
        if (_x select 0 == _class) exitwith
        {
            _amount = _x select 1;
        }; 
    } forEach RPP_var_inventory;
    
    _amount
};

RPP_fnc_itemGetClass = 
{
    ((_this call RPP_fnc_itemGetArray) select 0)
};

RPP_fnc_itemGetType1 =
{
    (((_this call RPP_fnc_itemGetArray) select 1) select 0)
};

RPP_fnc_itemGetType2 =
{
    (((_this call RPP_fnc_itemGetArray) select 1) select 1)
};

RPP_fnc_itemGetName =
{
    (((_this call RPP_fnc_itemGetArray) select 2) select 0)
};

RPP_fnc_itemGetDesc =
{
    (((_this call RPP_fnc_itemGetArray) select 2) select 1)
};

RPP_fnc_itemGetBuyPrice =
{
    (((_this call RPP_fnc_itemGetArray) select 3) select 0)
};

RPP_fnc_itemGetSellPrice =
{
    (((_this call RPP_fnc_itemGetArray) select 3) select 1)
};

RPP_fnc_itemGetMass =
{
    ((_this call RPP_fnc_itemGetArray) select 4)
};

RPP_fnc_itemGetScript =
{
    ((_this call RPP_fnc_itemGetArray) select 5)
};

RPP_fnc_itemGetTrunkSize =
{
    ((_this call RPP_fnc_itemGetArray) select 6)
};

RPP_fnc_itemGetCanDrop =
{
    ((_this call RPP_fnc_itemGetArray) select 7)
};

RPP_fnc_itemGetFactoryCost = 
{
    ((_this call RPP_fnc_itemGetArray) select 8)
};

RPP_fnc_itemGetIllegal = 
{
    ((_this call RPP_fnc_itemGetArray) select 9)
};

RPP_fnc_itemGetSiren = 
{
    ((_this call RPP_fnc_itemGetArray) select 10)
};
/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_goods =
[
    ["Money", ["ITEM", "SPECIAL"], ["Money", "No description"], [0, 0], 0, "core\items\noUse.sqf", 0, true, [   ], false ],
    ["Keychain", ["ITEM", "SPECIAL"], ["Keychain", "No description"], [0, 0], 0.0, "core\items\keychain.sqf", 0, false, [], false],
    ["MedicalBag", ["ITEM", "SPECIAL"], ["Medical Bag", "No description"], [150, 80], 2, "core\items\medic.sqf", 0, true, [2, [ ["wood", 1], ["Rubber", 2]]], false],

    /* Tools */
    ["Pickaxe", ["ITEM", "TOOL"], ["Pickaxe", localize "STRS_item_pickaxeDesc"], [400, 260], 9, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["wood", 2]]], false],
    ["sickle", ["ITEM", "TOOL"], ["Sickle", "No description"], [400, 290], 5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["wood", 2]]], false],
	["Hatchet", ["ITEM", "TOOL"], ["Hatchet", "No description"], [800, 410], 9, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 2], ["wood", 1]]], false],
	["Pump", ["ITEM", "TOOL"], ["Oil Pump", "No description"], [1500, 1000], 20, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["ElecComp", 1], ["Rubber", 1], ["Copper", 1]]], false],
	["Shovel", ["ITEM", "TOOL"], ["Shovel", "No description"], [400, 260], 5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["wood", 2], ["Rubber", 1]]], false],

    /* Equipment */
    ["ItemMap", ["WEAPON", "ITEM"], ["Map", "No description"], [5, 1], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemCompass", ["WEAPON", "ITEM"], ["Compass", "No description"], [40, 20], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemWatch", ["WEAPON", "ITEM"], ["Watch", "No description"], [80, 40], 0, "core\items\noUse.sqf", 0, true, [], false],
    ["ItemRadio", ["WEAPON", "ITEM"], ["Radio", "No description"], [800, 650], 0.5, "core\items\noUse.sqf", 0, true, [2, [["ElecComp", 1], ["Rubber", 1]]], false],
    ["ItemGPS", ["WEAPON", "ITEM"], ["GPS", "No fdescription"], [1600, 1250], 0.5, "core\items\noUse.sqf", 0, true, [2, [["ElecComp", 2], ["Rubber", 1]]], false],
    ["ACRE_PRC148_UHF", ["WEAPON", "SPECIAL"], ["PRC-148 UHF RADIO", "No description"], [1600, 1250], 1, "core\items\noUse.sqf", 0, true, [2, [["ElecComp", 2], ["Rubber", 1]]], false],
    ["ACRE_PRC119", ["WEAPON", "SPECIAL"], ["PRC-119 RADIO", "No description"], [687, 375], 1, "core\items\noUse.sqf", 0, true, [], false],
	["ACRE_PRC343", ["WEAPON", "SPECIAL"], ["PRC-343 RADIO", "No description"], [687, 375], 1, "core\items\noUse.sqf", 0, true, [], false],
    
    ["Handcuffs", ["ITEM", "TOOL"], ["Handcuffs", "No description"], [0, 0], 1, "core\items\handcuffs.sqf", 0, true, [], false],
    
    /* Misc_Items & Tools */
    ["Lockpick", ["ITEM", "TOOL"], ["Lockpick", "No description"], [300, 160], 0.5, "core\items\lockpick.sqf", 0, true, [2, [ ["IronBar", 1]]], false],
    ["Crowbar", ["ITEM", "TOOL"], ["Crowbar", "No description"], [400, 330], 2, "core\items\crowbar.sqf", 0, true, [2, [ ["IronBar", 2]]], false],
    
   	["Phone", ["ITEM", "MOBILE"], ["Mobile Phone", "No description"], [1500, 900], 0.5, "core\items\phone.sqf", 0, true, [2, [ ["IronBar", 1], ["ElecComp", 1], ["Copper", 1]]], false],
    ["RepairKit", ["ITEM", "ITEM"], ["RepairKit", "No description"], [600, 440], 10, "core\items\repairKit.sqf", 0, true, [2, [ ["IronBar", 1], ["Rubber", 1], ["Copper", 1], ["Tyre", 1]]], false],
	["Can", ["ITEM", "ITEM"], ["Can", "No description"], [180, 130], 1, "core\items\refuelCan.sqf", 0, true, [2, [ ["Copper", 1]]], false],
    ["RefuelCan", ["ITEM", "ITEM"], ["RefuelCan", "No description"], [450, 350], 9, "core\items\refuelCan.sqf", 0, true, [2, [ ["Can", 1], ["Petrol", 8]]], false],

    /* Objects */
    ["Land_Farm_Cowshed_c", ["ITEM", "OBJECT"], ["Cowshed", localize "STRS_object_desc"], [0,0], 5, "core\items\object.sqf", 0, true, [], false],
    ["cl_Spikestrip", ["ITEM", "OBJECT"], ["Spikestrip", localize "STRS_object_desc"], [700,0], 5, "core\items\object.sqf", 0, true, [], true],
    
    //["Wall_FenW2_6_EP1", ["ITEM", "OBJECT"], ["Fence", localize "STRS_object_desc"], [0,0], 5, "core\items\object.sqf", 0, true, []],
    
    /* Food & Drink */
    ["Soup", ["ITEM", "FOOD"], ["Soup", "No Desc"], [5, 2], 0.2, "core\items\food.sqf", 0, true, [], false], 
    ["Sandwich", ["ITEM", "FOOD"], ["Sandwich", "No Desc"], [20, 16], 0.5, "core\items\food.sqf", 0, true, [2, [ ["Bread", 1]]], false], 
    ["Bread", ["ITEM", "FOOD"], ["Bread", "No Desc"], [15, 10], 1, "core\items\food.sqf", 0, true, [2, [ ["Wheat", 3]]], false], 
    ["Donut", ["ITEM", "FOOD"], ["Donut", "No Desc"], [12, 7], 0.5, "core\items\food.sqf", 0, true, [2, [ ["Wheat", 2]]], false], 
    ["Low_bottleWater", ["ITEM", "DRINK"], ["Small Bottled Water", "No Desc"], [70, 50], 1, "core\items\drink.sqf", 0, true, [2, [ ["Bottle", 1]]], false],
    ["High_bottleWater", ["ITEM", "DRINK"], ["Bottled Water", "No Desc"], [70, 50], 2, "core\items\drink.sqf", 0, true, [2, [ ["Bottle", 1]]], false],
    ["Bottle", ["ITEM", "DRINK"], ["Bottle", "No Desc"], [50, 25], 1, "core\items\noUse.sqf", 0, true, [2, [ ["Glass", 1]]], false],
	["ApplePie", ["ITEM", "DRINK"], ["Apple Pie", "No Desc"], [50, 25], 0.5, "core\items\noUse.sqf", 0, true, [2, [ ["Bread", 1], ["Apple", 2]]], false],
    
    /* Boats */
    ["Fishing_Boat", ["VEHICLE", "BOAT"], ["Fishing Boat", "No Desc"], [10500, 7000], 600, "core\items\noUse.sqf", 400, true, [2, [ ["IronBar", 5], ["ElecComp", 6], ["wood", 40], ["Copper", 5]]], false],
    ["Smallboat_1", ["VEHICLE", "BOAT"], ["Small Boat 1", "No Desc"], [7000, 4000], 160, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 2], ["ElecComp", 4], ["wood", 20], ["Copper", 2]]], false],
    ["Smallboat_2", ["VEHICLE", "BOAT"], ["Small Boat 2", "No Desc"], [7000, 4000], 160, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 2], ["ElecComp", 4], ["wood", 20], ["Copper", 2]]], false],
    ["PBX", ["VEHICLE", "BOAT"], ["PBX", "No Desc"], [5500, 3300], 120, "core\items\noUse.sqf", 60, true, [2, [ ["IronBar", 1], ["ElecComp", 4], ["Rubber", 20], ["Copper", 2]]], false],
    
    /* Fishing */
    ["Fishing_rod", ["ITEM", "TOOL"], ["Fishing rod", "No Desc"], [400, 220], 2, "core\items\fishingUse.sqf", 0, true, [2, [ ["IronBar", 1], ["wood", 1]]], false],
	["Fishing_net", ["ITEM", "TOOL"], ["Fishing net", "No Desc"], [680, 330], 20, "core\items\fishingUse.sqf", 0, true, [2, [ ["IronBar", 1], ["Rubber", 1], ["Copper", 1]]], false],
    ["Harpoon", ["ITEM", "TOOL"], ["Harpoon", "No Desc"], [2500, 1250], 20, "core\items\fishingUse.sqf", 0, true, [2, [ ["IronBar", 3],["wood", 6], ["Rubber", 5], ["Copper", 3]]], false],
	
	["Minnow", ["ITEM", "BAIT"], ["Minnow", "No Desc"], [20, 10], 1, "core\items\food.sqf", 0, true, [], false],
    ["Worm", ["ITEM", "BAIT"], ["Worm", "No Desc"], [5, 1], 0, "core\items\noUse.sqf", 0, true, [], false],
    
    /* Fishing Rod Arrays */
    ["Bluegill", ["ITEM", "FISH"], ["Bluegill", "No Desc"], [50, 25], 2, "core\items\food.sqf", 0, true, [], false],
    ["Catfish", ["ITEM", "FISH"], ["Catfish", "No Desc"], [100, 50], 3, "core\items\food.sqf", 0, true, [], false],
    ["Perch", ["ITEM", "FISH"], ["Perch", "No Desc"], [75, 50], 2, "core\items\food.sqf", 0, true, [], false],
    ["Trout", ["ITEM", "FISH"], ["Trout", "No Desc"], [90, 60], 3, "core\items\food.sqf", 0, true, [], false],
    ["RockBass", ["ITEM", "FISH"], ["RockBass", "No Desc"], [150, 100], 4, "core\items\food.sqf", 0, true, [], false],
	
	/* Fishing net Arrays */
    ["Shrimp", ["ITEM", "FISH"], ["Shrimp", "No Desc"], [25, 12], 0.1, "core\items\food.sqf", 0, true, [], false],
    ["Sardine", ["ITEM", "FISH"], ["Sardine", "No Desc"], [75, 45], 0.1, "core\items\food.sqf", 0, true, [], false],
    ["Monkfish", ["ITEM", "FISH"], ["Monkfish", "No Desc"], [450, 300], 2, "core\items\food.sqf", 0, true, [], false],
    ["Salmon", ["ITEM", "FISH"], ["Salmon", "No Desc"], [350, 200], 4, "core\items\food.sqf", 0, true, [], false],
	
	/* Harpoon */
    ["Shark", ["ITEM", "FISH"], ["Shark", "No Desc"], [670,500], 15, "core\items\food.sqf", 0, true, [], false],
    ["Tuna", ["ITEM", "FISH"], ["Tuna", "No Desc"], [150,100], 5, "core\items\food.sqf", 0, true, [], false],
    ["Whale", ["ITEM", "FISH"], ["Whale", "No Desc"], [1200,700], 20, "core\items\food.sqf", 0, true, [], true],
    ["Swordfish", ["ITEM", "FISH"], ["Swordfish", "No Desc"], [600,350], 11, "core\items\food.sqf", 0, true, [], false],
   

    //Cars
    ["Skoda", ["VEHICLE", "CAR"], ["Skoda White", "No Desc"], [15500, 8000], 120, "core\items\noUse.sqf", 220, true, [2, [ ["IronBar", 16],["Tyre", 4], ["Rubber", 10], ["Copper", 8], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["SkodaRed", ["VEHICLE", "CAR"], ["Skoda Red", "No Desc"], [15500, 8000], 120, "core\items\noUse.sqf", 220, true, [2, [ ["IronBar", 16],["Tyre", 4], ["Rubber", 10], ["Copper", 8], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["SkodaBlue", ["VEHICLE", "CAR"], ["Skoda Blue", "No Desc"], [15500, 8000], 120, "core\items\noUse.sqf", 220, true, [2, [ ["IronBar", 16],["Tyre", 4], ["Rubber", 10], ["Copper", 8], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["SkodaGreen", ["VEHICLE", "CAR"], ["Skoda Green", "No Desc"], [15500, 8000], 120, "core\items\noUse.sqf", 220, true, [2, [ ["IronBar", 16],["Tyre", 4], ["Rubber", 10], ["Copper", 8], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["VWGolf", ["VEHICLE", "CAR"], ["VW Golf", "No Desc"], [17680, 9200], 130, "core\items\noUse.sqf", 240, true, [2, [ ["IronBar", 16],["Tyre", 4], ["Rubber", 10], ["Copper", 12], ["Vinyl" ,4], ["ElecComp", 6]]], false],
    ["car_hatchback", ["VEHICLE", "CAR"], ["Hatchback", "No Desc"], [16300, 8700], 100, "core\items\noUse.sqf", 180, true, [2, [ ["IronBar", 15],["Tyre", 4], ["Rubber", 10], ["Copper", 12], ["Leather" ,4], ["ElecComp", 5]]], false],
    ["car_sedan", ["VEHICLE", "CAR"], ["Sedan", "No Desc"], [16084, 8500], 130, "core\items\noUse.sqf", 230, true, [2, [ ["IronBar", 15],["Tyre", 4], ["Rubber", 8], ["Copper", 12], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["Lada1_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Lada Green", "No Desc"], [14080, 7400], 60, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 9],["Tyre", 4], ["Rubber", 5], ["Copper", 12], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["Lada2_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Lada Decorated", "No Desc"], [14080,7400], 60, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 9],["Tyre", 4], ["Rubber", 5], ["Copper", 12], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["Volha_1_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Car (Blue)", "No Desc"], [13120, 6900], 60, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 9],["Tyre", 4], ["Rubber", 5], ["Copper", 8], ["Vinyl" ,4], ["ElecComp", 5]]], false],
    ["Volha_2_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Car (White)", "No Desc"], [13120, 6900], 60, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 9],["Tyre", 4], ["Rubber", 5], ["Copper", 8], ["Vinyl" ,4],["ElecComp", 5]]], false],
    
	/* Classic Cars */
	["monaco", ["VEHICLE", "CAR"], ["1968 Dodge Monaco", "No Desc"], [22600, 11800], 120, "core\items\noUse.sqf", 120, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 6]]], false],
    ["roadrunner2", ["VEHICLE", "CAR"], ["1969 Road Runner", "Yellow"], [22600, 11800], 120, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 6]]], false],
    ["barcuda", ["VEHICLE", "CAR"], ["1970 Plymouth Barracuda", "No Desc"], [22600, 11800], 120, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 6]]], false],
    ["fury", ["VEHICLE", "CAR"], ["1977 Plymouth Fury", "No Desc"], [22600, 11800], 120, "core\items\noUse.sqf", 100, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 6]]], false],
    ["challenger", ["VEHICLE", "CAR"], ["2008 Dodge Challenger Concept", "No Desc"], [23820, 12300], 130, "core\items\noUse.sqf", 80, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 7]]], false],
    ["civic", ["VEHICLE", "CAR"], ["1989 Honda Civic", "No Desc"], [23820, 12300], 100, "core\items\noUse.sqf", 80, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 7]]], false],
    ["roadrunner", ["VEHICLE", "CAR"], ["1969 Road Runner", "Green"], [22600, 11800], 50, "core\items\noUse.sqf", 80, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 6]]], false],
    ["cuda", ["VEHICLE", "CAR"], ["1970 Plymouth AAR Cuda.", "No Desc"], [22600, 11800], 50, "core\items\noUse.sqf", 80, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 18], ["Leather" , 8], ["ElecComp", 6]]], false],
    
	//Police Cars
	["Copcar", ["VEHICLE", "CAR"], ["Holden Monaro Standard", "No Desc"], [15500, 10000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	["CopcarAus", ["VEHICLE", "CAR"], ["Holden Monaro Blue", "No Desc"], [50000, 10000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	["CopcarAusgreen", ["VEHICLE", "CAR"], ["Holden Monaro Green", "No Desc"], [50000, 10000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	["Copcarhw", ["VEHICLE", "CAR"], ["Holden Monaro Highway Patrol", "No Desc"], [19000, 13000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	["CopcarHW2", ["VEHICLE", "CAR"], ["Holden Monaro Highway Patrol", "No Desc"], [19000, 13000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	["Paddy", ["VEHICLE", "CAR"], ["Holden Paddywagon WIP", "No Desc"], [15500, 10000], 65, "core\items\noUse.sqf", 300, true, [], false, []],
	["SUV_TK_CIV_EP1", ["VEHICLE", "CAR"], ["SWAT SUV", "No Desc"], [22000, 15000], 65, "core\items\noUse.sqf", 250, true, [], true, [], false, true],
	["Fordpatrolbasic", ["VEHICLE", "CAR"], ["Ford Falcon Standard WIP", "No Desc"], [15500, 10000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	["CopcarNZ", ["VEHICLE", "CAR"], ["Holden Monaro NZ", "No Desc"], [15500, 10000], 65, "core\items\noUse.sqf", 220, true, [], false, []],
	
    //Pickups
    ["datsun1_civil_1_open", ["VEHICLE", "CAR"], ["Datsun Open (Blue)", "No Desc"], [18580, 9600], 150, "core\items\noUse.sqf", 300, true, [2, [ ["IronBar", 18],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Vinyl" , 6], ["ElecComp", 5]]], false],
    ["datsun1_civil_2_covered", ["VEHICLE", "CAR"], ["Datsun Covered", "No Desc"], [18580, 9600], 150, "core\items\noUse.sqf", 300, true, [2, [ ["IronBar", 18],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Vinyl" , 6], ["ElecComp", 5]]], false],
    ["datsun1_civil_3_open", ["VEHICLE", "CAR"], ["Datsun Tubeframe", "No Desc"], [18580, 9600], 150, "core\items\noUse.sqf", 300, true, [2, [ ["IronBar", 18],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Vinyl" , 6], ["ElecComp", 5]]], false],
    ["hilux1_civil_1_open", ["VEHICLE", "CAR"], ["Hilux Open (Gold)", "No Desc"], [20100, 10400], 170, "core\items\noUse.sqf", 320, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Leather" , 6], ["ElecComp", 5]]], false],
    ["hilux1_civil_2_covered", ["VEHICLE", "CAR"], ["Hilux Covered (Red)", "No Desc"], [20100, 10400], 170, "core\items\noUse.sqf", 320, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Leather" , 6], ["ElecComp", 5]]], false],
    ["hilux1_civil_3_open", ["VEHICLE", "CAR"], ["Hilux Open (White)", "No Desc"], [20100, 10400], 170, "core\items\noUse.sqf", 320, true, [2, [ ["IronBar", 22],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Leather" , 6], ["ElecComp", 5]]], false],
    ["LandRover_CZ_EP1", ["VEHICLE", "CAR"], ["Landrover", "No Desc"], [20580, 10600], 200, "core\items\noUse.sqf", 320, true, [2, [ ["IronBar", 20],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Leather" , 6], ["ElecComp", 5]]], false],
    ["LandRover_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Landrover (Red)", "No Desc"], [20580, 10600], 200, "core\items\noUse.sqf", 320, true, [2, [ ["IronBar", 20],["Tyre", 4], ["Rubber", 20], ["Copper", 15], ["Leather" , 6], ["ElecComp", 5]]], false],
    
    //Bikes
    ["MMT_Civ", ["VEHICLE", "CAR"], ["Mountain bike", "No Desc"], [1176, 600], 5, "core\items\noUse.sqf", 8, true, [2, [ ["IronBar", 1],["Tyre", 2], ["Rubber", 2]]], false],
    ["Old_bike_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old bike", "No Desc"], [3604, 1875], 5, "core\items\noUse.sqf", 8, true, [2, [ ["IronBar", 2],["Tyre", 2], ["Rubber", 8], ["Copper", 3], ["Vinyl" , 6], ["ElecComp", 1]]], false],
    ["Old_moto_TK_Civ_EP1", ["VEHICLE", "CAR"], ["Old motorbike", "No Desc"], [3604, 1875], 20, "core\items\noUse.sqf", 30, true, [2, [ ["IronBar", 2],["Tyre", 2], ["Rubber", 8], ["Copper", 3], ["Vinyl" , 6], ["ElecComp", 1]]], false],
    ["M1030", ["VEHICLE", "CAR"], ["M1030", "No Desc"], [3604, 1875], 30, "core\items\noUse.sqf", 40, true, [2, [ ["IronBar", 2],["Tyre", 2], ["Rubber", 8], ["Copper", 3], ["Vinyl" , 6], ["ElecComp", 1]]], false],
    ["TT650_Civ", ["VEHICLE", "CAR"], ["TT650", "No Desc"], [3604, 1875], 30, "core\items\noUse.sqf", 40, true, [2, [ ["IronBar", 2],["Tyre", 2], ["Rubber", 8], ["Copper", 3], ["Vinyl" , 6], ["ElecComp", 1]]], false],
    ["TT650_Gue", ["VEHICLE", "CAR"], ["TT650 (Pattern)", "No Desc"], [4824, 2550], 30, "core\items\noUse.sqf", 40, true, [2, [ ["IronBar", 2],["Tyre", 2], ["Rubber", 8], ["Copper", 3], ["Vinyl" , 1], ["ElecComp", 1]]], false],
    ["TT650_TK_CIV_EP1", ["VEHICLE", "CAR"], ["TT650 (Rusty)", "No Desc"], [4824, 2000], 30, "core\items\noUse.sqf",40, true, [2, [ ["IronBar", 2],["Tyre", 2], ["Rubber", 8], ["Copper", 3], ["Vinyl" , 1], ["ElecComp", 1]]], false],
    ["ATV_US_EP1", ["VEHICLE", "CAR"], ["ATV", "No Desc"], [4824, 2900], 40, "core\items\noUse.sqf", 50, true, [2, [ ["IronBar", 2],["Tyre", 4], ["Rubber", 8], ["Copper", 3], ["Leather" , 1], ["ElecComp", 2]]], false],
    
    //Trucks
    ["Kamaz", ["VEHICLE", "CAR"], ["Kamaz", "No Desc"], [38080, 20000], 1400, "core\items\noUse.sqf", 800, true, [2, [ ["IronBar", 50],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Vinyl" , 12], ["ElecComp",6], ["wood", 20]]], false],
    ["KamazOpen", ["VEHICLE", "CAR"], ["Kamaz (Open)", "No Desc"], [38080, 20000], 1400, "core\items\noUse.sqf", 800, true, [2, [ ["IronBar", 50],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Vinyl" , 12], ["ElecComp",6], ["wood", 20]]], false],
    ["UralCivil", ["VEHICLE", "CAR"], ["Ural Civil", "No Desc"], [34880, 18500], 800, "core\items\noUse.sqf", 600, true, [2, [ ["IronBar", 40],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Vinyl" , 12], ["ElecComp",6], ["wood", 20]]], false],
    ["UralCivil2", ["VEHICLE", "CAR"], ["Ural Civil 2", "No Desc"], [34880, 18500], 800, "core\items\noUse.sqf", 600, true, [2, [ ["IronBar", 40],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Vinyl" , 12], ["ElecComp",6], ["wood", 20]]], false],
    ["UralOpen_INS", ["VEHICLE", "CAR"], ["Ural Camo", "No Desc"], [34880, 18500], 800, "core\items\noUse.sqf", 600, true, [2, [ ["IronBar", 40],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Vinyl" , 12], ["ElecComp",6], ["wood", 20]]], false],
    ["MTVR", ["VEHICLE", "CAR"], ["MTVR", "No Desc"], [33380, 17750], 600, "core\items\noUse.sqf", 500, true, [2, [ ["IronBar", 30],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Leather" , 12], ["ElecComp",7], ["wood", 20]]], false],
    ["V3S_Salvage_TK_GUE_EP1", ["VEHICLE", "CAR"], ["V3S", "No Desc"], [30080, 16000], 500, "core\items\noUse.sqf", 400, true, [2, [ ["IronBar", 25],["Tyre", 6], ["Rubber", 50], ["Copper", 30], ["Vinyl" , 12], ["ElecComp",6], ["wood", 20]]], false],
    
    ["Tractor", ["VEHICLE", "CAR"], ["Tractor", "No Desc"], [17680, 9000], 250, "core\items\noUse.sqf", 80, true, [2, [ ["IronBar", 20],["Tyre", 4], ["Rubber", 20], ["Copper",15], ["Leather" , 4], ["ElecComp",4]]], false],
    
	//Weapons
    ["M9", ["WEAPON", "PISTOL"], ["M9", "No Desc"], [1520, 800], 5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 4], ["Copper",1]]], false],
    ["15Rnd_9x19_M9", ["MAGAZINE", "PISTOL"], ["M9 Magazine", "No Desc"], [560, 300], 0.5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["Copper",1]]], false],
    ["Colt1911", ["WEAPON", "PISTOL"], ["Colt 1911", "No Desc"], [1520, 800], 5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 4], ["Copper",1]]], false],
    ["7Rnd_45ACP_1911", ["MAGAZINE", "PISTOL"], ["7Rnd M1911 .45 ACP Mag", "No Desc"], [560, 300], 0.5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["Copper",1]]], false],
	["M1014", ["WEAPON", "PISTOL"], ["M1014", "No Desc"], [2800, 1500], 5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 8], ["Copper",1]]], true],
    ["8Rnd_B_Beneli_74Slug", ["MAGAZINE", "PISTOL"], ["8Rnds BeanBag Non-Lethal", "No Desc"], [560, 300], 0.5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["Copper",1]]], true],
    ["x26", ["WEAPON", "PISTOL"], ["X26 Tazer", "No Desc"], [1780, 900], 5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["Copper",1], ["ElecComp",1]]], true],
    ["x26_mag", ["MAGAZINE", "PISTOL"], ["X26 Cartridge", "No Desc"], [560, 300], 0.5, "core\items\noUse.sqf", 0, true, [2, [ ["IronBar", 1], ["Copper",1], ["ElecComp",1]]], true],
       
   /* Bushes/Seeds/Trees */
    	["mari_seed", ["ITEM", "SPROUT"], ["Marihuana Seed", "No Desc"], [50,5], 0, "core\items\sprout.sqf", 0, true, [], true],
    	["apple_seed", ["ITEM", "SPROUT"], ["Apple Seed", "No Desc"], [4,1], 0, "core\items\sprout.sqf", 0, true, [], false],
    	["populus_seed", ["ITEM", "SPROUT"], ["Populus Seed", "No Desc"], [4,2], 0, "core\items\sprout.sqf", 0, true, [], false],
    	["larix_seed", ["ITEM", "SPROUT"], ["Larix Seed", "No Desc"], [5,2], 0, "core\items\sprout.sqf", 0, true, [], false],
    	["pine_seed", ["ITEM", "SPROUT"], ["Pine Seed", "No Desc"], [4,2], 0, "core\items\sprout.sqf", 0, true, [], false],
    	["potato_sprouts", ["ITEM", "SPROUT"], ["Potato Sprouts", "No Desc"], [6,2], 0, "core\items\sprout.sqf", 0, true, [], false],
    	["alder_seed", ["ITEM", "SPROUT"], ["Alder Seed", "No Desc"], [5,2], 0, "core\items\sprout.sqf", 0, true, [], false],
	["pumpkin_seed", ["ITEM", "SPROUT"], ["Pumpkin Seed", "No Desc"], [6,2], 0, "core\items\sprout.sqf", 0, true, [], false],
	["cabbage_seed", ["ITEM", "SPROUT"], ["Cabbage Seed", "No Desc"], [4,1], 0, "core\items\sprout.sqf", 0, true, [], false],
	["maple_seed", ["ITEM", "SPROUT"], ["Maple Seed", "No Desc"], [8,4], 0, "core\items\sprout.sqf", 0, true, [], false],
	["rubber_seed", ["ITEM", "SPROUT"], ["Rubber Seed", "No Desc"], [8,4], 0, "core\items\sprout.sqf", 0, true, [], false],
    
    	["mari", ["ITEM", "DRUG"], ["Marihuana", "No Desc"], [70,10], 1, "core\items\noUse.sqf", 0, true, [], true],
    	["Apple", ["ITEM", "FOOD"], ["Apple", "No Desc"], [7,3], 0.2, "core\items\food.sqf", 0, true, [], false],
	["Pumpkin", ["ITEM", "FOOD"], ["Pumpkin", "No Desc"], [25,15], 2, "core\items\food.sqf", 0, true, [], false],
	["Cabbage", ["ITEM", "FOOD"], ["Cabbage", "No Desc"], [15,7], 0.5, "core\items\food.sqf", 0, true, [], false],
	["Potato", ["ITEM", "FOOD"], ["Potato", "No Desc"], [10,5], 0.1, "core\items\food.sqf", 0, true, [], false], 
	["Meat", ["ITEM", "FOOD"], ["Meat", "No Desc"], [40,25], 1, "core\items\food.sqf", 0, true, [], false],	
	
	//Resources
	/* Food Resources */
	["Rabbit", ["ITEM", "RESOURCE"], ["Rabbit", "No desc"], [12,10], 0.5, "core\items\noUse.sqf", 0, true, [], false],
	["Chicken", ["ITEM", "RESOURCE"], ["Chicken", "No desc"], [2,1], 0.5, "core\items\noUse.sqf", 0, true, [], false],
	["Lamb", ["ITEM", "RESOURCE"], ["Lamb", "No desc"], [15,6], 5, "core\items\noUse.sqf", 0, true, [], false],
	["Cow", ["ITEM", "RESOURCE"], ["Cow", "No desc"], [15,6], 5, "core\items\noUse.sqf", 0, true, [], false],
	["Boar", ["ITEM", "RESOURCE"], ["Boar", "No desc"], [20,10], 5, "core\items\noUse.sqf", 0, true, [], false],
	
    /* Primary Resources */
    	["GoldOre", ["ITEM", "RESOURCE"], ["Gold Ore", "No desc"], [40,20], 10, "core\items\noUse.sqf", 0, true, [], false],
    	["IronOre", ["ITEM", "RESOURCE"], ["Iron Ore", "No desc"], [30,15], 5, "core\items\noUse.sqf", 0, true, [], false],
	["CopperOre", ["ITEM", "RESOURCE"], ["Copper Ore", "No desc"], [25,12], 3, "core\items\noUse.sqf", 0, true, [], false],
	["Stone", ["ITEM", "RESOURCE"], ["Stone", "No desc"], [25,12], 3, "core\items\noUse.sqf", 0, true, [], false],
	["Sulphur", ["ITEM", "RESOURCE"], ["Sulphur", "No desc"], [25,12], 1, "core\items\noUse.sqf", 0, true, [], false],
	["Diamond", ["ITEM", "RESOURCE"], ["Diamond", "No desc"], [40,20], .05, "core\items\noUse.sqf", 0, true, [], false],
	["Silver", ["ITEM", "RESOURCE"], ["Silver", "No desc"], [50,25], .05, "core\items\noUse.sqf", 0, true, [], false],
    	["Sand", ["ITEM", "RESOURCE"], ["Sand", "No desc"], [4,2], 1, "core\items\noUse.sqf", 0, true, [], false],
	["Salt", ["ITEM", "RESOURCE"], ["Salt", "No desc"], [4,2], 1, "core\items\noUse.sqf", 0, true, [], false],
	["Clay", ["ITEM", "RESOURCE"], ["Clay", "No desc"], [5,2], 1, "core\items\noUse.sqf", 0, true, [], false],
	["Coal", ["ITEM", "RESOURCE"], ["Coal", "No desc"], [25,12], 1, "core\items\noUse.sqf", 0, true, [], false],
	["Oil", ["ITEM", "RESOURCE"], ["Oil", "No desc"], [20,10], 5, "core\items\noUse.sqf", 0, true, [], false],
	["Silicon", ["ITEM", "RESOURCE"], ["Silicon", "No desc"], [5,2], 1, "core\items\noUse.sqf", 0, true, [], false],
	["populus_log", ["ITEM", "RESOURCE"], ["Populus Log", "No Desc"], [5,2], 20, "core\items\noUse.sqf", 0, true, [], false],
	["alder_log", ["ITEM", "RESOURCE"], ["Alder Log", "No Desc"], [5,2], 20, "core\items\noUse.sqf", 0, true, [], false],
	["pine_log", ["ITEM", "RESOURCE"], ["Pine Log", "No Desc"], [6,3], 21, "core\items\noUse.sqf", 0, true, [], false],
	["larix_log", ["ITEM", "RESOURCE"], ["Larix Log", "No Desc"], [6,3], 21, "core\items\noUse.sqf", 0, true, [], false],
	["maple_log", ["ITEM", "RESOURCE"], ["Maple Log", "No Desc"], [8,3], 22, "core\items\noUse.sqf", 0, true, [], false],
	["rubber_log", ["ITEM", "RESOURCE"], ["Rubber Log", "No Desc"], [8,3], 20, "core\items\noUse.sqf", 0, true, [], false],
	["Wheat", ["ITEM", "RESOURCE"], ["Wheat", "No Desc"], [3,1], 1, "core\items\noUse.sqf", 0, true, [], false],
	    
	/* Secondary Resources */
	["wood", ["ITEM", "RESOURCE"], ["Wood", "No Desc"], [40,20], 5, "core\items\noUse.sqf", 0, true, [], false],
	["IronBar", ["ITEM", "RESOURCE"], ["Iron Bar", "No desc"], [160,80], 3, "core\items\noUse.sqf", 0, true, [], false],
	["Copper", ["ITEM", "RESOURCE"], ["Copper", "No desc"], [120,60], 2, "core\items\noUse.sqf", 0, true, [], false],
	["GoldBar", ["ITEM", "RESOURCE"], ["Gold Bar", "No desc"], [440,220], 5, "core\items\noUse.sqf", 0, true, [], false],
	["SilverBar", ["ITEM", "RESOURCE"], ["Silver Bar", "No desc"], [400,200], 5, "core\items\noUse.sqf", 0, true, [], false],
	["Glass", ["ITEM", "RESOURCE"], ["Glass", "No Desc"], [20,10], 3, "core\items\noUse.sqf", 0, true, [], false],
	["Bricks", ["ITEM", "RESOURCE"], ["Bricks", "No Desc"], [24,12], 3, "core\items\noUse.sqf", 0, true, [], false],
	["Petrol", ["ITEM", "RESOURCE"], ["Petrol", "No Desc"], [20,14], 1, "core\items\noUse.sqf", 0, true, [], false],
	["ElecComp", ["ITEM", "RESOURCE"], ["Electric Components", "No Desc"], [610,305], 3, "core\items\noUse.sqf", 0, true, [], false],
	["Rubber", ["ITEM", "RESOURCE"], ["Rubber", "No Desc"], [14,7], 1, "core\items\noUse.sqf", 0, true, [], false],
	["Tyre", ["ITEM", "RESOURCE"], ["Rubber Tyre", "No Desc"], [140,70], 5, "core\items\noUse.sqf", 0, true, [], false],
	["Leather", ["ITEM", "RESOURCE"], ["Leather", "No Desc"], [140,70], 5, "core\items\noUse.sqf", 0, true, [], false],
	["Vinyl", ["ITEM", "RESOURCE"], ["Vinyl", "No Desc"], [120,60], 2, "core\items\noUse.sqf", 0, true, [], false]


	///NO COMMA!
	
	];

RPP_fnc_itemGetArray =
{
    private ["_id", "_arr", "_getID"];
    _id = _this;
    _arr = [];

	if (RPP_AcreEnabled) then {
		if ([_id] call acre_api_fnc_isRadio) then {
			_id = [_id] call acre_api_fnc_getBaseRadio;
		};	
	};

    
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
/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

RPP_var_buyDelay = 0.5;
RPP_var_buyLastUsed = time;

RPP_var_shops = 
[
    /* Car shop */
    [shop_carwhite, "Skoda", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_carred, "SkodaRed", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_cargreen, "SkodaGreen", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_carblue, "SkodaBlue", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_cargolf, "VWGolf", "", [0,0], [] call RPP_fnc_generateID, 3, true, true],
    [shop_carhatch, "car_hatchback", "", [0,0], [] call RPP_fnc_generateID, 40, true, true],
    [shop_carsedan, "car_sedan", "", [0,0], [] call RPP_fnc_generateID, 35, true, true],
    [shop_carlada1, "Lada1_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 18, true, true],
    [shop_carlada2, "Lada2_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 18, true, true],
    [shop_caroldb, "Volha_1_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_caroldw, "Volha_2_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    
	/* Classic Cars */
	[shop_monaco, "monaco", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_roadrunner2, "roadrunner2", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_barcuda, "barcuda", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_fury, "fury", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [shop_challenger, "challenger", "", [0,0], [] call RPP_fnc_generateID, 3, true, true],
    [shop_civic, "civic", "", [0,0], [] call RPP_fnc_generateID, 40, true, true],
    [shop_roadrunner, "roadrunner", "", [0,0], [] call RPP_fnc_generateID, 35, true, true],
    [shop_cuda, "cuda", "", [0,0], [] call RPP_fnc_generateID, 18, true, true],
    	
	/* Police Car Shop */
	[shop_Copcar, "Copcar", "", [0,0], [] call RPP_fnc_generateID, 35, true, true],
    [shop_CopcarHW2, "CopcarHW2", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
	[shop_Copcarhw, "Copcarhw", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_CopcarNZ, "CopcarNZ", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
	[shop_swat_suv, "SUV_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
		
	/* Police Item Shop */
	[shop_police_map, "ItemMap", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_compass, "ItemCompass", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_watch, "ItemWatch", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_radio, "ItemRadio", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_gps, "ItemGPS", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_police_handcuffs, "Handcuffs", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_lockpick, "Lockpick", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_bottle, "Bottle", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
	[shop_police_crowbar, "Crowbar", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_police_donut, "Donut", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
	[shop_police_repair, "RepairKit", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_refuel, "RefuelCan", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_police_phone, "Phone", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_police_soup, "Soup", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
	[shop_police_bottleWater, "High_bottleWater", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
	
	/* Police Weapon Shop */
	[shop_police_tazer, "x26", "", [0, 0], [] call RPP_fnc_generateID, 999, true, true],
	[shop_police_tazer_mag, "x26_mag", "", [0, 0], [] call RPP_fnc_generateID, 999, true, true],
	[shop_police_stunshotgun, "M1014", "", [0, 0], [] call RPP_fnc_generateID, 999, true, true],
	[shop_police_stunshotgun_mag, "8Rnd_B_Beneli_74Slug", "", [0, 0], [] call RPP_fnc_generateID, 999, true, true],
	
    /* Pickup shop */
    [shop_pickup, "datsun1_civil_1_open", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup2, "datsun1_civil_2_covered", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup3, "datsun1_civil_3_open", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup4, "hilux1_civil_1_open", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup5, "hilux1_civil_2_covered", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup6, "hilux1_civil_3_open", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup7, "LandRover_CZ_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_pickup8, "LandRover_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    
    /* Bike Shop */
    [shop_bike1, "MMT_Civ", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike2, "Old_bike_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike3, "Old_moto_TK_Civ_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike4, "M1030", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike5, "TT650_Civ", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike6, "TT650_Gue", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike7, "TT650_TK_CIV_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_bike8, "ATV_US_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    
    /* Truck shop */
    [shop_truck1, "UralCivil", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_truck2, "UralCivil2", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
    [shop_truck3, "V3S_Salvage_TK_GUE_EP1", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_truck4, "Kamaz", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_truck5, "KamazOpen", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_truck6, "MTVR", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_truck7, "UralOpen_INS", "", [0,0], [] call RPP_fnc_generateID, 99, true, true],

    /* Item store */
    [shop_donut, "Donut", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
    [shop_soup, "Soup", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
    [shop_bottleWaterLow, "Low_bottleWater", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
    [shop_bottleWater, "High_bottleWater", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
    [shop_bottle, "Bottle", "", [0, 0], [] call RPP_fnc_generateID, 45, true, true],
    [shop_worm, "Bread", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_sandwich, "Sandwich", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	//[shop_can, "Can", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],	
    
    /* Tool Shop */
    [shop_shop2_rod, "Fishing_rod", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop2_pickaxe, "Pickaxe", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop2_hatchet, "Hatchet", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop2_repair, "RepairKit", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop2_refuel, "RefuelCan", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop2_phone, "Phone", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	//[shop_shop2_can, "Can", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	//[shop_shop2_pump, "Pump", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	//[shop_shop2_pump, "Shovel", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    
    /* Outdoor shop */
    [shop_shop3_map, "ItemMap", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop3_compass, "ItemCompass", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop3_watch, "ItemWatch", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop3_radio, "ItemRadio", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop3_gps, "ItemGPS", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop3_lockpick, "Lockpick", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    [shop_shop3_crowbar, "Crowbar", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
    
    /* Boat shop */
    [shop_fishingboat, "Fishing_Boat", "", [0,0], [] call RPP_fnc_generateID, 15, true, false],
    [shop_smallboat1, "Smallboat_1", "", [0,0], [] call RPP_fnc_generateID, 25, true, false],
    [shop_smallboat2, "Smallboat_2", "", [0,0], [] call RPP_fnc_generateID, 25, true, false],
    [shop_pbx, "Smallboat_2", "", [0,0], [] call RPP_fnc_generateID, 25, true, false],
    
    /* Fishing shop */
    [shop_shop4_rod, "Fishing_rod", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_net, "Fishing_net", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_harpoon, "Harpoon", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_minnow, "Minnow", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_worm, "Worm", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_bluegill, "Bluegill", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_catfish, "Catfish", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_perch, "Perch", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_trout, "Trout", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_rockbass, "RockBass", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_shrimp, "Shrimp", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_sardine, "Sardine", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_monkfish, "Monkfish", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_salmon, "Salmon", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_shark, "Shark", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_tuna, "Tuna", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_whale, "Whale", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
	[shop_shop4_swordfish, "Swordfish", "", [0, 0], [] call RPP_fnc_generateID, 250, true, true],
        
    /* Objects */
    [shop_fence, "Land_Farm_Cowshed_c", "", [0,0], [] call RPP_fnc_generateID, 25, true, false],
    
    /* Pistol shop */
    [shop_m9, "M9", "", [0, 0], [] call RPP_fnc_generateID, 2, true, true],
    [shop_m9mag, "15Rnd_9x19_M9", "", [0, 0], [] call RPP_fnc_generateID, 16, true, true],
    [shop_colt1911, "Colt1911", "", [0, 0], [] call RPP_fnc_generateID, 2, true, true],
    [shop_colt1911mag, "7Rnd_45ACP_1911", "", [0, 0], [] call RPP_fnc_generateID, 16, true, true],
    
    /* Resource shop */
    [shop_ironore, "IronOre", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_goldore, "GoldOre", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_copperore, "CopperOre", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	[//shop_sand, "Sand", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_salt, "Salt", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_clay, "Clay", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_oil, "Oil", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_wood, "wood", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_ironbar, "IronBar", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_copper, "Copper", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_goldbar, "GoldBar", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_glass, "Glass", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_bricks, "Bricks", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_silicon, "Silicon", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_petrol, "Petrol", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_eleccomp, "ElecComp", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_rubber, "Rubber", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_tyre, "Tyre", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_leather, "Leather", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	//[shop_vinyl, "Vinyl", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
    
    /* Farm Shop */
    [tractor_shop, "Tractor", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
    [wheat_shop, "Wheat", "", [0,0], [] call RPP_fnc_generateID, 250, true, true],
    [populus_shop, "populus_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[apple_shop, "apple_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[pine_shop, "pine_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
    [pumpkin_shop, "pumpkin_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[potato_shop, "potato_sprouts", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[alder_shop, "alder_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[larix_shop, "larix_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[cabbage_shop, "cabbage_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	[maple_shop, "maple_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	///[rubber_shop, "rubber_seed", "", [0,0], [] call RPP_fnc_generateID, 80, true, true],
	
    ////* Stockyard */
	///[stockyard_rabbit, "Rabbit", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
	///[stockyard_chicken, "Chicken", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
	///[stockyard_lamb, "Lamb", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
	///[stockyard_cow, "Cow", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
	///[stockyard_boar, "Boar", "", [0,0], [] call RPP_fnc_generateID, 25, true, true],
	
    ////* Lumberyard */	
	///[lumber_populus, "Populus Log", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	///[lumber_alder, "Alder Log", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	///[lumber_pine, "Pine Log", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	///[lumber_larix, "Larix Log", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	///[lumber_maple, "Maple Log", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	///[lumber_rubber, "Rubber Log", "", [0, 0], [] call RPP_fnc_generateID, 99, true, true],
	
	/* Mari Sell */
    [mari_sell, "mari", "", [0,0], [] call RPP_fnc_generateID, 0, true, false],

    /* Drug Equipment */
	//[cocaine_seeds, "cocaine_seed", "", [0,0], [] call RPP_fnc_generateID, 250, true, false],
    [mari_seeds, "mari_seed", "", [0,0], [] call RPP_fnc_generateID, 250, true, false]
];

RPP_fnc_addStock = 
{
    private ["_object", "_amount", "_stock"];
    _object = _this select 0;
    _amount = _this select 1;
    
    _stock = _object getVariable "stock";
    _stock = _stock + _amount;
    
    _object setVariable ["stock", _stock, true];
};

RPP_fnc_getStock = 
{
    private ["_object", "_return"];
    _object = _this;
    _return = _object getVariable "stock";
    
    _return
};

RPP_fnc_onShopBuy = 
{
    private ["_object", "_class", "_id", "_type", "_type2", "_name", "_price", "_ok", "_money"];
    _object = (_this select 1);
    _class = (_this select 0);
    _id = (_this select 2);
    _type = _class call RPP_fnc_itemGetType1;
    _type2 = _class call RPP_fnc_itemGetType2;
    _name = _class call RPP_fnc_itemGetName;
    _price = _id call RPP_fnc_shopGetBuyPrice;
    _ok = false;
    _money = "Money" call RPP_fnc_itemGetAmount;
    _stock = _object call RPP_fnc_getStock;
    
    if (_stock < 1) exitWith /* Player cannot buy as there is no stock available */
    {
        (format[localize "STRS_shop_notEnoughStock", _name]) call RPP_fnc_hint; 
    };
    
    if (_money < _price) exitWith /* Player cannot afford to purchase */
    {
         (format[localize"STRS_shop_notEnoughMoney", _name, _price, _money]) call RPP_fnc_hint;
    };
    
    if (_type == "VEHICLE") then
    {
        _ok = true;
        [_class, position _object] call RPP_fnc_createVehicle;
    };
    
    if (_type == "WEAPON") then
    {
        _ok = false;
        
        if ((not([player,"PISTOL"] call RPP_fnc_hasWeaponType)) && _type2 == "PISTOL") then
        {
            /* Player has no pistol and is buying a pistol.. so its ok to buy */
            _ok = true;
        }
        else
        {
            if ((not([player,"RIFLE"] call RPP_fnc_hasWeaponType)) && _type2 == "RIFLE") then
            {
                /* Player has no rifle and is buying a rifle.. so its ok to buy */
                _ok = true;
            };
        };
        
        if (_type2 == "ITEM") then
        {
            _ok = true;
        };
        
        if (_ok) then /* Add the weapon to the player */
        {
            player addweapon _class;
        }
        else /* Display reason why player cannot buy */
        {
            if (_type2 == "PISTOL") then 
            {
                (localize "STRS_shop_cannotBuyPistol") call RPP_fnc_hint;
            }
            else
            {
                (localize "STRS_shop_cannotBuyRifle") call RPP_fnc_hint;
            };
        };
    };
    
    if (_type == "MAGAZINE") then 
    {
        _count = [_type2, player] call RPP_fnc_getMagazineCount;
        _max = 0;
        if (_type2 == "RIFLE") then
        {
            _max = 12;
        }
        else
        {
            _max = 8;
        };
        
        if (_count+1 > _max) then
        {
            (localize "STRS_shop_tooManyMags") call RPP_fnc_hint;
            _ok = false;
        }
        else
        {
            _ok = true;
            player addmagazine _class;  
        };
    };   
    
    if (_type == "ITEM") then
    {
        if ([_class, 1] call RPP_fnc_addInventoryItem) then
        {
            _ok = true;
        }
        else
        {
            _size = _class call RPP_fnc_itemGetMass;
            (format[localize "STRS_shop_overweight", _name, _size]) call RPP_fnc_hint;
            _ok = false;
        };
    };
    
    if (_ok) then /* Player is OK to buy the item, subtract money and display message. */
    {
        [_class, 1, "Buy", _name, _price] call RPP_fnc_hint;
        //(format[localize"STRS_shop_purchasedItem", _name, _price]) call RPP_fnc_hint;
        ["Money", -(_price)] call RPP_fnc_addInventoryItem;
        RPP_var_shopping = RPP_var_shopping - _price;
        [_object, -1] call RPP_fnc_addStock;
    };
};

RPP_fnc_onShopSell = 
{
    private ["_object", "_class", "_id", "_type", "_type2", "_name", "_price", "_ok", "_money"];
    _object = (_this select 1);
    _class = (_this select 0);
    _id = (_this select 2);
    _type = _class call RPP_fnc_itemGetType1;
    _type2 = _class call RPP_fnc_itemGetType2;
    _name = _class call RPP_fnc_itemGetName;
    _price = _id call RPP_fnc_shopGetSellPrice;
    _ok = false;

    if (_type == "VEHICLE") then
    {
        _vehicles = nearestObjects[player, [_class], 20];
        _found = false;
        
        {
            if ((typeOf _x == _class) && (_x in RPP_var_keyChain)) exitWith
            {
                _ok = true;
                [_x, 0] call RPP_fnc_serverDelVehicle;
                _x call RPP_fnc_addToKeychain;
                _found = true;
            };
        } forEach _vehicles;
        
        if (not _found) exitWith
        {
            _ok = false;
            (format[localize "STRS_shop_notEnough", _name]) call RPP_fnc_hint;
        };
       
    };
    
    if (_type == "WEAPON") then
    {
        if ([player, _class] call RPP_fnc_hasWeaponClass) then
        {
            _ok = true;
            player removeWeapon _class;
        }
        else /* Doesnt have weapon to sell */
        {
            _ok = false;
            (format[localize "STRS_shop_notEnough", _name]) call RPP_fnc_hint;
        };
    };
    
    if (_type == "MAGAZINE") then 
    {
        if ([player, _class] call RPP_fnc_hasMagazineClass) then
        {
            _ok = true;
            player removeMagazine _class;
        }
        else /* Doesnt have magazine to sell */
        {
            _ok = false;
            (format[localize "STRS_shop_notEnough", _name]) call RPP_fnc_hint;
        };
    };   
    
    if (_type == "ITEM") then
    {
        _itemAmount = _class call RPP_fnc_itemGetAmount;
        
        if ((_type2 == "DRUG") && (([]call RPP_fnc_getNumberCops) < 2)) exitWith
        {
            localize "STRS_shop_sellDrugs" call RPP_fnc_hint;
        };
        
        if (_itemAmount >= 1) then
        {
            [_class, -1] call RPP_fnc_addInventoryItem;
            _ok = true; 
        }
        else /* Not enough */
        {
            (format[localize "STRS_shop_notEnough", _name]) call RPP_fnc_hint;
            _ok = false;
        };
    };
    
    if (_ok) then /* Player is OK to sell the item, add money and display message */
    {
        [_class, 1, "SELL", _name, _price] call RPP_fnc_hint;
        ["Money", +(_price)] call RPP_fnc_addInventoryItem;
        RPP_var_shopping = RPP_var_shopping + _price;
        [_object, +1] call RPP_fnc_addStock;
    };
};

RPP_fnc_onShopAction = 
{
    private ["_object", "_class", "_id", "_typeOfAction", "_foundClass", "_type"];
    _object = (_this select 0);
    _class = (_this select 1);
    _id = (_this select 2);
    _typeOfAction = (_this select 3);
    
    if (cursorTarget != _object) exitWith {};
    
    if (!(_id call RPP_fnc_shopGetCanCiv) && (player call RPP_fnc_isCiv)) exitWith
    {
        localize "STRS_shop_cantIsCiv" call RPP_fnc_hint;
    };
    
    if (!(_id call RPP_fnc_shopGetCanCop) && (player call RPP_fnc_isCop)) exitWith
    {
        localize "STRS_shop_cantIsCiv" call RPP_fnc_hint;
    };

    if (((RPP_var_buyLastUsed)+RPP_var_buyDelay) > time) exitWith
    {
        localize "STRS_shop_cantUseYet" call RPP_fnc_hint;
    };
    
    RPP_var_buyLastUsed = time;
    
    if (_typeOfAction == "BUY") then
    {
        [_class, _object, _id] call RPP_fnc_onShopBuy;
    }
    else
    {
        [_class, _object, _id] call RPP_fnc_onShopSell;
    };
};

RPP_fnc_shopGetArray =
{
    private ["_id", "_arr", "_getID"];
    _id = _this;
    _arr = [];
    
    {
        _getID = (_x select 4);
        
        if (_id == _getID) exitWith
        {
            _arr = _x;
        };
    } forEach RPP_var_shops;
    
    _arr
};

RPP_fnc_shopGetBuyPrice = 
{
    if ((((_this call RPP_fnc_shopGetArray) select 3) select 0) == 0) exitWith
    {
        ((_this call RPP_fnc_shopGetArray) select 1) call RPP_fnc_itemGetBuyPrice;
    };
     
    (((_this call RPP_fnc_shopGetArray) select 3) select 0);
};

RPP_fnc_shopGetSellPrice = 
{
    if ((((_this call RPP_fnc_shopGetArray) select 3) select 1) == 0) exitWith
    {
        ((_this call RPP_fnc_shopGetArray) select 1) call RPP_fnc_itemGetSellPrice;     
    };
     
     (((_this call RPP_fnc_shopGetArray) select 3) select 1);
};

RPP_fnc_shopGetStock = 
{
     ((_this call RPP_fnc_shopGetArray) select 5)
};

RPP_fnc_shopGetCanCiv = 
{
     ((_this call RPP_fnc_shopGetArray) select 6)
};

RPP_fnc_shopGetCanCop = 
{
     ((_this call RPP_fnc_shopGetArray) select 7)
};

RPP_fnc_setupShops =
{     
    {
        _object = (_x select 0);
        _class = (_x select 1);
        _type1 = _class call RPP_fnc_itemGetType1;
        _type2 = _class call RPP_fnc_itemGetType2;
        _stringName = _class call RPP_fnc_itemGetName;
        _picture = (_x select 2);
        _buyPrice = ((_x select 3) select 0);
        _sellPrice = ((_x select 3) select 1);
        _id = (_x select 4);
        _stock = (_x select 5);
        _weight = _class call RPP_fnc_itemGetMass;

        if (isServer) then
        {
            /* Initalize the stock */
            _object setVariable ["stock", _stock, true];
        };
        
        if (_buyPrice == 0) then
        {
            _buyPrice = _class call RPP_fnc_itemGetBuyPrice;
        };
        
        if (_sellPrice == 0) then
        {
            _sellPrice = _class call RPP_fnc_itemGetSellPrice;
        };
        
        _stock = _object getVariable "stock";
    

        _text = format["<t size='0.55' color='#4876FF'>%1</t><br/><t size='0.475'>%5x - %6 sz</t><br/><t size='0.45'>$%3/$%4</t><br/><t size='0.4'>(Press F to buy)<br/></t><t size='0.4'>(Press T to sell)</t>", _stringName, _picture, _buyPrice, _sellPrice, _stock, _weight];
        _onKeyBuy = format['[%1, ""%2"", %3, ""BUY""] call RPP_fnc_onShopAction;', _object, _class, _id];
        _onKeySell = format['[%1, ""%2"", %3, ""SELL""] call RPP_fnc_onShopAction;', _object, _class, _id];

        _onAdd = format[
        '
            _text = "%1";
            _onKeyB = "%4";
            _onKeyS = "%5";
            
            _strN = "%6";
            _pic = "%7";
            _bp = %8;
            _sp = %9;
            _stock = %3 getVariable "stock";
            
  
            [%3, _onKeyB, _onKeyS, "%6", "%7", _bp, _sp, %2, _stock] spawn
            {
                _oldStock = ((_this select 0) getVariable "stock")+1;
                _updated = false;

                _onTarget = false;
                
                while {player distance (_this select 0) <= 20} do
                {
                    if ((cursorTarget == (_this select 0)) || (not(_updated))) then
                    {
                        [33, (_this select 1), false, false, false] spawn RPP_fnc_addKeyAction;
                        [20, (_this select 2), false, false, false] spawn RPP_fnc_addKeyAction;
                        
                        if ((_this select 0 getVariable "stock") != _oldStock) then
                        {
                            %2 call RPP_fnc_disable3DText;
                            sleep 0.25;
                            _newStock = (_this select 0) getVariable "stock";
                            _text = "<img image=""%7""/><br/><t size=""0.55"" color=""#4876FF"">%6</t><br/><t size=""0.475"">"+str _newStock+"x - %10 sz</t><br/><t size=""0.45"">$%8/$%9</t><br/><t size=""0.4"">(Press F to buy)<br/></t><t size=""0.4"">(Press T to sell)</t>";
                            [(_this select 7), _text, (_this select 0), 0.65, 7, false] call RPP_fnc_create3DText;
                            _oldStock = (_this select 0) getVariable "stock";
                            _updated = true;
                        };

                        _onTarget = true;
                    }
                    else
                    {
                        if (_onTarget && (cursorTarget != (_this select 0))) then
                        {
                            _onTarget = false;
                            
                            //[33, "", false, false, false] spawn RPP_fnc_addKeyAction;
                            //[20, "", false, false, false] spawn  RPP_fnc_addKeyAction;

                            [33, false, false, false ] spawn RPP_fnc_remKeyAction;
                            [20, false, false, false ] spawn RPP_fnc_remKeyAction;
                        };
                    };
                    sleep 0.001;
                };
                
                [33, false, false, false ] spawn RPP_fnc_remKeyAction;
                [20, false, false, false ] spawn RPP_fnc_remKeyAction;
            };
    

        ',_text, _id, _object, _onKeyBuy, _onKeySell, _stringName, _picture, _buyPrice, _sellPrice, _weight];

        _onRem = format[
        '
             %1 call RPP_fnc_disable3DText;
        ', _id];

        [player, vehicle player, compile format['(player distance %1 <= 20)',_object], _onAdd, _id, _onRem] call RPP_fnc_addAction;
    } forEach RPP_var_shops;
};
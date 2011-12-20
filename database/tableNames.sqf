RPP_var_saving_tableUsers = "RPPR_Users";
RPP_var_saving_tableBanks = "RPPR_Banks";
RPP_var_saving_tableLicenses = "RPPR_Licenses";
RPP_var_saving_tableSkills = "RPPR_Skills";
RPP_var_saving_tableInvest = "RPPR_Invest";
RPP_var_saving_tableLocalTrunk = "RPP_LocalStorage";
RPP_var_saving_tablePublicTrunk = "RPP_PublicStorage";

RPP_var_saving_serverToLoad = 
[ 
    RPP_var_saving_tableUsers,
    RPP_var_saving_tableBanks,
    RPP_var_saving_tableLicenses,
    RPP_var_saving_tableSkills,
    RPP_var_saving_tableInvest,
    RPP_var_saving_tableLocalTrunk,
    RPP_var_saving_tablePublicTrunk
];

RPP_var_saving_clientToLoad = 
[
    [RPP_var_saving_tableBanks, "RPP_var_bankAmount"],
    [RPP_var_saving_tableLicenses, "RPP_var_playerLicenses"],
    [RPP_var_saving_tableSkills, "RPP_var_userSkills"],
    [RPP_var_saving_tableInvest, "RPP_var_invested"]
];

RPP_var_saving_localStorages = 
[
    [RPP_var_saving_tableLocalTrunk, "trunk"]
];

RPP_var_saving_publicStorages = 
[
    [RPP_var_saving_tablePublicTrunk, "trunk"]
];

RPP_var_saving_users =
[
    [RPP_var_saving_tableUsers, "RPP_var_acc_users"]
];


/*
RPP_gVar_arr_tables_clientLoad = 
[ 
	[RPP_gVar_str_tables_licenses, "Gvar_arr_lic_playerLicenses"],
	[RPP_gVar_str_tables_skills, "RPP_gVar_arr_skills"],
	[RPP_gVar_str_tables_markers, "RPP_gVar_arr_foundMarkers"],
	[RPP_gVar_str_tables_wallet, "RPP_wallet_walletArray"]
];

RPP_gVar_arr_tables_workplacesLoad =
[
	[RPP_gVar_str_tables_workplaces, "price"]
];

RPP_gVar_arr_tables_shopsLoad =
[
	[RPP_gVar_str_tables_shops, "stock"],
	[RPP_gVar_str_tables_shops, "name"]
];

RPP_gVar_arr_tables_storagesLoad = 
[ 
	[RPP_gVar_str_tables_trunk_storages, "storage"],
	[RPP_gVar_str_tables_trunk_storages, "weight"]
];

RPP_gVar_arr_tables_corporationsLoad = 
[
	[RPP_gVar_str_tables_corporations, "corporations"],
	[RPP_gVar_str_tables_corporations, "firms"]
];

RPP_gVar_arr_tables_stockMarketLoad = 
[
	[RPP_gVar_str_tables_stockmarket, "stockmarket"]
];

RPP_gVar_arr_tables_localStoragesLoad =
[
	[RPP_gVar_str_tables_trunk_localStorages, "storage"],
	[RPP_gVar_str_tables_trunk_localStorages, "weight"]
];

RPP_gVar_arr_tables_factoriesLoad =
[
	[RPP_gVar_str_tables_factories_settings, "factory_settings"]
];

RPP_gVar_arr_tables_serverLoad =
[
	[RPP_gVar_str_tables_serverVars, "RPP_db_userArray"]
];

RPP_gVar_arr_tables_bankReferencesLoad = 
[
	[RPP_gVar_str_tables_bankAccountRef, "RPP_bank_accounts"]
];

RPP_gVar_arr_tables_employeesLoad =
[
	[RPP_gVar_str_tables_employees, "employees"]
];
*/


class CfgItems
{  
    class baseItem
    {
        subType1 = "Item";
        subType2 = "Special";
        itemName = "Base Item";
        description = "Inherit from this";
        defaultBuyPrice = 0;
        defaultSellPrice = 0;
        weight = 0;
        useScript = "core\items\noUse.sqf";
        trunkSize = 0;
        canDrop = false;
        isIllegal = false;
        requiredResources[] = { };
        siren[] = { };
    };

    class Money : baseItem
    {
        itemName = "Money";
        description = "No description";
        canDrop = true;
    };
    
    class Keychain : baseItem
    {
        itemName = "Keychain";
        description = "No description";
        useScript = "core\items\keychain.sqf";
    };
    
    class MedicalBag : baseItem
    {
        itemName = "Medical Bag";
        description = "No description";
        weight = 5;
        useScript = "core\items\medic.sqf";
        canDrop = true;
    };
    
    class Pickaxe : baseItem
    {
        itemName = "Pickaxe";
        description = "No description";
        weight = 12;
        canDrop = true;
        defaultBuyPrice = 200;
        defaultSellPrice = 150;
        requiredResources[] = { 2, { {"IronBar", 1} } };
    };
    
    class Hatchet : baseItem
    {
        itemName = "Hatchet";
        description = "No description";
        weight = 8;
        useScript = "core\items\medic.sqf";
        canDrop = true;
        defaultBuyPrice = 150;
        defaultSellPrice = 75;
        requiredResources[] = { 2, { {"IronBar", 1} }  };
    };
    
    
};
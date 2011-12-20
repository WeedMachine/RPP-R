class RPP_Dlg_Trade
{
    idd = 1200;
    movingEnable = false;
    controlsBackground[] = { Background, Footer, Header, InfoFrame, InvFrame, TradingFrame, ActionsFrame };
    objects[] = { };
    controls[] = { Title, InvList, GivingList, SendBtn, CloseBtn, RemoveBtn, GiveBtn, AmountEdit, Info };
    OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
    OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

    class Background : RPP_BackgroundFill
    {
        idc = 1200;
        text = "images\center_webbox1.paa";
        x = 0.3265 * safezoneW + safezoneX;
        y = 0.203216 * safezoneH + safezoneY;
        w = 0.411994 * safezoneW;
        h = 0.594826 * safezoneH;
    };
    
    class Footer : RPP_BackgroundFill
    {
        idc = 1201;
        text = "images\footer_webbox1.paa";
        x = 0.3265 * safezoneW + safezoneX;
        y = 0.796785 * safezoneH + safezoneY;
        w = 0.411994 * safezoneW;
        h = 0.0184965 * safezoneH;
    };
    
    class Header : RPP_BackgroundFill
    {
        idc = 1202;
        text = "images\header_webbox1.paa";
        x = 0.326501 * safezoneW + safezoneX;
        y = 0.176122 * safezoneH + safezoneY;
        w = 0.411994 * safezoneW;
        h = 0.0271171 * safezoneH;
    };
    
    class Title : RPP_HeaderTitle1
    {
        idc = 1203;
        text = "Trading with Unforgiven";
        x = 0.345 * safezoneW + safezoneX;
        y = 0.18 * safezoneH + safezoneY;
        w = 0.411994 * safezoneW;
        h = 0.0271171 * safezoneH;
    };
    
    class InfoFrame : RPP_Frame
    {
        idc = 1800;
        text = "Information";
        x = 0.536892 * safezoneW + safezoneX;
        y = 0.20691 * safezoneH + safezoneY;
        w = 0.172383 * safezoneW;
        h = 0.337448 * safezoneH;
    };
    
    class Info : RPP_StructuredText
    {
        idc = 1204;
        text = "This is some example text, yay for me!";
        x = 0.536892 * safezoneW + safezoneX;
        y = 0.24 * safezoneH + safezoneY;
        w = 0.172383 * safezoneW;
        h = 0.337448 * safezoneH;  
        sizeEx = 0.018;
    };
    
    class InvFrame : RPP_Frame
    {
        idc = 1801;
        text = "Inventory";
        x = 0.354992 * safezoneW + safezoneX;
        y = 0.206909 * safezoneH + safezoneY;
        w = 0.172383 * safezoneW;
        h = 0.337448 * safezoneH;
            //colorText[] = {0,0,0,1};
    };
    
    class TradingFrame : RPP_Frame
    {
        idc = 1802;
        text = "Trading";
        x = 0.354991 * safezoneW + safezoneX;
        y = 0.544333 * safezoneH + safezoneY;
        w = 0.172383 * safezoneW;
        h = 0.245087 * safezoneH;
           // colorText[] = {0,0,0,1};
    };
    
    class ActionsFrame : RPP_Frame
    {
        idc = 1803;
        text = "Actions";
        x = 0.536891 * safezoneW + safezoneX;
        y = 0.544333 * safezoneH + safezoneY;
        w = 0.172383 * safezoneW;
        h = 0.245087 * safezoneH;
           // colorText[] = {0,0,0,1};
    };
    
    class InvList : RPP_List
    {
        idc = 1500;
        x = 0.354259 * safezoneW + safezoneX;
        y = 0.2325 * safezoneH + safezoneY;
        w = 0.159233 * safezoneW;
        h = 0.293116 * safezoneH;
            //colorBackground[] = {0,0,0,1};
    };
    
    class GivingList : RPP_List
    {
        idc = 1501;
        x = 0.356452 * safezoneW + safezoneX;
        y = 0.5725 * safezoneH + safezoneY;
        w = 0.158502 * safezoneW;
        h = 0.208144 * safezoneH;
            //colorBackground[] = {0,0,0,1};
    };
    
    class SendBtn : RPP_Button
    {
        idc = 1600;
        text = "Send";
        x = 0.540543 * safezoneW + safezoneX;
        y = 0.709351 * safezoneH + safezoneY;
        w = 0.0817973 * safezoneW;
        h = 0.0455892 * safezoneH;
    };
    
    class CloseBtn : RPP_Button
    {
        idc = 1601;
        text = "Close";
        x = 0.626746 * safezoneW + safezoneX;
        y = 0.70935 * safezoneH + safezoneY;
        w = 0.0781448 * safezoneW;
        h = 0.0455892 * safezoneH;
        action = "closeDialog 0;";
    };
    
    class AmountEdit : RPP_Edit
    {
        idc = 1400;
        text = "0";
        x = 0.572687 * safezoneW + safezoneX;
        y = 0.649008 * safezoneH + safezoneY;
        w = 0.0993299 * safezoneW;
        h = 0.0406633 * safezoneH;
    };
    
    class GiveBtn : RPP_Button
    {
        idc = 1602;
        text = "Add";
        x = 0.539813 * safezoneW + safezoneX;
        y = 0.582509 * safezoneH + safezoneY;
        w = 0.0803363 * safezoneW;
        h = 0.0455892 * safezoneH;
    };
    
    class RemoveBtn : RPP_Button
    {
        idc = 1603;
        text = "Remove";
        x = 0.624555 * safezoneW + safezoneX;
        y = 0.582509 * safezoneH + safezoneY;
        w = 0.0803363 * safezoneW;
        h = 0.0455892 * safezoneH;
    };
};

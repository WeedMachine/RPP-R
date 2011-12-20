class RPP_Dlg_Search
{
    idd = 2700;
    movingEnable = false;
    controlsBackground[] = { Background, Header, Footer, Frame };
    objects[] = { };
    controls[] = { SearchList, BtnClose, Title  };
    OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
    OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
    class Background : RPP_BackgroundFill
    {
        idc = 1200;
        text = "images\center_webbox1.paa";
        x = 0.390786 * safezoneW + safezoneX;
        y = 0.246315 * safezoneH + safezoneY;
        w = 0.243243 * safezoneW;
        h = 0.467985 * safezoneH;
    };
    
    class Header : RPP_BackgroundFill
    {
        idc = 1201;
        text = "images\footer_webbox1.paa";
        x = 0.390055 * safezoneW + safezoneX;
        y = 0.713045 * safezoneH + safezoneY;
        w = 0.243974 * safezoneW;
        h = 0.0135705 * safezoneH;
    };
    
    class Footer : RPP_BackgroundFill
    {
        idc = 1202;
        text = "images\header_webbox1.paa";
        x = 0.390056 * safezoneW + safezoneX;
        y = 0.21553 * safezoneH + safezoneY;
        w = 0.244706 * safezoneW;
        h = 0.0308115 * safezoneH;
    };
    
    class SearchList : RPP_List 
    {
        idc = 1500;
        x = 0.4125 * safezoneW + safezoneX;
        y = 0.267251 * safezoneH + safezoneY;
        w = 0.2 * safezoneW;
        h = 0.394096 * safezoneH;
        sizeEx = 0.0245;
    };
    
    class Frame : RPP_Frame
    {
        idc = 1800;
        x = 0.407588 * safezoneW + safezoneX;
        y = 0.254937 * safezoneH + safezoneY;
        w = 0.209639 * safezoneW;
        h = 0.415031 * safezoneH;
    };
    
    class Title : RPP_HeaderTitle1
    {
        idc = -1;
        text = "Searching";
        x = 0.4025 * safezoneW + safezoneX;
        y = 0.22 * safezoneH + safezoneY;
        w = 0.144622 * safezoneW;
        h = 0.0382003 * safezoneH;
    };
    
    class BtnClose : RPP_Button
    {
        idc = 1600;
        text = "Close";
        action = "CloseDialog 0;";
        x = 0.463109 * safezoneW + safezoneX;
        y = 0.672406 * safezoneH + safezoneY;
        w = 0.0971384 * safezoneW;
        h = 0.0369688 * safezoneH;
    };
};

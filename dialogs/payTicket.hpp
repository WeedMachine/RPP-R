class ALR_Dlg_payTicket
{
    idd = 2400;
    movingEnable = false;
    controlsBackground[] = { background, header };
    objects[] = { };
    controls[] = { payBtn, RefuseBtn, ReasonFrame, ticketReason, ticketCost, info };
    OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
    OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        

    class background: RPP_BackgroundFill
    {
            idc = 1200;
            text = "images\web_box1.paa";
            x = 0.405722 * safezoneW + safezoneX;
            y = 0.355722 * safezoneH + safezoneY;
            w = 0.183974 * safezoneW;
            h = 0.255383 * safezoneH;
    };
    
    class header : RPP_HeaderTitle1 
    {
        x = 0.411722 * safezoneW + safezoneX;
        y = 0.380722 * safezoneH + safezoneY;
        text = "Pay Ticket";
    };
    
    class ReasonFrame: RPP_Frame
    {
            idc = 1800;
            text = "Ticket Reason";
            x = 0.421368 * safezoneW + safezoneX;
            y = 0.441732 * safezoneH + safezoneY;
            w = 0.152974 * safezoneW;
            h = 0.068737 * safezoneH;
    };
    
    class ticketReason : RPP_StructuredText 
    {
            idc = 2;
            x = 0.359368;
            y = 0.446732;
            w = 0.25;
            h = 0.4;
            size = 0.025;
            text = "";
    };
	
	class ticketCost : RPP_StructuredText 
    {
            idc = 3;
            x = 0.442368;
            y = 0.389732;
            w = 0.25;
            h = 0.4;
            size = 0.025;
            text = "Fine:";
    };
    
    class payBtn : RPP_Button
    {
            idc = 1600;
            text = "Pay Now";
            x = 0.425900 * safezoneW + safezoneX;
            y = 0.5214597 * safezoneH + safezoneY;
            w = 0.0745669 * safezoneW;
            h = 0.0455892 * safezoneH;
            action = "";
    };
    
    class RefuseBtn : RPP_Button
    {
            idc = 1601;
            text = "Refuse";
            x = 0.501902 * safezoneW + safezoneX;
            y = 0.5214597 * safezoneH + safezoneY;
            w = 0.0745669 * safezoneW;
            h = 0.0455892 * safezoneH;
            action = "CloseDialog 0;";
    };
        
    class info : RPP_Text
    {
            idc = 1000;
            text = "You have been fined.";
            x = 0.423984 * safezoneW + safezoneX;
            y = 0.399528 * safezoneH + safezoneY;
            w = 0.25 * safezoneW;
            h = 0.0221912 * safezoneH;
    };

};
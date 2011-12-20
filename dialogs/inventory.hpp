/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_Inventory
{
	idd = 200;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground, InvListBG, ActionBGFill, ActionTitleFill, ActionTitle, ActionFooterFill, ListFrame, DescFrame };
	objects[] = { };
	controls[] = { InvList, BtnUse, BtnDrop, BtnClose, EditAmount, ItemDesc, TotalSize  };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.20;
            y = 0.25;
            w = 0.5;
            h = 0.5;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.175;
            y = 0.15;
            w = 0.55;
            h = 0.5;
            size = 0.035;
        };
        
        class ListFrame : RPP_Frame
        {
            x = 0.214;
            y = 0.20;
            w = 0.225;
            h = 0.4;
        };
        
        class DescFrame : RPP_Frame
        {
            x = 0.441;
            y = 0.20;
            w = 0.25;
            h = 0.4;
        };
        
        class ItemDesc : RPP_StructuredText 
        {
            idc = 3;
            x = 0.44;
            y = 0.21;
            w = 0.25;
            h = 0.4;
            size = 0.026;
            text = "Description: ";
        };
        
        class TotalSize : RPP_StructuredText
        {
            idc = 5;
            x = 0.214;
            y = 0.610;
            w = 0.225;
            h = 0.4;
            text = "Inventory Size: ";
        };
        
        
        class Title : RPP_HeaderTitle1
        {
            idc = 1;
            text = "Inventory";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.20;
            y = 0.145;
            w = 0.5;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.145;
            w = 0.55;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
		
	class FooterFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.645;
            w = 0.55;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
        
        class InvList : RPP_List 
        {
            idc = 2;
            x = 0.214;
            y = 0.205;
            w = 0.225;
            h = 0.4;
            sizeEx = 0.024;
            onLBSelChanged  = "[] call RPP_fnc_invSelChanged;";
            default = true;
        };
        
        class InvListBG : RPP_Background
        {
            x = 0.215;
            y = 0.27;
            w = 0.225;
            h = 0.455;
            size = 0.035;
            colorBackground[] = { 0.16, 0.55, 1, 0.8 };
	};
		
	class ActionTitleFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.675;
            w = 0.55;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
        
        class ActionBGFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.68;
            w = 0.55;
            h = 0.12;
            size = 0.035;
        };
		
	class ActionFooterFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.795;
            w = 0.55;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
		
	class ActionTitle : RPP_HeaderTitle1
        {
            idc = 1;
            y = 0.68;
            text = "Actions";
        };
        
        class BtnUse : RPP_Button
        {
            x = 0.215;
            y = 0.72;
            w = 0.085;
            h = 0.065;
            text = "Use";
            action = "[] spawn RPP_fnc_inventoryUse;";
           
        };
		
	class BtnDrop : BtnUse
        {
            x = 0.315; 
            y = 0.72;
            text = "Drop";
            action = "[] spawn RPP_fnc_inventoryDrop;";
        };
	
        class BtnClose : BtnUse
        {
            x = 0.415; 
            y = 0.72;
            text = "Close";
            action = "closeDialog 0;";
        };
        
	class EditAmount : RPP_Edit
        {
            idc = 4;
            x = 0.515; 
            y = 0.72;   
            w = 0.16;
            h = 0.065;
            text = "1";
        };
     
};    
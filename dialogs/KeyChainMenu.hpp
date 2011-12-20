/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_KeyChain
{
	idd = 1000;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground };
	objects[] = { };
	controls[] = { DescFrame, TransferFrame, Transfer, Close, DropKey, KeyList, PlayerSelect, InfoFrame, VclInfo };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.20;
            y = 0.25;
            w = 0.6;
            h = 0.55;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.175;
            y = 0.15;
            w = 0.65;
            h = 0.55;
            size = 0.035;
        };
    
        class Title : RPP_HeaderTitle1
        {
            idc = -1;
            text = "Key Chain";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.20;
            y = 0.145;
            w = 0.60;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.145;
            w = 0.65;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
        
        class FooterFill : RPP_BackgroundFill
        {
            x = 0.175;
            y = 0.695;
            w = 0.65;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
        
        class DescFrame : RPP_Frame
        {
            x = 0.22;
            y = 0.185;
            w = 0.31;
            h = 0.49;
            text = "Key List";
        };
		
        class InfoFrame : RPP_Frame
        {
            x = 0.55;
            y = 0.185;
            w = 0.23;
            h = 0.18;
            text = "Vehicle Info";
        };
        
        class VclInfo : RPP_structuredText 
        {
            idc = 14;
            x = 0.55;
            y = 0.2175;
            w = 0.23;
            h = 0.18;
            text = "";
        };
		
        class TransferFrame : RPP_Frame
        {
            x = 0.55;
            y = 0.375;
            w = 0.23;
            h = 0.147;
            text = "Transfer Key";
        };
		
        class PlayerSelect : RPP_ComboBox
        {
            idc = 7;
            x = 0.56;
            y = 0.415;
            w = 0.21;
            h = 0.032;
            sizeEx = 0.028;
        };
		
        class Transfer : RPP_Button
        {
            idc = 3;
            x = 0.56;
            y = 0.46;
            w = 0.21;
            h = 0.044;
            text = "Transfer";
            action = "[] call RPP_fnc_keyTransfer;";
           
        };
        
        class DropKey : RPP_Button
        {
            idc = 3;
            x = 0.56;
            y = 0.54;
            w = 0.21;
            h = 0.053;
            text = "Drop Key";
            action = "[] call RPP_fnc_keyDrop;";
           
        };
		
        class Close : DropKey
        {
            idc = 4;
            y = 0.61;
            text = "Close";
            action = "closeDialog 0;";
           
        };
		
        class KeyList : RPP_List 
        {
            idc = 2;
            x = 0.22;
            y = 0.22;
            w = 0.3;
            h = 0.446;
            sizeEx = 0.03;
            onLBSelChanged  = "[] call RPP_fnc_keyChainUpdate;";
            default = true;
        };
};    
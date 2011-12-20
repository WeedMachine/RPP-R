/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

class RPP_Dlg_FactoryManufacturing
{
	idd = 550;
	movingEnable = false;
	controlsBackground[] = { BackgroundFill, Background, TitleFill, FooterFill, Title, TitleBackground, InvListBG, ListFrame, ManufacturingFrame, ResourcesFrame, SelectFrame, BtnBgRight, BtnBgLeft };
	objects[] = { };
	controls[] = { BtnManufacture, StorageSize, InvSize, EditManufAmount, BtnTransferLeft, BtnTransferRight, EditTransferAmount, ResourceSelect, RequiredItemsList, FactoryList, StorageList };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
        
        class Background : RPP_Background
	{
            idc = -1;
            x = 0.10;
            y = 0.25;
            w = 0.8;
            h = 0.5;
            size = 0.035;
	};
                
        class BackgroundFill : RPP_BackgroundFill
        {
            idc = -1;
            x = 0.075;
            y = 0.15;
            w = 0.85;
            h = 0.5;
            size = 0.035;
        };
        
        class Title : RPP_HeaderTitle1
        {
            idc = 1;
			x = 0.115;
            text = "FACTORY NAME - Manufacturing";
        };
        
        class TitleBackground : RPP_Background
        {
            x = 0.1;
            y = 0.145;
            w = 0.8;
            h = 0.16;
        };
        
        class TitleFill : RPP_BackgroundFill
        {
            x = 0.075;
            y = 0.145;
            w = 0.85;
            h = 0.031;
            size = 0.035;
            text = "images\header_webbox1.paa";
        };
		
        class FooterFill : RPP_BackgroundFill
        {
            x = 0.075;
            y = 0.645;
            w = 0.85;
            h = 0.02;
            size = 0.035;
            text = "images\footer_webbox1.paa";
        };
		
        class ListFrame : RPP_Frame
        {
            x = 0.134;
            y = 0.182;
            w = 0.225;
            h = 0.42;
            text = "Factory Storage";
        };
        
        class ManufacturingFrame : ListFrame
        {
            x = 0.44;
            y = 0.182;
            text = "Manufacturing Que";
        };
		
        class ResourcesFrame : ListFrame
        {
            x = 0.67;
            y = 0.271;
            h = 0.287;
            w = 0.205;
            text = "Required Items";
        };
		
        class SelectFrame : ResourcesFrame
        {
            y = 0.182;
            h = 0.085;
            text = "Choose Product";
        };
        
        class StorageList : RPP_List 
        {
            idc = 11;
            x = 0.134;
            y = 0.215;
            w = 0.216;
            h = 0.378;
            sizeEx = 0.0245;
            onLBSelChanged  = "";
            default = true;
        };
        
        class InvSize : RPP_StructuredText
        {
            x = 0.434;
            y = 0.610;
            w = 0.25;
            h = 0.4;
            text = "";
        };
        
        class StorageSize : RPP_StructuredText
        {
            idc = 4;
            x = 0.127;
            y = 0.610;
            w = 0.25;
            h = 0.4;
            text = "Storage Size: ";
        };
        
        class EditManufAmount : RPP_Edit
        {
            idc = 5;
            x = 0.67; 
            y = 0.571;   
            w = 0.075;
            h = 0.065;
            text = "1";
        };
		
        class BtnManufacture : RPP_Button
        {
            x = 0.752;
            y = 0.57;
            w = 0.12;
            h = 0.065;
            text = "Manufacture";
            action = "[] call RPP_fnc_factory_manufacture;";
           
        };
		
        class BtnBgRight : RPP_BackgroundFill
        {
            x = 0.365; 
            y = 0.46;
            w = 0.065; 
            h = 0.065;
            colorBackground[] = {0,0.055,0.14,1};
            text = "images\arrowright.paa";
            sizeEx = 0.032;
        };
		
        class BtnBgLeft : BtnBgRight
        {
            x = 0.362;
            y = 0.28;
            text = "images\arrowleft.paa";
        };
		
        class BtnTransferRight : RPP_Button
        {
            idc = 9;
            x = 0.365; 
            y = 0.46;
            w = 0.066; 
            h = 0.066;
            action = "[] call RPP_fnc_factory_transferTo;";
            text = "";
            colorText[] = { 1, 1, 1, 0 };
            colorBorder[] = { 0.05, 0.05, 0.2, 0 };
            colorBackground[] = { 0.16, 0.55, 1, 0 };
            colorFocused[] = { 0.2, 0.6, 0.95, 0 };
            colorShadow[] = { 0, 0, 0, 0 };
        };
		
        class BtnTransferLeft : BtnTransferRight
        {
            idc = 10;
            x = 0.362;
            y = 0.28;
            action = "[] call RPP_fnc_factory_transferFrom;";
            text = "";
        };
		
        class EditTransferAmount : RPP_Edit
        {
            idc = 6;
            x = 0.365; 
            y = 0.37;   
            w = 0.065;
            h = 0.065;
            text = "1";
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
        
        class ResourceSelect : RPP_ComboBox
        {
            idc = 7;
            x = 0.677;
            y = 0.22;
            w = 0.19;
            h = 0.035;
            sizeEx = 0.028;
            onLBSelChanged  = "[] call RPP_fnc_factory_selectedItem;";
        };
        
        class FactoryList : StorageList 
        {
            idc = 12;
            x = 0.44;
            onLBSelChanged  = "";
        };
        
        class RequiredItemsList : StorageList 
        {
            idc = 13;
            x = 0.67;
            y = 0.305;
            w = 0.2;
            h = 0.245;
            sizeEx = 0.021;
            onLBSelChanged  = "";
        };
     
};    
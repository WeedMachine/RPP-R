/*
The Roleplay Project: Reloaded
Copyright (C) 2011  Matthew Simms
*/

_class = _this select 0;
_amount = _this select 1;
_type1 = _class call RPP_fnc_itemGetType1;
_type2 = _class call RPP_fnc_itemGetType2;


if (_type2 == "DRUG") then
{

		"radialBlur" ppEffectEnable true;
		"radialBlur" ppEffectAdjust[0.2, 0.2, 0, 0];
		"radialBlur" ppEffectCommit 0;
    	"colorCorrections" ppEffectEnable true;
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0,0,0,0.5], [random 5 - random 5,random 5 - random 5,random 5 - random 5,random 1], [random 5 - random 5,random 5 - random 5,random 5 - random 5, random 1]];  
		"colorCorrections" ppEffectCommit 1;	
		"chromAberration" ppEffectEnable true;
		"chromAberration" ppEffectAdjust [0.01,0.01,true]; 
		"chromAberration" ppEffectCommit 1;

		_time = time;
		while {_time+ALR_var_drugUseTime > time} do
		{
			_force = random 10;
			"chromAberration" ppEffectEnable true;
			"chromAberration" ppEffectAdjust [_force / 12, _force / 12, false];
			"chromAberration" ppEffectCommit (0.3 + random 0.1);
			"colorCorrections" ppEffectAdjust [1, 1, 0, [0,0,0,0.5], [random 5 - random 5,random 5 - random 5,random 5 - random 5,random 1], [random 5 - random 5,random 5 - random 5,random 5 - random 5, random 1]]; 
			waituntil {ppEffectCommitted "chromAberration"};
			sleep 0.2;
			"chromAberration" ppEffectAdjust [_force / -24,_force / -24, true];
			"chromAberration" ppEffectCommit (0.6 + random 0.2);
			waituntil {ppEffectCommitted "chromAberration"};
			sleep 0.2;
			"chromAberration" ppEffectAdjust [0,0, true];
			"chromAberration" ppEffectCommit (1.2 + random 0.4);
		};
		
		
		cutText ["","WHITE IN", 0.1];
		"radialBlur" ppEffectEnable false;
		"radialBlur" ppEffectCommit 5;
		
		"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5,0.5,0.5,0], [0.5,0.5,0.5,0], [0.5,0.5,0.5,0]]; 
		"colorCorrections" ppEffectCommit 10;
		waitUntil {ppEffectCommitted "colorCorrections"}; 
		"colorCorrections" ppEffectEnable false;
		"chromAberration" ppEffectEnable false;
		
		[_class, -(_amount)] call RPP_fnc_addInventoryItem;
}
else
{
    localize "STRS_not_a_drug" call RPP_fnc_hint;
};

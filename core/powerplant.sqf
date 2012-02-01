_types = ["Land_PowLines_WoodL", "Land_PowLines_ConcL", "Land_lampa_ind_zebr", "Land_lampa_sidl_3", "Land_lampa_vysoka", "Land_lampa_ind", "Land_lampa_ind_b", "MAP_trafostanica_velka", "Land_lampa_sidl", "MAP_lampa_sidl"];
_location = ["powercoverage", "powercoverage1", "powercoverage2", "powercoverage3", "powercoverage4", "powercoverage5", "powercoverage6", "powercoverage7", "powercoverage8", "powercoverage9"]; 

while {true} do

{

waituntil{!alive power1 and !alive power2};

hint "The reactors at the Cicada Power Plant have been destroyed, it'll be a dark night!";

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do

{

_lamps = getmarkerpos _x nearObjects [_types select _i, 4000] forEach _location;
Sleep 1;
{_x switchLight "OFF";} forEach _lamps;

};

waituntil{alive power1 and alive power2};

hint "The Cicada power plant has been repaired and power has been restored!";

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do

{

_lamps = getmarkerpos _x nearObjects [_types select _i, 4000] forEach _location;
Sleep 1;
{_x switchLight "ON";} forEach _lamps;

};

};
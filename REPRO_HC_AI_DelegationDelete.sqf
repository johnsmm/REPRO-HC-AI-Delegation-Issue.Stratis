_group = _this;

//--- Delete this group's unit from this hc
[[_group, local _group, count units _group], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Removing HC units from group [%1], is local -> [%2], units count -> [%3]", _this select 0, _this select 1, _this select 2]}] remoteExec ["call", -2];
diag_log format ["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Removing HC units from group [%1], is local -> [%2], units count -> [%3]", _group, local _group, count units _group];

[[_group, local _group, count units _group, groupOwner _group], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) About to remove units from group [%1], group is local -> [%2], units left -> [%3], owner -> [%4]", _this select 0, _this select 1, _this select 2, _this select 3]}] remoteExec ["call", -2];
diag_log format ["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) About to remove units from group [%1], group is local -> [%2], units left -> [%3]", _group, local _group, count units _group, groupOwner _group];

{
	[[_x, _group, local _x], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Removing unit [%1] from group [%2] via deleteVehicle, unit is local -> [%3]", _this select 0, _this select 1, _this select 2]}] remoteExec ["call", -2];
	diag_log format ["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Removing unit [%1] from group [%2] via deleteVehicle, unit is local -> [%3]", _x, _group, local _x];
	deleteVehicle _x;
	[[_group, _x], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Checking for unit removal in group [%1], result is [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
	diag_log format ["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Checking for unit removal in group [%1], result is [%2]", _group, _x];
} forEach units _group;

//--- Remove the group from this hc
[[_group, count units _group], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) About to remove group [%1] via deleteGroup, units left -> [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
diag_log format ["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) About to remove group [%1] via deleteGroup, units left -> [%2]", _group, count units _group];

deleteGroup _group;

[_group, {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Checking for group removal [%1]", _this]}] remoteExec ["call", -2];
diag_log format ["REPRO(Headless Client:REPRO_HC_AI_DelegationDelete.sqf) Checking for group removal [%1]", _group];

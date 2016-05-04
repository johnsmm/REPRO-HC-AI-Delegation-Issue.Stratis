/*
	AI Delegation, the group is created on the server before being delegated to the HC 
	which will populate it with AIs
*/

//--- The origin (the player)
_origin = _this;

//--- Make sure that we have HCs
if (count REPRO_HC_LIST > 0) then {
	_group = createGroup resistance;
	
	[_group, {player sideChat format["(Server:REPRO_SRV_AI_DelegationCreate.sqf) Created group [%1] for HC Delegation", _this]}] remoteExec ["call", -2];
	diag_log format["(Server:REPRO_SRV_AI_DelegationCreate.sqf) Created group [%1] for HC Delegation", _group];
	
	//--- Pick a random HC from our list
	_hc = REPRO_HC_LIST select floor(random count REPRO_HC_LIST);
	
	_hc_id = _hc select 0;
	_hc_object = _hc select 1;
	
	[[_hc_object, _hc_id], {player sideChat format["(Server:REPRO_SRV_AI_DelegationCreate.sqf) Picked HC [%1] with id [%2]", _this select 0, _this select 1]}] remoteExec ["call", -2];
	diag_log format["(Server:REPRO_SRV_AI_DelegationCreate.sqf) Picked HC [%1] with id [%2]", _hc_object, _hc_id];
	
	//--- Trigger the AI Creation on the HC now
	[_group, _hc_id, _hc_object, _origin] remoteExec ["REPRO_HC_AI_DelegationDoCreate", _hc_id];
	
} else { //--- No HCs, warn our clients
	[time, {player sideChat format["(Server:REPRO_SRV_AI_DelegationCreate.sqf) There are no HCs present at time: [%1]", _this]}] remoteExec ["call", -2];
	diag_log format["(Server:REPRO_SRV_AI_DelegationCreate.sqf) There are no HCs present at time: [%1]", time];
};

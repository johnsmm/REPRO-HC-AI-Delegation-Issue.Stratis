_group = _this select 0;
_hc_id = _this select 1;
_hc_object = _this select 2;
_origin = _this select 3;

[[_hc_object, _hc_id, _group]], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDoCreate.sqf) HC [%1] with id [%2] is about to create units for group [%3]", _this select 0, _this select 1, _this select 2]}] remoteExec ["call", -2];
diag_log format["REPRO(Headless Client:REPRO_HC_AI_DelegationDoCreate.sqf) HC [%1] with id [%2] is about to create units for group [%3]", _hc_object, _hc_id, _group];

//--- Units array
_units_array = ["I_Soldier_SL_F", "I_soldier_F", "I_soldier_F", "I_Soldier_AR_F", "I_Soldier_LAT_F", "I_Soldier_GL_F", "I_medic_F"];

//--- Spawn the units in front of the player
_distance_player = 10;
_origin_position = _origin modelToWorld [0, _distance_player, 0];

{
	_unit = _group createUnit [_x, _origin_position, [], 0, "FORM"];
	diag_log format["REPRO(Headless Client:REPRO_HC_AI_DelegationDoCreate.sqf) HC [%1] with id [%2] has created AI unit [%3] in group [%4]", _hc_object, _hc_id, _unit, _group];
} forEach _units_array;

//--- Notify
diag_log format["REPRO(Headless Client:REPRO_HC_AI_DelegationDoCreate.sqf) HC [%1] with id [%2] has created [%3] units in group [%4]", _hc_object, _hc_id, count units _group, _group];
[[_hc_object, _hc_id, count units _group, _group]], {player sideChat format["REPRO(Headless Client:REPRO_HC_AI_DelegationDoCreate.sqf) HC [%1] with id [%2] has created [%3] units in group [%4]", _this select 0, _this select 1, _this select 2, _this select 3]}] remoteExec ["call", -2];

//--- Append this group to the global arrays
if (isNil 'REPRO_HC_GROUPS') then {REPRO_HC_GROUPS = []};
if (isNil 'REPRO_HC_GROUP_LAST') then {REPRO_HC_GROUP_LAST = []};

//--- Broadcast for server awareness
REPRO_HC_GROUP_LAST = _group;
publicVariable "REPRO_HC_GROUP_LAST";

REPRO_HC_GROUPS pushBack _group;
publicVariable "REPRO_HC_GROUPS";
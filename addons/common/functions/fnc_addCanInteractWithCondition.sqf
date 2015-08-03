/*
 * Author: commy2
 *
 * Add a condition that gets checked by ace_common_fnc_canInteractWith.
 *
 * Arguments:
 * 0: The conditions id. Used to remove later or as exception name. An already existing name overwrites. (String)
 * 1: The condition to check. format of "_this" is "[_player, _target]". (Code)
 *
 * Return Value:
 * Unit can interact?
 *
 */
#include "script_component.hpp"

private ["_conditionName", "_conditionFunc"];
//IGNORE_PRIVATE_WARNING("_player", "_target");

params ["_conditionName", "_conditionFunc"];
_conditionName = toLower _conditionName;

private ["_conditions", "_conditionNames", "_conditionFuncs"];

_conditions = missionNamespace getVariable [QGVAR(InteractionConditions), [[],[]]];

_conditionNames = _conditions select 0;
_conditionFuncs = _conditions select 1;

private "_index";
_index = _conditionNames find _conditionName;

if (_index == -1) then {
    _index = count _conditionNames;
};

_conditionNames set [_index, _conditionName];
_conditionFuncs set [_index, _conditionFunc];

GVAR(InteractionConditions) = [_conditionNames, _conditionFuncs];

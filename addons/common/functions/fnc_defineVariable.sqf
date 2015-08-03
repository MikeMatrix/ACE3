/**
 * fn_defineVariable.sqf
 * @Descr: Define a variable for the ACE variable framework
 * @Author: Glowbal
 *
 * @Arguments: [name STRING, defaultValue ANY, publicFlag BOOL, category STRING, type NUMBER, persistentFlag BOOL]
 * @Return:
 * @PublicAPI: true
 */
#include "script_component.hpp"

private ["_code","_persistent"];

// If not enough parameters are given, exit early.
if (count _this < 3) exitWith {};
params ["_name", "_value", "_defaultGlobal", "_category", ["_code", 0], ["_persistent", false]];

if (typeName _name != typeName "") exitwith {
    [format["Tried to the deinfe a variable with an invalid name: %1 Arguments: %2", _name, _this]] call FUNC(debug);
};

if (isnil QGVAR(OBJECT_VARIABLES_STORAGE)) then {
    GVAR(OBJECT_VARIABLES_STORAGE) = [];
};

GVAR(OBJECT_VARIABLES_STORAGE) pushback [_name,_value,_defaultGlobal,_category,_code, _persistent];

missionNamespace setvariable [QGVAR(OBJECT_VARIABLES_STORAGE_) + _name, [_name,_value,_defaultGlobal,_category,_code, _persistent]];


//XEH_clientInit.sqf
#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Install the render EH on the main display
addMissionEventHandler ["Draw3D", DFUNC(render)];

// This spawn is probably worth keeping, as pfh don't work natively on the briefing screen and IDK how reliable the hack we implemented for them is.
// The thread dies as soon as the mission start, so it's not really compiting for scheduler space.
[] spawn {
    // Wait until the map display is detected
    waitUntil {(!isNull findDisplay 12)};

    // Install the render EH on the map screen
    ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", DFUNC(render)];
};


["ACE3", QGVAR(InteractKey), (localize "STR_ACE_Interact_Menu_InteractKey"),
{[0] call FUNC(keyDown)},
{[0] call FUNC(keyUp)},
[219, [false, false, false]], false] call cba_fnc_addKeybind;  //Left Windows Key

["ACE3", QGVAR(SelfInteractKey), (localize "STR_ACE_Interact_Menu_SelfInteractKey"),
{[1] call FUNC(keyDown)},
{[1] call FUNC(keyUp)},
[219, [false, true, false]], false] call cba_fnc_addKeybind; //Left Windows Key + Ctrl/Strg
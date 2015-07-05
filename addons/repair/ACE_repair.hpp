class ACE_Repair {
	class Actions {
		class ReplaceWheel {
                  displayName = CSTRING(ReplaceWheel);
                  displayNameProgress = CSTRING(ReplacingWheel);

                  locations[] = {"All"};
                  requiredEngineer = 0;
                  repairingTime = 5;
                  repairingTimeSelfCoef = 1;
                  items[] = {};
                  condition = "";
                  itemConsumed = 0;

                  callbackSuccess = QUOTE(DFUNC(repairBasic_bandage));
                  callbackFailure = "";
                  callbackProgress = "";

                  animationCaller = "AinvPknlMstpSlayWrflDnon_medicOther";
                  animationCallerProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
                  animationCallerSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
                  animationCallerSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
                  litter[] = {};
		};
            class RemoveWheel: ReplaceWheel {

            };
            class RepairEngine {

            };
		class Tracks: ReplaceWheel {

		};
		class MiscRepair: ReplaceWheel {
                  displayName = ""; // let's make empty string an auto generated string
                  displayNameProgress = CSTRING(Repairing);
		};
	};
};
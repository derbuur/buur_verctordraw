/*
This short script draws an arrow on the map while pressing the lef alt key. It also give distance and Angel.
No needs for input Variables.
Written by buur (derbuur@googlemail.com)

*/

if (!hasInterface) exitWith {};

findDisplay 12 displayaddEventHandler ["MouseButtonDown",
		{if (_this select 6) then
			{
					private ["_id_MouseMoving","_id_Draw"];
					player setVariable ["buur_vectordraw_myStartCoordinates",((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld [(_this select 2), (_this select 3)]];
					player setVariable ["buur_vectordraw_myActualCoordinates",(player getVariable "buur_vectordraw_myStartCoordinates")];


					_id_MouseMoving = ((findDisplay 12) displayCtrl 51) ctrladdEventHandler
						["MouseMoving",
							{player setVariable ["buur_vectordraw_myActualCoordinates", ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld [(_this select 1),(_this select 2)]];
							private ["_meters","_azimuth"];
							_meters = round ((player getVariable "buur_vectordraw_myActualCoordinates") distance2D (player getVariable "buur_vectordraw_myStartCoordinates"));
							_azimuth = round ((player getVariable "buur_vectordraw_myStartCoordinates") getDir (player getVariable "buur_vectordraw_myActualCoordinates"));
							hintSilent format ["Distance: %1, Direction: %2",_meters,_azimuth];
							}
						];

					_id_Draw = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",
						{
							_this select 0 drawArrow
							[
								(player getVariable "buur_vectordraw_myStartCoordinates"), (player getVariable "buur_vectordraw_myActualCoordinates"), [1,0,0,1]
							];
						}
					];

					player setVariable ["buur_vectordraw_id_MouseMoving",_id_MouseMoving];
					player setVariable ["buur_vectordraw_id_Draw",_id_Draw];
			}
		}
	];

findDisplay 12 displayaddEventHandler
	["MouseButtonUp",
		{if (isnil str (player getVariable "buur_vectordraw_myStartCoordinates")) then
			{
				private ["_id_MouseMoving","_id_Draw"];
				_id_MouseMoving = player getVariable "buur_vectordraw_id_MouseMoving";
				_id_Draw = player getVariable "buur_vectordraw_id_Draw";

				((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw",_id_Draw];
				((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["MouseMoving",_id_MouseMoving];
				player setVariable ["buur_vectordraw_myStartCoordinates",nil];
				player setVariable ["buur_vectordraw_myActualCoordinates",nil];
			};
		}
	];

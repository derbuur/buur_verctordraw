/*
This short script draws an arrow on the map while pressing the shift key. It also give distance and Angel.
No needs for input Variables.
Written by buur (derbuur@googlemail.com)

*/
findDisplay 12 displayaddEventHandler ["MouseButtonDown",
	{if (_this select 6) then
		{
		myStartCoordinates = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld [(_this select 2), (_this select 3)];
		myActualCoordinates = myStartCoordinates;
		myDistance = 0;
			((findDisplay 12) displayCtrl 51) ctrladdEventHandler ["MouseMoving",
				{myActualCoordinates = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld [(_this select 1),(_this select 2)];
				_meters = round (myActualCoordinates distance2D myStartCoordinates);
				_azimuth = round (myStartCoordinates getDir myActualCoordinates);
				hintSilent format ["Distance: %1, Direction: %2",_meters,_azimuth];
				}
				];
			findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",
				{
				_this select 0 drawArrow [
				myStartCoordinates, myActualCoordinates, [1,0,0,1]
				];
				}];
		}
	}
	];
findDisplay 12 displayaddEventHandler ["MouseButtonUp",
	{if (!isnil "myDistance") then
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
			((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "MouseMoving";
			missionNamespace setVariable ["myActualCoordinates", nil];
			missionNamespace setVariable ["myStartCoordinates", nil];
		};
	}];

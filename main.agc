
// Project: Temple00 
// Created: 2017-05-22
#include "ImageManager.agc"
#include "PlayerManager.agc"
#include "TankManager.agc"
#include "MapSystem.agc"
#include "System.agc"
// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "Temple00" )
SetWindowSize( 1024, 768, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 1024, 768 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 60, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

SetPrintSize(20)

InitGame()
//SetRawMouseVisible(0)
SetPhysicsDebugOn()

do	
	print(IsTankInMap(player))
	Print(player.spd)
	Print(str(player.spd*sin(player.angle))+"," +str(player.spd*cos(player.angle)))
	Print( ScreenToWorldX(GetPointerX()))
	Print( ScreenToWorldY(GetPointerY()))
	Print(ScreenFPS())
	InGame()
	

	Print(str(player.xp)+","+str(player.yp))
	Print(str(player.bullet[1].xp)+","+str(player.bullet[1].yp))
	//print(player.rate * player.bullet.spd)
    Sync()
    if GetRawKeyPressed(27)
		end
	endif
loop

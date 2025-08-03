' ### introducing to user-defined types ###
' ### a program with window with double buffering in fullscreen mode and scaling ###

' force the SuperStrict mode
SuperStrict

' include the user-defined type TScreen from file
Include "TScreen.bmx"

' a variable to store the reference of the loaded image
Global imgSpaceShip:TImage

' x&y position of the space-ship
Global spaceShipX:Int
Global spaceShipY:Int

TScreen.Init(320, 256)

' load the image
imgSpaceShip = LoadImage("images/spaceship.png")

' some values about the desktop resolution
Print("desktop-width:" + DesktopWidth())
Print("desktop-height:" + DesktopHeight())
Print("desktop-depth:" + DesktopDepth())
Print("desktop-hertz:" + DesktopHertz())

' initialize the space ship position
spaceShipX = 100
spaceShipY = 100

' set the clear color to dark blue
SetClsColor(0, 0, 50)
' our simple game loop
Repeat
	TScreen.Clear()
	TScreen.SetScaling()
	TScreen.Draw()
	
	' draw the spaceship with the calculated scaling
	' we must multiply the coordinates with the scaling factor as well
	' and add the offsetX & offsetY values for centering
	DrawImage(imgSpaceShip, ..
			  TScreen.offsetX + spaceShipX * TScreen.scaleFactor, ..
			  TScreen.offsetY + spaceShipY * TScreen.scaleFactor)
	
	TScreen.Reset()
	
	' make backbuffer visible
	Flip
Until KeyDown(KEY_ESCAPE)
End

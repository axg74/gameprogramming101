' a program with window and double buffering in fullscreen mode
SuperStrict

Global imgSpaceShip:TImage
Global spaceShipX:Int
Global spaceShipY:Int

Graphics DesktopWidth(), DesktopHeight(), DesktopDepth(), DesktopHertz()

imgSpaceShip = LoadImage("images/spaceship.png")

Print(DesktopWidth())
Print(DesktopHeight())
Print(DesktopDepth())
Print(DesktopHertz())

spaceShipX = 100
spaceShipY = 100

Repeat
	DrawImage(imgSpaceShip, spaceShipX, spaceShipY)
	
	Flip
Until KeyDown(KEY_ESCAPE)
End

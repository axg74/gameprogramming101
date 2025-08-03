' ### a program with window with double buffering in fullscreen mode and scaling ###

' force the SuperStrict mode
SuperStrict

' the native game resolution as constants
Const GAME_WIDTH:Int = 320
Const GAME_HEIGHT:Int = 256

' a variable to store the reference of the loaded image
Global imgSpaceShip:TImage

' x&y position of the space-ship
Global spaceShipX:Int
Global spaceShipY:Int

' scale factor for the game graphics scaling
Global scaleFactor:Int

' variables to store the positioning offset for X&Y
Global offsetX:Int
Global offsetY:Int

' variables to store the desktop-resolution
Global deskWidth:Int
Global deskHeight:Int

' create a game window in fullscreen mode
deskWidth = DesktopWidth()
deskHeight = DesktopHeight()
Graphics deskWidth, deskHeight, DesktopDepth(), DesktopHertz()

' important for a pixel-art game, crispy pixels! no blurry images
AutoImageFlags MASKEDIMAGE

' load the image
imgSpaceShip = LoadImage("images/spaceship.png")

' some values about the desktop resolution
Print("desktop-width:" + DesktopWidth())
Print("desktop-height:" + DesktopHeight())
Print("desktop-depth:" + DesktopDepth())
Print("desktop-hertz:" + DesktopHertz())

' calculating the game scale factor: desktop-height divided by game-height
scaleFactor = DesktopHeight() / GAME_HEIGHT
Print("scale factor: " + scaleFactor)

' calculating the X/Y offset values for centering
offsetX = (DesktopWidth() - (GAME_WIDTH * scaleFactor)) / 2;
Print("offsetX:" + offsetX)
offsetY = (DesktopHeight() - (GAME_HEIGHT * scaleFactor)) / 2;
Print("offsetY:" + offsetY)

' initialize the space ship position
spaceShipX = 100
spaceShipY = 100

' set the clear color to dark blue
SetClsColor(0, 0, 50)

' our simple game loop
Repeat
	' clear the entired screen
	SetViewport(0, 0, deskWidth, deskHeight)
	Cls()

	' set the viewport to the game resultion and centered
	SetViewport(offsetX, offsetY, GAME_WIDTH * scaleFactor, GAME_HEIGHT * scaleFactor)
	
	' set the scaling for all drawing operations
	SetScale (scaleFactor, scaleFactor)
	
	' draw the game-area with a dark green background
	SetColor(0, 50, 0)
	DrawRect(offsetX, offsetY, GAME_WIDTH, GAME_HEIGHT)
		
	' set the drawing color to white again, so that further drawing operation don´t tint any graphics
	SetColor(255, 255, 255)

	' draw the spaceship with the calculated scaling
	' we must multiply the coordinates with the scaling factor as well
	' and add the offsetX & offsetY values for centering
	DrawImage(imgSpaceShip, ..
			  offsetX + spaceShipX * scaleFactor, ..
			  offsetY + spaceShipY * scaleFactor)
	
	' reset scaling
	SetScale(1, 1)
	
	' make backbuffer visible
	Flip
Until KeyDown(KEY_ESCAPE)
End

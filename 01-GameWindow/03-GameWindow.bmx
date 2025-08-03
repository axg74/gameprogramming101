' ### a program with window and double buffering in fullscreen mode and scaling ###

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

' create a game window in fullscreen mode
Graphics DesktopWidth(), DesktopHeight(), DesktopDepth(), DesktopHertz()

' important for a pixel-art game, crispy pixels! no blurry images
AutoImageFlags MASKEDIMAGE

' load the image
imgSpaceShip = LoadImage("images/spaceship.png")

' some values about the desktop resolution
Print(DesktopWidth())
Print(DesktopHeight())
Print(DesktopDepth())
Print(DesktopHertz())

' calculating the game scale factor: desktop-height divided by game-height
scaleFactor = DesktopHeight() / GAME_HEIGHT
Print(scaleFactor)

' initialize the space ship position
spaceShipX = GAME_WIDTH / 2
spaceShipY = GAME_HEIGHT / 2

' set the clear color to dark blue
SetClsColor(0, 0, 50)

' our simple game loop
Repeat
	' clear the entired screen
	Cls
	
	' set the scaling for all drawing operations
	SetScale (scaleFactor, scaleFactor)
	
	' draw the game-area with a dark green background
	SetColor(0, 50, 0)
	DrawRect(0, 0, GAME_WIDTH, GAME_HEIGHT)
	
	' set the drawing color to white again, so that further drawing operation don´t tint any graphics
	SetColor(255, 255, 255)

	' draw the spaceship with the calculated scaling
	' we must multiply the coordinates with the scaling factor as well	
	DrawImage(imgSpaceShip, spaceShipX * scaleFactor, spaceShipY * scaleFactor)
	
	' reset scaling
	SetScale(1, 1)
	
	' make backbuffer visible
	Flip
Until KeyDown(KEY_ESCAPE)
End

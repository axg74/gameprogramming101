' ### introducing to user-defined types ###
' ### a program with window with double buffering in fullscreen mode and scaling ###

' force the SuperStrict mode
SuperStrict

Type TScreen
	' the native game resolution
	Global width:Int
	Global height:Int	

	' scale factor for the game graphics scaling
	Global scaleFactor:Int
	
	' variables to store the positioning offset for X&Y
	Global offsetX:Int
	Global offsetY:Int
	
	' variables to store the desktop-resolution
	Global deskWidth:Int
	Global deskHeight:Int
	
	Function Init(gameWidth:Int, gameHeight:Int)
		width = gameWidth
		height = gameHeight
		deskWidth = DesktopWidth()
		deskHeight = DesktopHeight()

		' calculating the game scale factor: desktop-height divided by game-height
		scaleFactor = DesktopHeight() / gameHeight
		Print("scale factor: " + scaleFactor)
		
		' calculating the X/Y offset values for centering
		offsetX = (DesktopWidth() - (width * scaleFactor)) / 2;
		Print("offsetX:" + offsetX)
		offsetY = (DesktopHeight() - (height * scaleFactor)) / 2;
		Print("offsetY:" + offsetY)

		' create a game window in fullscreen mode
		Graphics deskWidth, deskHeight, DesktopDepth(), DesktopHertz()
		
		' important for a pixel-art game, crispy pixels! no blurry images
		AutoImageFlags MASKEDIMAGE
	EndFunction
	
	Function Clear()
		' clear the entired screen
		SetViewport(0, 0, deskWidth, deskHeight)
		Cls()
		
		' set the viewport to the game resultion and centered
		SetViewport(offsetX, offsetY, width * scaleFactor, height * scaleFactor)
	EndFunction
	
	Function SetScaling()
		' set the scaling for all drawing operations
		SetScale (scaleFactor, scaleFactor)
	EndFunction
	
	Function Draw()
		' draw the game-area with a dark green background
		SetColor(0, 50, 0)
		DrawRect(offsetX, offsetY, width, height)
			
		' set the drawing color to white again, so that further drawing operation don´t tint any graphics
		SetColor(255, 255, 255)	
	EndFunction
	
	Function Reset()
		' reset scaling
		SetScale(1, 1)
	EndFunction
EndType

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

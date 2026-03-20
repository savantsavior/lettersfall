# Copyright 2026 TeamJeZxLee.Itch.io
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software
# and associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# "LogicCore.gd"
extends Node2D

var HideCopyright = false

var Version = "1.1.0 - Beta 2 Same Story"

const ChildStoryMode				= 0
const TeenStoryMode					= 2
const AdultStoryMode				= 1
const TurboStoryMode				= 3
const ChildNeverMode				= 4
const TeenNeverMode					= 6
const AdultNeverMode				= 5
const TurboNeverMode				= 7
var GameMode = AdultStoryMode

const Playing				= 1
const FadingTiles			= 2
const ApplyingGravity		= 3
var GameState = Playing

var LevelAdvance = []

var TotalTilesCleared = 0

var SecretCode = []
var SecretCodeCombined = 0

var PAUSEgame = false
var PauseWasJustPressed = false

var Score
var ScoreChanged
var ScoreText

var ScoreAddPointsOnWord

var Level
var LevelText

var TotalClearedTiles
var LevelCleared
var CurrentClearedTiles

var GameWon

var StillPlaying

var Playfield = []

var TileSpriteIndex = []

var FallingTileScreenX
var FallingTileScreenY
var FallingTileX
var FallingTileY
var FallingTileYoffset

var FallingTile

var GameOver

var SelectedTilePlayfieldX = []
var SelectedTilePlayfieldY = []
var SelectedTileIndex

var UndoButtonDelay

var BadEquationRedTimer

var EquationString: String = ""
var ValueToCheck: String = ""
var EquationStringNew = ""

var DrawEverything

var ThereIsAnOperator

var ThereIsAnEqual

var SelectedTilesAlpha = 1.0

var PiecesCanStillFall = false

var BonusScore

var ShownA = false
var ShownE = false
var ShownI = false
var ShownO = false
var ShownU = false
var ShownApostrophe = false
var ShownHyphen = false

var TheEnd

var number = []
var mathOperator = []

var GameQuit

var CurrentHeightOfPlayfield

var CutSceneAlpha
var CutSceneScale
var CutSceneTimer
var CutSceneBlackBackgroundAlpha

var UndoAction = 1

var EnableRightClick = 1

var FramesSinceLastPlayerInput = 0

var WordDictionary = []
var EndOfWordsFile = 0

#---------------------------------------------------------------------------------------
func SetupForNewGame():
	PAUSEgame = false

	GameState = Playing

	TotalTilesCleared = 0

	Score = 0
	Level = 1

	ScoreAddPointsOnWord = 0

	BonusScore = 0

	GameQuit = false

	TotalClearedTiles = 0

	GameWon = false

	for y in range(0, 12):
		for x in range(0, 18):
			Playfield[x][y] = -1

	var allTilesShown = false
	while (allTilesShown == false):
		for y in range(0, 4):
			for x in range(0, 18):
				Playfield[x][y] = ( randi() % (28-2) )

		Playfield[randi() % 12][randi() % 3] = 0
		Playfield[randi() % 12][randi() % 3] = 4
		Playfield[randi() % 12][randi() % 3] = 8
		Playfield[randi() % 12][randi() % 3] = 14
		Playfield[randi() % 12][randi() % 3] = 20

		Playfield[randi() % 12][randi() % 3] = 0
		Playfield[randi() % 12][randi() % 3] = 4
		Playfield[randi() % 12][randi() % 3] = 8
		Playfield[randi() % 12][randi() % 3] = 14
		Playfield[randi() % 12][randi() % 3] = 20

		Playfield[randi() % 12][randi() % 3] = 26
		Playfield[randi() % 12][randi() % 3] = 27

		ShownA = 0
		ShownE = 0
		ShownI = 0
		ShownO = 0
		ShownU = 0
		ShownApostrophe = false
		ShownHyphen = false
		for y in range(0, 12):
			for x in range(0, 18):
				if (Playfield[x][y] == 0):  ShownA+=1
				if (Playfield[x][y] == 4):  ShownE+=1
				if (Playfield[x][y] == 8):  ShownI+=1
				if (Playfield[x][y] == 14):  ShownO+=1
				if (Playfield[x][y] == 20):  ShownU+=1

				if (Playfield[x][y] == 26):  ShownApostrophe = true
				if (Playfield[x][y] == 27):  ShownHyphen = true

		if (ShownA > 1 and ShownE > 1 and ShownI > 1 and ShownO > 1 and ShownU > 1 and ShownApostrophe == true and ShownHyphen == true):
			allTilesShown = true

	FallingTileX = 0
	FallingTileY = 11
	FallingTileScreenX = 99-11-1
	FallingTileScreenY = (500-37+10) - (FallingTileY*50)
	FallingTileYoffset = 0

	FallingTile = ( randi() % (28-2) )

	StillPlaying = true

	GameOver = false

	for index in range(0, 20):
		SelectedTilePlayfieldX[index] = -1
		SelectedTilePlayfieldY[index] = -1

	SelectedTileIndex = 0

	UndoButtonDelay = 0

	BadEquationRedTimer = 0

	EquationString = ""

	DrawEverything = true
	ScoreChanged = true

	ThereIsAnEqual = false

	SelectedTilesAlpha = 1.0

	PiecesCanStillFall = false

	CurrentClearedTiles = 0

	CurrentHeightOfPlayfield = 0

	if (GameMode < 4):
		CutSceneAlpha = 0.0
		CutSceneScale = 1.0
		CutSceneTimer = 0
		CutSceneBlackBackgroundAlpha = 1.0
		
	else:
		CutSceneAlpha = 0.0
		CutSceneScale = 0.0
		CutSceneTimer = 0
		CutSceneBlackBackgroundAlpha = 0.0

	if (LogicCore.SecretCodeCombined == 2776):
		Score = 95788340
		Level = 9
		TotalClearedTiles = 109

	FramesSinceLastPlayerInput = 0

#	print(ShownA, " / ", ShownE, " / ", ShownI, " / ", ShownO, " / ", ShownU)

	pass

#----------------------------------------------------------------------------------------
func SetUpNextFallingTile():
	DrawEverything = true

	GameState = Playing

	PiecesCanStillFall = false

	SelectedTilesAlpha = 1.0

	AudioCore.PlayEffect(3)

	if (FallingTileX < 17):
		FallingTileX+=1
	else:
		FallingTileX = 0

	FallingTileY = 11

	if (Playfield[FallingTileX][FallingTileY-1] > -1):
		StillPlaying = false
		GameOver = true
		AudioCore.PlayEffect(4)
		return

	FallingTileScreenX = 99 - 11 - 1 + (FallingTileX*50)
	FallingTileScreenY = (500-37+11) - (FallingTileY*50)
	FallingTileYoffset = 0

	FallingTile = ( randi() % (28-2) )

	ShownA = 0
	ShownE = 0
	ShownI = 0
	ShownO = 0
	ShownU = 0
	ShownApostrophe = false
	ShownHyphen = false
	for y in range(0, 12):
		for x in range(0, 18):
			if (Playfield[x][y] == 0):  ShownA+=1
			if (Playfield[x][y] == 4):  ShownE+=1
			if (Playfield[x][y] == 8):  ShownI+=1
			if (Playfield[x][y] == 14):  ShownO+=1
			if (Playfield[x][y] == 20):  ShownU+=1

			if (Playfield[x][y] == 26):  ShownApostrophe = true
			if (Playfield[x][y] == 27):  ShownHyphen = true

	if (ShownApostrophe == false):  FallingTile = 26
	elif (ShownHyphen == false):  FallingTile = 27

	elif (ShownA < 1):  FallingTile = 0
	elif (ShownE < 1):  FallingTile = 4
	elif (ShownI < 1):  FallingTile = 8
	elif (ShownO < 1):  FallingTile = 14
	elif (ShownU < 1):  FallingTile = 20

	elif (ShownA < 2):  FallingTile = 0
	elif (ShownE < 2):  FallingTile = 4
	elif (ShownI < 2):  FallingTile = 8
	elif (ShownO < 2):  FallingTile = 14
	elif (ShownU < 2):  FallingTile = 20

	pass

#----------------------------------------------------------------------------------------
func ConvertTilesToString():
	CurrentClearedTiles = 0

	ScoreAddPointsOnWord = 0

	ValueToCheck = ""
	var index = 0
	while (index < 18 and SelectedTilePlayfieldX[index] != -1 and SelectedTilePlayfieldY[index] != -1):
		var selX = SelectedTilePlayfieldX[index]
		var selY = SelectedTilePlayfieldY[index]
		if (Playfield[selX][selY] > -1 and Playfield[selX][selY] < 28):
			CurrentClearedTiles+=1
			var part = Playfield[selX][selY]
			if   (part ==  0):
				ValueToCheck+="a"
				ScoreAddPointsOnWord+=1
			elif (part ==  1):
				ValueToCheck+="b"
				ScoreAddPointsOnWord+=3
			elif (part ==  2):
				ValueToCheck+="c"
				ScoreAddPointsOnWord+=3
			elif (part ==  3):
				ValueToCheck+="d"
				ScoreAddPointsOnWord+=2
			elif (part ==  4):
				ValueToCheck+="e"
				ScoreAddPointsOnWord+=1
			elif (part ==  5):
				ValueToCheck+="f"
				ScoreAddPointsOnWord+=4
			elif (part ==  6):
				ValueToCheck+="g"
				ScoreAddPointsOnWord+=2
			elif (part ==  7):
				ValueToCheck+="h"
				ScoreAddPointsOnWord+=4
			elif (part ==  8):
				ValueToCheck+="i"
				ScoreAddPointsOnWord+=1
			elif (part ==  9):
				ValueToCheck+="j"
				ScoreAddPointsOnWord+=8
			elif (part == 10):
				ValueToCheck+="k"
				ScoreAddPointsOnWord+=5
			elif (part == 11):
				ValueToCheck+="l"
				ScoreAddPointsOnWord+=1
			elif (part == 12):
				ValueToCheck+="m"
				ScoreAddPointsOnWord+=3
			elif (part == 13):
				ValueToCheck+="n"
				ScoreAddPointsOnWord+=1
			elif (part == 14):
				ValueToCheck+="o"
				ScoreAddPointsOnWord+=1
			elif (part == 15):
				ValueToCheck+="p"
				ScoreAddPointsOnWord+=3
			elif (part == 16):
				ValueToCheck+="q"
				ScoreAddPointsOnWord+=10
			elif (part == 17):
				ValueToCheck+="r"
				ScoreAddPointsOnWord+=1
			elif (part == 18):
				ValueToCheck+="s"
				ScoreAddPointsOnWord+=1
			elif (part == 19):
				ValueToCheck+="t"
				ScoreAddPointsOnWord+=1
			elif (part == 20):
				ValueToCheck+="u"
				ScoreAddPointsOnWord+=1
			elif (part == 21):
				ValueToCheck+="v"
				ScoreAddPointsOnWord+=4
			elif (part == 22):
				ValueToCheck+="w"
				ScoreAddPointsOnWord+=4
			elif (part == 23):
				ValueToCheck+="x"
				ScoreAddPointsOnWord+=8
			elif (part == 24):
				ValueToCheck+="y"
				ScoreAddPointsOnWord+=4
			elif (part == 25):
				ValueToCheck+="z"
				ScoreAddPointsOnWord+=10
			elif (part == 26):
				ValueToCheck+="'"
				ScoreAddPointsOnWord+=5
			elif (part == 27):
				ValueToCheck+="-"
				ScoreAddPointsOnWord+=10

		index+=1
		
	pass

#----------------------------------------------------------------------------------------
func CheckEquationNewPerfect():
	ConvertTilesToString()

	for index in range(0, EndOfWordsFile):
		if (WordDictionary[index] == ValueToCheck):
			Score+=( (ScoreAddPointsOnWord*SelectedTileIndex) + (100*Level) )
			ScoreChanged = true

			TotalClearedTiles+=SelectedTileIndex
			if (SecretCodeCombined == 1111):  TotalClearedTiles = ( LevelAdvance[GameMode] + 1)

			if ( TotalClearedTiles > ( LevelAdvance[GameMode]) ):
				AudioCore.PlayEffect(8)
				TotalClearedTiles = 0
				LevelAdvance[GameMode]+=10
				Level+=1

				if (GameMode < 4):
					CutSceneAlpha = 0.0
					CutSceneScale = 2.0
					CutSceneTimer = 0

					if (Level == 4):  AudioCore.PlayMusic(2, true)
					elif (Level == 6):  AudioCore.PlayMusic(3, true)
					elif (Level == 8):  AudioCore.PlayMusic(4, true)
					elif (Level == 9):  AudioCore.PlayMusic(5, true)

					if (Level == 10):
						StillPlaying = false
						GameWon = true
					else:
						ScreensCore.ScreenFadeStatus = ScreensCore.FadingToBlack
				else:
					CutSceneAlpha = 0.0
					CutSceneScale = 0.0
					CutSceneTimer = 0

			return(true)

	return(false)

#----------------------------------------------------------------------------------------
func RunGameplayCore():
	if (GameMode > 3):
		if (AudioCore.MusicPlayer.playing == false):
			var index = randi_range(1, 6)
			while (index == AudioCore.MusicCurrentlyPlaying):
				index = randi_range(1, 6)

			AudioCore.PlayMusic(index, false)

	if (GameState == FadingTiles):
		DrawEverything = true

		BonusScore = 0

		SelectedTilesAlpha-=0.1
		if (SelectedTilesAlpha < 0.0):
			SelectedTilesAlpha = 0.0
			GameState = ApplyingGravity

			for index in range(20):
				for y in range(12):
					for x in range(18):
						if (Playfield[x][y] > -1):
							if (SelectedTilePlayfieldX[index] == x and SelectedTilePlayfieldY[index] == y):
								Playfield[x][y] = -1
								index+=1

			for index in range(20):
				SelectedTilePlayfieldX[index] = -1
				SelectedTilePlayfieldY[index] = -1

			SelectedTileIndex = 0

			ThereIsAnEqual = false
	elif (GameState == ApplyingGravity):
		DrawEverything = true

		SelectedTilesAlpha = 1.0

		for y in range(11):
			for x in range(18):
				if (Playfield[x][y] == -1 and Playfield[x][y+1] > -1):
					for yTwo in range(y+1, 11):
						Playfield[x][yTwo-1] = Playfield[x][yTwo]
					
					Playfield[x][7] = -1

		PiecesCanStillFall = false
		for y in range(11):
			for x in range(18):
				if (Playfield[x][y] == -1 and Playfield[x][y+1] > -1):
					PiecesCanStillFall = true

		if (PiecesCanStillFall == false):
			GameState = Playing
			DrawEverything = true
	elif (GameState == Playing):
		CurrentHeightOfPlayfield = 0
		for y in range(12):
			for x in range(18):
				if (LogicCore.Playfield[x][y] > -1):
					if (y > CurrentHeightOfPlayfield):
						CurrentHeightOfPlayfield = y

		var allowTileSelection = false
		var xPos = -1
		var yPos = -1

		if (Level < 10):
			FallingTileYoffset+=(2+Level)

		if (CurrentHeightOfPlayfield < 5):
			FallingTileYoffset+=35
			FramesSinceLastPlayerInput = 0

		if (FramesSinceLastPlayerInput > 500):  FallingTileYoffset+=35

		if (FallingTileYoffset > 50):
			FallingTileYoffset = 0
			FallingTileScreenY+=50
			FallingTileY-=1

			if (FallingTileY == 0):
				Playfield[FallingTileX][FallingTileY] = FallingTile
				SetUpNextFallingTile()
			elif (Playfield[FallingTileX][FallingTileY-1] > -1):
				Playfield[FallingTileX][FallingTileY] = FallingTile
				SetUpNextFallingTile()

		if (InputCore.MouseButtonLeftPressed == true and CutSceneScale == 0.0 and InputCore.DelayAllUserInput == -1):
			var screenY = 500-37+11
			var screenX = 99-11
			for y in range(12):
				for x in range(18):
					if (Playfield[x][y] > -1):
						DrawEverything = true

						if (SelectedTileIndex < 16):
							var mY = InputCore.MouseScreenY
							var mX = InputCore.MouseScreenX
							if ( mY > (screenY - 25) and mY < (screenY + 25) and mX > (screenX - 25) and mX < (screenX + 25) ):
								xPos = x
								yPos = y
								var selected = false
								for index in range(0, 18):
									if (SelectedTilePlayfieldX[index] == x and SelectedTilePlayfieldY[index] == y):
										selected = true

								if (selected == false):
									if (SelectedTileIndex == 0):
											allowTileSelection = true
									elif (SelectedTileIndex > 0):
										allowTileSelection = true

					screenX+=50

				screenX = 99-11
				screenY-=50

		if (allowTileSelection == true):
			SelectedTilePlayfieldX[SelectedTileIndex] = xPos
			SelectedTilePlayfieldY[SelectedTileIndex] = yPos
			SelectedTileIndex+=1
#			ConvertTilesToString()
			AudioCore.PlayEffect(0)
			FramesSinceLastPlayerInput = 0

			DrawEverything = true

		FramesSinceLastPlayerInput+=1

	pass

#----------------------------------------------------------------------------------------
func LoadDictionary():
	var file = FileAccess.open("res://media/Dictionary/words.txt", FileAccess.READ)
	assert(file != null, "Failed to open word list")

	WordDictionary.resize(500000)

	var idx := 0
	while not file.eof_reached():
		WordDictionary[idx] = file.get_line()
		idx += 1
		EndOfWordsFile = idx

	var success := WordDictionary.resize(idx+1)
	assert(success == OK, "Failed to resize by trim")

	pass

#----------------------------------------------------------------------------------------
func _ready():
	SecretCode.append(0)
	SecretCode.append(0)
	SecretCode.append(0)
	SecretCode.append(0)

	LogicCore.SecretCodeCombined = 0000

	LevelAdvance.resize(8)
	LevelAdvance[ChildStoryMode] = 7
	LevelAdvance[TeenStoryMode]  = (7 * 3)
	LevelAdvance[AdultStoryMode] = (7 * 2)
	LevelAdvance[TurboStoryMode] = (7 * 4)
	LevelAdvance[ChildNeverMode] = 7
	LevelAdvance[TeenNeverMode]  = (7 * 3)
	LevelAdvance[AdultNeverMode] = (7 * 2)
	LevelAdvance[TurboNeverMode] = (7 * 4)

	Playfield.resize(18)
	for x in range(18):
		Playfield[x] = []
		Playfield[x].resize(12)
		for y in range(12):
			Playfield[x][y] = []

	TileSpriteIndex.resize(28)

	Score = 0
	Level = 0

	SelectedTilePlayfieldX.resize(20)
	SelectedTilePlayfieldY.resize(20)

	SelectedTileIndex = 0

	UndoButtonDelay = 0

	BadEquationRedTimer = 0

	EquationString = ""

	DrawEverything = true
	ScoreChanged = true
	ThereIsAnEqual = false

	GameState = Playing

	SelectedTilesAlpha = 1.0

	PiecesCanStillFall = false

	number.resize(16)
	mathOperator.resize(16)

	LoadDictionary()

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	pass

# Copyright 2026 "TeamJeZxLee.itch.io"
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
#
# ------------------------------------------------------------------------------
#                    Cross-Platform / M.I.T. Open-Source
#      "Grand National GNX" v4 Godot Engine 4.8+ 2D Video Game Framework
# ------------------------------------------------------------------------------
#                                               TM
#                            "Learn To Have Fun!"
# .____           __    __                      ___________      .__  .__ TM
# |    |    _____/  |__/  |_  ___________  _____\_   _____/____  |  | |  |  
# |    |  _/ __ \   __\   __\/ __ \_  __ \/  ___/|    __) \__  \ |  | |  |  
# |    |__\  ___/|  |  |  | \  ___/|  | \/\___ \ |     \   / __ \|  |_|  |__
# |_______ \___  >__|  |__|  \___  >__|  /____  >\___  /  (____  /____/____/
#         \/   \/                \/           \/     \/        \/   110%
#                                               TM
#                              "LettersFall 110%"
#
#                            Version 1.1.1 - Retail 2
#
#                            Linux Flatpak On Flathub
#                 HTML5 Enabled Desktop/Laptop Internet Browsers
#
#                     (C)opyright 2026 - TeamJeZxLee.itch.io
# ------------------------------------------------------------------------------------------------
extends Node2D

#----------------------------------------------------------------------------------------
func _ready():
	VisualsCore.SetFramesPerSecond(30)

	if (ScreensCore.OperatingSys == ScreensCore.OSHTMLFive):  VisualsCore.FullScreenMode = 0

	#LogicCore.SecretCode[0] = 5
	#LogicCore.SecretCode[1] = 4
	#LogicCore.SecretCode[2] = 3
	#LogicCore.SecretCode[3] = 1
	#LogicCore.SecretCodeCombined = 5431

	DataCore.LoadOptionsAndHighScores()

	VisualsCore.SetScreenStretchMode()

	VisualsCore.SetFullScreenMode()

	randomize()

	pass

#----------------------------------------------------------------------------------------
func _process(_delta):

	ScreensCore.ProcessScreenToDisplay()

	VisualsCore.DrawSprite(100000, InputCore.MouseScreenX+25, InputCore.MouseScreenY+25, 999, 1.0, 1.0, 0, 1.0, 1.0, 1.0, 1.0)

	pass

# A 110% By "TeamJeZxLee.itch.io" !

# Import file "gitGumblePrototype"
s = Framer.Importer.load("imported/gitGumblePrototype@1x")
# Firebase Setup
{Firebase} = require 'firebase'
firebase = new Firebase "https://simpleframerdemo.firebaseio.com/"
firebase.projectID = "git-gumble"
firebase.secret = "gWGWJ6VXV8Ck0zTxYYsrrFqOHEaRqQkJ9qBDfPDX"
firebase.debug = true


Framer.Extras.Preloader.enable()

defaultW = 640
defaultH = 1136

ratio = Screen.width / defaultW

Framer.Defaults.Layer.force2d = true

all = new Layer
	width: defaultW
	height: defaultH
	scale: ratio
	originY: 0 
	y: 0
	
all.centerX()

# Flow component

flow = new FlowComponent
	backgroundColor: "#FCFFEE"
	parent.all 
	width: all.width
	height: all.height
	
flow.showNext(s.GitGumbleLogin)

# Default States 
# screen 1 : GitGumbleLogin
# username = new TextLayer
	
# password = new TextLayer

loginBtn = new Layer
	width: 100
	height: 50
	backgroundColor: "#F5C252"
	borderRadius: 10
	shadowY: 2
	shadowBlur: 5
	shadowColor: "rgba(0,0,0, .5)"
	
loginBtn.centerX()

textLabel = new Layer
	width: 100
	height: 50
	backgroundColor: null
	html: "Login"
	superLayer: loginBtn
	
textLabel.style.color = "#000"     
textLabel.style.fontSize = "20px"
textLabel.style.fontWeight = "500"
textLabel.style.letterSpacing = ".1em"
textLabel.style.textTransform = "uppercase"
textLabel.style.lineHeight = "50px"
textLabel.style.textAlign = "center"

# Flow Events
screen2 = false
loginBtn.onClick -> 
	flow.showNext(s.GitGumbleIntro)
	screen2 = true
	clippy.load 'Clippy', (agent) ->
	  # Do anything with the loaded agent
		agent.show()
		agent.moveTo(250,500)
		agent.speak("This is git gumble.  It judges you based on your github activity.")
		return



###
	EXAMPLE CODE
###

# https://codepen.io/stakes/pen/LELrdX 

# countLabel = new Layer
# 	x: 300
# 	y: 28
# 	width: 500
# 	height: 140
# 	backgroundColor: null
# # countLabel.html = count
# countLabel.style = 
# 	fontFamily: "Helvetica, Arial, sans-serif"
# 	fontSize: "100px"
# 	lineHeight: "100px"
# 	color: "#000000"
# 
# button = new Layer
# 	width: 240
# 	x: 20
# 	y: 20
# 	backgroundColor: "#E91E63"
# 	borderRadius: 10
# Utils.labelLayer button, "Tap to increment"

# firebase = new Firebase "https://simpleframerdemo.firebaseio.com/"
# 
# count = null
# 
# firebase.on "value", (dataSnapshot)->
#   
# 	count = dataSnapshot.val().count
# 	countLabel.html = count
# 
#   
# button.on Events.Click, ->
#   
# 	firebase.set 
# 		count: count+1
#     
# 	@opacity = .5
# 	@animate
# 		properties:
# 			opacity: 1
# 		time: .25

# Github OAuth

# Github JSON 


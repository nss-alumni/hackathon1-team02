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
	parent: all 
	width: all.width
	height: all.height
	
flow.showNext(s.GitGumbleLogin)

# Default States 
# screen 1 : GitGumbleLogin
# username = new TextLayer
# password = new TextLayer

loginBtn = new Layer
	parent: all.GitGumbleLogin
	width: 100
	height: 50
	backgroundColor: "#F5C252"
	borderRadius: 10
	y: 458 
	shadowY: 2
	shadowBlur: 5
	shadowColor: "rgba(0,0,0, .5)"
	
loginBtn.centerX()

loginLabel = new Layer
	width: 100
	height: 50
	backgroundColor: null
	html: "Login"
	superLayer: loginBtn
	
loginLabel.style.color = "#000"     
loginLabel.style.fontSize = "20px"
loginLabel.style.fontWeight = "500"
loginLabel.style.letterSpacing = ".1em"
loginLabel.style.textTransform = "uppercase"
loginLabel.style.lineHeight = "50px"
loginLabel.style.textAlign = "center"

iconBtn = new Layer
	parent: all.GitGumbleIntro
	width: 78
	height: 78
	borderRadius: "50%"
	backgroundColor: "transparent"
	borderColor: "rgba(255,255,255, .12)"
	borderWidth: .5
	x: 125
	y: 489        
	shadowY: 8
	shadowBlur: 8
	shadowColor: "rgba(0,0,0, .24)"
	
s.Nope.visible = false
s.Like.visible = false

stashBtn = new Layer
    width: 135
    height: 50
    backgroundColor: "#ffffff"
    borderWidth: 1
    borderRadius: 10
    borderColor: "#000000"
    parent: all.GitGumble
    y: 507
    x: 10

stashLabel = new Layer
    width: 100
    height: 50
    color: "#000000"
    backgroundColor: null
    html: "stash"
    superLayer: stashBtn

stashLabel.centerX()
stashLabel.style.color = "#000"     
stashLabel.style.fontSize = "20px"
stashLabel.style.fontWeight = "500"
stashLabel.style.letterSpacing = ".1em"
stashLabel.style.textTransform = "uppercase"
stashLabel.style.lineHeight = "50px"
stashLabel.style.textAlign = "center"

popBtn = new Layer
    width: 135
    height: 50
    backgroundColor: "9cdaef"
    borderWidth: 1
    borderRadius: 10
    borderColor: "#000000"
    parent: all.GitGumble
    y: 507
    x: 175

popLabel = new Layer
    width: 100
    height: 50
    color: "#000000"
    backgroundColor: null
    html: "pop"
    superLayer: popBtn

popLabel.centerX()
popLabel.style.color = "#000"     
popLabel.style.fontSize = "20px"
popLabel.style.fontWeight = "500"
popLabel.style.letterSpacing = ".1em"
popLabel.style.textTransform = "uppercase"
popLabel.style.lineHeight = "50px"
popLabel.style.textAlign = "center"

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
		agent.moveTo(250,450)
		agent.speak("Swipe right if you think you'll like someone, swipe left if you think you'll hate         them.")
		return
		
if s.GitGumbleIntro == true
	loginBtn.visible = false
	iconBtn.visible = true
	stashBtn.visible = false
	popBtn.visible = false
	
	
screen3 = false
iconBtn.onClick -> 
	flow.showNext(s.GitGumble)
	iconBtn.visible = true
	screen2 = false
	screen3 = true

screen4 = false
s.Hamburger.onClick -> 
	flow.showNext(s.Navigation)
	screen2 = false
	screen3 = false
	screen4 = true
	
# Navigation 



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


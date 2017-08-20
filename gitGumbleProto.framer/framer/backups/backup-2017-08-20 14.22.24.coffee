# Import file "gitGumblePrototype"
s = Framer.Importer.load("imported/gitGumblePrototype@1x")

# Firebase Setup
{Firebase} = require 'firebase'
firebase = new Firebase "https://simpleframerdemo.firebaseio.com/"
firebase.projectID = "git-gumble"
firebase.secret = "gWGWJ6VXV8Ck0zTxYYsrrFqOHEaRqQkJ9qBDfPDX"
firebase.debug = true

# Input Setup
InputModule = require 'input'

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
	backgroundColor: "#FFF"
	parent: all 
	width: all.width
	height: all.height
	
flow.showNext(s.GitGumbleLogin)

# Button States 
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
	html: "login"
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
	x: 121
	y: 489
	shadowY: 8
	shadowBlur: 8
	shadowColor: "rgba(0,0,0, .24)"

iconBtn.visible = false
	
s.Nope.visible = false
s.Like.visible = false

stashBtn = new Layer
	parent: all.GitGumble
	width: 135
	height: 50
	borderRadius: 10
	backgroundColor: "#F5C252"
	y: 507
	x: 10
	shadowY: 2
	shadowBlur: 5
	shadowColor: "rgba(0,0,0, .5)"

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

stashBtn.visible = false

popBtn = new Layer
	parent: all.GitGumble
	width: 135
	height: 50
	borderRadius: 10
	backgroundColor: "9cdaef"
	y: 507
	x: 175
	shadowY: 2
	shadowBlur: 5
	shadowColor: "rgba(0,0,0, .5)"

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

popBtn.visible = false

# # Clippy Layer
# clippyLayer = new Layer
# 	backgroundColor: "#FFF"
# 	
# 
# 
# 
# 	clippy.load 'Clippy', (agent) ->
#       # Do anything with the loaded agent
# 		agent.show()
# 		agent.moveTo(250,500)
# 		agent.speak("This is git gumble.  It judges you based on your github activity.")
# 		agent.moveTo(250,450)
# 		agent.speak("Swipe right if you think you'll like someone, swipe left if you think you'll hate         them.")
# 		return



# Flow Events
screen2 = false
loginBtn.onClick -> 
	flow.showNext(s.GitGumbleIntro)
	loginBtn.visible = false
	iconBtn.visible = true
	screen2 = true
	
	
screen3 = false
iconBtn.onClick -> 
	flow.showNext(s.GitGumble)
	loginBtn.visible = false
	iconBtn.visible = false
	stashBtn.visible = true
	popBtn.visible = true
	screen2 = false
	screen3 = true

screen4 = false
s.Hamburger.onClick -> 
	flow.showOverlayRight(s.Navigation)
	overlayBack = flow.children[0]
	overlayBack.backgroundColor = "transparent"
	loginBtn.visible = false
	iconBtn.visible = false
	stashBtn.visible = true
	popBtn.visible = true
	screen2 = false
	screen3 = false
	screen4 = true
	
# Keyboard Flow Events

# variable to store username info
userNameValue = undefined
#input box for user name
userNameInput = new InputModule.Input
	setup: false
	placeholder: "Github Username"
	fontSize: 20
	width: 180
	height: 25
	x: 60
	y: 320
	backgroundColor: "transparent"
# function that stores username input to username variable  
userNameInput.on "keyup", ->
	userNameValue = @value
# same for email login below
emailLoginBox = new Layer
	width: 200
	height: 45
	backgroundColor: "#F5C252"
	x: 60
	y: 400

emailValue = undefined
emailInput = new InputModule.Input
	setup: false
	placeholder: "Email"
	fontSize: 20
	width: 180
	height: 25
	x: 60
	y: 400
	backgroundColor: "transparent"

emailInput.on "keyup", ->
    emailValue = @value

# s.emailInput.onClick -> 
# 	flow.showOverlayBottom(s.keyboard1ExampleMobile)
# 	overlayBack = flow.children[0]
# 	overlayBack.backgroundColor = "transparent"
# 	
# s.usernameInput.onClick -> 
# 	flow.showOverlayBottom(s.keyboard1ExampleMobile)
# 	overlayBack = flow.children[0]
# 	overlayBack.backgroundColor = "transparent"
# 	
# s.keys.onClick -> 
# 	if screen2 == true
# 		continueBtnignoreEvents = false
# 		flow.showPrevious(s.screen2ExampleMobile)
# 		s.continueBtn.animate
# 			properties:
# 				opacity: 1
# 			options: 
# 				curve: "spring(280,30,0)"
# 		s.emailEntered.animate
# 			width: 235
# 			options: 
# 				curve: "spring(280,30,0)"
# 		s.passEntered.animate
# 			width: 218
# 			options: 
# 				curve: "spring(280,30,0)"
# 	else if screen3 == true
# 		findCachesBtnignoreEvents = false
# 		flow.showPrevious(s.screen3ExampleMobile)
# 		s.findCachesBtn.animate
# 			properties:
# 				opacity: 1
# 			options: 
# 				curve: "sprint(280,30,0)"
# 		s.userEntered.animate
# 			width: 198
# 			options: 
# 				curve: "spring(280,30,0)"
	
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


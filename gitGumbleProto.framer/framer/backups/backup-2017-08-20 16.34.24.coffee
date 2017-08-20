# Import file "gitGumblePrototype"
s = Framer.Importer.load("imported/gitGumblePrototype@1x")

# Firebase Setup
{Firebase} = require 'firebase'
firebase = new Firebase "https://git-gumble.firebaseio.com/"
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

s.Swipe_Card.visible = false

# swipeCard = new Layer
# 	parent: all.GitGumble
# 	width: 250
# 	height: 369
# 	borderRadius: 10
# 	backgroundColor: "red"
# 	y: 80
# 	shadowY: 2
# 	shadowBlur: 5
# 	shadowColor: "rgba(0,0,0, .5)"
# swipeCard.centerX()

##SWIPE FUNCTIONS##
cardWidth = 250
cardHeight = 369

swipeCard = new Layer
# 	parent: all.GitGumble
	width: cardWidth
	height: cardHeight
	borderRadius: 10
	backgroundColor: "#FFF"
	y: 80
	shadowY: 2
	shadowBlur: 5
	shadowColor: "rgba(0,0,0,.5)"
	clip: true
swipeCard.centerX()

swipeCard.visible = false

newUser = (usersArray) ->
	if swipeCard
		swipeCard.visible = true
	else 
		swipeCard = new Layer
			width: cardWidth
			height: cardHeight
			borderRadius: 10
			backgroundColor: "#FFF"
			y: 80
			shadowY: 2
			shadowBlur: 5
			shadowColor: "rgba(0,0,0,.5)"
			clip: true
		swipeCard.centerX()
		swipeCard.visible = true
		print swipeCard

	console.log(usersArray)
	usersLength = usersArray.length
	randomNumber = Math.floor(Math.random() * usersLength) + 1  
	console.log(randomNumber)
	if !globalArray.includes(randomNumber)
		currentMatch = usersArray[randomNumber]
		globalArray.push(randomNumber)
	commitNumber = Number(currentMatch.contributions)
	console.log(commitNumber)
	commitPercent = commitNumber / 1000
	if commitPercent < 0.20
		swipeCard.backgroundColor = "#eee"
	else if commitPercent > 0.20 && commitPercent < 0.40
		swipeCard.backgroundColor = "#c6e48b"
	else if commitPercent > 0.40 && commitPercent < 0.60
		swipeCard.backgroundColor = "#7bc96f"
	else if commitPercent > 0.60 && commitPercent < 0.80
		swipeCard.backgroundColor = "#239a3b"
	else if commitPercent > 0.80
		swipeCard.backgroundColor = "#196127"

likeLabel = new Layer
	width: cardWidth 
	height: 50
	parent: swipeCard
	backgroundColor: "#9cdaef"
	opacity: 0
	name: "like"

nopeLabel = new Layer		
	width: cardWidth 
	height: 50
	parent: swipeCard
	backgroundColor: "#F5C252"
	opacity: 0


# # Clippy Layer
# clippyLayer = new Layer
# 	backgroundColor: "#FFF"
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
usersArray = []
globalArray = []
getAllUsers = (users)->
	usersArray = _.toArray(users)

screen2 = false
loginBtn.onClick -> 
	flow.showNext(s.GitGumbleIntro)
	firebase.get("/users", getAllUsers, {orderBy: "$key"})
	loginBtn.visible = false
	iconBtn.visible = true
	userNameLoginBox.visible = false
	userNameInput.visible = false
	emailLoginBox.visible = false
	emailInput.visible = false
	screen2 = true
	clippy.load 'Clippy', (agent) ->
      # Do anything with the loaded agent
		agent.moveTo(750,375)
		agent.show()
		agent.speak("Welcome to git gumble.  It judges you based on your github activity.")
		agent.moveTo(650,450)
		agent.speak("Swipe right (or click 'Pop') if someone seems cool. Swipe left (or click 'Stash') if they aren't cool enough for you.")
		agent.moveTo(600,400)
		agent.speak("Click or Tap the icon below to start!")
		agent.play("GestureDown")
		setTimeout (->
			agent.hide()
			return
			), 14000
		return
	
screen3 = false
iconBtn.onClick -> 
	flow.showNext(s.GitGumble)
	newUser(usersArray)
	loginBtn.visible = false
	iconBtn.visible = false
	stashBtn.visible = true
	popBtn.visible = true
	userNameLoginBox.visible = false
	userNameInput.visible = false
	emailLoginBox.visible = false
	emailInput.visible = false
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
	popBtn.visible = false
	screen2 = false
	screen3 = false
	screen4 = true

screen5 = false
s.popMatches.onClick -> 
	flow.showOverlayLeft(s.POP_Matches)
	loginBtn.visible = false
	iconBtn.visible = false
	stashBtn.visible = false
	popBtn.visible = false
	screen2 = false
	screen3 = false
	screen4 = false
	screen5 = true
	
screen3 = false
s.gitGumbling.onClick -> 
	flow.showPrevious(s.GitGumble)
	popBtn.visible = true
	screen2 = false
	screen3 = true
	screen4 = false
	screen5 = false

screen2 = false
s.explained1.onClick -> 
	flow.showOverlayLeft(s.GitGumbleIntro)
	loginBtn.visible = false
	iconBtn.visible = true
	stashBtn.visible = false
	popBtn.visible = false
	screen2 = true
	screen3 = false
	screen4 = false
	screen5 = false

# Keyboard Flow Events

# yellow login box outline
userNameLoginBox = new Layer
	width: 200
	height: 45
	backgroundColor: "#FFF"
	borderRadius: 10
	y: 320
userNameLoginBox.centerX()
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
	backgroundColor: "#FFF"
	borderRadius: 10
	y: 380
emailLoginBox.centerX()

emailValue = undefined
emailInput = new InputModule.Input
	setup: false
	placeholder: "Email"
	fontSize: 20
	width: 180
	height: 25
	x: 60
	y: 380
	backgroundColor: "transparent"

emailInput.on "keyup", ->
    emailValue = @value

# userNameInput.onClick -> 
# 	flow.showOverlayBottom(s.keyboard1ExampleMobile)
# 	overlayBack = flow.children[0]
# 	overlayBack.backgroundColor = "transparent"
# 	
# emailInput.onClick -> 
# 	flow.showOverlayBottom(s.keyboard1ExampleMobile)
# 	overlayBack = flow.children[0]
# 	overlayBack.backgroundColor = "transparent"
	
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
	
swipeCard.childDic = {
	"like" : likeLabel
	"nope" : nopeLabel
}

swipeCard.states = {
	"goLeftUp":
		x: -Screen.width
		y: -swipeCard.y
	"goLeftDown":
		x: -Screen.width
		y: Screen.height 
	"goRightUp":
		x: Screen.width + swipeCard.width
		y: -swipeCard.y
	"goRightDown":
		x: Screen.width + swipeCard.width
		y: Screen.height
}

swipeCard.states.animationOptions = {
    curve:"ease"
    time:0.3
}

swipeCard.center()
swipeCard.draggable.enabled = true
# card.draggable.constraints = card.frame

rotateCard = (layer) ->
	layer.rotationZ = Utils.modulate(layer.midX, [0,Screen.width], [10,-10])

showLikeOrNope = (layer) ->
	if layer.midX < Screen.width/2
		layer.childDic["nope"].opacity = Utils.modulate(layer.midX, [100,Screen.width/2], [1,0])
	else
		layer.childDic["like"].opacity = Utils.modulate(layer.midX, [Screen.width/2,Screen.width-100], [0,1])

# ===========EVENT===========
swipeCard.on Events.Move,->
	rotateCard(this)
	showLikeOrNope(this)

swipeCard.on Events.DragEnd, ->
#     magnitude = Math.sqrt(Math.pow(card.draggable.velocity.x,2) + Math.pow(card.draggable.velocity.y,2))     
	if swipeCard.midX < 0
		if swipeCard.midY < Screen.height/2
			swipeCard.animate("goLeftUp")
		else
			swipeCard.animate("goLeftDown")
		swipeCard.destroy()
		newUser(usersArray)
	else if swipeCard.midX > Screen.width
		if swipeCard.midY < Screen.height/2
			swipeCard.animate("goRightUp")
		else
			swipeCard.animate("goRightDown")
		swipeCard.destroy()
		newUser(usersArray)

swipeCard.on Events.DragMove, ->
	rotateCard(this)
	showLikeOrNope(this)

# Flow component
flow = new FlowComponent
	backgroundColor: "#FFF"
	parent: all 
	width: all.width
	height: all.height

flow.showNext(s.GitGumbleLogin)


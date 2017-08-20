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


# Flow Events
screen2 = false
loginBtn.onClick -> 
	flow.showNext(s.GitGumbleIntro)
	loginBtn.visible = false
	iconBtn.visible = true
	screen2 = true
	
	clippy.load 'Clippy', (agent) ->
      # Do anything with the loaded agent
		agent.show()
		agent.moveTo(250,500)
		agent.speak("This is git gumble.  It judges you based on your github activity.")
		agent.moveTo(250,450)
		agent.speak("Swipe right if you think you'll like someone, swipe left if you think you'll hate         them.")
		return

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

exports.keyboardLayer = new Layer
    x:0, y:Screen.height, width:Screen.width, height:432
    html:"<img style='width: 100%;' src='modules/keyboard.png'/>"
#screen width vs. size of image width
growthRatio = Screen.width / 732
imageHeight = growthRatio * 432
# Extends the LayerStyle class which does the pixel ratio calculations in framer
_inputStyle =
    Object.assign({}, Framer.LayerStyle,
        calculatePixelRatio = (layer, value) ->
            (value * layer.context.pixelMultiplier) + "px"
        fontSize: (layer) ->
            calculatePixelRatio(layer, layer._properties.fontSize)
        lineHeight: (layer) ->
            (layer._properties.lineHeight) + "em"
        padding: (layer) ->
            { pixelMultiplier } = layer.context
            padding = []
            paddingValue = layer._properties.padding
            # Check if we have a single number as integer
            if Number.isInteger(paddingValue)
                return calculatePixelRatio(layer, paddingValue)
            # If we have multiple values they come as string (e.g. "1 2 3 4")
            paddingValues = layer._properties.padding.split(" ")
            switch paddingValues.length
                when 4
                    padding.top = parseFloat(paddingValues[0])
                    padding.right = parseFloat(paddingValues[1])
                    padding.bottom = parseFloat(paddingValues[2])
                    padding.left = parseFloat(paddingValues[3])
                when 3
                    padding.top = parseFloat(paddingValues[0])
                    padding.right = parseFloat(paddingValues[1])
                    padding.bottom = parseFloat(paddingValues[2])
                    padding.left = parseFloat(paddingValues[1])
                when 2
                    padding.top = parseFloat(paddingValues[0])
                    padding.right = parseFloat(paddingValues[1])
                    padding.bottom = parseFloat(paddingValues[0])
                    padding.left = parseFloat(paddingValues[1])
                else
                    padding.top = parseFloat(paddingValues[0])
                    padding.right = parseFloat(paddingValues[0])
                    padding.bottom = parseFloat(paddingValues[0])
                    padding.left = parseFloat(paddingValues[0])
            # Return as 4-value string (e.g "1px 2px 3px 4px")
            "#{padding.top * pixelMultiplier}px #{padding.right * pixelMultiplier}px #{padding.bottom * pixelMultiplier}px #{padding.left * pixelMultiplier}px"
    )
exports.keyboardLayer.states =
    shown:
        y: Screen.height - imageHeight
exports.keyboardLayer.states.animationOptions =
    curve: "spring(500,50,15)"
class exports.Input extends Layer
    @define "style",
        get: -> @input.style
        set: (value) ->
            _.extend @input.style, value
    @define "value",
        get: -> @input.value
        set: (value) ->
            @input.value = value
    constructor: (options = {}) ->
        options.setup ?= false
        options.width ?= Screen.width
        options.clip ?= false
        options.height ?= 60
        options.backgroundColor ?= if options.setup then "rgba(255, 60, 47, .5)" else "transparent"
        options.fontSize ?= 30
        options.lineHeight ?= 1
        options.padding ?= 10
        options.text ?= ""
        options.placeholder ?= ""
        options.virtualKeyboard ?= if Utils.isMobile() then false else true
        options.type ?= "text"
        options.goButton ?= false
        options.autoCorrect ?= "on"
        options.autoComplete ?= "on"
        options.autoCapitalize ?= "on"
        options.spellCheck ?= "on"
        options.autofocus ?= false
        options.textColor ?= "#000"
        options.fontFamily ?= "-apple-system"
        options.fontWeight ?= "500"
        super options
        # Add additional properties
        @_properties.fontSize = options.fontSize
        @_properties.lineHeight = options.lineHeight
        @_properties.padding = options.padding
        @placeholderColor = options.placeholderColor if options.placeholderColor?
        @input = document.createElement "input"
        @input.id = "input-#{_.now()}"
        # Add styling to the input element
        @input.style.width = _inputStyle["width"](@)
        @input.style.height = _inputStyle["height"](@)
        @input.style.fontSize = _inputStyle["fontSize"](@)
        @input.style.lineHeight = _inputStyle["lineHeight"](@)
        @input.style.outline = "none"
        @input.style.border = "none"
        @input.style.backgroundColor = options.backgroundColor
        @input.style.padding = _inputStyle["padding"](@)
        @input.style.fontFamily = options.fontFamily
        @input.style.color = options.textColor
        @input.style.fontWeight = options.fontWeight
        @input.value = options.text
        @input.type = options.type
        @input.placeholder = options.placeholder
        @input.setAttribute "autocorrect", options.autoCorrect
        @input.setAttribute "autocomplete", options.autoComplete
        @input.setAttribute "autocapitalize", options.autoCapitalize
        if options.autofocus == true
            @input.setAttribute "autofocus", true
        @input.setAttribute "spellcheck", options.spellCheck
        @form = document.createElement "form"
        if options.goButton
            @form.action = "#"
            @form.addEventListener "submit", (event) ->
                event.preventDefault()
        @form.appendChild @input
        @_element.appendChild @form
        @backgroundColor = "transparent"
        @updatePlaceholderColor options.placeholderColor if @placeholderColor
        #only show honor virtual keyboard option when not on mobile,
        #otherwise ignore
        if !Utils.isMobile() && options.virtualKeyboard is true
            @input.addEventListener "focus", ->
                exports.keyboardLayer.bringToFront()
                exports.keyboardLayer.stateCycle()
            @input.addEventListener "blur", ->
                exports.keyboardLayer.animate("default")
    updatePlaceholderColor: (color) ->
        @placeholderColor = color
        if @pageStyle?
            document.head.removeChild @pageStyle
        @pageStyle = document.createElement "style"
        @pageStyle.type = "text/css"
        css = "##{@input.id}::-webkit-input-placeholder { color: #{@placeholderColor}; }"
        @pageStyle.appendChild(document.createTextNode css)
        document.head.appendChild @pageStyle
    focus: () ->
        @input.focus()
    onFocus: (cb) ->
        @input.addEventListener "focus", ->
            cb.apply(@)
    onBlur: (cb) ->
        @input.addEventListener "blur", ->
            cb.apply(@)





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


extends Node

@export var wepselect: Subweapon



func parabol(x,a,b,c):
	var y = a*x**2-b*x+c
	return y

# You'll need to fix up the exact values, cuz it doesn't give exact values.
var parama = [0.000054235,0.0000813524,0.0000948956,0.00010845,0.0000783197,0.000121996,0.103014,0.0167883]
var paramb = [0.00661038,0.00991591,0.0115677,0.0132204,0.00954775,0.01485,12.53846,2.0622]
var paramc = [1,1,1,1,1,1,600,180]


func curves(x,i):
	var y = parabol(x,parama[i],paramb[i],paramc[i])
	return y

var isspoints : Array
var ismpoints : Array
var irukpoints : Array
var iruspoints : Array

var ismirukresult = {"lowest time": 100, "required AP": [0]}
var ismirusresult = {"lowest time": 100, "required AP": [0]}
var issirukresult = {"lowest time": 100, "required AP": [0]}
var issirusresult = {"lowest time": 100, "required AP": [0]}


func pointsmultiply(recoverypoints, saverpoints):
		var multipliedpoints : Array
		for n in 58:
			multipliedpoints.append(sec(recoverypoints[57-n]) * saverpoints[n])
		return multipliedpoints

func result(pointsarray, resultdict, inkcost = 100):
	var inkcostratio = inkcost/100.0
	
	for n in 58:
		var pointsarrayscaled = snapped(pointsarray[n]*inkcostratio,0.001)
		if pointsarrayscaled < resultdict["lowest time"]:
			resultdict["lowest time"] = pointsarrayscaled
			resultdict["required AP"][0] = n
		elif pointsarrayscaled == resultdict["lowest time"]:
			resultdict["required AP"].append(n)
		else:
			break
			

func sec(x):
	return x/60

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in 58:
		isspoints.append(curves(n,wepselect.curvetype))
		ismpoints.append(curves(n,5))
		irukpoints.append(curves(n,6))
		iruspoints.append(curves(n,7))
		
	result(pointsmultiply(irukpoints,ismpoints), ismirukresult)
	result(pointsmultiply(iruspoints,ismpoints), ismirusresult)
	result(pointsmultiply(irukpoints,isspoints), issirukresult, wepselect.inkcost)
	result(pointsmultiply(iruspoints,isspoints), issirusresult, wepselect.inkcost)
	
	print_rich("[b]Sub weapon selected = " + wepselect.wepname + "[/b]")
	print("")
	print_rich("[table=3][cell]Type		[/cell][cell][hint=in seconds]Time[/hint]	[/cell][cell][hint=Number of AP of either ISM or ISS, with the remaining AP being IRU up to 57]AP required[/hint]	[/cell][cell border=#ffffff00][hint=Amount of time (in seconds) between shots of the main weapon while in kid form]Main kid[/hint][/cell][cell border=#ffffff00]" + str(ismirukresult["lowest time"]) + "[/cell][cell border=#ffffff00]" + str(ismirukresult["required AP"]) + "[/cell][cell border=#ffffff00][hint=Amount of time (in seconds) between shots of the main weapon while in squid form]Main squid[/hint][/cell][cell border=#ffffff00]" + str(ismirusresult["lowest time"]) + "[/cell][cell border=#ffffff00]" + str(ismirusresult["required AP"]) + "[/cell][cell border=#ffffff00][hint=Amount of time (in seconds) between shots of the sub weapon while in kid form]Sub kid[/hint][/cell][cell border=#ffffff00]" + str(issirukresult["lowest time"]) + "[/cell][cell border=#ffffff00]" + str(issirukresult["required AP"]) + "[/cell][cell border=#ffffff00][hint=Amount of time (in seconds) between shots of the sub weapon while in squid form]Sub squid[/hint][/cell][cell border=#ffffff00]" + str(issirusresult["lowest time"]) + "[/cell][cell border=#ffffff00]" + str(issirusresult["required AP"]) + "[/cell][/table]")
	
	
	
	#print_rich("[table=3]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the main weapon while in kid form]Main kid[/hint][/cell][cell]" + str(ismirukresult["lowest time"]) + "[/cell][cell]" + str(ismirukresult["required AP"]) + "[/cell]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the main weapon while in squid form]Main squid[/hint][/cell][cell]" + str(ismirusresult["lowest time"]) + "[/cell][cell]" + str(ismirusresult["required AP"]) + "[/cell]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the sub weapon while in kid form]Sub kid[/hint][/cell][cell]" + str(issirukresult["lowest time"]) + "[/cell][cell]" + str(issirukresult["required AP"]) + "[/cell]")
	#print_rich("[cell][hint=Amount of time (in seconds) between shots of the sub weapon while in squid form]Sub squid[/hint][/cell][cell]" + str(issirusresult["lowest time"]) + "[/cell][cell]" + str(issirusresult["required AP"]) + "[/cell]")
	#print_rich("[/table]")
	
		
#	for n in 58:
#		if ismirukpoints[n] <= ismirukresult["lowest time"]:
#			ismirukresult["lowest time"] = ismirukpoints[n] 
#			ismirukresult["required AP"].append(n)
		




#func _input(event):
#	if event.is_action_pressed("Print"):
#		print("""
#		""")
#		print(curves(57,wepselect.curvetype))
#		print(wepselect.curvetype)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

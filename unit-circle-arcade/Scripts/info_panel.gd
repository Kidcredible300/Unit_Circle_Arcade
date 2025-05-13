extends Node2D

var points_p1 = 0
var points_p2 = 0

func victory(player : int):
	if(player==1):
		points_p1+=1
		$"Points P1/Description".text = str(points_p1)+" Pts"
	if(player==2):
		points_p2+=1
		$"Points P2/Description".text = str(points_p2)+" Pts"

func winner() -> String:
	if(points_p1>points_p2): return "Player 1 Wins!"
	if(points_p2>points_p1): return "Player 2 Wins!"
	return "No Player Wins!"

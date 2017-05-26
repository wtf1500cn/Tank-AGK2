


global player as Tank


function ResetPlayer()
	player.size = 80
	player.rate = 0
	player.fire = 0
	player.a = .25
	
	player.spr = P_TANK
	player.turrent.spr = P_TANK_TUR
	player.bullet[0].spr = P_TANK_BUL
	
	for i = 1 to player.bullet.length
		player.bullet[i].spr = 1003 + i
		player.bullet[i].spd = 30
		player.bullet[i].range = 800
		player.bullet[i].xp = player.xp + GetSpriteHeight(player.turrent.spr)/2*sin(player.turrent.angle)
		player.bullet[i].yp = player.yp - GetSpriteWidth(player.turrent.spr)/2*cos(player.turrent.angle)
		player.bullet[i].status = 0
	next i
	
	player.xp = 100
	player.yp = 100
	player.spd = 0
	player.maxspd = 60
	player.angle = 90
	
	player.turrent.size = player.size * 0.9
	player.turrent.angle = 0
	player.turrent.spd = 3.0
	
	//SetSpritePositionByOffset(player.spr,player.xp,player.yp)
	//SetSpriteAngle(player.spr,player.angle)
	//SetSpritePositionByOffset(player.turrent.spr,player.turrent.xp,player.turrent.yp)
	//SetSpriteAngle(player.turrent.spr,player.turrent.angle)
endfunction

function PlayerControll()
	if IsTankInMap(player)
		TankMove(player,GetRawKeyState(87),GetRawKeyState(83))
		TankPostionFix(player)
	endif
	TankTurning(player,GetRawKeyState(68),GetRawKeyState(65))
	TankFire(player,GetPointerPressed())
	TurTurning(player)
endfunction


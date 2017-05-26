
//------------------------------------//
// ***********************************//
//          Tank and Turrent          //
//                                    //
// ***********************************//
//------------------------------------//
type Tank
	size as float
	rate as float
	fire as integer
	a as float
	spr as integer
	spd as float
	maxspd as float
	xp as float
	yp as float
	angle as float
	turrent as TurType
	bullet as BulletType[8]
endtype

type BulletType
	range as float
	spr as integer
	spd as float
	angle as float
	xp as float
	yp as float
	status as integer
endtype

type TurType
	size as float
	spr as integer
	angle as float
	spd as float
endtype


//------------------------------------//
// ***********************************//
//           Tank's action            //
//                                    //
// ***********************************//
//------------------------------------//

function InitTank(tk as Tank)
	SetSpritePositionByOffset(tk.spr,tk.xp,tk.yp)
	SetSpritePositionByOffset(tk.turrent.spr,tk.xp,tk.yp)
	SetSpriteSize(tk.spr,tk.size,-1)
	SetSpriteSize(tk.turrent.spr,tk.turrent.size,-1)
	SetSpriteAngle(tk.spr,tk.angle)
	SetSpriteAngle(tk.turrent.spr,tk.turrent.angle)
	
	for i = 1 to tk.bullet.length
		SetSpritePositionByOffset(tk.bullet[i].spr,tk.bullet[i].xp,tk.bullet[i].yp)
		SetSpriteAngle(tk.bullet[i].spr,tk.bullet[i].angle)
	next i
endfunction


function SetTank(tk as Tank)
	SetSpritePositionByOffset(tk.spr,tk.xp,tk.yp)
	SetSpritePositionByOffset(tk.turrent.spr,tk.xp,tk.yp)
	
	SetSpriteAngle(tk.spr,tk.angle)
	SetSpriteAngle(tk.turrent.spr,tk.turrent.angle)
	
	for i = 1 to tk.bullet.length
		SetSpritePositionByOffset(tk.bullet[i].spr,tk.bullet[i].xp,tk.bullet[i].yp)
		SetSpriteAngle(tk.bullet[i].spr,tk.bullet[i].angle)
	next i
endfunction

function TankMove(tk ref as Tank, mov1 as integer, mov2 as integer)
	if mov1 and tk.spd < tk.maxspd
		tk.spd = tk.spd + tk.a
	endif
	
	if mov2 and tk.spd > - tk.maxspd * 6
		tk.spd = tk.spd - tk.a
	endif
	
	if not mov1 and not mov2
		if tk.spd > 0
			tk.spd = tk.spd - 0.5
		elseif tk.spd < 0
			tk.spd = tk.spd + 0.5
		endif
		if abs(tk.spd) < 0.5
			tk.spd = 0
		endif
	endif
	
	tw# = GetSpriteWidth(tk.turrent.spr)
	th# = GetSpriteHeight(tk.turrent.spr)
	//for i = 1 to tk.bullet.length
	//next i
	
	tk.xp = tk.xp + tk.spd*sin(tk.angle)/10
	tk.yp = tk.yp - tk.spd*cos(tk.angle)/10
	
endfunction

function TankTurning(tk ref as Tank, mov1 as integer, mov2 as integer)
	a# = GetSpriteAngle(tk.spr)
	if mov1
		tk.angle = tk.angle + tk.a*5
	elseif mov2
		tk.angle = tk.angle - tk.a*5
	endif
	
endfunction

function TankFire(tk ref as Tank,mov as integer)
	
	if mov and tk.fire = 0
		//tarx# = GetPointerX()
		//tary# = GetPointerY()
		
		if tk.bullet[1].angle = tk.turrent.angle
			tk.fire = 1
			tk.bullet[1].status = 1
			SetSpriteVisible(tk.bullet[1].spr,1)
		endif
		//tk.bullet.xp = tk.bullet.xp + tk.bullet.spd*sin(tk.turrent.angle)
		//tk.bullet.yp = tk.bullet.yp - tk.bullet.spd*cos(tk.turrent.angle)
	//else
		//tk.fire = 0
		
	endif
	
	
	BulletManager(tk)
	
endfunction

function BulletManager(tk ref as Tank)
	select tk.fire
		case 1:
			//tk.bullet.angle = tk.turrent.angle
			player.rate = player.rate + Timer()
			//if tk.bullet[1].xp <> 
			tk.bullet[1].xp = tk.bullet[1].xp + tk.bullet[1].spd*sin(tk.bullet[1].angle)/4 + tk.spd*sin(tk.angle)/15
			tk.bullet[1].yp = tk.bullet[1].yp - tk.bullet[1].spd*cos(tk.bullet[1].angle)/4 - tk.spd*cos(tk.angle)/15
			//else
			//endif
			if player.rate * player.bullet[1].spd > player.bullet[1].range
				tk.fire = 0
			endif
		endcase
		case 0:
			ResetBullet(player,1)
		endcase
	endselect
endfunction

//------------------------------------//
// ***********************************//
//         Turrent's action           //
//                                    //
// ***********************************//
//------------------------------------//
function TurTurning(tk ref as Tank)
	//a# = GetSpriteAngle(player.turrent.spr)
	xoff# = ScreenToWorldX(GetPointerX()) - GetSpriteXByOffset(tk.turrent.spr)
	yoff# = ScreenToWorldY(GetPointerY()) - GetSpriteYByOffset(tk.turrent.spr)
	//if a# > Atan2(yoff#,xoff#)-90	
	
	rem  Handle over turing, angle > 360 
	
	if ATan2(yoff#,xoff#) + 90 - tk.turrent.angle < -180
		tk.turrent.angle = tk.turrent.angle - 360
	elseif ATan2(yoff#,xoff#) + 90 - tk.turrent.angle > 180
		tk.turrent.angle = tk.turrent.angle + 360
	endif
	
	rem	 Turrent Turing
	
	if	ATan2(yoff#,xoff#) + 90 - tk.turrent.angle < 0
		tk.turrent.angle = tk.turrent.angle - tk.turrent.spd
	elseif ATan2(yoff#,xoff#) + 90 - tk.turrent.angle > 0
		tk.turrent.angle = tk.turrent.angle + tk.turrent.spd
	endif
	
	rem Angle fix
	
	if abs(ATan2(yoff#,xoff#) + 90 - tk.turrent.angle) < 3
		tk.turrent.angle = ATan2(yoff#,xoff#) + 90
	endif
	
	for i = 0 to tk.bullet.length
		if tk.bullet[i].status = 0
			tk.bullet[i].angle = tk.turrent.angle
		endif
	next i
	//endif
endfunction

//------------------------------------//
// ***********************************//
//          Bullet's action           //
//                                    //
// ***********************************//
//------------------------------------//
function ResetBullet(tk ref as Tank,id as integer)
	tw# = GetSpriteWidth(tk.turrent.spr)
	th# = GetSpriteHeight(tk.turrent.spr)
	
	tk.bullet[id].xp = tk.xp + tw# * sin(tk.turrent.angle)/2 * .8
	tk.bullet[id].yp = tk.yp - th# * cos(tk.turrent.angle)/2 * .8
	tk.bullet[id].angle = tk.turrent.angle
	player.rate = 0
	ResetTimer()
	SetSpriteVisible(player.bullet[1].spr,0)
endfunction

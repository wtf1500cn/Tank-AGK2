#constant IMG_PLAYER_TANK = 1001
#constant IMG_PLAYER_BULLENT = 1002
#constant IMG_MAP_001 = 2001

#constant P_TANK = 1001
#constant P_TANK_TUR = 1002
#constant P_TANK_BUL = 1003
#constant G_MAP = 2001

function LoadImages()
	_img_p_tank$ = "sfx/imgs/TankSet5.png"
	_img_p_bullet$ = "sfx/imgs/bean1.png"
	p1$ = "File don't exists."
	
	if GetFileExists(_img_p_tank$) and GetFileExists(_img_p_bullet$)
		LoadImage(IMG_PLAYER_TANK,_img_p_tank$)
		LoadImage(IMG_PLAYER_BULLENT,_img_p_bullet$)
	else
		Print("Cann't Load Images, cause :" + p1$)
	endif
	iw# = GetImageWidth(IMG_PLAYER_TANK)
	ih# = GetImageHeight(IMG_PLAYER_TANK)
	
	CreateSprite(P_TANK,IMG_PLAYER_TANK)
	SetSpriteSize(P_TANK,80,-1)
	SetSpriteAnimation(P_TANK,iw#/4,ih#/4,16)
	SetSpriteFrame(P_TANK,1)
	CreateSprite(P_TANK_TUR,IMG_PLAYER_TANK)
	SetSpriteAnimation(P_TANK_TUR,iw#/4,ih#/4,16)
	SetSpriteSize(P_TANK_TUR,GetSpriteWidth(P_TANK)*0.9,-1)
	SetSpriteFrame(P_TANK_TUR,9)
	CreateSprite(P_TANK_BUL,IMG_PLAYER_BULLENT)
	SetSpriteSize(P_TANK_BUL,16,24)
	SetSpriteVisible(P_TANK_BUL,0)
	SetSpriteShape(P_TANK_BUL,3)
	SetSpriteDepth(P_TANK_BUL,GetSpriteDepth(P_TANK_TUR)+1)
	for i = 1 to 10
		CloneSprite(P_TANK_BUL+i,P_TANK_BUL)
		//SetSpriteVisible(P_TANK_BUL+i,0)
	next i
	
	//SetSpriteVisible(P_TANK_BUL,0)
endfunction

function SelectAllSprite()
	arr as integer[]
	arr.insert(P_TANK)
	arr.insert(P_TANK_TUR)
	arr.insert(P_TANK_BUL)
	for i = 1 to 10
		arr.insert(P_TANK_BUL+i)
	next i
	arr.insert(G_MAP)
endfunction arr

#constant MAP_TOP = 0
#constant MAP_BUTTOM = 3000
#constant MAP_LEFT_EDGE = 0
#constant MAP_RIGHT_EDGE = 3000


function LoadMap()
	_img_p_map_001$ = "map/GrassTexture.png"
	LoadSprite(G_MAP,_img_p_map_001$)
	SetSpriteDepth(G_MAP,1002)
	SetSpriteSize(G_MAP,3000,3000)
endfunction

function HandleCamera()
	SetViewOffset(player.xp-GetVirtualWidth()/2,player.yp-GetVirtualHeight()/2)
endfunction

function IsTankInMap(tk as Tank)
	
	result as integer
	if tk.xp < MAP_LEFT_EDGE or tk.xp > MAP_RIGHT_EDGE or tk.yp < MAP_TOP or tk.yp > MAP_BUTTOM 
		result = 0
	else
		result = 1
	endif
endfunction result

function TankPostionFix(tk ref as Tank)
	
	if MAP_LEFT_EDGE - tk.xp < 20 and tk.xp < MAP_LEFT_EDGE
		tk.xp = MAP_LEFT_EDGE
		tk.spd = abs(tk.spd*cos(tk.angle))
	endif
	if tk.xp - MAP_RIGHT_EDGE < 20 and tk.xp > MAP_RIGHT_EDGE
		tk.xp = MAP_RIGHT_EDGE
		tk.spd = abs(tk.spd*cos(tk.angle))
	endif
	if MAP_TOP - tk.yp < 20 and tk.yp < MAP_TOP
		tk.yp = MAP_TOP
		tk.spd = abs(tk.spd*sin(tk.angle))
	endif
	if tk.yp  - MAP_BUTTOM < 20 and tk.yp > MAP_BUTTOM
		tk.yp = MAP_BUTTOM
		tk.spd = abs(tk.spd*sin(tk.angle))
	endif
endfunction

function Zoom()
	if GetRawMouseWheelDelta() > 0
		
	elseif GetRawMouseWheelDelta() < 0
	endif
endfunction

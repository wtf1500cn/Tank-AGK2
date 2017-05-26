

global g_status as integer

//------------------------------------//
// ***********************************//
//         Game Main Funtion          //
//                                    //
// ***********************************//
//------------------------------------//
function InitGame()
	LoadImages()
	ResetPlayer()
	
	LoadMap()
	InitTank(player)
endfunction 

function InGame()
	HandleCamera()
	PlayerControll()
	SetTank(player)
endfunction

function EndGame()
	
endfunction

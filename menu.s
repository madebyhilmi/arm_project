//CPSC 359 - Assignment 3 - RoadFighter
//Kyle Ostrander 10128524, Carlin Liu 10123584, Hilmi Abou-Saleh 10125373
 
//Menu.s
//Functions:
//Print_Menu_Start, Print_Menu_Quit, Print_Menu_Black_Start, Print_Menu_Black_Quit
//Print_Menu_Starting_Game, Print_Menu_Quitting_Game, Menu_Controller, 


.section .text
.align 4

//Print_Menu_Start
//Args: None
//Return: None
//This function sets the location and colours to print out the strings for game name etc.
//This function will print <> around the start.
.globl Print_Menu_Start
Print_Menu_Start:
	push	{r4-r10, lr}

	//Game_Name
	mov	r0, #100
	mov	r1, #100
	ldr	r2, =0x0FF0
	ldr	r3, =Game_Name
	bl	Draw_String

	//Creator_Names
	mov	r0, #100
	mov	r1, #300
	ldr	r2, =0x0FF0
	ldr	r3, =Creator_Names
	bl	Draw_String

	//Main_Menu
	mov	r0, #500
	mov	r1, #500
	ldr	r2, =0x0FF0
	ldr	r3, =Main_Menu
	bl	Draw_String

	//Start_Game
	mov	r0, #500
	mov	r1, #600
	ldr	r2, =0x0FF0
	ldr	r3, =Start_Game_Selected
	bl	Draw_String

	//Quit_Game
	mov	r0, #500
	mov	r1, #700
	ldr	r2, =0x0FF0
	ldr	r3, =Quit_Game
	bl	Draw_String


	pop	{r4-r10, lr}
	mov	pc, lr


//Print_Menu_Quit
//Args: None
//Return: None
//This function sets the location and colours to print out the strings for game name etc.
//This function will print <> around the Quit.
.globl Print_Menu_Quit
Print_Menu_Quit:
	push	{r4-r10, lr}

	//Game_Name
	mov	r0, #100
	mov	r1, #100
	ldr	r2, =0x0F00
	ldr	r3, =Game_Name
	bl	Draw_String

	//Creator_Names
	mov	r0, #100
	mov	r1, #300
	ldr	r2, =0x0F00
	ldr	r3, =Creator_Names
	bl	Draw_String

	//Main_Menu
	mov	r0, #500
	mov	r1, #500
	ldr	r2, =0x0F00
	ldr	r3, =Main_Menu
	bl	Draw_String

	//Start_Game
	mov	r0, #500
	mov	r1, #600
	ldr	r2, =0x0F00
	ldr	r3, =Start_Game
	bl	Draw_String

	//Quit_Game
	mov	r0, #500
	mov	r1, #700
	ldr	r2, =0x0F00
	ldr	r3, =Quit_Game_Selected
	bl	Draw_String


	pop	{r4-r10, lr}
	mov	pc, lr


//Print_Menu_Black_Start
//Args: None
//Return: None
//This function Changes the options of <Start> and quit to be black
.globl Print_Menu_Black_Start
Print_Menu_Black_Start:
	push	{r4-r10, lr}

	//Start_Game
	mov	r0, #500
	mov	r1, #600
	ldr	r2, =0x0000
	ldr	r3, =Start_Game_Selected
	bl	Draw_String

	//Quit_Game
	mov	r0, #500
	mov	r1, #700
	ldr	r2, =0x0000
	ldr	r3, =Quit_Game
	bl	Draw_String


	pop	{r4-r10, lr}
	mov	pc, lr

//Print_Menu_Black_Quit
//Args: None
//Return: None
//This function Changes the options of <quit> and start to be black
.globl Print_Menu_Black_Quit
Print_Menu_Black_Quit:
	push	{r4-r10, lr}

	//Start_Game
	mov	r0, #500
	mov	r1, #600
	ldr	r2, =0x0000
	ldr	r3, =Start_Game
	bl	Draw_String

	//Quit_Game
	mov	r0, #500
	mov	r1, #700
	ldr	r2, =0x0000
	ldr	r3, =Quit_Game_Selected
	bl	Draw_String


	pop	{r4-r10, lr}
	mov	pc, lr

//Print_Menu_Starting_Game
//Args: None
//Return: None
//This function prints out the Starting_Game string
.globl Print_Menu_Starting_Game
Print_Menu_Starting_Game:
	push	{r4-r10, lr}

	ldr	r2, =0x0F00	
	bl	DrawCharB

	mov	r0, #500
	mov	r1, #600
	ldr	r2, =0x0F00
	ldr	r3, =Starting_Game
	bl	Draw_String

	ldr	r0, =0x0000
	bl	FillScreen

	bl	PixelLoopManager

	pop	{r4-r10, lr}
	mov	pc, lr

//Print_Menu_Quitting_Game
//Args: None
//Return: None
//This function prints out the Quitting_Game string
.globl Print_Menu_Quitting_Game
Print_Menu_Quitting_Game:
	push	{r4-r10, lr}

	ldr	r2, =0x0F00	
	bl	DrawCharB

	mov	r0, #500
	mov	r1, #600
	ldr	r2, =0xFFFF
	ldr	r3, =Quitting_Game
	bl	Draw_String
	
	ldr	r0, =0x0000
	bl	FillScreen

	pop	{r4-r10, lr}
	mov	pc, lr


//Menu_Controller
//Args: r4 = start/quit flag 0 = START, 1 = QUIT
//Return: r1 = start/quit return flag 0 = START, 1 = QUIT
//This function determines which button is pressed on the main menu screen. 
//The function runs on a loop waiting on input. When input is entered, it will
//be compared to up,down etc. Based on the flag it will determine what to print
//to the screen.
.globl Menu_Controller
Menu_Controller:
	push	{r4-r10, lr}
	mov	r4, #0

Menu_Wait:
	bl	Read_Data			//read in data

	//no input
	ldr     r1, =0xFFFF		
    	cmp     r0, r1
    	beq     Menu_Wait

	//dpadup
   	ldr	r1, =0xFFEF		
    	cmp	r0, r1
	beq	dpadup_Menu
	
	//dpaddown_button:
	ldr	r1, =0xFFDF
	cmp	r0, r1
	beq	dpaddown_Menu

	//A_button:
	ldr	r1, =0xFEFF
	cmp	r0, r1
	beq	A_Menu

	b	Menu_Wait

dpadup_Menu:
	ldr	r2, =0x0FF0			//draw test B
	bl	DrawCharB

	cmp	r4, #0				//Check if flag 0
	beq	Menu_Wait			//if 0, up does nothing

	cmp	r4, #1				//if 1, make <quit> black
	bleq	Print_Menu_Black_Quit

	cmp	r4, #1				//if 1, print <start>
	bleq	Print_Menu_Start
	
	moveq	r4, #0				//set flag to 0
	b	Menu_Wait

dpaddown_Menu:
	ldr	r2, =0xF0F0			//draw test B	
	bl	DrawCharB

	cmp	r4, #1				//Check if flag 1
	beq	Menu_Wait			//if 1, down does nothing

	cmp	r4, #0				//if 0, make <start> black
	bleq	Print_Menu_Black_Start

	cmp	r4, #0				//if 0, print <quit>
	bleq	Print_Menu_Quit	

	moveq	r4, #1				//set flag to 0
	b	Menu_Wait

A_Menu:	
	ldr	r2, =0xFFFF			//draw test B	
	bl	DrawCharB

	bl	Print_Menu_Black_Start		//set everything to black
	bl	Print_Menu_Black_Quit

	cmp	r4, #0				//if 0, start
	bleq	Print_Menu_Starting_Game
	moveq	r1, #0

	cmp	r4, #1				//if 1, end
	bleq	Print_Menu_Quitting_Game
	moveq	r1, #1

	b	Menu_Controller_Done
	

Menu_Controller_Done:
	pop	{r4-r10, lr}
	mov	pc, lr


.section .data
.align 4

.globl Game_Name
Game_Name:
	.asciz	"RoadFighter"


.globl Creator_Names
Creator_Names:
	.asciz	"A Video Game by Kyle Ostrander, Carlin Liu & Hilms Abou-Saleh"

.globl Main_Menu
Main_Menu:
	.asciz	"MAIN MENU"


.globl Start_Game
Start_Game:
	.asciz	"START"


.globl Quit_Game
Quit_Game:
	.asciz	"QUIT"

.globl Start_Game_Selected
Start_Game_Selected:
	.asciz	"<START>"


.globl Quit_Game_Selected
Quit_Game_Selected:
	.asciz	"<QUIT>"

.globl Starting_Game
Starting_Game:
	.asciz	"Initializing game"

.globl Quitting_Game
Quitting_Game:
	.asciz	"Exiting program..."















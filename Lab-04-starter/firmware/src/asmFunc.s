/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */
    
 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    LDR r1,=balance
    LDR r2,[r1]
    ADD r0,r0,r2
.endif
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    mov r10,0			  //storing 0 in r10 to modify the outputs later
    mov r11,1			  //storing 1 in r11 to modify the outputs later
    
    /* set output variables to 0 */
    ldr r6,= we_have_a_problem	//storing address of we_hava_a_problem in r6
    str r10,[r6]		//storing 0 to we_hava_a_problem
    ldr r6,= transaction	//storing address of transaction in r6
    str r10,[r6]		//storing 0 to transaction
    ldr r6,= eat_out		//storing address of eat_out in r6
    str r10,[r6]		//storing 0 to eat_out
    ldr r6,= stay_in		//storing address of stay_in in r6
    str r10,[r6]		//storing 0 to stay_in
    ldr r6,= eat_ice_cream	//storing address of eat_ice_cream in r6
    str r10,[r6]		//storing 0 to eat_ice_cream
    
    ldr r3,= balance	//storing balance address in r3
    ldr r8,[r3]		   //storing balance value in r8
    ldr r1,=transaction	   //stroing transaction address in r1
    str r0,[r1]		   // storing transation value to r0
    
    /* checking whether the transation value is between 1000 and -1000 or not*/
    cmp r0,1000		   //checking transation is greater than 1000 or not by using cmp
    bgt not_acceptable	   //if transation is greater than 1000 the program will direct to the not_acceptable branch
    cmp r0,-1000	   //checking transation is lower than 1000 or not by using cmp
    blt not_acceptable	   //if transation is lower than -1000 the program will direct to the not_acceptable branch
    
    /** adding transation value and balance into r4, temBalance**/
    adds r4,r0,r8	    //if the transation is between 1000 and -1000, store the result of adding transaction and balance in r4, which will be served as tmpBalance
    bvs not_acceptable	    //if the result in r4 is overflow, the program will direct to not_acceptable branch
    
    /** checking whether balance is greater than 0 or not **/
    str r4,[r3]		    //store the adding result, r4, in balance
    cmp r4,0		    //comparing the r4 with 0
    bgt balance_greater_0   //if r4 is greater than 0, the program will direct to balance_greater_0 branch
    blt balance_lesser_0    //if r4 is lower than 0, the program will direct to balance_lesser_0 branch
    
    ldr r6,= eat_ice_cream  //storing the address of eat_ice_cream in r6
    str r11,[r6]	    //storing 1 to eat_ice_cream
    b doneBalance
    
    /** bracnches**/
    /** This branch will run if the transaction is greater than 1000 or lower than -1000 or if there is an overflow in when adding
	balance and transaction **/
    not_acceptable:			    //declaring not_acceptable branch
	ldr r2,=we_have_a_problem	    //storing the address of we_have_a_problem in r2 to modify
	str r10,[r1]			    //storing 0 to transaction
	str r11,[r2]			    //storing 1 to we_have_a_problem
	mov r0,r8			    //storing balance in r0
	b done				    //done for not_acceptable branches
    
    /**This branch will run if the balance is greater than 0**/
    balance_greater_0:			    //declaring balance_greater_0 branch
	ldr r6,=eat_out			    //storing the address of eat_out in r6 to modify
	str r11,[r6]			    //storing 1 to the value of eat_out
	b doneBalance			    //done for balance_greater_0 branch
	
    /**This branch will run if the balance is leeser than 0**/
    balance_lesser_0:			    //declaring balance_lesser_0 branch
	ldr r6,= stay_in		    //storing the address of stay_in in r6 to modify
	str r11,[r6]			    //storing 1 to the value of stay_in
	b doneBalance			    //done for balance_lesser_0
    
    /** This is the final branch after running this branch the program will stop**/
    doneBalance:
	ldr r0,[r3]			    ///store the transation in balance
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           





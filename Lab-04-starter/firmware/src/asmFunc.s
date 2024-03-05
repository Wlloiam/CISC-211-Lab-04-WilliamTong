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
    
    mov r10,0 
    mov r11,1
    
    /* set output variables to 0 */
    ldr r6,= we_have_a_problem
    str r10,[r6]
    ldr r6,= transaction
    str r10,[r6]
    ldr r6,= eat_out
    str r10,[r6]
    ldr r6,= stay_in
    str r10,[r6]
    ldr r6,= eat_ice_cream
    str r10,[r6]
    
    ldr r3,= balance	//storing balance address in r3
    ldr r8,[r3]		   //storing balance value in r8
    ldr r1,=transaction	   //stroing transaction address in r1
    str r0,[r1]		   // storing transation value to r0
    
    /* checking whether the transation value is between 1000 and -1000 or not*/
    cmp r0,1000		   
    bgt not_acceptable
    cmp r0,-1000
    blt not_acceptable
    
    /** adding transation value and balance into r4, temBalance**/
    adds r4,r0,r8
    bvs not_acceptable
    
    /** checking whether balance is greater than 0 or not **/
    str r4,[r3]
    cmp r4,0
    bgt balance_greater_0
    blt balance_lesser_0
    
    ldr r6,= eat_ice_cream
    str r11,[r6]
    b doneBalance
    
    /** bracnches**/
    not_acceptable:
	ldr r2,=we_have_a_problem
	str r10,[r1]
	str r11,[r2]
	mov r0,r8
	b done
    
    balance_greater_0:
	ldr r6,=eat_out
	str r11,[r6]
	b doneBalance
	
    balance_lesser_0:
	ldr r6,= stay_in
	str r11,[r6]
	b doneBalance
	
    doneBalance:
	ldr r0,[r3]
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           





#Topaz Avraham 206842627

.section .rodata
printInvalidInput:        .string	"invalid input!\n"
.text
.globl	pstrlen 
	.type	pstrlen, @function

pstrlen:
	    pushq	%rbp	            #save the old frame pointer
	    movq	%rsp, %rbp          #create the new frame pointer

        movb  (%rdi),%al            #al=size field value of pstring

	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function

.globl	replaceChar
	.type	replaceChar, @function

replaceChar:
        pushq	%rbp                #save the old frame pointer
        movq	%rsp, %rbp          #create the new frame pointer
        pushq   %r14                #save value of callee-saved register
        movq    $0, %r14            #r14=0
        movq    %rdi, %rcx          #rcx = &pstring
        movzbq  (%rdi), %r10        #r10= size field value of pstring
        leaq    1(%rdi),%rdi        #rdi = pointer to string of pstring
        jmp startLoop               #start loop of replacing chars

startLoop:
        cmpq    %r10,%r14           #compare size field value of pstring and current len(initially 0)
        je      .FinishedString     #if current len = size field value, break


        cmp    (%r14,%rdi), %sil    #compare string[current_len] and old char
        je      .changeChar         #if equal- replace old char in new char

        incb    %r14b               #current len += 1
        jmp     startLoop           #return to loop- next iteration

.changeChar:
        movb    %dl, 1(%r14,%rcx)   #string[current_len] = newChar
        incb    %r14b               #current len += 1
        jmp     startLoop           #return to loop- next iteration


.FinishedString:
        movq    %rcx, %rax          #return &pstring after swaps
        popq    %r14                #release the memory allocated on the stack for this func
	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function


.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
	    pushq	%rbp	            #save the old frame pointer
	    movq	%rsp, %rbp          #create the new frame pointer
        pushq   %rbx                #save value on the stack to use later
        pushq   %r10                #save value on the stack to use later
        pushq   %r12                #save value on the stack to use later
        pushq   %r13                #save value on the stack to use later
        pushq   %r14                #save value on the stack to use later
        pushq   %r15                #save value on the stack to use later
        movq    %rdi, %rbx          #rbx= &dst pstring
        movzbq  (%rdi), %r10        #r10= size field value of dst pstring
        movzbq  (%rsi), %r13        #r13= size field value of src pstring
        movzbq  %dl, %r12           #r12= i
        movzbq  %cl, %r15           #r13= j
        movq    $0, %r14
        cmpq     %r14, %r12         #check if i is smaller than 0
        jl      .invalidInput
        cmpq    %r10, %r15          #check if j bigger than size value of dst pstring
        jg      .invalidInput
        cmpq    %r13, %r15          #check if j bigger than size value of src pstring
        jg      .invalidInput
        cmp     %r12,%r15           #check if i > j
        jl      .invalidInput
        jmp     .copySubString      #when reached here, all edge cases are covered, so do copy

.copySubString:
        cmp     %r12,%r15           #check if i > j
        jl      .finishedCopy       #in case i>j we finished copying
        movb    1(%r12,%rsi), %r14b #r14b = src[i]
        movb    %r14b, 1(%r12,%rdi) #dst[i] = src[i]
        incq    %r12                #current_index += 1
        jmp     .copySubString      #next iteration

.finishedCopy:
        movq    %rbx, %rax          #return &dst pstring
        popq    %r15                #release memory used by function
        popq    %r14                #release memory used by function
        popq    %r13                #release memory used by function
        popq    %r12                #release memory used by function
        popq    %r10                #release memory used by function
        popq    %rbx                #release memory used by function
	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function


.invalidInput:
        movq    $printInvalidInput, %rdi #send the string of invalid input as first parameter to printf
        call    printf
        movq    %rbx, %rax          #return &dst pstring
        popq    %r15                #release memory used by function
        popq    %r14                #release memory used by function
        popq    %r13                #release memory used by function
        popq    %r12                #release memory used by function
        popq    %r10                #release memory used by function
        popq    %rbx                #release memory used by function
	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function



.globl	swapCase
	.type	swapCase, @function

swapCase:
	    pushq	%rbp	            #save the old frame pointer
	    movq	%rsp, %rbp          #create the new frame pointer
        pushq   %r13                #save value of callee-saved register
        pushq   %r14                #save value of callee-saved register
        pushq   %rbx                #save value of callee-saved register
        pushq   %r15                #save value of callee-saved register
        movzbq  (%rdi), %rbx        #rbx = size field value of pstring
        movq    %rdi, %r14          #r14 = &pstring
        leaq    1(%rdi), %rdi       #rdi = address to the string of pstring
        movq    $0, %r15            #r15 = 0
        jmp     swapLoop

swapLoop:
        movzbq  (%rdi,%r15), %r13   #r13 = string[current_index], current_index initially 0
        cmpq    %r15, %rbx          #check if size field value = current_index
        je      finishedSwap


        cmpq     $65, %r13          #check if string[current_index] is not a letter
        jl      nextIteration

        cmpq     $122, %r13         #check if string[current_index] is not a letter
        jg      nextIteration

        cmpq     $96, %r13          #check if string[current_index] is between 97 and 121 - lower case letter
        jg      doSwapToUpper

        cmpq     $91, %r13          #when reached here string[current_index] is upper case letter
        jl      doSwapToLower

        jmp     nextIteration

doSwapToUpper:
        subb    $32, (%rdi,%r15)    #string[current_index] += 32, changes the lower case letter to upper
        incq    %r15                #current_index += 1
        jmp     swapLoop            #go back to loop



doSwapToLower:
        addb    $32, (%rdi,%r15)    #string[current_index] -= 32, changes the upper case letter to lower
        incq    %r15                #current_index += 1
        jmp     swapLoop            #go back to loop



nextIteration:
        incq    %r15                #current_index += 1
        jmp swapLoop                #go back to loop

finishedSwap:
        movq    %r14, %rax          #return &pstring after swaps
        popq    %r15                #release memory used by function
        popq    %rbx                #release memory used by function
        popq    %r14                #release memory used by function
        popq    %r13                #release memory used by function
	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function

.globl	pstrijcmp
	.type	pstrijcmp, @function

pstrijcmp:
	    pushq	%rbp	            #save the old frame pointer
	    movq	%rsp, %rbp          #create the new frame pointer
        pushq   %r9                 #save value on the stack to use later
        pushq   %rbx                #save value on the stack to use later
        pushq   %r10                #save value on the stack to use later
        pushq   %r11                #save value on the stack to use later
        pushq   %r12                #save value on the stack to use later
        pushq   %r14                #save value on the stack to use later
        pushq   %r15                #save value on the stack to use later

        movq    %rdi, %rbx          #rbx= &pstring1
        movzbq  (%rdi), %r10        #r10= size field value of pstring1
        movzbq  (%rsi), %r11        #r11= size field value of pstring2
        movzbq  %dl, %r12           #r12= i
        movzbq  %cl, %r15           #r15= j

        movq    $0, %r14            #r14= 0
        movq    $0, %r9             #r9= 0
        cmpq     %r14, %r12         #check if i is smaller than 0
        jl      .invalidCmpInput
        cmpq    %r10, %r15          #check if j bigger than size value of pstring1
        jg      .invalidCmpInput
        cmpq    %r11, %r15          #check if j bigger than size value of pstring2
        jg      .invalidCmpInput
        cmp     %r12,%r15           #check if i > j
        jl      .invalidCmpInput
        jmp     .compareStrings     #when reached here, all edge cases are covered, so do compare

.invalidCmpInput:
        movq    $printInvalidInput, %rdi    #send the string of invalid input as first parameter to printf
        movq    $0, %rax            #before calling printf
        call    printf
        movq    $0, %rax            #to indicate printf was successfull
        movq    $-2, %rax           #return compare result = -2
        jmp     .finishCmp

.compareStrings:
        cmp     %r12,%r15           #check if i > j, if its true when reached here, compare of all substring is equal
        jl      .identical

        movb    1(%r12,%rdi), %r9b  #r9b= string[current_index] in pstr1, initially current_index is i
        movb    1(%r12,%rsi), %r14b #r14b= string[current_index] in pstr2, initially current_index is i

        cmpb    %r14b, %r9b         #compare string1[current_index] - string2[current_index]
        jg      .returnFirstBigger  #check if > 0 so pstr1 is bigger

        jl      .returnSecondBigger #check if < 0 so pstr1 is bigger

        incq    %r12                #current_index += 1
        jmp     .compareStrings     #when reached here string1[current_index] = string2[current_index] so next iteration


.returnFirstBigger:
        movq    $1, %rax            #when reached here pstr1 is bigger so return 1
        jmp     .finishCmp

.returnSecondBigger:
        movq    $-1, %rax           #when reached here pstr2 is bigger so return -1
        jmp     .finishCmp


.identical:
        movq    $0, %rax            #when reached here string1[i:j] = string2[i:j] so return 0
        jmp     .finishCmp


.finishCmp:
        popq    %r15                #release memory used by function
        popq    %r14                #release memory used by function
        popq    %r12                #release memory used by function
        popq    %r11                #release memory used by function
        popq    %r10                #release memory used by function
        popq    %rbx                #release memory used by function
        popq    %r9                 #release memory used by function
	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function







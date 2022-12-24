#Topaz Avraham 206842627

.section .rodata
printCase31:        .string	"first pstring length: %d, second pstring length: %d\n"
printCase32Case33:   .string	"old char: %c, new char: %c, first string: %s, second string: %s\n"
printCase35:      .string	"length: %d, string: %s\n"
printCase36:      .string	"length: %d, string: %s\n"
printCase37:      .string	"compare result: %d\n"
printCaseDefault:            .string	"invalid option!\n"
scanfInt:       .string      "%d"
scanfChar:      .string      "%c"
scanfString:       .string      "%s"

    .align 8
.switchCase:
.quad .CaseDefault
.quad .Case31
.quad .Case32
.quad .Case33
.quad .CaseDefault
.quad .Case35
.quad .Case36
.quad .Case37

.text
.globl	run_func
	.type	run_func, @function
run_func:
	    pushq	%rbp	            #save the old frame pointer
	    movq	%rsp, %rbp          #create the new frame pointer
        pushq   %rbx                #save value of callee-saved register
        pushq   %r12                #save value of callee-saved register
        pushq   %r13                #save value of callee-saved register
        movq    %rsi, %r12          #r12=&pstring1
        movq    %rdx, %r13          #r13=&pstring2
        movq    %rdi, %rbx          #rbx= opt
        leaq -30(%rbx),%rbx         #opt-=30
        cmpq $7,%rbx                #Compare opt-30 - 7
        jg .CaseDefault             #if > 0 then go to default
        cmpq $1,%rbx                #Compare opt-30 - 1
        jl .CaseDefault             #if < 0 go to default
        jmp *.switchCase(,%rbx,8)   #go to case the user entered


.CaseDefault:
        movq    $printCaseDefault, %rdi     #send the string as first parameter to printf
        call    printf
        movq   $0, %rax     #to indicate printf was successfull
        jmp      .Finish


.Case31:
        movq    %r12, %rdi          #pass &pstring1 as first parameter to pstrlen
        call    pstrlen
        movb    %al, %r14b          #r14b = byte of result (size field of pstring1)

        movq    %r13, %rdi          #pass &pstring2 as first parameter to pstrlen
        call    pstrlen
        movb    %al, %r15b          #r14b = byte of result (size field of pstring2)

        movzbq   %r14b, %rsi        #send as second parameter to printCase31 the size field of pstring1
        movzbq   %r15b, %rdx        #send as third parameter to printCase31 the size field of pstring2
        movq	$printCase31, %rdi  #send as first parameter to printCase31 the string itself
	    movq	$0, %rax            #before calling printf
	    call	printf
	    movq	$0, %rax            #to indicate printf was successfull
        jmp      .Finish


.Case32:
.Case33:
        subq    $8, %rsp            #allocate 8 bytes on the stack
        movq    $0, %rax            #before calling scanf
        movq    $scanfString, %rdi  #send as first parameter to scanf the string itself
        movq    %rsp, %rsi          #send as second parameter to scanf the address to save input in
        call    scanf

        movq    $0, %rax            #to indicate scanf was successfull
        movq    $scanfString, %rdi  #send as first parameter to scanf the string itself
        leaq    4(%rsp), %rsi       #send as second parameter to scanf the address to save input in
        call    scanf

        movq    %r12, %rdi          #address of pstring1 as first parameter to replaceChar
        movq    (%rsp), %rsi        #send as second parameter to replaceChar the old char
        movq    4(%rsp), %rdx       #send as third parameter to replaceChar the new char
        call    replaceChar
        movq    %rax, %r12          #r12= &pstring1 after swaps

        movq    %r13, %rdi          #address of pstring2 as first parameter to replaceChar
        movq    (%rsp), %rsi        #send as second parameter to replaceChar the old char
        movq    4(%rsp), %rdx       #send as third parameter to replaceChar the new char
        call    replaceChar
        movq    %rax, %r13          #r13= &pstring2 after swaps

        movq    $printCase32Case33, %rdi    #send the string as first parameter to printf
        movzbq    (%rsp), %rsi      #send as second parameter to printf the old char
        movzbq    4(%rsp), %rdx     #send as third parameter to printf the old char
        leaq    1(%r12), %rcx       #send as forth parameter to printf the address of the string of pstring1
        leaq    1(%r13), %r8        #send as fifth parameter to printf the address of the string of pstring2
        call    printf
        movq    $0, %rax            #to indicate printf was successfull
        addq    $8, %rsp            #release the memory allocated on the stack for this case
        jmp .Finish

.Case35:
        subq    $8, %rsp            #allocate 8 bytes on the stack
        movq    $0, %rax            #before calling scanf
        movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
        movq    %rsp, %rsi          #send as second parameter to scanf the address to save input in
        call    scanf

        movq    $0, %rax            #to indicate scanf was successfull
        movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
        leaq    4(%rsp), %rsi       #send as second parameter to scanf the address to save input in
        call    scanf

        movq    %r12, %rdi          #send &pstring1 as first parameter to pstrijcpy
        movq    %r13, %rsi          #send &pstring2 as first parameter to pstrijcpy
        movzbq  (%rsp), %rdx        #send i as third parameter to pstrijcpy
        movzbq  4(%rsp), %rcx       #send j as third parameter to pstrijcpy
        call    pstrijcpy

        movq    %rax, %r12          #r12= the return from pstrijcpy which is &pstring1
        movq    $printCase35, %rdi  #send as first parameter to printf the string itself
        movzbq  (%r12), %rsi        #send the size field value of pstring1 as second parameter to printf
        leaq    1(%r12), %rdx       #send the address of the string of pstring1 as third parameter to printf
        call    printf
        movq    $0, %rax            #to indicate printf was successfull

        movq    $printCase35, %rdi  #send as first parameter to printf the string itself
        movzbq  (%r13), %rsi        #send the size field value of pstring2 as second parameter to printf
        leaq    1(%r13), %rdx       #send the address of the string of pstring2 as third parameter to printf
        call    printf
        movq    $0, %rax            #to indicate printf was successfull

        addq    $8, %rsp            #release the memory allocated on the stack for this case
        jmp .Finish

.Case36:
        movq    %r12, %rdi          #send &pstring1 as first parameter to swapCase
        call    swapCase
        movq    %rax, %r12          #r12= &pstring1 after swaps

        movq    $printCase36, %rdi  #send as first parameter to printf the string itself
        movzbq  (%r12), %rsi        #send the size field value of pstring1 as second parameter to printf
        leaq    1(%r12), %rdx       #send the address of the string of pstring1 as third parameter to printf
        movq    $0, %rax            #before calling printf
        call    printf
        movq    $0, %rax            #to indicate printf was successfull



        movq    %r13, %rdi          #send &pstring1 as first parameter to swapCase
        call    swapCase
        movq    $0, %rax
        movq    $printCase36, %rdi  #send as first parameter to printf the string itself
        movzbq   (%r13), %rsi       #send the size field value of pstring1 as second parameter to printf
        leaq    1(%r13), %rdx       #send the address of the string of pstring1 as third parameter to printf
        call    printf
        movq    $0, %rax            #to indicate printf was successfull

        jmp .Finish

.Case37:
        subq    $8, %rsp            #allocate 8 bytes on the stack
        movq    $0, %rax            #before calling scanf
        movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
        movq    %rsp, %rsi          #send as second parameter to scanf the address to save input in
        call    scanf

        movq    $0, %rax            #before calling scanf
        movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
        leaq    4(%rsp), %rsi       #send as second parameter to scanf the address to save input in
        call    scanf

        movq    %r12, %rdi          #send &pstring1 as first parameter to pstrijcmp
        movq    %r13, %rsi          #send &pstring2 as second parameter to pstrijcmp
        movzbq  (%rsp), %rdx        #send i as third parameter to pstrijcmp
        movzbq  4(%rsp), %rcx       #send i as forth parameter to pstrijcmp
        call    pstrijcmp


        movq    %rax, %r10          #r10= compare result
        movq    $printCase37, %rdi  #send as first parameter to printf the string itself
        movq    %r10, %rsi          #send as second parameter to printf the compare result
        call    printf
        movq    $0, %rax            #to indicate printf was successfull

        addq    $8, %rsp            #release the memory allocated on the stack for this case
        jmp .Finish


.Finish:
        popq   %rbx                 #release the memory allocated on the stack for this case
        popq   %r12                 #release the memory allocated on the stack for this case
	    movq	%rbp, %rsp          #restore the old stack pointer
	    popq	%rbp	            #restore old frame pointer
	    ret		                    #return to caller function

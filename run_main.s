#Topaz Avraham 206842627

.section	.rodata
	.align	8
scanfInt:	.string	"%d"
scanfString:	.string	"%s"

	.text
.global	run_main
	.type	run_main,	@function
run_main:
	pushq	%rbp		        #save the old frame pointer
	movq	%rsp, %rbp	        #create the new frame pointer

    subq    $528, %rsp          #allocate memory in stack to store 2 pstring (including space for /0 for strings)

    movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
    movq    %rsp, %rsi          #send as second parameter to scanf the address to save input in
    movq    $0, %rax            #before calling scanf
    call    scanf
    movq    $0, %rax            #to indicate scanf was successfull

    movq    %rsp, %r14          #r14 is pointer to size field variable in pstring1
    movzbq  (%rsp), %r9         #r9  is the size field value of pstring1
    leaq    1(%rsp, %r9), %r10  #r10 is pointer to end of string of pstring1
    leaq    1(%rsp), %r8        #r8 is pointer to string of pstring1
    movb      $0, (%r10)        #put 0 in the end of string in pstring1

    movq    $scanfString, %rdi  #send as first parameter to scanf the string itself
    movq    %r8, %rsi           #send as second parameter to scanf the address to save input- r8 is pointer to string
    movq    $0, %rax            #before calling scanf
    call    scanf
    movq    $0, %rax            #to indicate scanf was successfull



    leaq    256(%rsp), %r12     #r12 is pointer to size field variable in pstring2

    movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
    movq    %r12, %rsi          #send the pointer to size field variable in pstring2 as second parameter to scanf
    movq    $0, %rax            #before calling scanf
    call    scanf
    movq    $0, %rax            #to indicate scanf was successfull

    movzbq  256(%rsp), %r9      #r9 now is the size field value of pstring2
    leaq    257(%rsp, %r9), %r10        #r10 now is pointer to end of string of pstring2
    leaq    257(%rsp), %r8      #r8 now is pointer to string of pstring2
    movb      $0, (%r10)        #put 0 in the end of string in pstring2

    movq    $scanfString, %rdi  #send as first parameter to scanf the string itself
    movq    %r8, %rsi           #send as second parameter to scanf the address to save input- r8 is pointer to string
    movq    $0, %rax            #before calling scanf
    call    scanf
    movq    $0, %rax            #to indicate scanf was successfull

    subq    $16, %rsp           #allocate 16 bytes to store opt inputed by user
    movq    $0, %rax            #before calling scanf
    movq    $scanfInt, %rdi     #send as first parameter to scanf the string itself
    movq    %rsp, %rsi          #send as second parameter to scanf the address to save input in
    call    scanf

    movq    $0, %rax            #to indicate scanf was successfull
    movzbq  (%rsp), %r13        #r13= opt

    movq    %r13, %rdi          #send opt as first parameter to run_func
    movq    %r14, %rsi          #send &pstring1 as second parameters to run_func
    movq    %r12, %rdx          #send &pstring2 as second parameters to run_func
    call    run_func
    movq    $0, %rax            #to indicate run_func was successfull


    movq    %rbp,%rsp           #restore the old stack pointer
    popq    %rbp                #restore old frame pointer
    ret                         #return to caller function









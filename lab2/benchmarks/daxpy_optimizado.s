	.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .dword 2      // scalar value
	
	.bss 
	X: .zero  32768        // vector X(4096)*8
	Y: .zero  32768        // Vector Y(4096)*8
        Z: .zero  32768        // Vector Y(4096)*8

	.arch armv8-a
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	x1, 0
	mov	x0, 0
	bl	m5_dump_stats

	ldr     x0, N
    	ldr     x10, =Alpha
    	ldr     x2, =X
    	ldr     x3, =Y
	ldr     x4, =Z

//---------------------- CODE HERE ------------------------------------

	daxpy_loop:
        cmp x1, x0              // comparo i con N
        b.ge daxpy_end

        // hacemos loop unrolling de 4 indices
        mov x6, x1              // i
        add x7, x1, #1          // i + 1
        add x8, x1, #2          // i + 2
        add x9, x1, #3          // i + 3

        // cargamos X[i], X[i+1], X[i+2], X[i+3]
        ldr d1, [x2, x6, LSL #3]
        ldr d5, [x2, x7, LSL #3]
        ldr d9, [x2, x8, LSL #3]
        ldr d13, [x2, x9, LSL #3]

        // cargamos Y[i], Y[i+1], Y[i+2], Y[i+3]
        ldr d2, [x3, x6, LSL #3]
        ldr d6, [x3, x7, LSL #3]
        ldr d10, [x3, x8, LSL #3]
        ldr d14, [x3, x9, LSL #3]

        ldr x5, [x10]
        scvtf d0, x5// convertimo alpha a punto flotante una vez

        fmul d3, d0, d1// Z[i] = alpha * X[i+1]
        fadd d3, d3, d2// Z[i] = Z[i] + Y[i+1]
        str d3, [x4, x6, LSL #3]// guardamos Z[i] en x4

        fmul d7, d0, d5
        fadd d7, d7, d6
        str d7, [x4, x7, LSL #3]    // guardamos Z[i+1] en x4

        fmul d11, d0, d9
        fadd d11, d11, d10
        str d11, [x4, x8, LSL #3]   // guardamos Z[i+2]

        fmul d15, d0, d13
        fadd d15, d15, d14
        str d15, [x4, x9, LSL #3]   // guardamos Z[i+3]

        add x1, x1, #4              // sumo 4 a i
        b daxpy_loop

    daxpy_end:

//---------------------- END CODE -------------------------------------

	mov 	x0, 0
	mov 	x1, 0
	bl	m5_dump_stats
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits

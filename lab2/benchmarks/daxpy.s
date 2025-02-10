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
        cmp x1, x0    // comparo i con N
        b.ge daxpy_end    // si i >= N

        ldr d1, [x2, x1, LSL #3]
        ldr d2, [x3, x1, LSL #3]    //guardamos X[i] en d1 y Y[i] en d2 

        ldr x5, [x10]
        scvtf d0, x5    // convertimos alpha en punto flotante

        fmul d3, d0, d1    // Z[i] = alpha * X[i]
        fadd d3, d3, d2    // Z[i] = Z[i] + Y[i]

        str d3, [x4, x1, LSL #3]    // guardamos Z[i] en x4

        add x1, x1, 1    // sumo 1 a i

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

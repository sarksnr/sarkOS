ORG 0x7C00
bits 16

start:
	jmp main

;print str to screen
;Params:
;	-ds:si points to str	

puts:
	;save registers to modify
	push s1
	push ax

.loop:
	lodsb ;load next char in al
	or al,al	;verify if next char is null
	jz .done

	mov ah, 0x0e
	int 0x10

	jmp .loop 

.done:
	pop ax
	pop si
	ret
	

main:
	; setup data segments
	mov ax, 0 ; no writing to es/ds directly
	mov ds, ax
	mov es, ax

	; setup stack
	mov ss, ax
	mov es, 0x7C00

	mov si, msg_hello
	call puts

	hlt

.halt:
	jmp .halt

msg_hello: db 'Hello world!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h

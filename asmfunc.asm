section .text
bits 64
default rel
global flipHorizontal

flipHorizontal:
    ; Arguments:
    ; rcx - img2 (destination)
    ; rdx - img1 (source)
    ; r8 - m (width)
    ; r9 - n (height)
    
    push rbx
    push r12
    push r13

    mov r12, rcx ; img2
    mov r13, rdx ; img1
    
    xor r10, r10; r10 = y (row index)
    
    flip_loop_rows:
        cmp r10, r9 ; if y >= n , end loop
        jge end_flip
        
        xor r11, r11 ; r11 = x (column index)
        
        flip_loop_cols:
            cmp r11, r8 ; if x >= m , end loop
            je end_flip_row

           ; get row
            mov rax, r10
            imul rax, 3
            imul rax, r8
            mov rdx, rax ; rdx = r8 * 3 * r10
            
            ; get destination index
            mov rbx, r8
            sub rbx, r11
            dec rbx 
            imul rbx, 3                  
            add rbx, rdx ; rbx = r8 * 3 * r10 + (r8 - r11 - 1) * 3
            
            ; get source index
            mov rax, r11
            imul rax, 3        
            add rdx, rax ; rdx + r11 * 3

            ; calculate source addresses [r13 + r8 * 3 * r10 + r11 * 3]
            lea rax, [r13 + rdx] ; rax = &img1[y][x]

            ; calculate destination addresses [r12 + r8 * 3 * r10 + (r8 - r11 - 1) * 3]
            lea rbx, [r12 + rbx] ; rbx = &img2[y][m-x-1] 
            
            
            ; copy RGB values
            mov rcx, 3
            
            flip_loop_channels:
                dec rcx
                js end_flip_channels
                
                mov dl, [rax + rcx]
                mov [rbx + rcx], dl
                jmp flip_loop_channels
                
        end_flip_channels:
            inc r11 ; x++
            jmp flip_loop_cols
                
            end_flip_row:
                inc r10 ; y++
                jmp flip_loop_rows
                
    end_flip: 
        pop r13
        pop r12
        pop rbx

        xor rax, rax
        ret
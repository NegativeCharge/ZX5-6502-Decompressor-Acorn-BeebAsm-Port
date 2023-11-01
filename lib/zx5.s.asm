.unZX5        lda   #$ff
              sta   offset
              sta   offset+1
              ldy   #$00
              sty   len
              sty   len+1
              lda   #$80

.dzx5s_literals
              jsr   dzx5s_elias
              pha
.cop0         jsr   _GET_BYTE
              ldy   #$00
              sta   (ZX5_OUTPUT),y
              inc   ZX5_OUTPUT
			  bne   skip1
			  inc   ZX5_OUTPUT+1
.skip1
              lda   len
              bne   l1
              dec   len+1
.l1           dec   len
              bne   cop0
              lda   len+1
              bne   cop0
              pla
              asl   a
              bcs   dzx5s_other_offset

.dzx5s_last_offset
              jsr   dzx5s_elias
.dzx5s_copy   pha
              lda   ZX5_OUTPUT
              clc
              adc   offset
              sta   copysrc
              lda   ZX5_OUTPUT+1
              adc   offset+1
              sta   copysrc+1
              ldy   #$00
              ldx   len+1
              beq   Remainder
.Page         lda   (copysrc),y
              sta   (ZX5_OUTPUT),y
              iny
              bne   Page
              inc   copysrc+1
              inc   ZX5_OUTPUT+1
              dex
              bne   Page
.Remainder    ldx   len
              beq   copyDone
.copyByte     lda   (copysrc),y
              sta   (ZX5_OUTPUT),y
              iny
              dex
              bne   copyByte
              tya
              clc
              adc   ZX5_OUTPUT
              sta   ZX5_OUTPUT
              bcc   copyDone
              inc   ZX5_OUTPUT+1
.copyDone     stx   len+1
              stx   len
              pla
              asl   a
              bcc   dzx5s_literals

.dzx5s_other_offset
              asl   a
              bne   dzx5s_other_offset_skip
              jsr   _GET_BYTE
              sec   
              rol   a
.dzx5s_other_offset_skip
              bcc   dzx5s_prev_offset

.dzx5s_new_offset
              sta   pnb
              asl   a
              ldx   offset2
              stx   offset3
              ldx   offset2+1
              stx   offset3+1
              ldx   offset
              stx   offset2
              ldx   offset+1
              stx   offset2+1
              ldx   #$fe
              stx   len
              jsr   dzx5s_elias_loop
              pha
              ldx   len
              inx
              stx   offset+1
              bne   l2
              pla
              rts
.l2           jsr   _GET_BYTE
              sta   offset
              ldx   #$00
              stx   len+1
              inx
              stx   len
              pla
              dec   pnb
              bmi   l3
              jsr   dzx5s_elias_backtrack
.l3           inc   len
			  bne   skip2
			  inc   len+1
.skip2
              jmp   dzx5s_copy

.dzx5s_prev_offset
              asl   a
              bcc   dzx5s_second_offset
              ldy   offset2
              ldx   offset3
              sty   offset3
              stx   offset2
              ldy   offset2+1
              ldx   offset3+1
              sty   offset3+1
              stx   offset2+1

.dzx5s_second_offset
              ldy   offset2
              ldx   offset
              sty   offset
              stx   offset2
              ldy   offset2+1
              ldx   offset+1
              sty   offset+1
              stx   offset2+1
              jmp   dzx5s_last_offset

.dzx5s_elias  inc   len
.dzx5s_elias_loop
              asl   a
              bne   dzx5s_elias_skip
              jsr   _GET_BYTE
              sec   
              rol   a
.dzx5s_elias_skip
              bcc   dzx5s_elias_backtrack
              rts
.dzx5s_elias_backtrack
              asl   a
              rol   len
              rol   len+1
              jmp   dzx5s_elias_loop
			
._GET_BYTE    lda   $ffff
ZX5_INPUT     =     *-2
              inc   ZX5_INPUT
			  bne   skip3
			  inc   ZX5_INPUT+1
.skip3
              rts
; Draws sprites

UpdateSprites:
  ; draw ship
  lda ship_y
  sta $0200
  sta $0204
  clc
  adc #$08
  sta $0208
  sta $020C
  
  lda ship_x
  sta $0203
  sta $020B
  clc
  adc #$08
  sta $0207
  sta $020F
  
  ; draw laser
  lda laser_1_y
  sta $0210
  lda laser_1_x
  sta $0213
  
  lda laser_2_y
  sta $0214
  lda laser_2_x
  sta $0217
  
  lda laser_3_y
  sta $0218
  lda laser_3_x
  sta $021B
  
  ; draw aliens
  ; write a fancy loop here later
  lda alien_1_y
  sta $021C
  sta $0220
  clc
  adc #$08
  sta $0224
  sta $0228
  lda alien_1_x
  sta $021F
  sta $0227
  clc
  adc #$08
  sta $0223
  sta $022B
  
  lda alien_2_y
  sta $022C
  sta $0230
  clc
  adc #$08
  sta $0234
  sta $0238
  lda alien_2_x
  sta $022F
  sta $0237
  clc
  adc #$08
  sta $0233
  sta $023B
  
  lda alien_3_y
  sta $023C
  sta $0240
  clc
  adc #$08
  sta $0244
  sta $0248
  lda alien_3_x
  sta $023F
  sta $0247
  clc
  adc #$08
  sta $0243
  sta $024B
  
  lda alien_4_y
  sta $024C
  sta $0250
  clc
  adc #$08
  sta $0254
  sta $0258
  lda alien_4_x
  sta $024F
  sta $0257
  clc
  adc #$08
  sta $0253
  sta $025B
  
  ; draw score hard coded
  lda digit_1
  clc
  adc #$04
  sta $025D
  lda digit_2
  clc
  adc #$04
  sta $0261
  lda digit_3
  clc
  adc #$04
  sta $0265
  lda digit_4
  clc
  adc #$04
  sta $0269
  
  ; draw life
  lda lives
  clc
  adc #$04
  sta $0285
  
  rts

DrawBG:
; update bg
  lda bg_cooldown
  sec
  sbc #$01
  sta bg_cooldown
  bne .bg_cooldown_done
  
  ; reset time
  lda #BG_COOLDOWN_TIME
  sta bg_cooldown
  
  lda #%00001000 ; disable NMI
  sta $2000
  lda #%00000000 ; disable rendering
  sta $2001
  
  ; switch choice
  lda #%11111111
  eor bg_choice
  sta bg_choice
  beq .switch_second

  lda #LOW(gameover_bg_sub_1)
  sta pointerLo
  lda #HIGH(gameover_bg_sub_1)
  sta pointerHi
  jmp .switch_done
.switch_second:
  lda #LOW(gameover_bg_sub_2)
  sta pointerLo
  lda #HIGH(gameover_bg_sub_2)
  sta pointerHi
.switch_done:
  
  jsr LoadPartialBG
  lda #%10001000
  sta $2000 ; set PPUCTRL
  lda #%10001110
  sta $2001 ; set PPUMASK
  lda #%00000000
  
.bg_cooldown_done:
  rts
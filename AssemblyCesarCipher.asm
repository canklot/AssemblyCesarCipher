.MODEL SMALL
.STACK 100H
.DATA

CR EQU 0DH
LF EQU 0AH

MSG0 DB 'WELCOME TO THE EMU8086 CESAR CIPHER: ',0DH,0AH,0DH,0AH, 'PLEASE ENTER HOW MANY TIMES DO YOU WANT TO SHIFT THE ALPHABET:  ', '$'
MSG1 DB 0DH,0AH, 0DH,0AH, 'ENTER THE ORIGINAL MESSAGE LETTER BY LETTER: $'
MSG2 DB 0DH,0AH, 'CRYPTED MESSAGE IS LETTER BY LETTER: '
 

CHAR DB ?, 0DH,0AH ,'$'

.CODE

MAIN PROC
    ;INITALIZE DS
    MOV AX, @DATA       ;get data segment
    MOV DS,AX           ;initailize DS
    
    ;display welcome message
    LEA DX,MSG0         ;MSG0'in adresini dx'e yukle
    MOV AH,9            ;AH registerina 9 yaz. Bu ekrana bas demek
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen INT21 fonksiyonu'nu cagir. Bu fonksiyon dx yazmacinda belirtilen ofset adresinden itibaren $ karakteri ile karsilasana kadar karakterleri ekrana yazar.
  
    ;input number
    MOV AH,1            ;AH registerine 1 yaz.
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen fonksiyonu cagir. INT21,1 fonksiyonu klavyeden veri girisi icin beklenir. Klavyeden girilen tus AL yazmacina koyulur.
    SUB AL,30h          ;Neden bilmiyorum ama 1 girince 31 oluyor o yuzden 30 cikardik. Normal 30 yazinca olmuyor 30h olmasi lazim
    MOV BH,AL           ;AL'yi BH'a kopyala
 
    

 
    go:                 ;go isimli bir belirtec koy
    
    ;display MSG1
    LEA DX,MSG1         ;MSG0'in adresini dx'e yukle
    MOV AH,9            ;AH registerina 9 yaz.
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen INT21 fonksiyonu'nu cagir. Bu fonksiyon dx yazmacinda belirtilen ofset adresinden itibaren $ karakteri ile karsilasana kadar karakterleri ekrana yazar.




 

    ;input letter
    MOV AH,1            ;AH registerine 1 yaz
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen fonksiyonu cagir. INT21,1 fonksiyonu klavyeden veri girisi icin beklenir. Klavyeden girilen tus AL yazmacina koyulur.
    add AL, bh          ;AL registerini BH kadar arttir
    MOV CHAR, AL        ;AL'yi CHAR db'sine yaz. 

    ;display on ciphered text
    LEA DX,MSG2         ;MSG2'in adresini dx'e yukle
    MOV AH,9            ;AH registerine 9 yaz
    INT 21H             ;Dolar isareti gorene kadar ekrana bas. MSG2'nin sonunda dolar isareti yok ve sonrasinde bellekte CHAR degeri var bu yuzden hem MSG2 hem CHAR degeri ekrana basilir.
    

    

    jmp go  ;go isili belirtece zipla
            ;donguyle surekli olarak harf almasini sagliyoruz


    ;DOS EXIT
    MOV AH,4CH
    INT 21H             ;dos exit   
    
    
    
    alphabetoverflow:
    
    
    ;not alphabet overflow hatasini kapat
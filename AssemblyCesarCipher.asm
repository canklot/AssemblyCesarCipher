.MODEL SMALL
.STACK 100H
.DATA

CR EQU 0DH
LF EQU 0AH

numbers DB ?,'$'        ;Soru isareti initialize olmamis tek byte demek max 127 tutabilir. Dolar isareti ise string sonu demek.

harf DB ?

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
  
    ;input numbers
    MOV AH,1            ;AH registerine 1 yaz.
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen fonksiyonu cagir. INT21,1 fonksiyonu klavyeden veri girisi icin beklenir. Klavyeden girilen tus AL yazmacina koyulur.
    SUB AL,30h          ;1'in ascii degeri hexadecimal 31 oldugu icin 30h cikariyoruz.
    MOV DL,10
    MUL DL
    MOV numbers,AL
    
    MOV AH,1            ;AH registerine 1 yaz.
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen fonksiyonu cagir. INT21,1 fonksiyonu klavyeden veri girisi icin beklenir. Klavyeden girilen tus AL yazmacina koyulur.
    SUB AL,30h
    ADD AL,numbers
    MOV numbers,AL
 
    

 
    go:                 ;go isimli bir belirtec koy
    
    ;display MSG1
    LEA DX,MSG1         ;MSG1'in adresini dx'e yukle
    MOV AH,9            ;AH registerina 9 yaz.
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen INT21 fonksiyonu'nu cagir. Bu fonksiyon dx yazmacinda belirtilen ofset adresinden itibaren $ karakteri ile karsilasana kadar karakterleri ekrana yazar.




 

    ;input letter
    MOV AH,1            ;AH registerine 1 yaz
    INT 21H             ;AH registerine bak ve icindeki sayiya karsilik gelen fonksiyonu cagir. INT21,1 fonksiyonu klavyeden veri girisi icin beklenir. Klavyeden girilen tus AL yazmacina koyulur.
    MOV harf, AL
    
   
    
    ;Add
    MOV AL, harf
    add AL, numbers          ;AL registerini arttir
    mov harf, AL
    
    
    CMP AL,7Ah
    JNB  alphabetoverflow
     
    displayciphered: 
     
    ;display on ciphered text 
    MOV CHAR, AL        ;AL'yi CHAR db'sine yaz. Daha sonra burasi ekrana bailacak
    LEA DX,MSG2         ;MSG2'in adresini dx'e yukle
    MOV AH,9            ;AH registerine 9 yaz
    INT 21H             ;Dolar isareti gorene kadar ekrana bas. MSG2'nin sonunda dolar isareti yok ve sonrasinde bellekte CHAR degeri var bu yuzden hem MSG2 hem CHAR degeri ekrana basilir.
    

    

    jmp go  ;go isili belirtece zipla
            ;donguyle surekli olarak harf almasini sagliyoruz


    ;DOS EXIT
    MOV AH,4CH
    INT 21H             ;dos exit   
    
    
    
    alphabetoverflow:
    SUB AL,0x1A
    JMP displayciphered
    
    
    
    
    ;not tek basamakli sayi girilebiliyor sadece onu duzelt
    
    
    ;Not tum sayilari decimale cevir oyle islem yap hex oldugunu unutuyorsun sonra 1+10 neden 17 yapiyor diyosun
    
    ;Neden bilmiyorum ama 1 girince 31 oluyor o yuzden 30 cikardik. Normal 30 yazinca olmuyor 30h olmasi lazim. Debug yaparken variables kisminda degiskenleri hex,bin,ascii olarak goster var o zaman anladim. Assci olarak 1 hexadecimal 31 oluyorus. Cok sacma ben 1'in degeri 1 olmali bence neden gidip taa 31'e koyarsin ki?
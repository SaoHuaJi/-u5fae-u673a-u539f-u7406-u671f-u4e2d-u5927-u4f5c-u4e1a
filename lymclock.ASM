DATA SEGMENT PARA 'DATA'
    FILE0 DB 'BUPT0.BMP',00    ;主页面图像文件
    FILE1 DB 'BUPT1.BMP',00    ;日期时间页面图像文件
    HANDLE DW ?    ;文件句柄
;图像信息及数据
    HEAD DB 54 DUP(0)
    COLOR DB 1024 DUP(0)
    DATAS DB 64000 DUP(0)
;计时器提示文本
    COUNTTIPS0 DB 'PRESS S TO START '
    COUNTTIPS1 DB 'PRESS P TO PAUSE '
    COUNTTIPS2 DB 'PRESS R TO RESET '
    COUNTTIPS3 DB 'PRESS Q TO RETURN'
    COUNTTIPS4 DB 'MADE BY LIYINMING'
    COUNTTIPS5 DB '  ID:2018211762  '
    COUNTTIPS6 DB 'TRY TO MOVE COUNT'
    COUNTTIPS7 DB 'lol Look! How empty it is! Just like my brain!'
;计时框
    TIMECOUNTUP DB 00H,1EH,1EH,1EH,1EH,1EH,1EH,1EH,1EH,1EH,1EH,00H
    TIMECOUNT DB 11H,00H,'0','0',':','0','0',':','0','0',00H,10H    ;时分秒
    TIMECOUNTDOWN DB 00H,1FH,1FH,1FH,1FH,1FH,1FH,1FH,1FH,1FH,1FH,00H
    POINTER DW ?     ;自定义指针1
    PT DW ?    ;自定义指针2
    CTIMEON DB 0    ;计时开关
;错误信息文本
    ERROR1 DB 'FAILED TO OPEN FILE!',24H
    ERROR2 DB 'FAILED TO READ FILE!',24H
DATA ENDS

STACK SEGMENT PARA STACK 'STACK'
;定义秒分时日月年鸟（图）星期与汉字一至六与日的16*16点阵及数字0~9的16*8点阵
    MIAO DW 16 DUP(0420H,0E20H,7820H,0820H,08A8H,0FEA6H,08A2H,1D20H,1A24H,2824H,2828H,4810H,8820H,0840H,0880H,0B00H)
    FEN DW 16 DUP(0080H,0480H,0440H,0840H,0820H,1010H,2008H,4FEEH,8424H,0420H,0420H,0420H,0420H,0820H,1140H,2080H)
    SHI DW 16 DUP(0008H,0408H,7E08H,4408H,47FEH,4408H,4408H,7C88H,4448H,4448H,4408H,4408H,7C08H,4448H,0028H,0010H)
    RI DW 16 DUP(0010H,1FF8H,1010H,1010H,1010H,1010H,1010H,1FF0H,1010H,1010H,1010H,1010H,1010H,1FF0H,1010H,0000H)
    YUE DW 16 DUP(0010H,0FF8H,0810H,0810H,0810H,0FF0H,0810H,0810H,0810H,0FF0H,0810H,0810H,1010H,1010H,2050H,4020H)
    NIAN DW 16 DUP(0800H,0808H,1FFCH,1100H,2100H,4110H,1FF8H,1100H,1100H,1104H,0FFFEH,0100H,0100H,0100H,0100H,0100H)
    BIRD DW 16 DUP(0000H,000EH,001CH,00B0H,01FCH,0000H,0F00H,5C00H,0FE40H,00FEH,001CH,01CFH,0380H,1600H,3F80H,0000H)
    XING DW 16 DUP(0008H,3FFCH,2008H,3FF8H,2008H,3FF8H,0100H,2108H,3FFCH,2100H,4110H,0BFF8H,0100H,0104H,0FFFEH,0000H)
    QI DW 16 DUP(2204H,227EH,2244H,7F44H,2244H,3E7CH,2244H,3E44H,2244H,227CH,0FFC4H,0044H,2444H,2284H,4114H,8208H)
    Z1 DW 16 DUP(0000H,0000H,0000H,0000H,0000H,0000H,0004H,0FFFEH,0000H,0000H,0000H,0000H,0000H,0000H,0000H,0000H)
    Z2 DW 16 DUP(0000H,0000H,0010H,3FF8H,0000H,0000H,0000H,0000H,0000H,0000H,0000H,0004H,0FFFEH,0000H,0000H,0000H)
    Z3 DW 16 DUP(0000H,0008H,7FFCH,0000H,0000H,0000H,0010H,3FF8H,0000H,0000H,0000H,0000H,0004H,0FFFEH,0000H,0000H)
    Z4 DW 16 DUP(0000H,0004H,7FFEH,4444H,4444H,4444H,4444H,4444H,4444H,443CH,4804H,5004H,4004H,7FFCH,4004H,0000H)
    Z5 DW 16 DUP(0000H,0008H,7FFCH,0200H,0200H,0200H,0210H,3FFCH,0410H,0410H,0410H,0810H,0810H,0814H,0FFFEH,0000H)
    Z6 DW 16 DUP(0000H,0400H,0200H,0300H,0104H,0FFFEH,0000H,0000H,0440H,0C20H,0810H,1018H,100CH,200CH,4004H,0000H)
    Z7 DW 16 DUP(0010H,1FF8H,1010H,1010H,1010H,1010H,1010H,1FF0H,1010H,1010H,1010H,1010H,1010H,1FF0H,1010H,0000H)
    NUM0 DB 16 DUP(00H,00H,00H,3EH,63H,63H,63H,63H,63H,63H,63H,63H,3EH,00H,00H,00H)
    NUM1 DB 16 DUP(00H,00H,00H,0CH,1CH,3CH,0CH,0CH,0CH,0CH,0CH,0CH,3FH,00H,00H,00H)
    NUM2 DB 16 DUP(00H,00H,00H,3EH,63H,03H,06H,0CH,18H,30H,61H,63H,7FH,00H,00H,00H)
    NUM3 DB 16 DUP(00H,00H,00H,3EH,63H,03H,03H,1EH,03H,03H,03H,63H,3EH,00H,00H,00H)
    NUM4 DB 16 DUP(00H,00H,00H,06H,0EH,1EH,36H,66H,66H,7FH,06H,06H,0FH,00H,00H,00H)
    NUM5 DB 16 DUP(00H,00H,00H,7FH,60H,60H,60H,7EH,03H,03H,63H,73H,3EH,00H,00H,00H)
    NUM6 DB 16 DUP(00H,00H,00H,1CH,30H,60H,60H,7EH,63H,63H,63H,63H,3EH,00H,00H,00H)
    NUM7 DB 16 DUP(00H,00H,00H,7FH,63H,03H,06H,06H,0CH,0CH,18H,18H,18H,00H,00H,00H)
    NUM8 DB 16 DUP(00H,00H,00H,3EH,63H,63H,63H,3EH,63H,63H,63H,63H,3EH,00H,00H,00H)
    NUM9 DB 16 DUP(00H,00H,00H,3EH,63H,63H,63H,63H,3FH,03H,03H,06H,3CH,00H,00H,00H)    ;秒分时日月年(16*16)及0-9(8*16)的点阵
    DB 50000 DUP(0) 
 TOP LABEL WORD
STACK ENDS

CODE SEGMENT 'CODE'
ASSUME CS:CODE,DS:DATA,SS:STACK
;------------------------------------------------------
;获取输入函数
GETINPUT MACRO
;跳转到计时器
    .IF AL=='C'
    CALL COUNT
    .ELSEIF AL=='c'
    CALL COUNT
;跳转到显示日期
    .ELSEIF AL=='D'
    CALL DATE
    .ELSEIF AL=='d'
    CALL DATE
;跳转到显示时间
    .ELSEIF AL=='T'
    MOV PT,18970D
    CALL TIME
    .ELSEIF AL=='t'
    MOV PT,18970D
    CALL TIME
;跳转到重置回程序初始页面
    .ELSEIF AL=='R'
    CALL RESET
    .ELSEIF AL=='r'
    CALL RESET
;清屏并返回DOS模式
    .ELSEIF AL=='Q'
    CALL EXIT
    .ELSEIF AL=='q'
    CALL EXIT
;删除键盘输入缓冲区输入
    .ELSE
    MOV AX,0C00H
    INT 21H
    .ENDIF
ENDM
;------------------------------------------------------
;获取输入函数
CGETINPUT MACRO
;计时暂停
    .IF AL=='P'
    CALL CPAUSE
    .ELSEIF AL=='p'
    CALL CPAUSE
;计时开始
    .ELSEIF AL=='S'
    CALL CSTART
    .ELSEIF AL=='s'
    CALL CSTART
;计时重置
    .ELSEIF AL=='R'
    CALL CRESET
    .ELSEIF AL=='r'
    CALL CRESET
;返回主页面
    .ELSEIF AL=='Q'
    CALL CQUIT
    .ELSEIF AL=='q'
    CALL CQUIT
    .ELSEIF AH==4BH    ;左方向键扫描码
    CALL CML    ;计时显示左移
    .ELSEIF AH==48H    ;上方向键扫描码
    CALL CMU    ;计时显示上移
    .ELSEIF AH==4DH    ;右方向键扫描码
    CALL CMR    ;计时显示右移
    .ELSEIF AH==50H    ;下方向键扫描码
    CALL CMD    ;计时显示下移
;删除键盘输入缓冲区输入
    .ELSE
    MOV AX,0C00H
    INT 21H
    .ENDIF
ENDM
;------------------------------------------------------
;显示计时器提示文本函数
SHOWTEXT MACRO  MEM0,MEM1,MEM2
    LOCAL CL1,CL2
    MOV AH,MEM0
    MOV AL,MEM1
    MOV ES,AX    ;显存地址
    MOV DI,0
    MOV SI,0
    MOV CX,11H
CL1:
    MOV AL,DS:[BX+SI]
    MOV ES:[DI],AL
    INC SI
    ADD DI,2
    LOOP CL1

    MOV DL,MEM2    ;颜色属性
    MOV SI,1
    MOV CX,11H
CL2:
    MOV ES:[SI],DL
    ADD SI,2
    LOOP CL2
ENDM
;------------------------------------------------------
;主程序
START:
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX    ;定义DS与SS段
    MOV BP,TOP
    MOV POINTER,OFFSET FILE0
    MOV AH,3DH
    MOV AL,00H
    MOV DX,POINTER
    INT 21H
    MOV HANDLE,AX
MAIN:
    MOV POINTER,OFFSET FILE0    ;指针指向打开文件名
    CALL OPENFILE    ;打开文件
    CALL READPIC    ;读取文件信息
    CALL SETMODE    ;设置显示模式
    MOV POINTER,OFFSET DATAS    ;指针指向图像数据存储段
    CALL DISP    ;显示图像

;主页面等待输入循环
NEXT:
;读取键盘缓冲区状态
    MOV AH,1
    INT 16H
    JZ NEXT    ;无键盘输入时跳转
    GETINPUT    ;有键盘输入时获取输入
    JMP NEXT    ;键盘输入无效时跳转
;------------------------------------------------------
;读取BUPT函数
OPENFILE PROC NEAR
    MOV BX,HANDLE
    MOV AH,3EH
    INT 21H
;只读方式打开文件
    MOV AH,3DH
    MOV AL,00H
    MOV DX,POINTER
    INT 21H
    MOV HANDLE,AX
    JC OPENERROR    ;找不到文件时反馈错误信息
    RET
OPENFILE ENDP
;------------------------------------------------------
;读取图像信息函数
READPIC PROC NEAR
;将文件位图信息读入内存从HEAD开始的数据缓冲区
    MOV BX,HANDLE
    MOV AH,3FH
    MOV CX,0FE36H    ;位图头信息54+调色板信息1024+图片数据64000=65078
    LEA DX,HEAD
    INT 21H
    JC READERROR    ;读取文件失败时反馈错误信息
    RET
READPIC ENDP
;------------------------------------------------------
;设置显示模式函数
SETMODE PROC NEAR
;设置显示模式 320*200像素256色
    MOV AX,0013H
    INT 10H
;设置调色板
    MOV CX,256
    MOV BL,0
    MOV DI,0
LOOP1:
    MOV AL,BL
    MOV DX,03C8H
    OUT DX,AL
    MOV DX,03C9H

    MOV AL,COLOR[DI+2]    ;位图中调色板存放格式：BGR
    SHR AL,1
    SHR AL,1
    OUT DX,AL
    MOV AL,COLOR[DI+1]
    SHR AL,1
    SHR AL,1
    OUT DX,AL
    MOV AL,COLOR[DI]
    SHR AL,1
    SHR AL,1
    OUT DX,AL

    ADD DI,4
    INC BL
    LOOP LOOP1
    RET
SETMODE ENDP
;------------------------------------------------------
;写图像数据入显存函数
DISP PROC NEAR
;向显存地址写入数据
    MOV AX,0A000H    ;图形模式下显存地址为A0000~AF9FF
    MOV ES,AX
    MOV DI,63680D    ;320*199（0~199）
    MOV SI,POINTER    ;从底向上写图像索引号及RGB数据
    MOV BX,200    ;200行

LOOP2:
    MOV CX,320    ;320列

LOOP3:
    MOV AL,[SI]
    MOV ES:[DI],AL
    INC SI
    INC DI
    LOOP LOOP3
    SUB DI,640    ;移至上一行开头
    DEC BX
    CMP BX,0
    JNZ LOOP2
    RET
DISP ENDP
;------------------------------------------------------
;比较数字（并在屏幕上写对应数字）函数
COMPARE PROC NEAR
    .IF AL==0
    CALL SHOW0
    .ELSEIF AL==1
    CALL SHOW1
    .ELSEIF AL==2
    CALL SHOW2
    .ELSEIF AL==3
    CALL SHOW3
    .ELSEIf AL==4
    CALL SHOW4
    .ELSEIF AL==5
    CALL SHOW5
    .ELSEIF AL==6
    CALL SHOW6
    .ELSEIF AL==7
    CALL SHOW7
    .ELSEIF AL==8
    CALL SHOW8
    .ELSE
    CALL SHOW9
    .ENDIF
    RET
COMPARE ENDP
;------------------------------------------------------
;显示日期函数
DATE PROC NEAR
    MOV AX,0C00H
    INT 21H    ;删除键盘输入缓冲区输入
    MOV POINTER,OFFSET FILE1    ;指针指向打开文件
    CALL OPENFILE    ;打开文件
    CALL READPIC    ;读取文件信息
    MOV POINTER,OFFSET DATAS    ;指针指向图像数据存储段
    CALL DISP    ;显示图像
;取日期（CX=年份，DH=月份，DL=日，AL=星期）
    MOV AH,2AH
    INT 21H
    PUSH AX    ;星期入栈保护
    PUSH CX    ;年份入栈保护
    MOV POINTER,6486H    ;指针指向日个位数显存地址

;取日
    MOV AL,DL
    DAA    ;16进制转10进制
    AND AL,0FH    ;取日个位数
    CALL COMPARE
    SUB POINTER,08H    ;16*8点阵数字占8列
    MOV AL,DL
    DAA
    MOV CL,4
    SHR AL,CL    ;取日十位数
    CALL COMPARE
    CALL SHOWRI    ;在屏幕上写“日”字
;取月
    SUB POINTER,18H    ;16*16点阵汉字占16列，16（“月”）+8（日十位数）=24
    MOV AL,DH
    DAA
    AND AL,0FH    ;取月个位数
    CALL COMPARE
    SUB POINTER,08H
    MOV AL,DH
    DAA
    MOV CL,4
    SHR AL,CL    ;取月十位数
    CALL COMPARE
    CALL SHOWYUE    ;在屏幕上写“月”字
;取年
    POP BX    ;年份取至BX寄存器
    SUB POINTER,18H
;年份为4位，用DAA无法正确转换进制，用除法逐个取商得各位数字
;取年个位数
    MOV AX,BX
    MOV DX,0
    MOV CX,1000D
    DIV CX
    MOV AX,DX
    MOV CL,100D
    DIV CL
    MOV AL,AH
    MOV AH,0
    MOV CL,10D
    DIV CL
    MOV AL,AH
    CALL COMPARE
;取年十位数
    SUB POINTER,08H
    MOV AX,BX
    MOV DX,0
    MOV CX,1000D
    DIV CX
    MOV AX,DX
    MOV CL,100D
    DIV CL
    MOV AL,AH
    MOV AH,0
    MOV CL,10D
    DIV CL
    CALL COMPARE
;取年百位数
    SUB POINTER,08H
    MOV AX,BX
    MOV DX,0
    MOV CX,1000D
    DIV CX
    MOV AX,DX
    MOV CL,100D
    DIV CL
    CALL COMPARE
;取年千位数
    SUB POINTER,08H
    MOV AX,BX
    MOV DX,0
    MOV CX,1000D
    DIV CX
    CALL COMPARE
    CALL SHOWNIAN    ;在屏幕上写“年”字
;取星期
    POP BX    ;星期出栈
    CALL SHOWXING
    CALL SHOWQI
    .IF BL==1
    MOV BP,OFFSET Z1
    .ELSEIF BL==2
    MOV BP,OFFSET Z2
    .ELSEIF BL==3
    MOV BP,OFFSET Z3
    .ELSEIF BL==4
    MOV BP,OFFSET Z4
    .ELSEIF BL==5
    MOV BP,OFFSET Z5
    .ELSEIF BL==6
    MOV BP,OFFSET Z6
    .ELSE
    MOV BP,OFFSET Z7
    .ENDIF
    CALL SHOWZN

;日期页面等待输入循环
DWAIT:
;读取键盘缓冲区状态
    MOV AH,1
    INT 16H
    JZ DWAIT    ;无键盘输入时跳转
    GETINPUT    ;有键盘输入时获取输入
    JMP DWAIT    ;键盘输入无效时跳转
    RET
DATE ENDP
;------------------------------------------------------
;显示时间函数
TIME PROC NEAR
    MOV AX,0C00H
    INT 21H    ;删除键盘输入缓冲区输入
    MOV POINTER,OFFSET FILE1    ;指针指向打开文件
    CALL OPENFILE    ;打开文件
    CALL READPIC    ;读取文件信息
    MOV POINTER,OFFSET DATAS    ;指针指向图像数据存储段
    CALL DISP    ;显示图像
;取时间（CH=小时，CL=分钟，DH=秒）
    MOV AH,2CH
    INT 21H
    AND DX,0FF00H    ;令DL（百分秒）为0方便后续比较
    PUSH DX    ;秒数入栈保护
    PUSH CX    ;小时和分钟入栈保护
    MOV POINTER,6486H    ;指针指向秒个位数显存地址

;取秒
;取秒个位数
    MOV AL,DH
    MOV AH,0
    MOV BL,10D
    DIV BL
    MOV AL,AH
    CALL COMPARE
;取秒十位数
    SUB POINTER,08H
    MOV AL,DH
    MOV AH,0
    MOV BL,10D
    DIV BL
    CALL COMPARE
    CALL SHOWMIAO    ;在屏幕上写“秒”字
;取分
    POP BX    ;小时和分钟数取至BX寄存器
;取分个位数
    SUB POINTER,18H
    MOV AL,BL
    MOV AH,0
    MOV CL,10D
    DIV CL
    MOV AL,AH
    CALL COMPARE
;取分十位数
    SUB POINTER,08H
    MOV AL,BL
    MOV AH,0
    MOV CL,10D
    DIV CL
    CALL COMPARE
    CALL SHOWFEN    ;在屏幕上写“分”字
;取时
;取时个位数
    SUB POINTER,18H
    MOV AL,BH
    MOV AH,0
    MOV CL,10D
    DIV CL
    MOV AL,AH
    CALL COMPARE
;取时十位数
    SUB POINTER,08H
    MOV AL,BH
    MOV AH,0
    MOV CL,10D
    DIV CL
    CALL COMPARE
    CALL SHOWSHI    ;在屏幕上写“时”字

;在屏幕上画鸟
    SUB PT,4
    CALL SHOWBIRD
    ADD PT,1000D
    CALL SHOWBIRD
    SUB PT,1000D

    POP BX    ;秒数取至BX寄存器

;时间页面等待输入循环
TWAIT:
    CALL COMPARETIME    ;比较秒数是否有变化
;读取键盘缓冲区状态
    MOV AH,1
    INT 16H
    JZ TWAIT    ;无键盘输入时跳转
    GETINPUT    ;有键盘输入时获取输入
    JMP TWAIT    ;键盘输入无效时跳转
    RET
TIME ENDP
;------------------------------------------------------
;时间比较函数
COMPARETIME PROC NEAR
;取时间
    MOV AH,2CH
    INT 21H
    AND DX,0FF00H
;当前时间（DX）与上次时间（BX）不同则重新显示时间（刷新时间），否则返回
    .IF BX!=DX
    CALL TIME
    .ENDIF
    RET
COMPARETIME ENDP
;------------------------------------------------------
;计时器函数
COUNT PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
;设置为80×25 16色文本显示模式
    MOV AX,0003H
    INT 10H
    MOV PT,44H
    MOV POINTER,0B832H
    CALL SHOWTIPS
    CALL CRESET

;计时器页面等待输入循环
CWAIT:
    MOV AH,2CH
    INT 21H
    AND DX,0FF00H
    MOV AL,CTIMEON
;计时开关为1时打打开
    .IF AL==1
;当前时间（DX）与上次时间（BX）不同则计时一秒
    .IF BX!=DX
    MOV BX,DX
    CALL CHANGECOUNT
    CALL SHOWCOUNT
    .ENDIF
    .ENDIF
;读取键盘缓冲区状态
    MOV AH,01H
    INT 16H
    JZ CWAIT
    CGETINPUT
    JMP CWAIT
    RET
COUNT ENDP
;------------------------------------------------------
;显示计时器提示文本函数
SHOWTIPS PROC NEAR
    PUSH BX
;彩色文本模式下显存地址为B8000~B8F9F
;偶地址存储字符，奇地址存放颜色属性（闪烁+背景RGB+高亮+字符RGB）
    MOV BX,OFFSET COUNTTIPS0
    SHOWTEXT 0B8H,72H,71H
    MOV BX,OFFSET COUNTTIPS1
    SHOWTEXT 0B8H,7CH,72H
    MOV BX,OFFSET COUNTTIPS2
    SHOWTEXT 0B8H,86H,74H
    MOV BX,OFFSET COUNTTIPS3
    SHOWTEXT 0B8H,90H,70H
    MOV BX,OFFSET COUNTTIPS4
    SHOWTEXT 0B8H,9AH,0CAH
    MOV BX,OFFSET COUNTTIPS5
    SHOWTEXT 0B8H,0A4H,0CAH
    MOV BX,OFFSET COUNTTIPS6
    SHOWTEXT 0B8H,68H,1EH
    MOV BX,OFFSET COUNTTIPS7
    MOV AX,0B8E6H
    MOV ES,AX    ;显存地址
    MOV DI,36
    MOV SI,0
    MOV CX,2EH
C1:
    MOV AL,DS:[BX+SI]
    MOV ES:[DI],AL
    INC SI
    ADD DI,2
    LOOP C1

    MOV DL,0BDH    ;颜色属性
    MOV SI,37
    MOV CX,2EH
C2:
    MOV ES:[SI],DL
    ADD SI,2
    LOOP C2
    POP BX
    RET
SHOWTIPS ENDP
;------------------------------------------------------
;改变计时数函数
CHANGECOUNT PROC NEAR
    PUSH BX    ;BX入栈保护
    MOV BX,OFFSET TIMECOUNT
    MOV AL,DS:[BX+9]
;秒个位数为9时进位
    .IF AL=='9'
    MOV DS:[BX+9],'0'
    MOV AL,DS:[BX+8]
;秒十位数为5时进位
    .IF AL=='5'
    MOV DS:[BX+8],'0'
    MOV DS:[BX+9],'0'    ;不知道为什么运行到此处时上面的这一条指令不被执行，保险起见后面也做覆盖处理
    MOV AL,DS:[BX+6]
;分个位数为9时进位
    .IF AL=='9'
    MOV DS:[BX+6],'0'
    MOV DS:[BX+8],'0'
    MOV DS:[BX+9],'0' 
    MOV AL,DS:[BX+5]
;分十位数为5时进位
    .IF AL=='5'
    MOV DS:[BX+5],'0'
    MOV DS:[BX+6],'0'
    MOV DS:[BX+8],'0'
    MOV DS:[BX+9],'0' 
    MOV AL,DS:[BX+3]
;时个位数为9时进位
    .IF AL=='9'
    MOV DS:[BX+3],'0'
    MOV DS:[BX+5],'0'
    MOV DS:[BX+6],'0'
    MOV DS:[BX+8],'0'
    MOV DS:[BX+9],'0' 
    MOV AL,DS:[BX+2]
;时十位数为9时进位
    .IF AL=='9'
    MOV DS:[BX+2],'0'
    MOV DS:[BX+3],'0'
    MOV DS:[BX+5],'0'
    MOV DS:[BX+6],'0'
    MOV DS:[BX+8],'0'
    MOV DS:[BX+9],'0' 
;时十位数不为9时加一
    .ELSE
    INC BYTE PTR DS:[BX+2]
    .ENDIF
;时个位数不为9时加一
    .ELSE
    INC BYTE PTR DS:[BX+3]
    .ENDIF
;分十位数不为5时加一
    .ELSE
    INC BYTE PTR DS:[BX+5]
    .ENDIF
;分个位数不为9时加一
    .ELSE
    INC BYTE PTR DS:[BX+6]
    .ENDIF
;秒十位数不为5时加一
    .ELSE
    INC BYTE PTR DS:[BX+8]
    .ENDIF
;秒个位数不为9时加一
    .ELSE
    INC BYTE PTR DS:[BX+9]
    .ENDIF
    POP BX    ;BX出栈
    RET
CHANGECOUNT ENDP
;------------------------------------------------------
;显示计时函数
SHOWCOUNT PROC NEAR
    PUSH BX
;计时器行
    MOV BX,OFFSET TIMECOUNT
    MOV AX,POINTER
    MOV ES,AX    ;显存地址
    MOV DI,PT
    MOV SI,0
    MOV CX,0CH
CL1:
    MOV AL,DS:[BX+SI]
    MOV ES:[DI],AL
    INC SI
    ADD DI,2
    LOOP CL1

    MOV DL,0FH    ;颜色属性
    MOV SI,PT
    INC SI
    MOV CX,0CH
CL2:
    MOV ES:[SI],DL
    ADD SI,2
    LOOP CL2

;上装饰行
    MOV BX,OFFSET TIMECOUNTUP
    MOV AX,POINTER
    SUB AX,0AH
    MOV ES,AX    ;显存地址
    MOV DI,PT
    MOV SI,0
    MOV CX,0CH
CL3:
    MOV AL,DS:[BX+SI]
    MOV ES:[DI],AL
    INC SI
    ADD DI,2
    LOOP CL3

    MOV DL,0FH    ;颜色属性
    MOV SI,PT
    INC SI
    MOV CX,0CH
CL4:
    MOV ES:[SI],DL
    ADD SI,2
    LOOP CL4

;下装饰行
    MOV BX,OFFSET TIMECOUNTDOWN
    MOV AX,POINTER
    ADD AX,0AH
    MOV ES,AX    ;显存地址
    MOV DI,PT
    MOV SI,0
    MOV CX,0CH
CL5:
    MOV AL,DS:[BX+SI]
    MOV ES:[DI],AL
    INC SI
    ADD DI,2
    LOOP CL5

    MOV DL,0FH    ;颜色属性
    MOV SI,PT
    INC SI
    MOV CX,0CH
CL6:
    MOV ES:[SI],DL
    ADD SI,2
    LOOP CL6
    POP BX
    RET
SHOWCOUNT ENDP
;------------------------------------------------------
;计时显示左移函数
CML PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
;限制移动范围
    MOV AX,PT
    .IF AL>=1
;清痕迹
    PUSH BX
    MOV BX,OFFSET TIMECOUNT
    MOV AX,POINTER
    MOV ES,AX
    MOV DI,PT
    MOV ES:[DI+22],0
    POP BX

    SUB PT,2
    CALL SHOWTIPS
    CALL SHOWCOUNT
    .ENDIF
    RET
CML ENDP
;------------------------------------------------------
;计时显示右移函数
CMR PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
;限制移动范围
    MOV AX,PT
    .IF AL<=86H
;清痕迹
    PUSH BX
    MOV BX,OFFSET TIMECOUNT
    MOV AX,POINTER
    MOV ES,AX
    MOV DI,PT
    MOV ES:[DI],0
    POP BX

    ADD PT,2
    CALL SHOWTIPS
    CALL SHOWCOUNT
    .ENDIF
    RET
CMR ENDP
;------------------------------------------------------
;计时显示上移函数
CMU PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
;限制移动范围
    MOV AX,POINTER
    .IF AX>=0B814H
;清痕迹
    PUSH CX
    PUSH BX
    MOV BX,OFFSET TIMECOUNT
    MOV AX,POINTER
    ADD AX,0AH
    MOV ES,AX
    MOV CX,18H
    MOV DI,PT
    MOV SI,0
CU:
    MOV ES:[DI],0
    INC DI
    LOOP CU
    POP BX
    POP CX

    SUB POINTER,0AH
    CALL SHOWTIPS
    CALL SHOWCOUNT
    .ENDIF
    RET
CMU ENDP
;------------------------------------------------------
;计时显示下移函数
CMD PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
;限制移动范围
    MOV AX,POINTER
    .IF AX<=0B8DCH
;清痕迹
    PUSH CX
    PUSH BX
    MOV BX,OFFSET TIMECOUNT
    MOV AX,POINTER
    SUB AX,0AH
    MOV ES,AX
    MOV CX,18H
    MOV DI,PT
    MOV SI,0
CD:
    MOV ES:[DI],0
    INC DI
    LOOP CD
    POP BX
    POP CX

    ADD POINTER,0AH
    CALL SHOWTIPS
    CALL SHOWCOUNT
    .ENDIF
    RET
CMD ENDP
;------------------------------------------------------
;计时重置函数
CRESET PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
    MOV CTIMEON,0    ;关闭计时开关
    PUSH BX
    MOV BX,OFFSET TIMECOUNT
    MOV DS:[BX+2],'0'
    MOV DS:[BX+3],'0'
    MOV DS:[BX+4],':'
    MOV DS:[BX+5],'0'
    MOV DS:[BX+6],'0'
    MOV DS:[BX+7],':'
    MOV DS:[BX+8],'0'
    MOV DS:[BX+9],'0'
    POP BX
    CALL SHOWCOUNT
    RET
CRESET ENDP
;------------------------------------------------------
;计时暂停函数
CPAUSE PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
    MOV CTIMEON,0    ;关闭计时开关
    JMP CWAIT
    RET
CPAUSE ENDP
;------------------------------------------------------
;计时启动函数
CSTART PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
    MOV CTIMEON,1    ;打开计时开关
    MOV AH,2CH
    INT 21H
    AND DX,0FF00H
    PUSH DX
    POP BX
    JMP CWAIT
    RET
CSTART ENDP
;------------------------------------------------------
;返回时钟程序
CQUIT PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
    JMP MAIN
    RET
CQUIT ENDP
;------------------------------------------------------
;重置回程序初始页面函数
RESET PROC NEAR
;删除键盘输入缓冲区输入
    MOV AX,0C00H
    INT 21H
    MOV POINTER,OFFSET FILE0    ;指针指向打开文件名
    CALL OPENFILE    ;打开文件
    CALL READPIC    ;读取文件信息
    MOV POINTER,OFFSET DATAS    ;指针指向图像数据存储段
    CALL DISP    ;显示图像
    JMP NEXT
    RET
RESET ENDP
;------------------------------------------------------
;清屏并返回DOS模式
EXIT PROC NEAR
;设置为80×25 16色文本显示模式（清屏）
    MOV AX,3
    INT 10H
;返回DOS模式
    MOV AH,4CH
    INT 21H
    RET
EXIT ENDP
;------------------------------------------------------
;在屏幕上写0
SHOW0 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM0
    MOV CX,10H    ;16行
L00:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H    ;8列
L01:
    SHR AL,1    ;点阵末位数字（0或1）移入CF标志寄存器
    JNC NEXT01    ;末位为0则不写数据直接循环，否则重写对应像素显存后再循环
    MOV ES:[DI],00H    ;重写对应像素（黑色）
    JMP NEXT01
NEXT01:
    DEC DI
    LOOP L01
NEXT00:
    INC BP
    ADD DI,148H    ;320（显存一行）+8（数字点阵8列）=328
    POP CX
    LOOP L00
    RET
SHOW0 ENDP
;------------------------------------------------------
;在屏幕上写1
SHOW1 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM1
    MOV CX,10H
L10:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L11:
    SHR AL,1
    JNC NEXT11
    MOV ES:[DI],00H
    JMP NEXT11
NEXT11:
    DEC DI
    LOOP L11
NEXT10:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L10
    RET
SHOW1 ENDP
;------------------------------------------------------
;在屏幕上写2
SHOW2 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM2
    MOV CX,10H
L20:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L21:
    SHR AL,1
    JNC NEXT21
    MOV ES:[DI],00H
    JMP NEXT21
NEXT21:
    DEC DI
    LOOP L21
NEXT20:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L20
    RET
SHOW2 ENDP
;------------------------------------------------------
;在屏幕上写3
SHOW3 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM3
    MOV CX,10H
L30:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L31:
    SHR AL,1
    JNC NEXT31
    MOV ES:[DI],00H
    JMP NEXT31
NEXT31:
    DEC DI
    LOOP L31
NEXT30:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L30
    RET
SHOW3 ENDP
;------------------------------------------------------
;在屏幕上写4
SHOW4 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM4
    MOV CX,10H
L40:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L41:
    SHR AL,1
    JNC NEXT41
    MOV ES:[DI],00H
    JMP NEXT41
NEXT41:
    DEC DI
    LOOP L41
NEXT40:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L40
    RET
SHOW4 ENDP
;------------------------------------------------------
;在屏幕上写5
SHOW5 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM5
    MOV CX,10H
L50:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L51:
    SHR AL,1
    JNC NEXT51
    MOV ES:[DI],00H
    JMP NEXT51
NEXT51:
    DEC DI
    LOOP L51
NEXT50:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L50
    RET
SHOW5 ENDP
;------------------------------------------------------
;在屏幕上写6
SHOW6 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM6
    MOV CX,10H
L60:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L61:
    SHR AL,1
    JNC NEXT61
    MOV ES:[DI],00H
    JMP NEXT61
NEXT61:
    DEC DI
    LOOP L61
NEXT60:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L60
    RET
SHOW6 ENDP
;------------------------------------------------------
;在屏幕上写7
SHOW7 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM7
    MOV CX,10H
L70:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L71:
    SHR AL,1
    JNC NEXT71
    MOV ES:[DI],00H
    JMP NEXT71
NEXT71:
    DEC DI
    LOOP L71
NEXT70:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L70
    RET
SHOW7 ENDP
;------------------------------------------------------
;在屏幕上写8
SHOW8 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM8
    MOV CX,10H
L80:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L81:
    SHR AL,1
    JNC NEXT81
    MOV ES:[DI],00H
    JMP NEXT81
NEXT81:
    DEC DI
    LOOP L81
NEXT80:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L80
    RET
SHOW8 ENDP
;------------------------------------------------------
;在屏幕上写9
SHOW9 PROC NEAR
    MOV DI,POINTER
    MOV BP,OFFSET NUM9
    MOV CX,10H
L90:
    MOV AL,SS:[BP]
    PUSH CX
    MOV CX,08H
L91:
    SHR AL,1
    JNC NEXT91
    MOV ES:[DI],00H
    JMP NEXT91
NEXT91:
    DEC DI
    LOOP L91
NEXT90:
    INC BP
    ADD DI,148H
    POP CX
    LOOP L90
    RET
SHOW9 ENDP
;------------------------------------------------------
;在屏幕上写年
SHOWNIAN PROC NEAR
    MOV DI,25686D
    MOV BP,OFFSET NIAN
    MOV CX,10H
LN0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LN1:
    SHR AX,1
    JNC NEXTN1
    MOV ES:[DI],00H
    JMP NEXTN1
NEXTN1:
    DEC DI
    LOOP LN1
NEXTN0:
    INC BP
    INC BP
    ADD DI,150H    ;320（显存一行）+16（汉字点阵16列）=336
    POP CX
    LOOP LN0
    RET
SHOWNIAN ENDP
;------------------------------------------------------
;在屏幕上写月
SHOWYUE PROC NEAR
    MOV DI,25718D
    MOV BP,OFFSET YUE
    MOV CX,10H
LY0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LY1:
    SHR AX,1
    JNC NEXTY1
    MOV ES:[DI],00H
    JMP NEXTY1
NEXTY1:
    DEC DI
    LOOP LY1
NEXTY0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LY0
    RET
SHOWYUE ENDP
;------------------------------------------------------
;在屏幕上写日
SHOWRI PROC NEAR
    MOV DI,25750D
    MOV BP,OFFSET RI
    MOV CX,10H
LR0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LR1:
    SHR AX,1
    JNC NEXTR1
    MOV ES:[DI],00H
    JMP NEXTR1
NEXTR1:
    DEC DI
    LOOP LR1
NEXTR0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LR0
    RET
SHOWRI ENDP
;------------------------------------------------------
;在屏幕上写星
SHOWXING PROC NEAR
    MOV DI,13200D
    MOV BP,OFFSET XING
    MOV CX,10H
LX0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LX1:
    SHR AX,1
    JNC NEXTR1
    MOV ES:[DI],00H
    JMP NEXTX1
NEXTX1:
    DEC DI
    LOOP LX1
NEXTX0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LX0
    RET
SHOWXING ENDP
;------------------------------------------------------
;在屏幕上写期
SHOWQI PROC NEAR
    MOV DI,13216D
    MOV BP,OFFSET QI
    MOV CX,10H
LQ0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LQ1:
    SHR AX,1
    JNC NEXTQ1
    MOV ES:[DI],00H
    JMP NEXTQ1
NEXTQ1:
    DEC DI
    LOOP LQ1
NEXTQ0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LQ0
    RET
SHOWQI ENDP
;------------------------------------------------------
;在屏幕上写星期几
SHOWZN PROC NEAR
    MOV DI,13232D
    MOV CX,10H
LZ0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LZ1:
    SHR AX,1
    JNC NEXTZ1
    MOV ES:[DI],00H
    JMP NEXTZ1
NEXTZ1:
    DEC DI
    LOOP LZ1
NEXTZ0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LZ0
    RET
SHOWZN ENDP
;------------------------------------------------------
;在屏幕上写时
SHOWSHI PROC NEAR
    MOV DI,25686D
    MOV BP,OFFSET SHI
    MOV CX,10H
LS0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LS1:
    SHR AX,1
    JNC NEXTS1
    MOV ES:[DI],00H
    JMP NEXTS1
NEXTS1:
    DEC DI
    LOOP LS1
NEXTS0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LS0
    RET
SHOWSHI ENDP
;------------------------------------------------------
;在屏幕上写分
SHOWFEN PROC NEAR
    MOV DI,25718D
    MOV BP,OFFSET FEN
    MOV CX,10H
LF0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LF1:
    SHR AX,1
    JNC NEXTF1
    MOV ES:[DI],00H
    JMP NEXTF1
NEXTF1:
    DEC DI
    LOOP LF1
NEXTF0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LF0
    RET
SHOWFEN ENDP
;------------------------------------------------------
;在屏幕上写秒
SHOWMIAO PROC NEAR
    MOV DI,25750D
    MOV BP,OFFSET MIAO
    MOV CX,10H
LM0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LM1:
    SHR AX,1
    JNC NEXTM1
    MOV ES:[DI],00H
    JMP NEXTM1
NEXTM1:
    DEC DI
    LOOP LM1
NEXTM0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LM0
    RET
SHOWMIAO ENDP
;------------------------------------------------------
;在屏幕上画鸟
SHOWBIRD PROC NEAR
    MOV DI,PT
    MOV BP,OFFSET BIRD
    MOV CX,10H
LB0:
    MOV AX,SS:[BP]
    PUSH CX
    MOV CX,10H
LB1:
    SHR AX,1
    JNC NEXTB1
    MOV ES:[DI],00H
    JMP NEXTB1
NEXTB1:
    DEC DI
    LOOP LB1
NEXTB0:
    INC BP
    INC BP
    ADD DI,150H
    POP CX
    LOOP LB0
    RET
SHOWBIRD ENDP
;------------------------------------------------------
;打开文件失败提示
OPENERROR:
    LEA DX,ERROR1
;显示字符串
    MOV AH,9
    INT 21H
    JMP EXIT
;------------------------------------------------------
;读取图像信息失败提示
READERROR:
    LEA DX,ERROR2
    MOV AH,9
    INT 21H
    JMP EXIT

CODE ENDS
    END START
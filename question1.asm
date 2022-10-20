.data
   prompt:         .asciiz "Enter n, followed by n lines of text: \n"
text:       .asciiz "The values are:"
newline:    .asciiz "\n"
   .align 2
array:      .space  120
string:     .space  104       
size:       .word   20



    .text
    .globl main
main:

    li      $v0,4
    la      $a0,prompt
    syscall
   
    li      $v0,5
    syscall
    addi    $s0,$v0,0           

    add     $t0,$zero,$zero     
    addi    $t1,$zero,1         
    la      $s2,string          

loop:
    bgt     $t1,$s0,exit          



    move    $a0,$s2             
    li      $a1,20
    li      $v0,8
    syscall

 
    sw      $a0,array($t0)

    addi    $t0,$t0,4           
    addi    $t1,$t1,1           
    addi    $s2,$s2,20          

    j       loop


exit:
    mul     $t5,$s0,4
    sub    $t5,$t5,4
    add     $t0,$t5,$zero    
    addi    $t1,$zero,1        

 
    la      $a0,text
    li      $v0,4
    syscall
    jal     new_line

print_text:
    bgt     $t1,$s0,close       
    lw      $t2,array($t0)    


    li      $v0,4
    move    $a0,$t2
    syscall


    addi    $t0,$t0,-4           
    addi    $t1,$t1,1           
    j       print_text


new_line:
    la      $a0,newline
    li      $v0,4
    syscall
    jr      $ra


close:
    li      $v0,10
    syscall

.data 0x10000000
msg: .asciiz "Enter a sum:\n"
str: .space 1024
msg2: .asciiz "The value is:\n"

.text
.globl main
main:
lui $s0,0x1000
addi $s1,$s0,0x0 
addi $s2,$s0,0xe 
addi $s4,$s0,0x40e

#display the string to the user
addi $v0,$0,4 
addi $a0,$s1,0 
syscall

#scan the input
addi $v0,$0,8
addi $a0,$s1,0
addi $a1,$0,1024
syscall

addi $t1,$s1,0 
addi $t2,$0,43 
addi $t4,$0,0
addi $t5,$0,10 
addi $s3,$0,0 
loop: lb $s2,0($t1)
addi $t1,$t1,1
beq $s2,$t5,finish 
sll $0,$0,0 
beq $s2,$t2,complete
sll $0,$0,0 
addi $t3,$s2,-48
mul $t4,$t4,$t5
sll $0,$0,0 
add $t4,$t4,$t3
j loop
sll $0,$0,0 
complete:
add $s3,$s3,$t4
addi $t4,$0,0
j loop
sll $0,$0,0 
finish:

add $s3,$s3,$t4
#display user output
addi $a0,$s4,0
addi $v0,$0,4
syscall

#displays total
addi $v0,$0,1
addi $a0,$s3,0
syscall

#closes program
addi $v0,$0,10
syscall

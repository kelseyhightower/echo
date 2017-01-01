;; Copyright 2017 Google Inc. All Rights Reserved.
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;     http://www.apache.org/licenses/LICENSE-2.0
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

section .text
  global _start

_start:          ; The entrypoint for the linker.

  ; Get the first positional argument. The results will be stored in EBX.
  pop ebx        ; store the number of program arguments in the EBX general register.
  pop ebx        ; overwrite EBX with the program name argv[0].
  pop ebx        ; overwrite EBX with the first positional argument argv[1].


  ; Compute the length of argv[1]. The results will be stored in EDI
  mov ax,ds      ; initialize AX.
  mov es,ax      ; initialize ES.
  mov edi,ebx    ; set to string argv[1] 
  mov ebp,ebx    ; set to string argv[1]

  cld            ; left to right or auto-increment mode 
  mov ecx,255    ; set the max size of the string.
  mov al,0       ; initialize AL with a null character.
  repne scasb    ; scan bytes in the string until we find the null character.
  dec edi        ; 
  sub edi,ebp    ; store the length of the string.


  ; Print the first positional argument to stdout.
  mov edx,edi   ; set third argument to computed length of argv[1].
  mov ecx,ebx   ; set second argument to string argv[1].
  mov ebx,1     ; set first argument to stdout file handle.
  mov eax,4     ; system call sys_write.
  int 0x80      ; call kernel.


  ; Exit the program.
  mov ebx,0     ; set exit code to 0.
  mov eax,1     ; system call sys_exit
  int 0x80      ; call kernel.

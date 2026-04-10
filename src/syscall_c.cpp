
#include "../h/syscall_c.h"
#include "../h/riscv.hpp"
#include "../h/print.hpp"
#include "../h/tcb.hpp"
#include "../lib/hw.h"
//static uint64 PID = 0;

void switch_to_user_mode() {
    __asm__ volatile ("addi a0, zero, 0x99");
    __asm__ volatile ("ecall");
}

void *mem_alloc(size_t size)
{

    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x01");
//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    __asm__ volatile ("ecall");
    uint64 volatile a1 = Riscv::r_a0();
    return (void *) a1;
}

int mem_free(void *addr)
{
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x02");
//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    __asm__ volatile ("ecall");
    uint64 volatile a1 = Riscv::r_a0();
    return (int) a1;
}

int thread_create_not_start(thread_t *handle, void(*start_routine)(void *), void *arg)
{
    __asm__ volatile ("addi a3, a2, 0x0");
    __asm__ volatile ("addi a2, a1, 0x0");
    __asm__ volatile ("addi a1, a0, 0x0");

    __asm__ volatile ("mv a0, %0" : : "r"(0x07));

//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    int a0;
    __asm__ volatile ("ecall");

    __asm__ volatile ("mv %0, a0" :  "=r"(a0));

    return a0;
}
int thread_create(thread_t *handle, void(*start_routine)(void *), void *arg)
{

    __asm__ volatile ("addi a3, a2, 0x0");
    __asm__ volatile ("addi a2, a1, 0x0");
    __asm__ volatile ("addi a1, a0, 0x0");


    __asm__ volatile ("mv a0, %0" : : "r"(0x11));

//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    int a0;
    __asm__ volatile ("ecall");


    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    return a0;
}

int thread_start(thread_t *handle)
{
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x08");
    __asm__ volatile ("ecall");
    return 0;
}
int thread_exit()
{

    __asm__ volatile ("addi a0, zero, 0x12");
    __asm__ volatile ("ecall");
    return 0;
}

void thread_dispatch()
{

    __asm__ volatile ("addi a0, zero, 0x13");
    __asm__ volatile ("ecall");

}

void thread_join(thread_t handle)
{

    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x14");
    __asm__ volatile ("ecall");
}


int sem_open(sem_t *handle, unsigned init)
{
    __asm__ volatile ("addi a2, a1, 0x0");
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x21");
    __asm__ volatile ("ecall");
    return 0;
}
int sem_close(sem_t handle)
{
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x22");
    __asm__ volatile ("ecall");
    return 0;
}
int sem_wait(sem_t id)
{
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x23");
    int a0;
    __asm__ volatile ("ecall");


    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    return a0;
}
int sem_signal(sem_t id)
{
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x24");
    int a0;
    __asm__ volatile ("ecall");


    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    return a0;
}

char getc()
{
    __asm__ volatile ("addi a0, zero, 0x41");
    __asm__ volatile ("ecall");
    char volatile a1 = Riscv::r_a0();
    return (char) a1;
}

void putc(char c)
{
    __asm__ volatile ("addi a1, a0, 0x0");
    __asm__ volatile ("addi a0, zero, 0x42");
    __asm__ volatile ("ecall");
}

#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../h/syscall_c.h"
#include "../h/riscv.hpp"
#include "../h/syscall_cpp.hpp"
extern void userMain();

void initialize()
{
    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);

    MemoryAllocator::initMemory();
    Scheduler::init();
    thread_t handle;
//    thread_t  usr;

    TCB::createThread(&handle, nullptr, nullptr);
//    TCB::createThread(&usr, (void(*)(void*))userMain, nullptr);
//    switch_to_user_mode();

    TCB::running = handle;
//    thread_join(usr);

//    __asm__ volatile("csrs sstatus, %[mask]": : [mask] "r"(1 << 5));
//    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
//
//
//    Riscv::mc_sstatus(Riscv::SSTATUS_SPP);
}

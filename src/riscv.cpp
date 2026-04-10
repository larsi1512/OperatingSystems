
#include "../h/riscv.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/semaphore.hpp"


void Riscv::popSppSpie()
{
//    Riscv::mc_sstatus(Riscv::SSTATUS_SPP);
    mc_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    __asm__ volatile("sret");
}

void Riscv::handleSupervisorTrap()
{
    uint64 a00 = Riscv::r_a0();
    uint64 a01  = Riscv::r_a1();
    uint64 a02  = Riscv::r_a2();
    uint64 a03  = Riscv::r_a3();
    void* sscratchsp;
    asm volatile("csrr %0, sscratch" : "=r"(sscratchsp));


    uint64 scause = r_scause();
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    {
        uint64 volatile sepc = r_sepc() + 4;

        //mem_alloc
        if(a00 == 0x01) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            void *ret=MemoryAllocator::_mem_alloc(a01);


            asm volatile("csrw sstatus, %0" : : "r"(sstatus));


            __asm__ volatile("mv a0, %0" : : "r" (ret));
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));


        }
        //mem_free
        else if (a00 == 0x02) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            int ret=MemoryAllocator::_mem_free((void*)a01);


            asm volatile("csrw sstatus, %0" : : "r"(sstatus));


            __asm__ volatile("mv a0, %0" : : "r" (ret));
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));

        }
        // thread_create_not_start
        else if(a00 == 0x07) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            int ret=TCB::createThreadNotStart( (thread_t *)a01,(void (*)(void*))a02, (void*)a03);


            asm volatile("csrw sstatus, %0" : : "r"(sstatus));


            __asm__ volatile("mv a0, %0" : : "r" (ret));
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));


        }
        //thread_start
        else if(a00 == 0x08) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            int ret=TCB::start(reinterpret_cast<thread_t *>(a01));


            asm volatile("csrw sstatus, %0" : : "r"(sstatus));


            __asm__ volatile("mv a0, %0" : : "r" (ret));
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));


        }
        // thread_create
        else if(a00 == 0x11) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            int ret=TCB::createThread( (thread_t *)a01,(void (*)(void*))a02, (void*)a03);


            asm volatile("csrw sstatus, %0" : : "r"(sstatus));


            __asm__ volatile("mv a0, %0" : : "r" (ret));
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));


        }

        //thread_exit
        else if(a00 ==  0x12) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            TCB::exitThread();

            asm volatile("csrw sstatus, %0" : : "r"(sstatus));



        }
        //thread_dispatch
        else if (a00 == 0x13) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            uint64 tmpsepc;
            asm volatile("csrr %0, sepc" : "=r"(tmpsepc));

            TCB::dispatch();
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
            sepc=tmpsepc+4;

        }
        //thread_join
        else if(a00 ==  0x14) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            TCB::join((thread_t)a01);
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));

        }
        //yield
        else if(a00 ==  0x15) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            TCB::yield();
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));

        }
        //sem_open
        else if(a00 ==  0x21) {

            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            uint64 tmpsepc;
            asm volatile("csrr %0, sepc" : "=r"(tmpsepc));
            semaphore::_sem_open((sem_t*)a01,(unsigned int)a02);
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
            sepc=tmpsepc+4;
        }
        //sem_close
        else if(a00 ==  0x22) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            semaphore::_sem_close((sem_t)a01);
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));

        }
        //sem_wait
        else if(a00 ==  0x23) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            semaphore::_sem_wait((sem_t)a01);
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
        }
        //sem_signal
        else if(a00 ==  0x24) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            semaphore::_sem_signal((sem_t)a01);
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
        }

        else if(a00 ==  0x41) {
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));

            char ret=__getc();

            asm volatile("csrw sstatus, %0" : : "r"(sstatus));

            __asm__ volatile("mv a0, %0" : : "r" (ret));
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));

        }

        else if(a00 ==  0x42 ){
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            __putc((char)a01);
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
        }

        else if(a00 ==  0x99) {
            // switch to user mode
            uint64 sstatus;
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
            Riscv::mc_sstatus(1<<8);
            w_sepc(sepc);
            return;

        }



        w_sepc(sepc);
    }
    else if (scause == 0x8000000000000001UL)
    {
//        __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));

        __asm__ volatile("csrc sip, 0x02");
//        prekid od tajmera
//         interrupt: yes; cause code: supervisor software interrupt (CLINT; machine timer interrupt)
//        mc_sip(SIP_SSIP);
//        TCB::timeSliceCounter++;
//        if (TCB::timeSliceCounter >= TCB::running->getTimeSlice())
//        {
//            uint64 volatile sepc = r_sepc();
//            uint64 volatile sstatus = r_sstatus();
//            TCB::timeSliceCounter = 0;
//            TCB::dispatch();
//            w_sstatus(sstatus);
//            w_sepc(sepc);
//        }
    }
    else if (scause == 0x8000000000000009UL)
    {
        //prekid spolja, od konzole na primer
        console_handler();
    }
    else
    {
        // unexpected trap cause
//        print_integer(scause);
//        print_string("null");
//        print_integer(r_stval());
    }
}
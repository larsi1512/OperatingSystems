

#include "../h/tcb.hpp"
#include "../h/workers.hpp"
#include "../h/print.hpp"
#include "../h/riscv.hpp"
//#include "../h/syscall_cpp.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/scheduler.hpp"

#include "../h/syscall_c.h"
#include "../lib/console.h"
extern "C" void _ZN5Riscv14supervisorTrapEv();
extern void userMain();
extern void initialize();


int main()
{
//    __asm__ volatile("csrw stvec, %0" : : "r" (&_ZN5Riscv14supervisorTrapEv));

    initialize();
    userMain();

    List<int> lista;
    int x = 1;
    lista.addFirst(&x);
    print_integer(*lista.peekFirst());

    auto* t2 = new Thread((void(*)(void*))workerBodyProba, nullptr);
    auto* t0 = new Thread((void(*)(void*))workerBodyProba, nullptr);
    print_string("Thread made\n");
//
//    //__asm__ volatile("csrc sstatus, 0x02");
//
////    main->dispatch();

//    t3->start();
    t0->start();
    t2->start();
    print_string("Thread started\n");


//    t4->start();
//    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
//    while(!t0->myHandle->isFinished() and !t2->myHandle->isFinished()
//    and !t4->myHandle->isFinished() and !t3->myHandle->isFinished()) {
//        TCB::yield();
//    }
//
//    TCB::join(t3->myHandle);
//    printString("Finished\n");

    while(!(t0->myHandle->isFinished() && t2->myHandle->isFinished())) {
        Thread::dispatch();
    }
    delete t0;
    delete t2;
    print_string("deleted");

    return 0;
}

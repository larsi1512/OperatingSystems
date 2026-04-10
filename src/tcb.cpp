

#include "../h/tcb.hpp"
#include "../h/riscv.hpp"
#include "../h/print.hpp"
#include "../h/syscall_c.h"

TCB *TCB::running = nullptr;
int TCB::id = 1;
uint64 TCB::timeSliceCounter = 0;

int TCB::createThread(thread_t* handle, Body body, void *arg)
{   *handle = new TCB(body,arg, TIME_SLICE);
    if (body) {Scheduler::put(*handle); }
    return (*handle)->pid;
}

void TCB::exitThread() {
    TCB::running->setFinished(true);
    //delete nit
    unblock();
    TCB::dispatch();
}


void TCB::yield()
{

    Riscv::pushRegisters();

    dispatch();
//    __asm__ volatile ("addi a0, zero, 0x15");
//    __asm__ volatile("ecall");

    Riscv::popRegisters();
}

void TCB::dispatch()
{
    TCB *old = running;
    if (!old->isFinished() and !old->isBlocked()) {
        Scheduler::put(old);
    }
    running = Scheduler::get();

    TCB::contextSwitch(&old->context, &running->context);
    if (running) {

    }
}

void TCB::threadWrapper()
{
    Riscv::popSppSpie();
    running->body(running->arg);
    running->setFinished(true);
    if(running->isFinished()) {
       unblock();
    }
//    TCB::dispatch();
//    thread_dispatch();
    Thread::dispatch();

}

void TCB::join(thread_t handle)
{
    if (!handle->isFinished()) {
        handle->waitToJoin.addLast(running);
        running->setBlocked(true);
        TCB::yield();
    }

}

void TCB::unblock()
{
    while(running->waitToJoin.peekFirst()) {
        thread_t notBlocked = running->waitToJoin.removeFirst();
        notBlocked->setBlocked(false);
        Scheduler::put(notBlocked);
    }
}

int TCB::start(thread_t* handle)
{
    if (handle) {
        Scheduler::put(*handle);
    }
    return 0;
}

int TCB::createThreadNotStart(thread_t *handle, TCB::Body body, void *arg)
{
    *handle = new TCB(body,arg, TIME_SLICE);
    return (*handle)->pid;
}

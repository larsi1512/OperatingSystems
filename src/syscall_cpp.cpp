//
// Created by os on 9/8/23.
//

#include "../h/syscall_cpp.hpp"
#include "../h/print.hpp"
#include "../lib/hw.h"
#include "../h/syscall_c.h"
#include "../h/tcb.hpp"
#include "../h/scheduler.hpp"

void *operator new[](size_t n) {
    return (void*) mem_alloc(n);
}

void *operator new(size_t n)
{
    return (void*) mem_alloc(n);
}

void operator delete (void* addr)  noexcept
{
    mem_free(addr);
}
void operator delete[](void *addr) noexcept
{
    mem_free(addr);
}



Thread::Thread(void (*body)(void *), void *arg)
{
    this->body = body;
    this->arg = arg;
    thread_create_not_start(&this->myHandle, body, arg);

}

Thread::Thread()
{

    thread_create_not_start(&this->myHandle, wrapper, this);

}

int Thread::sleep(time_t)
{
    return 0;
}

void Thread::dispatch()
{
    thread_dispatch();
}

int Thread::start()
{
//    thread_start(&myHandle);

    Scheduler::put(myHandle);
    return 0;
}

void Thread::join()
{
    thread_join(myHandle);
}


Thread::~Thread()
{
    if (this->myHandle) {
//        thread_exit();
        delete &this->myHandle;
    }
}
Semaphore::Semaphore (unsigned int init) {
    sem_open(&myHandle, init);
}

int Semaphore::wait () {
    sem_wait(myHandle);
    return 0;
}

int Semaphore::signal() {
    sem_signal(myHandle);
    return 0;
}
Semaphore::~Semaphore () {
    sem_close(myHandle);
}

char Console::getc()
{
    return ::getc();
}

void Console::putc(char c)
{
    ::putc(c);
}

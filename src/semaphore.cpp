//
// Created by os on 1/30/24.
//

#include "../h/semaphore.hpp"
#include "../h/scheduler.hpp"
#include "../h/tcb.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"

void semaphore::block()
{

}

void semaphore::unblock()
{

}
TCB * semaphore::get(semaphore *sem)
{
    return sem->blocked.removeFirst();


}

void semaphore::put(semaphore *sem)
{
    sem->blocked.addLast(TCB::running);

}
int semaphore::_sem_open(semaphore **sem, unsigned int val)
{
    auto  semafor  = (sem_t) MemoryAllocator::_mem_alloc(sizeof (semaphore));
    if(!semafor) {
        return -1;
    }
    semafor->val = val;
    semafor->closed = false;
    semafor->lock = false;

    *sem = semafor;

    return 0;
}

int semaphore::_sem_close(semaphore *sem)
{
    if (sem->closed) {return -1;}

    if(!sem->lock) {
        thread_t ready;
        sem->lock = true;
        while(sem->blocked.peekFirst()) {
            ready = sem->blocked.removeFirst();
            ready->setBlocked(false);
            Scheduler::put(ready);
        }
        sem->closed =true;

        sem->lock = false;
    }
    return 0;
}

int semaphore::_sem_wait(semaphore *sem)
{

    if (sem->closed) {return -1;}

    if(sem->val > 0) {

        sem->val = sem->val - 1;

    }
    else {
        TCB::running->setBlocked(true);
        sem->blocked.addLast(TCB::running);

        TCB::dispatch(); // kontekst sw
    }

    return 0;
}

int semaphore::_sem_signal(semaphore *sem)
{

    if (sem->closed) {return -1;}

    thread_t ready;
    if(sem->blocked.peekFirst()) {
        ready = get(sem);
        ready->setBlocked(false);
        Scheduler::put(ready);
    }
    else {
        sem->val +=1;
    }

    return 0;
}

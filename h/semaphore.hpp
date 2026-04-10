
#ifndef PROJ_SEMAPHORE_HPP
#define PROJ_SEMAPHORE_HPP
#include "MemoryAllocator.hpp"
#include "tcb.hpp"
#include "workers.hpp"
#include "print.hpp"
#include "riscv.hpp"
#include "syscall_c.h"
#include "syscall_cpp.hpp"
#include "scheduler.hpp"

class TCB;

class semaphore final
{
public:
     explicit semaphore(unsigned int init = 1) {
        this->val = init;
        this->lock = false;
        this->closed = false;
    }

    bool isLocked() const {return lock;}
    bool isClosed() const {return closed;}
    void setClosed(bool close) {closed = close;}
    unsigned int getVal() const {return val;}

    static int _sem_open(semaphore** sem,unsigned int val);
    static int _sem_close(semaphore* sem);
    static int _sem_wait(semaphore* sem);
    static int _sem_signal(semaphore* sem);

    void* operator new(size_t size) {
        return MemoryAllocator::_mem_alloc(size);
    }
    void* operator new[](size_t size) {
        return MemoryAllocator::_mem_alloc(size);
    }

    void operator delete(void *ptr) {
        MemoryAllocator::_mem_free(ptr);
    }
    void operator delete[](void *ptr) {
        MemoryAllocator::_mem_free(ptr);
    }

    static TCB * get(semaphore *sem);

    static void put(semaphore *sem);

protected:
    void block();
    void unblock();

private:

    unsigned int val;
    bool lock;
    bool closed;
    List<TCB> blocked;
};


#endif //PROJ_SEMAPHORE_HPP


#ifndef PROJ_SYSCALL_CPP_HPP
#define PROJ_SYSCALL_CPP_HPP

#include "syscall_c.h"
#include "../lib/hw.h"
#include "../h/tcb.hpp"
#include "../h/print.hpp"
class TCB;

typedef TCB *thread_t;
class semaphore;
typedef semaphore* sem_t;

void *operator new[](size_t n);
void *operator new(size_t n);
void operator delete(void *addr) noexcept;
void operator delete[](void *addr) noexcept;


class Thread
{
public:
    Thread(void (*body)(void *), void *arg);

     virtual ~Thread ();

     int start ();
     void join();

     static void dispatch ();

     static int sleep (time_t);

    thread_t myHandle;
protected:
     Thread ();
     virtual void run () { }
 private:
    void (*body)(void*);
     void* arg;
     static void wrapper(void* args) {
         Thread* thread = (Thread*) args;
         thread->run();
     }
 };

 class Semaphore {
 public:
     explicit Semaphore (unsigned init = 1);
     virtual ~Semaphore ();
     int wait ();
     int signal ();
 private:
     sem_t myHandle;
 };


class Console{
public:
    static char getc ();
    static void putc (char);
};


#endif //PROJ_SYSCALL_CPP_HPP

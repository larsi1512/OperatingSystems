
#ifndef SYSCALL_C_HPP
#define SYSCALL_C_HPP

#include "../h/tcb.hpp"
#include "../lib/hw.h"



void* mem_alloc (size_t size);
int mem_free (void*);


class TCB;

typedef TCB *thread_t;

int thread_create(thread_t *handle, void(*start_routine)(void *), void *arg);
int thread_create_not_start(thread_t *handle, void(*start_routine)(void *), void *arg);
int thread_exit();
int thread_start(thread_t* handle);
void thread_dispatch();

void thread_join(thread_t handle);

class semaphore;
typedef semaphore* sem_t;

int sem_open (
        sem_t* handle,
        unsigned init
);
int sem_close (sem_t handle);
int sem_wait (sem_t id);
int sem_signal (sem_t id);

char getc();

void putc(char);
void switch_to_user_mode();

typedef unsigned long time_t;

#endif //SYSCALL_C_HPP


#ifndef PROJ_SYSCALL_C_HPP
#define PROJ_SYSCALL_C_HPP

#include "../lib/hw.h"
#include "../h/scheduler.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/MemoryAllocator.hpp"
// Thread Control Block

typedef TCB *thread_t;

class TCB final
{
public:
    ~TCB() { delete[] stack; }

    bool isFinished() const { return finished; }

    void setFinished(bool value) { finished = value; }

    bool isBlocked() const { return blocked; }

    void setBlocked(bool value) { blocked = value; }

    uint64 getTimeSlice() const { return timeSlice; }

    using Body = void (*)(void*);

    static int createThread(thread_t* handle, Body body,void * arg);

    static int createThreadNotStart(thread_t* handle, Body body,void * arg);
    static void exitThread();
    static void yield();
    static void join(thread_t handle);

    static TCB *running;
    static int id;

    static void dispatch();

private:

    TCB(Body body,void * arg, uint64 timeSlice) :
            pid(TCB::id++),
            body(body),
            arg(arg),
            stack(body != nullptr ? new uint64[STACK_SIZE] : nullptr),
            context({(uint64) &threadWrapper,
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
                    }),
            timeSlice(timeSlice),
            finished(false),
            blocked(false)
    {
            if (body != nullptr) { }
    }
//            pid(TCB::id++),
//            body(body),
//            arg(arg),
//            timeSlice(timeSlice),
//            finished(false)
//    {
//            uint64* stekic = (uint64*) MemoryAllocator::_mem_alloc(sizeof(uint64)*DEFAULT_STACK_SIZE);
//            this->stack = stekic;
//            this->context = (Context*) MemoryAllocator::_mem_alloc(sizeof(context));
//            this->context->ra = (uint64) &threadWrapper;
//            this->context->sp = (uint64)(stekic)+sizeof(uint64)*DEFAULT_STACK_SIZE;
//        if (body != nullptr) { Scheduler::put(this); }
//    }

    struct Context
    {
        uint64 ra;
        uint64 sp;
    };

    const int pid;
    Body body;
    void* arg;
    uint64 *stack;
    Context context;
    uint64 timeSlice;
    bool finished;
    bool blocked;
    List<TCB> waitToJoin;

    friend class Riscv;

    static void threadWrapper();

    static void contextSwitch(Context *oldContext, Context *runningContext);
    static int start(thread_t *handle);

    static void unblock();
    static uint64 timeSliceCounter;

    static uint64 constexpr STACK_SIZE = DEFAULT_STACK_SIZE;
    static uint64 constexpr TIME_SLICE = DEFAULT_TIME_SLICE;
};

#endif //PROJ_SYSCALL_C_HPP

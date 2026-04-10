//
// Created by marko on 20.4.22..
//

#ifndef OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_SCHEDULER_HPP
#define OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_SCHEDULER_HPP

#include "list.hpp"

class TCB;

class Scheduler
{
private:
    static Scheduler* scheduler;
    static List<TCB> readyThreads;
protected:
    Scheduler();
public:

    static void init();
    static Scheduler* getInstance();

    static TCB *get();

    static void put(TCB *ccb);

};

#endif //OS1_VEZBE07_RISCV_CONTEXT_SWITCH_2_INTERRUPT_SCHEDULER_HPP

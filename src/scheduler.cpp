//
// Created by marko on 20.4.22..
//

#include "../h/scheduler.hpp"
#include "../h/tcb.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/print.hpp"

List<TCB> Scheduler::readyThreads;

Scheduler::Scheduler() {
};

TCB *Scheduler::get()
{
    return readyThreads.removeFirst();


}

void Scheduler::put(TCB *ccb)
{
    readyThreads.addLast(ccb);

}

Scheduler *Scheduler::scheduler = nullptr;

void Scheduler::init() {
    if (scheduler == nullptr) {
        scheduler  = new Scheduler();

    }
}
Scheduler *Scheduler::getInstance()
{
    if (scheduler == nullptr) {
        scheduler  = new Scheduler();

    }
    return scheduler;
}
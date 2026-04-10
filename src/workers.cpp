//
// Created by marko on 20.4.22..
//

#include "../lib/hw.h"
#include "../h/tcb.hpp"
#include "../h/print.hpp"

//void workerBodyA()
//{
//    for (uint64 i = 0; i < 10; i++)
//    {
//        print_string("A: i=");
//        print_integer(i);
//        print_string("\n");
//        for (uint64 j = 0; j < 10000; j++)
//        {
//            for (uint64 k = 0; k < 30000; k++)
//            {
//                // busy wait
//            }
//
//
//        }
//        if (i ==5) {
//            TCB::yield();
//        }
//    }
//}


void workerBodyEmpty()
{
    print_string("Coffa la la lalalalalalala");

}

//void workerBodyB()
//{
//    for (uint64 i = 0; i < 16; i++)
//    {
//        print_string("B: i=");
//        print_integer(i);
//        print_string("\n");
//        for (uint64 j = 0; j < 10000; j++)
//        {
//            for (uint64 k = 0; k < 30000; k++)
//            {
//                // busy wait
//            }
//
//
//        }
//        if(i == 5) {
//            TCB::yield();
//        }
//    }
//}
//
//static uint64 fibonacci(uint64 n)
//{
//    if (n == 0 || n == 1) { return n; }
//    if (n % 10 == 0) { TCB::yield(); }
//    return fibonacci(n - 1) + fibonacci(n - 2);
//}
//
//void workerBodyC()
//{
//    uint8 i = 0;
//    for (; i < 3; i++)
//    {
//        print_integer(i);
//        print_string("C: i=");
//
//        print_string("\n");
//    }
//
//    print_string("C: yield\n");
//    __asm__ ("li t1, 7");
//    TCB::yield();
//
//    uint64 t1 = 0;
//    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
//
//    print_string("C: t1=");
//    print_integer(t1);
//    print_string("\n");
//
//    uint64 result = fibonacci(12);
//    print_string("C: fibonaci=");
//    print_integer(result);
//    print_string("\n");
//
//    for (; i < 6; i++)
//    {
//        print_string("C: i=");
//        print_integer(i);
//        print_string("\n");
//    }
////    TCB::yield();
//}
//
//void workerBodyD()
//{
//    uint8 i = 10;
//    for (; i < 13; i++)
//    {
//        print_string("D: i=");
//        print_integer(i);
//        print_string("\n");
//    }
//
//    print_string("D: yield\n");
//    __asm__ ("li t1, 5");
//    TCB::yield();
//
//    uint64 result = fibonacci(16);
//    print_string("D: fibonaci=");
//    print_integer(result);
//    print_string("\n");
//
//    for (; i < 16; i++)
//    {
//        print_string("D: i=");
//        print_integer(i);
//        print_string("\n");
//    }
////    TCB::yield();
//}

void workerBodyProba()
{
    uint8 i = 10;
    for (; i < 13; i++)
    {
        print_string("Proba: i=");
        print_integer(i);
        print_string("\n");
    }

    print_string("D: yield\n");
    Thread::dispatch();

    uint64 result = 16;
    print_string("D: fibonaci=");
    print_integer(result);
    print_string("\n");

    for (; i < 16; i++)
    {
        print_string("D: i=");
        print_integer(i);
        print_string("\n");
    }
    Thread::dispatch();
}
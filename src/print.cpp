
#include "../h/print.hpp"
#include "../h/riscv.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"

void print_string(char const *string)
{
    while (*string != '\0')
    {
        Console::putc(*string);
        string++;
    }
}

void print_integer(uint64 integer)
{

    static char digits[] = "0123456789";
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if (integer < 0)
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    }

    i = 0;
    do
    {
        buf[i++] = digits[x % 10];
    } while ((x /= 10) != 0);
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { Console::putc(buf[i]); }
}
#ifndef PROJ_MEMORYALLOCATOR_HPP
#define PROJ_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

class MemoryAllocator {
    struct mem_seg {
        //proveri jel okej da next i prev budu mem_seg*
        mem_seg* next; // pokazivac na sledeci slobodni fragment
        mem_seg* prev; // analogno
        uint64 addr; // cuva pocetnu adresu slobodnog fragmenta
        uint64 mem_block_num; //cuva broj blokova slobodnog fragmenta
    };

public:
    static void initMemory();

    static void* _mem_alloc(size_t size);

    static int _mem_free(void* addr);

};

#endif //PROJ_MEMORYALLOCATOR_HPP

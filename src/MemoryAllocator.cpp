//
// Created by os on 9/8/23.
//

#include "../h/MemoryAllocator.hpp"

#include "../lib/hw.h"
#include "../h/print.hpp"


void MemoryAllocator::initMemory() {

    mem_seg* head = (mem_seg*) ((void*) HEAP_START_ADDR);
    head->next = nullptr;
    head->prev = nullptr;
    head->addr = *((uint64*)&HEAP_START_ADDR)  + sizeof(mem_seg);
    head->mem_block_num = (*((uint64*)&HEAP_END_ADDR) - *((uint64*)&HEAP_START_ADDR) - sizeof(mem_seg) -1) / MEM_BLOCK_SIZE;
}

void* MemoryAllocator::_mem_alloc(size_t size) {
    uint64 num_block = ((uint64)size + sizeof(uint64)) / MEM_BLOCK_SIZE;
    if (((uint64)size + sizeof(uint64)) % MEM_BLOCK_SIZE != 0) {
        num_block = num_block + 1;
    }
    mem_seg* head = (mem_seg*) ((void*) HEAP_START_ADDR);
    mem_seg* temp = (mem_seg*) ((void*) HEAP_START_ADDR);
    temp = (mem_seg*) temp->next;


    if (head->mem_block_num >= num_block ) {
        uint64 *adr = (uint64*) head->addr;
        head->mem_block_num = head->mem_block_num - num_block;
        *adr = num_block;
        head->addr = head->addr + num_block * MEM_BLOCK_SIZE;
        return (void*) (adr+1);

    }
        //proveri ispravnost nakon radjenja free
    else {
        while (temp) {
            if (temp->mem_block_num >= num_block ) {
                uint64 *adr = (uint64*) temp->addr;
                temp->mem_block_num = temp->mem_block_num - num_block;
                *adr = num_block;
                temp->addr = temp->addr + num_block * MEM_BLOCK_SIZE;
                return (void*) (adr+ 1);
            }
            else {
                temp = temp->next;
            }
        }
        print_string("Nema mesta za alokaciju");
    }
    return (void*) 0;

}

int MemoryAllocator::_mem_free(void* addr) {
    uint64 *adr = (uint64*) addr;
    uint64 *adrBlock = (uint64*)(adr - 1);
    uint64 num = (uint64) *adrBlock;
    mem_seg* head = (mem_seg*) ((void*) HEAP_START_ADDR);
    mem_seg* temp = (mem_seg*) ((void*) HEAP_START_ADDR);
    mem_seg* free_seg= (mem_seg*) ((void*) head->addr);
    uint64 num_block = (sizeof(mem_seg)) / MEM_BLOCK_SIZE;
    num_block = num_block + 1;
    if (temp == nullptr) {
        return -1;
    }
    if (head->mem_block_num >= num_block) {
        mem_seg * free_seg = (mem_seg*) ((void*) head->addr) ;
        head->addr = head->addr  + sizeof(mem_seg);
        head->mem_block_num = head->mem_block_num - num_block;
        while(temp->next) {
            temp = (mem_seg*) temp->next;
        }
        temp->next = free_seg;
    }
    else {
        temp = (mem_seg*) temp->next;

        while(temp) {
            if (temp->mem_block_num >= num_block) {
                mem_seg * free_seg = (mem_seg*) ((void*) temp->addr) ;
                temp->addr = temp->addr  + sizeof(mem_seg);
                temp->mem_block_num = temp->mem_block_num - num_block;
                while(temp->next) {
                    temp = (mem_seg*) temp->next;
                }
                temp->next = free_seg;
                break;
            }
            else {
                temp = (mem_seg*) temp->next;
            }
        }
        if (temp == nullptr) {
            return -1;
        }

    }

    free_seg->next = nullptr;
    free_seg->prev = temp; //posle sredi
    free_seg->addr = *((uint64*)&adrBlock);
    free_seg->mem_block_num = num;
    return 0;
}



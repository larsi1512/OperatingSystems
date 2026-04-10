# OperatingSystems

An educational **RISC-V kernel project** written in **C, C++, and assembly**, focused on core operating-system mechanisms such as memory allocation, thread management, context switching, system calls, synchronization, and trap handling.

This project is intended as a small operating-systems kernel for learning and experimentation in a QEMU-based RISC-V environment.

---

## Features

- **Custom memory allocator**
  - Initializes the kernel heap
  - Supports dynamic allocation and deallocation through kernel-managed memory blocks

- **Thread management**
  - Thread Control Block (TCB) implementation
  - Thread creation, start, dispatch, exit, and join
  - Separate C and C++ thread interfaces

- **Scheduling**
  - Ready-queue based scheduler
  - Cooperative context switching through explicit dispatch/yield paths

- **System call layer**
  - C API for low-level kernel services
  - C++ wrappers for threads, semaphores, memory allocation, and console I/O

- **Synchronization**
  - Semaphore implementation for blocking and signaling between threads

- **Trap and interrupt handling**
  - Supervisor trap entry and syscall dispatch
  - Console interrupt support
  - RISC-V register access helpers

- **Testing support**
  - Included test programs for:
    - C thread API
    - C++ thread API
    - semaphores / producer-consumer scenarios
    - user/system mode checks
    - sleep-related coursework tests

---

## Project Structure

```text
.
├── build/                  # Build output
├── h/                      # Header files
│   ├── MemoryAllocator.hpp
│   ├── riscv.hpp
│   ├── scheduler.hpp
│   ├── semaphore.hpp
│   ├── syscall_c.h
│   ├── syscall_cpp.hpp
│   ├── tcb.hpp
│   └── ...
├── lib/                    # Support libraries / hardware interface
│   ├── console.h
│   ├── hw.h
│   ├── mem.h
│   └── *.lib
├── src/                    # Kernel source files
│   ├── initialize.cpp
│   ├── main.cpp
│   ├── MemoryAllocator.cpp
│   ├── riscv.cpp
│   ├── scheduler.cpp
│   ├── semaphore.cpp
│   ├── syscall_c.cpp
│   ├── syscall_cpp.cpp
│   ├── tcb.cpp
│   └── ...
├── test/                   # Test programs and helpers
├── kernel.ld               # Linker script
├── Makefile                # Build and run commands
├── kernel                  # Built kernel image
└── kernel.asm              # Kernel disassembly

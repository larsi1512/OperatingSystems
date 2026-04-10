
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	63013103          	ld	sp,1584(sp) # 8000b630 <_GLOBAL_OFFSET_TABLE_+0x20>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	1c4060ef          	jal	ra,800061e0 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv14supervisorTrapEv>:
.align 4
.global _ZN5Riscv14supervisorTrapEv
.type _ZN5Riscv14supervisorTrapEv, @function
_ZN5Riscv14supervisorTrapEv:
    # push all registers to stack
    addi sp, sp, -256
    80001020:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00013023          	sd	zero,0(sp)
    80001028:	00113423          	sd	ra,8(sp)
    8000102c:	00213823          	sd	sp,16(sp)
    80001030:	00313c23          	sd	gp,24(sp)
    80001034:	02413023          	sd	tp,32(sp)
    80001038:	02513423          	sd	t0,40(sp)
    8000103c:	02613823          	sd	t1,48(sp)
    80001040:	02713c23          	sd	t2,56(sp)
    80001044:	04813023          	sd	s0,64(sp)
    80001048:	04913423          	sd	s1,72(sp)
    8000104c:	04a13823          	sd	a0,80(sp)
    80001050:	04b13c23          	sd	a1,88(sp)
    80001054:	06c13023          	sd	a2,96(sp)
    80001058:	06d13423          	sd	a3,104(sp)
    8000105c:	06e13823          	sd	a4,112(sp)
    80001060:	06f13c23          	sd	a5,120(sp)
    80001064:	09013023          	sd	a6,128(sp)
    80001068:	09113423          	sd	a7,136(sp)
    8000106c:	09213823          	sd	s2,144(sp)
    80001070:	09313c23          	sd	s3,152(sp)
    80001074:	0b413023          	sd	s4,160(sp)
    80001078:	0b513423          	sd	s5,168(sp)
    8000107c:	0b613823          	sd	s6,176(sp)
    80001080:	0b713c23          	sd	s7,184(sp)
    80001084:	0d813023          	sd	s8,192(sp)
    80001088:	0d913423          	sd	s9,200(sp)
    8000108c:	0da13823          	sd	s10,208(sp)
    80001090:	0db13c23          	sd	s11,216(sp)
    80001094:	0fc13023          	sd	t3,224(sp)
    80001098:	0fd13423          	sd	t4,232(sp)
    8000109c:	0fe13823          	sd	t5,240(sp)
    800010a0:	0ff13c23          	sd	t6,248(sp)
    csrw sscratch, sp
    800010a4:	14011073          	csrw	sscratch,sp
    call _ZN5Riscv20handleSupervisorTrapEv
    800010a8:	330010ef          	jal	ra,800023d8 <_ZN5Riscv20handleSupervisorTrapEv>

    # pop all registers from stack
    .irp index, 0,1,2,3,4,5,6,7,8,9,10, 11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800010ac:	00013003          	ld	zero,0(sp)
    800010b0:	00813083          	ld	ra,8(sp)
    800010b4:	01013103          	ld	sp,16(sp)
    800010b8:	01813183          	ld	gp,24(sp)
    800010bc:	02013203          	ld	tp,32(sp)
    800010c0:	02813283          	ld	t0,40(sp)
    800010c4:	03013303          	ld	t1,48(sp)
    800010c8:	03813383          	ld	t2,56(sp)
    800010cc:	04013403          	ld	s0,64(sp)
    800010d0:	04813483          	ld	s1,72(sp)
    800010d4:	05013503          	ld	a0,80(sp)
    800010d8:	05813583          	ld	a1,88(sp)
    800010dc:	06013603          	ld	a2,96(sp)
    800010e0:	06813683          	ld	a3,104(sp)
    800010e4:	07013703          	ld	a4,112(sp)
    800010e8:	07813783          	ld	a5,120(sp)
    800010ec:	08013803          	ld	a6,128(sp)
    800010f0:	08813883          	ld	a7,136(sp)
    800010f4:	09013903          	ld	s2,144(sp)
    800010f8:	09813983          	ld	s3,152(sp)
    800010fc:	0a013a03          	ld	s4,160(sp)
    80001100:	0a813a83          	ld	s5,168(sp)
    80001104:	0b013b03          	ld	s6,176(sp)
    80001108:	0b813b83          	ld	s7,184(sp)
    8000110c:	0c013c03          	ld	s8,192(sp)
    80001110:	0c813c83          	ld	s9,200(sp)
    80001114:	0d013d03          	ld	s10,208(sp)
    80001118:	0d813d83          	ld	s11,216(sp)
    8000111c:	0e013e03          	ld	t3,224(sp)
    80001120:	0e813e83          	ld	t4,232(sp)
    80001124:	0f013f03          	ld	t5,240(sp)
    80001128:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000112c:	10010113          	addi	sp,sp,256

    sret
    80001130:	10200073          	sret
	...

0000000080001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>:
.global _ZN3TCB13contextSwitchEPNS_7ContextES1_
.type _ZN3TCB13contextSwitchEPNS_7ContextES1_, @function
_ZN3TCB13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001140:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001144:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001148:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000114c:	0085b103          	ld	sp,8(a1)

    ret
    80001150:	00008067          	ret

0000000080001154 <_ZN5Riscv13pushRegistersEv>:


.global _ZN5Riscv13pushRegistersEv
.type _ZN5Riscv13pushRegistersEv @function
_ZN5Riscv13pushRegistersEv:
    addi sp, sp, -256
    80001154:	f0010113          	addi	sp,sp,-256
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001158:	00313c23          	sd	gp,24(sp)
    8000115c:	02413023          	sd	tp,32(sp)
    80001160:	02513423          	sd	t0,40(sp)
    80001164:	02613823          	sd	t1,48(sp)
    80001168:	02713c23          	sd	t2,56(sp)
    8000116c:	04813023          	sd	s0,64(sp)
    80001170:	04913423          	sd	s1,72(sp)
    80001174:	04a13823          	sd	a0,80(sp)
    80001178:	04b13c23          	sd	a1,88(sp)
    8000117c:	06c13023          	sd	a2,96(sp)
    80001180:	06d13423          	sd	a3,104(sp)
    80001184:	06e13823          	sd	a4,112(sp)
    80001188:	06f13c23          	sd	a5,120(sp)
    8000118c:	09013023          	sd	a6,128(sp)
    80001190:	09113423          	sd	a7,136(sp)
    80001194:	09213823          	sd	s2,144(sp)
    80001198:	09313c23          	sd	s3,152(sp)
    8000119c:	0b413023          	sd	s4,160(sp)
    800011a0:	0b513423          	sd	s5,168(sp)
    800011a4:	0b613823          	sd	s6,176(sp)
    800011a8:	0b713c23          	sd	s7,184(sp)
    800011ac:	0d813023          	sd	s8,192(sp)
    800011b0:	0d913423          	sd	s9,200(sp)
    800011b4:	0da13823          	sd	s10,208(sp)
    800011b8:	0db13c23          	sd	s11,216(sp)
    800011bc:	0fc13023          	sd	t3,224(sp)
    800011c0:	0fd13423          	sd	t4,232(sp)
    800011c4:	0fe13823          	sd	t5,240(sp)
    800011c8:	0ff13c23          	sd	t6,248(sp)
    ret
    800011cc:	00008067          	ret

00000000800011d0 <_ZN5Riscv12popRegistersEv>:
.global _ZN5Riscv12popRegistersEv
.type _ZN5Riscv12popRegistersEv @function
_ZN5Riscv12popRegistersEv:
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011d0:	01813183          	ld	gp,24(sp)
    800011d4:	02013203          	ld	tp,32(sp)
    800011d8:	02813283          	ld	t0,40(sp)
    800011dc:	03013303          	ld	t1,48(sp)
    800011e0:	03813383          	ld	t2,56(sp)
    800011e4:	04013403          	ld	s0,64(sp)
    800011e8:	04813483          	ld	s1,72(sp)
    800011ec:	05013503          	ld	a0,80(sp)
    800011f0:	05813583          	ld	a1,88(sp)
    800011f4:	06013603          	ld	a2,96(sp)
    800011f8:	06813683          	ld	a3,104(sp)
    800011fc:	07013703          	ld	a4,112(sp)
    80001200:	07813783          	ld	a5,120(sp)
    80001204:	08013803          	ld	a6,128(sp)
    80001208:	08813883          	ld	a7,136(sp)
    8000120c:	09013903          	ld	s2,144(sp)
    80001210:	09813983          	ld	s3,152(sp)
    80001214:	0a013a03          	ld	s4,160(sp)
    80001218:	0a813a83          	ld	s5,168(sp)
    8000121c:	0b013b03          	ld	s6,176(sp)
    80001220:	0b813b83          	ld	s7,184(sp)
    80001224:	0c013c03          	ld	s8,192(sp)
    80001228:	0c813c83          	ld	s9,200(sp)
    8000122c:	0d013d03          	ld	s10,208(sp)
    80001230:	0d813d83          	ld	s11,216(sp)
    80001234:	0e013e03          	ld	t3,224(sp)
    80001238:	0e813e83          	ld	t4,232(sp)
    8000123c:	0f013f03          	ld	t5,240(sp)
    80001240:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001244:	10010113          	addi	sp,sp,256
    80001248:	00008067          	ret

000000008000124c <_Z19switch_to_user_modev>:
#include "../h/print.hpp"
#include "../h/tcb.hpp"
#include "../lib/hw.h"
//static uint64 PID = 0;

void switch_to_user_mode() {
    8000124c:	ff010113          	addi	sp,sp,-16
    80001250:	00813423          	sd	s0,8(sp)
    80001254:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a0, zero, 0x99");
    80001258:	09900513          	li	a0,153
    __asm__ volatile ("ecall");
    8000125c:	00000073          	ecall
}
    80001260:	00813403          	ld	s0,8(sp)
    80001264:	01010113          	addi	sp,sp,16
    80001268:	00008067          	ret

000000008000126c <_Z9mem_allocm>:

void *mem_alloc(size_t size)
{
    8000126c:	fe010113          	addi	sp,sp,-32
    80001270:	00813c23          	sd	s0,24(sp)
    80001274:	02010413          	addi	s0,sp,32

    __asm__ volatile ("addi a1, a0, 0x0");
    80001278:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x01");
    8000127c:	00100513          	li	a0,1
//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    __asm__ volatile ("ecall");
    80001280:	00000073          	ecall

};
inline uint64 Riscv::r_a0()
{
    uint64  a0;
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    80001284:	00050793          	mv	a5,a0
    uint64 volatile a1 = Riscv::r_a0();
    80001288:	fef43423          	sd	a5,-24(s0)
    return (void *) a1;
    8000128c:	fe843503          	ld	a0,-24(s0)
}
    80001290:	01813403          	ld	s0,24(sp)
    80001294:	02010113          	addi	sp,sp,32
    80001298:	00008067          	ret

000000008000129c <_Z8mem_freePv>:

int mem_free(void *addr)
{
    8000129c:	fe010113          	addi	sp,sp,-32
    800012a0:	00813c23          	sd	s0,24(sp)
    800012a4:	02010413          	addi	s0,sp,32
    __asm__ volatile ("addi a1, a0, 0x0");
    800012a8:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x02");
    800012ac:	00200513          	li	a0,2
//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    __asm__ volatile ("ecall");
    800012b0:	00000073          	ecall
    800012b4:	00050793          	mv	a5,a0
    uint64 volatile a1 = Riscv::r_a0();
    800012b8:	fef43423          	sd	a5,-24(s0)
    return (int) a1;
    800012bc:	fe843503          	ld	a0,-24(s0)
}
    800012c0:	0005051b          	sext.w	a0,a0
    800012c4:	01813403          	ld	s0,24(sp)
    800012c8:	02010113          	addi	sp,sp,32
    800012cc:	00008067          	ret

00000000800012d0 <_Z23thread_create_not_startPP3TCBPFvPvES2_>:

int thread_create_not_start(thread_t *handle, void(*start_routine)(void *), void *arg)
{
    800012d0:	ff010113          	addi	sp,sp,-16
    800012d4:	00813423          	sd	s0,8(sp)
    800012d8:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a3, a2, 0x0");
    800012dc:	00060693          	mv	a3,a2
    __asm__ volatile ("addi a2, a1, 0x0");
    800012e0:	00058613          	mv	a2,a1
    __asm__ volatile ("addi a1, a0, 0x0");
    800012e4:	00050593          	mv	a1,a0

    __asm__ volatile ("mv a0, %0" : : "r"(0x07));
    800012e8:	00700793          	li	a5,7
    800012ec:	00078513          	mv	a0,a5

//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    int a0;
    __asm__ volatile ("ecall");
    800012f0:	00000073          	ecall

    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    800012f4:	00050513          	mv	a0,a0

    return a0;
}
    800012f8:	0005051b          	sext.w	a0,a0
    800012fc:	00813403          	ld	s0,8(sp)
    80001300:	01010113          	addi	sp,sp,16
    80001304:	00008067          	ret

0000000080001308 <_Z13thread_createPP3TCBPFvPvES2_>:
int thread_create(thread_t *handle, void(*start_routine)(void *), void *arg)
{
    80001308:	ff010113          	addi	sp,sp,-16
    8000130c:	00813423          	sd	s0,8(sp)
    80001310:	01010413          	addi	s0,sp,16

    __asm__ volatile ("addi a3, a2, 0x0");
    80001314:	00060693          	mv	a3,a2
    __asm__ volatile ("addi a2, a1, 0x0");
    80001318:	00058613          	mv	a2,a1
    __asm__ volatile ("addi a1, a0, 0x0");
    8000131c:	00050593          	mv	a1,a0


    __asm__ volatile ("mv a0, %0" : : "r"(0x11));
    80001320:	01100793          	li	a5,17
    80001324:	00078513          	mv	a0,a5

//    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);

    int a0;
    __asm__ volatile ("ecall");
    80001328:	00000073          	ecall


    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    8000132c:	00050513          	mv	a0,a0
    return a0;
}
    80001330:	0005051b          	sext.w	a0,a0
    80001334:	00813403          	ld	s0,8(sp)
    80001338:	01010113          	addi	sp,sp,16
    8000133c:	00008067          	ret

0000000080001340 <_Z12thread_startPP3TCB>:

int thread_start(thread_t *handle)
{
    80001340:	ff010113          	addi	sp,sp,-16
    80001344:	00813423          	sd	s0,8(sp)
    80001348:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a1, a0, 0x0");
    8000134c:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x08");
    80001350:	00800513          	li	a0,8
    __asm__ volatile ("ecall");
    80001354:	00000073          	ecall
    return 0;
}
    80001358:	00000513          	li	a0,0
    8000135c:	00813403          	ld	s0,8(sp)
    80001360:	01010113          	addi	sp,sp,16
    80001364:	00008067          	ret

0000000080001368 <_Z11thread_exitv>:
int thread_exit()
{
    80001368:	ff010113          	addi	sp,sp,-16
    8000136c:	00813423          	sd	s0,8(sp)
    80001370:	01010413          	addi	s0,sp,16

    __asm__ volatile ("addi a0, zero, 0x12");
    80001374:	01200513          	li	a0,18
    __asm__ volatile ("ecall");
    80001378:	00000073          	ecall
    return 0;
}
    8000137c:	00000513          	li	a0,0
    80001380:	00813403          	ld	s0,8(sp)
    80001384:	01010113          	addi	sp,sp,16
    80001388:	00008067          	ret

000000008000138c <_Z15thread_dispatchv>:

void thread_dispatch()
{
    8000138c:	ff010113          	addi	sp,sp,-16
    80001390:	00813423          	sd	s0,8(sp)
    80001394:	01010413          	addi	s0,sp,16

    __asm__ volatile ("addi a0, zero, 0x13");
    80001398:	01300513          	li	a0,19
    __asm__ volatile ("ecall");
    8000139c:	00000073          	ecall

}
    800013a0:	00813403          	ld	s0,8(sp)
    800013a4:	01010113          	addi	sp,sp,16
    800013a8:	00008067          	ret

00000000800013ac <_Z11thread_joinP3TCB>:

void thread_join(thread_t handle)
{
    800013ac:	ff010113          	addi	sp,sp,-16
    800013b0:	00813423          	sd	s0,8(sp)
    800013b4:	01010413          	addi	s0,sp,16

    __asm__ volatile ("addi a1, a0, 0x0");
    800013b8:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x14");
    800013bc:	01400513          	li	a0,20
    __asm__ volatile ("ecall");
    800013c0:	00000073          	ecall
}
    800013c4:	00813403          	ld	s0,8(sp)
    800013c8:	01010113          	addi	sp,sp,16
    800013cc:	00008067          	ret

00000000800013d0 <_Z8sem_openPP9semaphorej>:


int sem_open(sem_t *handle, unsigned init)
{
    800013d0:	ff010113          	addi	sp,sp,-16
    800013d4:	00813423          	sd	s0,8(sp)
    800013d8:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a2, a1, 0x0");
    800013dc:	00058613          	mv	a2,a1
    __asm__ volatile ("addi a1, a0, 0x0");
    800013e0:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x21");
    800013e4:	02100513          	li	a0,33
    __asm__ volatile ("ecall");
    800013e8:	00000073          	ecall
    return 0;
}
    800013ec:	00000513          	li	a0,0
    800013f0:	00813403          	ld	s0,8(sp)
    800013f4:	01010113          	addi	sp,sp,16
    800013f8:	00008067          	ret

00000000800013fc <_Z9sem_closeP9semaphore>:
int sem_close(sem_t handle)
{
    800013fc:	ff010113          	addi	sp,sp,-16
    80001400:	00813423          	sd	s0,8(sp)
    80001404:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a1, a0, 0x0");
    80001408:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x22");
    8000140c:	02200513          	li	a0,34
    __asm__ volatile ("ecall");
    80001410:	00000073          	ecall
    return 0;
}
    80001414:	00000513          	li	a0,0
    80001418:	00813403          	ld	s0,8(sp)
    8000141c:	01010113          	addi	sp,sp,16
    80001420:	00008067          	ret

0000000080001424 <_Z8sem_waitP9semaphore>:
int sem_wait(sem_t id)
{
    80001424:	ff010113          	addi	sp,sp,-16
    80001428:	00813423          	sd	s0,8(sp)
    8000142c:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a1, a0, 0x0");
    80001430:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x23");
    80001434:	02300513          	li	a0,35
    int a0;
    __asm__ volatile ("ecall");
    80001438:	00000073          	ecall


    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    8000143c:	00050513          	mv	a0,a0
    return a0;
}
    80001440:	0005051b          	sext.w	a0,a0
    80001444:	00813403          	ld	s0,8(sp)
    80001448:	01010113          	addi	sp,sp,16
    8000144c:	00008067          	ret

0000000080001450 <_Z10sem_signalP9semaphore>:
int sem_signal(sem_t id)
{
    80001450:	ff010113          	addi	sp,sp,-16
    80001454:	00813423          	sd	s0,8(sp)
    80001458:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a1, a0, 0x0");
    8000145c:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x24");
    80001460:	02400513          	li	a0,36
    int a0;
    __asm__ volatile ("ecall");
    80001464:	00000073          	ecall


    __asm__ volatile ("mv %0, a0" :  "=r"(a0));
    80001468:	00050513          	mv	a0,a0
    return a0;
}
    8000146c:	0005051b          	sext.w	a0,a0
    80001470:	00813403          	ld	s0,8(sp)
    80001474:	01010113          	addi	sp,sp,16
    80001478:	00008067          	ret

000000008000147c <_Z4getcv>:

char getc()
{
    8000147c:	fe010113          	addi	sp,sp,-32
    80001480:	00813c23          	sd	s0,24(sp)
    80001484:	02010413          	addi	s0,sp,32
    __asm__ volatile ("addi a0, zero, 0x41");
    80001488:	04100513          	li	a0,65
    __asm__ volatile ("ecall");
    8000148c:	00000073          	ecall
    80001490:	00050793          	mv	a5,a0
    char volatile a1 = Riscv::r_a0();
    80001494:	0ff7f793          	andi	a5,a5,255
    80001498:	fef407a3          	sb	a5,-17(s0)
    return (char) a1;
    8000149c:	fef44503          	lbu	a0,-17(s0)
}
    800014a0:	0ff57513          	andi	a0,a0,255
    800014a4:	01813403          	ld	s0,24(sp)
    800014a8:	02010113          	addi	sp,sp,32
    800014ac:	00008067          	ret

00000000800014b0 <_Z4putcc>:

void putc(char c)
{
    800014b0:	ff010113          	addi	sp,sp,-16
    800014b4:	00813423          	sd	s0,8(sp)
    800014b8:	01010413          	addi	s0,sp,16
    __asm__ volatile ("addi a1, a0, 0x0");
    800014bc:	00050593          	mv	a1,a0
    __asm__ volatile ("addi a0, zero, 0x42");
    800014c0:	04200513          	li	a0,66
    __asm__ volatile ("ecall");
    800014c4:	00000073          	ecall
}
    800014c8:	00813403          	ld	s0,8(sp)
    800014cc:	01010113          	addi	sp,sp,16
    800014d0:	00008067          	ret

00000000800014d4 <_Z10initializev>:
#include "../h/riscv.hpp"
#include "../h/syscall_cpp.hpp"
extern void userMain();

void initialize()
{
    800014d4:	fe010113          	addi	sp,sp,-32
    800014d8:	00113c23          	sd	ra,24(sp)
    800014dc:	00813823          	sd	s0,16(sp)
    800014e0:	02010413          	addi	s0,sp,32
    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
    800014e4:	0000a797          	auipc	a5,0xa
    800014e8:	13c7b783          	ld	a5,316(a5) # 8000b620 <_GLOBAL_OFFSET_TABLE_+0x10>
    return stvec;
}

inline void Riscv::w_stvec(uint64 stvec)
{
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800014ec:	10579073          	csrw	stvec,a5

    MemoryAllocator::initMemory();
    800014f0:	00001097          	auipc	ra,0x1
    800014f4:	39c080e7          	jalr	924(ra) # 8000288c <_ZN15MemoryAllocator10initMemoryEv>
    Scheduler::init();
    800014f8:	00001097          	auipc	ra,0x1
    800014fc:	2c8080e7          	jalr	712(ra) # 800027c0 <_ZN9Scheduler4initEv>
    thread_t handle;
//    thread_t  usr;

    TCB::createThread(&handle, nullptr, nullptr);
    80001500:	00000613          	li	a2,0
    80001504:	00000593          	li	a1,0
    80001508:	fe840513          	addi	a0,s0,-24
    8000150c:	00000097          	auipc	ra,0x0
    80001510:	608080e7          	jalr	1544(ra) # 80001b14 <_ZN3TCB12createThreadEPPS_PFvPvES2_>
//    TCB::createThread(&usr, (void(*)(void*))userMain, nullptr);
//    switch_to_user_mode();

    TCB::running = handle;
    80001514:	0000a797          	auipc	a5,0xa
    80001518:	1247b783          	ld	a5,292(a5) # 8000b638 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000151c:	fe843703          	ld	a4,-24(s0)
    80001520:	00e7b023          	sd	a4,0(a5)
//    __asm__ volatile("csrs sstatus, %[mask]": : [mask] "r"(1 << 5));
//    Riscv::w_stvec((uint64)&Riscv::supervisorTrap);
//
//
//    Riscv::mc_sstatus(Riscv::SSTATUS_SPP);
}
    80001524:	01813083          	ld	ra,24(sp)
    80001528:	01013403          	ld	s0,16(sp)
    8000152c:	02010113          	addi	sp,sp,32
    80001530:	00008067          	ret

0000000080001534 <_Z15workerBodyEmptyv>:
//    }
//}


void workerBodyEmpty()
{
    80001534:	ff010113          	addi	sp,sp,-16
    80001538:	00113423          	sd	ra,8(sp)
    8000153c:	00813023          	sd	s0,0(sp)
    80001540:	01010413          	addi	s0,sp,16
    print_string("Coffa la la lalalalalalala");
    80001544:	00008517          	auipc	a0,0x8
    80001548:	adc50513          	addi	a0,a0,-1316 # 80009020 <CONSOLE_STATUS+0x10>
    8000154c:	00001097          	auipc	ra,0x1
    80001550:	524080e7          	jalr	1316(ra) # 80002a70 <_Z12print_stringPKc>

}
    80001554:	00813083          	ld	ra,8(sp)
    80001558:	00013403          	ld	s0,0(sp)
    8000155c:	01010113          	addi	sp,sp,16
    80001560:	00008067          	ret

0000000080001564 <_Z15workerBodyProbav>:
//    }
////    TCB::yield();
//}

void workerBodyProba()
{
    80001564:	fe010113          	addi	sp,sp,-32
    80001568:	00113c23          	sd	ra,24(sp)
    8000156c:	00813823          	sd	s0,16(sp)
    80001570:	00913423          	sd	s1,8(sp)
    80001574:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80001578:	00a00493          	li	s1,10
    8000157c:	0380006f          	j	800015b4 <_Z15workerBodyProbav+0x50>
    for (; i < 13; i++)
    {
        print_string("Proba: i=");
    80001580:	00008517          	auipc	a0,0x8
    80001584:	ac050513          	addi	a0,a0,-1344 # 80009040 <CONSOLE_STATUS+0x30>
    80001588:	00001097          	auipc	ra,0x1
    8000158c:	4e8080e7          	jalr	1256(ra) # 80002a70 <_Z12print_stringPKc>
        print_integer(i);
    80001590:	00048513          	mv	a0,s1
    80001594:	00001097          	auipc	ra,0x1
    80001598:	520080e7          	jalr	1312(ra) # 80002ab4 <_Z13print_integerm>
        print_string("\n");
    8000159c:	00008517          	auipc	a0,0x8
    800015a0:	e4c50513          	addi	a0,a0,-436 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800015a4:	00001097          	auipc	ra,0x1
    800015a8:	4cc080e7          	jalr	1228(ra) # 80002a70 <_Z12print_stringPKc>
    for (; i < 13; i++)
    800015ac:	0014849b          	addiw	s1,s1,1
    800015b0:	0ff4f493          	andi	s1,s1,255
    800015b4:	00c00793          	li	a5,12
    800015b8:	fc97f4e3          	bgeu	a5,s1,80001580 <_Z15workerBodyProbav+0x1c>
    }

    print_string("D: yield\n");
    800015bc:	00008517          	auipc	a0,0x8
    800015c0:	a9450513          	addi	a0,a0,-1388 # 80009050 <CONSOLE_STATUS+0x40>
    800015c4:	00001097          	auipc	ra,0x1
    800015c8:	4ac080e7          	jalr	1196(ra) # 80002a70 <_Z12print_stringPKc>
    Thread::dispatch();
    800015cc:	00001097          	auipc	ra,0x1
    800015d0:	c34080e7          	jalr	-972(ra) # 80002200 <_ZN6Thread8dispatchEv>

    uint64 result = 16;
    print_string("D: fibonaci=");
    800015d4:	00008517          	auipc	a0,0x8
    800015d8:	a8c50513          	addi	a0,a0,-1396 # 80009060 <CONSOLE_STATUS+0x50>
    800015dc:	00001097          	auipc	ra,0x1
    800015e0:	494080e7          	jalr	1172(ra) # 80002a70 <_Z12print_stringPKc>
    print_integer(result);
    800015e4:	01000513          	li	a0,16
    800015e8:	00001097          	auipc	ra,0x1
    800015ec:	4cc080e7          	jalr	1228(ra) # 80002ab4 <_Z13print_integerm>
    print_string("\n");
    800015f0:	00008517          	auipc	a0,0x8
    800015f4:	df850513          	addi	a0,a0,-520 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800015f8:	00001097          	auipc	ra,0x1
    800015fc:	478080e7          	jalr	1144(ra) # 80002a70 <_Z12print_stringPKc>
    80001600:	0380006f          	j	80001638 <_Z15workerBodyProbav+0xd4>

    for (; i < 16; i++)
    {
        print_string("D: i=");
    80001604:	00008517          	auipc	a0,0x8
    80001608:	a6c50513          	addi	a0,a0,-1428 # 80009070 <CONSOLE_STATUS+0x60>
    8000160c:	00001097          	auipc	ra,0x1
    80001610:	464080e7          	jalr	1124(ra) # 80002a70 <_Z12print_stringPKc>
        print_integer(i);
    80001614:	00048513          	mv	a0,s1
    80001618:	00001097          	auipc	ra,0x1
    8000161c:	49c080e7          	jalr	1180(ra) # 80002ab4 <_Z13print_integerm>
        print_string("\n");
    80001620:	00008517          	auipc	a0,0x8
    80001624:	dc850513          	addi	a0,a0,-568 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80001628:	00001097          	auipc	ra,0x1
    8000162c:	448080e7          	jalr	1096(ra) # 80002a70 <_Z12print_stringPKc>
    for (; i < 16; i++)
    80001630:	0014849b          	addiw	s1,s1,1
    80001634:	0ff4f493          	andi	s1,s1,255
    80001638:	00f00793          	li	a5,15
    8000163c:	fc97f4e3          	bgeu	a5,s1,80001604 <_Z15workerBodyProbav+0xa0>
    }
    Thread::dispatch();
    80001640:	00001097          	auipc	ra,0x1
    80001644:	bc0080e7          	jalr	-1088(ra) # 80002200 <_ZN6Thread8dispatchEv>
    80001648:	01813083          	ld	ra,24(sp)
    8000164c:	01013403          	ld	s0,16(sp)
    80001650:	00813483          	ld	s1,8(sp)
    80001654:	02010113          	addi	sp,sp,32
    80001658:	00008067          	ret

000000008000165c <_ZN9semaphore5blockEv>:
#include "../h/tcb.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"

void semaphore::block()
{
    8000165c:	ff010113          	addi	sp,sp,-16
    80001660:	00813423          	sd	s0,8(sp)
    80001664:	01010413          	addi	s0,sp,16

}
    80001668:	00813403          	ld	s0,8(sp)
    8000166c:	01010113          	addi	sp,sp,16
    80001670:	00008067          	ret

0000000080001674 <_ZN9semaphore7unblockEv>:

void semaphore::unblock()
{
    80001674:	ff010113          	addi	sp,sp,-16
    80001678:	00813423          	sd	s0,8(sp)
    8000167c:	01010413          	addi	s0,sp,16

}
    80001680:	00813403          	ld	s0,8(sp)
    80001684:	01010113          	addi	sp,sp,16
    80001688:	00008067          	ret

000000008000168c <_ZN9semaphore3getEPS_>:
TCB * semaphore::get(semaphore *sem)
{
    8000168c:	fe010113          	addi	sp,sp,-32
    80001690:	00113c23          	sd	ra,24(sp)
    80001694:	00813823          	sd	s0,16(sp)
    80001698:	00913423          	sd	s1,8(sp)
    8000169c:	02010413          	addi	s0,sp,32
    800016a0:	00050793          	mv	a5,a0
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    800016a4:	00853503          	ld	a0,8(a0)
    800016a8:	02050e63          	beqz	a0,800016e4 <_ZN9semaphore3getEPS_+0x58>

        Elem *elem = head;
        head = head->next;
    800016ac:	00853703          	ld	a4,8(a0)
    800016b0:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    800016b4:	02070463          	beqz	a4,800016dc <_ZN9semaphore3getEPS_+0x50>

        T *ret = elem->data;
    800016b8:	00053483          	ld	s1,0(a0)
            MemoryAllocator::_mem_free(ptr);
    800016bc:	00001097          	auipc	ra,0x1
    800016c0:	2f0080e7          	jalr	752(ra) # 800029ac <_ZN15MemoryAllocator9_mem_freeEPv>
    return sem->blocked.removeFirst();


}
    800016c4:	00048513          	mv	a0,s1
    800016c8:	01813083          	ld	ra,24(sp)
    800016cc:	01013403          	ld	s0,16(sp)
    800016d0:	00813483          	ld	s1,8(sp)
    800016d4:	02010113          	addi	sp,sp,32
    800016d8:	00008067          	ret
        if (!head) { tail = 0; }
    800016dc:	0007b823          	sd	zero,16(a5)
    800016e0:	fd9ff06f          	j	800016b8 <_ZN9semaphore3getEPS_+0x2c>
        if (!head) { return 0; }
    800016e4:	00050493          	mv	s1,a0
    return sem->blocked.removeFirst();
    800016e8:	fddff06f          	j	800016c4 <_ZN9semaphore3getEPS_+0x38>

00000000800016ec <_ZN9semaphore3putEPS_>:

void semaphore::put(semaphore *sem)
{
    800016ec:	fe010113          	addi	sp,sp,-32
    800016f0:	00113c23          	sd	ra,24(sp)
    800016f4:	00813823          	sd	s0,16(sp)
    800016f8:	00913423          	sd	s1,8(sp)
    800016fc:	01213023          	sd	s2,0(sp)
    80001700:	02010413          	addi	s0,sp,32
    80001704:	00050493          	mv	s1,a0
    sem->blocked.addLast(TCB::running);
    80001708:	0000a797          	auipc	a5,0xa
    8000170c:	f307b783          	ld	a5,-208(a5) # 8000b638 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001710:	0007b903          	ld	s2,0(a5)
            return MemoryAllocator::_mem_alloc(size);
    80001714:	01000513          	li	a0,16
    80001718:	00001097          	auipc	ra,0x1
    8000171c:	1c8080e7          	jalr	456(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001720:	01253023          	sd	s2,0(a0)
    80001724:	00053423          	sd	zero,8(a0)
        if (tail)
    80001728:	0104b783          	ld	a5,16(s1)
    8000172c:	02078263          	beqz	a5,80001750 <_ZN9semaphore3putEPS_+0x64>
            tail->next = elem;
    80001730:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001734:	00a4b823          	sd	a0,16(s1)

}
    80001738:	01813083          	ld	ra,24(sp)
    8000173c:	01013403          	ld	s0,16(sp)
    80001740:	00813483          	ld	s1,8(sp)
    80001744:	00013903          	ld	s2,0(sp)
    80001748:	02010113          	addi	sp,sp,32
    8000174c:	00008067          	ret
            head = tail = elem;
    80001750:	00a4b823          	sd	a0,16(s1)
    80001754:	00a4b423          	sd	a0,8(s1)
    80001758:	fe1ff06f          	j	80001738 <_ZN9semaphore3putEPS_+0x4c>

000000008000175c <_ZN9semaphore9_sem_openEPPS_j>:
int semaphore::_sem_open(semaphore **sem, unsigned int val)
{
    8000175c:	fe010113          	addi	sp,sp,-32
    80001760:	00113c23          	sd	ra,24(sp)
    80001764:	00813823          	sd	s0,16(sp)
    80001768:	00913423          	sd	s1,8(sp)
    8000176c:	01213023          	sd	s2,0(sp)
    80001770:	02010413          	addi	s0,sp,32
    80001774:	00050493          	mv	s1,a0
    80001778:	00058913          	mv	s2,a1
    auto  semafor  = (sem_t) MemoryAllocator::_mem_alloc(sizeof (semaphore));
    8000177c:	01800513          	li	a0,24
    80001780:	00001097          	auipc	ra,0x1
    80001784:	160080e7          	jalr	352(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
    if(!semafor) {
    80001788:	02050863          	beqz	a0,800017b8 <_ZN9semaphore9_sem_openEPPS_j+0x5c>
        return -1;
    }
    semafor->val = val;
    8000178c:	01252023          	sw	s2,0(a0)
    semafor->closed = false;
    80001790:	000502a3          	sb	zero,5(a0)
    semafor->lock = false;
    80001794:	00050223          	sb	zero,4(a0)

    *sem = semafor;
    80001798:	00a4b023          	sd	a0,0(s1)

    return 0;
    8000179c:	00000513          	li	a0,0
}
    800017a0:	01813083          	ld	ra,24(sp)
    800017a4:	01013403          	ld	s0,16(sp)
    800017a8:	00813483          	ld	s1,8(sp)
    800017ac:	00013903          	ld	s2,0(sp)
    800017b0:	02010113          	addi	sp,sp,32
    800017b4:	00008067          	ret
        return -1;
    800017b8:	fff00513          	li	a0,-1
    800017bc:	fe5ff06f          	j	800017a0 <_ZN9semaphore9_sem_openEPPS_j+0x44>

00000000800017c0 <_ZN9semaphore10_sem_closeEPS_>:

int semaphore::_sem_close(semaphore *sem)
{
    if (sem->closed) {return -1;}
    800017c0:	00554783          	lbu	a5,5(a0)
    800017c4:	08079e63          	bnez	a5,80001860 <_ZN9semaphore10_sem_closeEPS_+0xa0>
{
    800017c8:	fe010113          	addi	sp,sp,-32
    800017cc:	00113c23          	sd	ra,24(sp)
    800017d0:	00813823          	sd	s0,16(sp)
    800017d4:	00913423          	sd	s1,8(sp)
    800017d8:	01213023          	sd	s2,0(sp)
    800017dc:	02010413          	addi	s0,sp,32
    800017e0:	00050493          	mv	s1,a0

    if(!sem->lock) {
    800017e4:	00454783          	lbu	a5,4(a0)
    800017e8:	08079063          	bnez	a5,80001868 <_ZN9semaphore10_sem_closeEPS_+0xa8>
        thread_t ready;
        sem->lock = true;
    800017ec:	00100793          	li	a5,1
    800017f0:	00f50223          	sb	a5,4(a0)
    800017f4:	0240006f          	j	80001818 <_ZN9semaphore10_sem_closeEPS_+0x58>
        if (!head) { tail = 0; }
    800017f8:	0004b823          	sd	zero,16(s1)
        T *ret = elem->data;
    800017fc:	00053903          	ld	s2,0(a0)
            MemoryAllocator::_mem_free(ptr);
    80001800:	00001097          	auipc	ra,0x1
    80001804:	1ac080e7          	jalr	428(ra) # 800029ac <_ZN15MemoryAllocator9_mem_freeEPv>

    void setFinished(bool value) { finished = value; }

    bool isBlocked() const { return blocked; }

    void setBlocked(bool value) { blocked = value; }
    80001808:	02090ca3          	sb	zero,57(s2)
        while(sem->blocked.peekFirst()) {
            ready = sem->blocked.removeFirst();
            ready->setBlocked(false);
            Scheduler::put(ready);
    8000180c:	00090513          	mv	a0,s2
    80001810:	00001097          	auipc	ra,0x1
    80001814:	f44080e7          	jalr	-188(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
    80001818:	0084b503          	ld	a0,8(s1)
    8000181c:	00050e63          	beqz	a0,80001838 <_ZN9semaphore10_sem_closeEPS_+0x78>
        return head->data;
    80001820:	00053783          	ld	a5,0(a0)
        while(sem->blocked.peekFirst()) {
    80001824:	00078a63          	beqz	a5,80001838 <_ZN9semaphore10_sem_closeEPS_+0x78>
        head = head->next;
    80001828:	00853783          	ld	a5,8(a0)
    8000182c:	00f4b423          	sd	a5,8(s1)
        if (!head) { tail = 0; }
    80001830:	fc0796e3          	bnez	a5,800017fc <_ZN9semaphore10_sem_closeEPS_+0x3c>
    80001834:	fc5ff06f          	j	800017f8 <_ZN9semaphore10_sem_closeEPS_+0x38>
        }
        sem->closed =true;
    80001838:	00100793          	li	a5,1
    8000183c:	00f482a3          	sb	a5,5(s1)

        sem->lock = false;
    80001840:	00048223          	sb	zero,4(s1)
    }
    return 0;
    80001844:	00000513          	li	a0,0
}
    80001848:	01813083          	ld	ra,24(sp)
    8000184c:	01013403          	ld	s0,16(sp)
    80001850:	00813483          	ld	s1,8(sp)
    80001854:	00013903          	ld	s2,0(sp)
    80001858:	02010113          	addi	sp,sp,32
    8000185c:	00008067          	ret
    if (sem->closed) {return -1;}
    80001860:	fff00513          	li	a0,-1
}
    80001864:	00008067          	ret
    return 0;
    80001868:	00000513          	li	a0,0
    8000186c:	fddff06f          	j	80001848 <_ZN9semaphore10_sem_closeEPS_+0x88>

0000000080001870 <_ZN9semaphore9_sem_waitEPS_>:

int semaphore::_sem_wait(semaphore *sem)
{

    if (sem->closed) {return -1;}
    80001870:	00554783          	lbu	a5,5(a0)
    80001874:	0a079063          	bnez	a5,80001914 <_ZN9semaphore9_sem_waitEPS_+0xa4>
{
    80001878:	fe010113          	addi	sp,sp,-32
    8000187c:	00113c23          	sd	ra,24(sp)
    80001880:	00813823          	sd	s0,16(sp)
    80001884:	00913423          	sd	s1,8(sp)
    80001888:	01213023          	sd	s2,0(sp)
    8000188c:	02010413          	addi	s0,sp,32
    80001890:	00050493          	mv	s1,a0

    if(sem->val > 0) {
    80001894:	00052783          	lw	a5,0(a0)
    80001898:	02078463          	beqz	a5,800018c0 <_ZN9semaphore9_sem_waitEPS_+0x50>

        sem->val = sem->val - 1;
    8000189c:	fff7879b          	addiw	a5,a5,-1
    800018a0:	00f52023          	sw	a5,0(a0)
        sem->blocked.addLast(TCB::running);

        TCB::dispatch(); // kontekst sw
    }

    return 0;
    800018a4:	00000513          	li	a0,0
}
    800018a8:	01813083          	ld	ra,24(sp)
    800018ac:	01013403          	ld	s0,16(sp)
    800018b0:	00813483          	ld	s1,8(sp)
    800018b4:	00013903          	ld	s2,0(sp)
    800018b8:	02010113          	addi	sp,sp,32
    800018bc:	00008067          	ret
        TCB::running->setBlocked(true);
    800018c0:	0000a797          	auipc	a5,0xa
    800018c4:	d787b783          	ld	a5,-648(a5) # 8000b638 <_GLOBAL_OFFSET_TABLE_+0x28>
    800018c8:	0007b903          	ld	s2,0(a5)
    800018cc:	00100793          	li	a5,1
    800018d0:	02f90ca3          	sb	a5,57(s2)
            return MemoryAllocator::_mem_alloc(size);
    800018d4:	01000513          	li	a0,16
    800018d8:	00001097          	auipc	ra,0x1
    800018dc:	008080e7          	jalr	8(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800018e0:	01253023          	sd	s2,0(a0)
    800018e4:	00053423          	sd	zero,8(a0)
        if (tail)
    800018e8:	0104b783          	ld	a5,16(s1)
    800018ec:	00078e63          	beqz	a5,80001908 <_ZN9semaphore9_sem_waitEPS_+0x98>
            tail->next = elem;
    800018f0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800018f4:	00a4b823          	sd	a0,16(s1)
        TCB::dispatch(); // kontekst sw
    800018f8:	00000097          	auipc	ra,0x0
    800018fc:	328080e7          	jalr	808(ra) # 80001c20 <_ZN3TCB8dispatchEv>
    return 0;
    80001900:	00000513          	li	a0,0
    80001904:	fa5ff06f          	j	800018a8 <_ZN9semaphore9_sem_waitEPS_+0x38>
            head = tail = elem;
    80001908:	00a4b823          	sd	a0,16(s1)
    8000190c:	00a4b423          	sd	a0,8(s1)
    80001910:	fe9ff06f          	j	800018f8 <_ZN9semaphore9_sem_waitEPS_+0x88>
    if (sem->closed) {return -1;}
    80001914:	fff00513          	li	a0,-1
}
    80001918:	00008067          	ret

000000008000191c <_ZN9semaphore11_sem_signalEPS_>:

int semaphore::_sem_signal(semaphore *sem)
{

    if (sem->closed) {return -1;}
    8000191c:	00554783          	lbu	a5,5(a0)
    80001920:	06079063          	bnez	a5,80001980 <_ZN9semaphore11_sem_signalEPS_+0x64>
        if (!head) { return 0; }
    80001924:	00853783          	ld	a5,8(a0)
    80001928:	04078263          	beqz	a5,8000196c <_ZN9semaphore11_sem_signalEPS_+0x50>
        return head->data;
    8000192c:	0007b783          	ld	a5,0(a5)

    thread_t ready;
    if(sem->blocked.peekFirst()) {
    80001930:	02078e63          	beqz	a5,8000196c <_ZN9semaphore11_sem_signalEPS_+0x50>
{
    80001934:	ff010113          	addi	sp,sp,-16
    80001938:	00113423          	sd	ra,8(sp)
    8000193c:	00813023          	sd	s0,0(sp)
    80001940:	01010413          	addi	s0,sp,16
        ready = get(sem);
    80001944:	00000097          	auipc	ra,0x0
    80001948:	d48080e7          	jalr	-696(ra) # 8000168c <_ZN9semaphore3getEPS_>
    8000194c:	02050ca3          	sb	zero,57(a0)
        ready->setBlocked(false);
        Scheduler::put(ready);
    80001950:	00001097          	auipc	ra,0x1
    80001954:	e04080e7          	jalr	-508(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
    }
    else {
        sem->val +=1;
    }

    return 0;
    80001958:	00000513          	li	a0,0
}
    8000195c:	00813083          	ld	ra,8(sp)
    80001960:	00013403          	ld	s0,0(sp)
    80001964:	01010113          	addi	sp,sp,16
    80001968:	00008067          	ret
        sem->val +=1;
    8000196c:	00052783          	lw	a5,0(a0)
    80001970:	0017879b          	addiw	a5,a5,1
    80001974:	00f52023          	sw	a5,0(a0)
    return 0;
    80001978:	00000513          	li	a0,0
    8000197c:	00008067          	ret
    if (sem->closed) {return -1;}
    80001980:	fff00513          	li	a0,-1
}
    80001984:	00008067          	ret

0000000080001988 <main>:
extern void userMain();
extern void initialize();


int main()
{
    80001988:	fd010113          	addi	sp,sp,-48
    8000198c:	02113423          	sd	ra,40(sp)
    80001990:	02813023          	sd	s0,32(sp)
    80001994:	00913c23          	sd	s1,24(sp)
    80001998:	01213823          	sd	s2,16(sp)
    8000199c:	03010413          	addi	s0,sp,48
//    __asm__ volatile("csrw stvec, %0" : : "r" (&_ZN5Riscv14supervisorTrapEv));

    initialize();
    800019a0:	00000097          	auipc	ra,0x0
    800019a4:	b34080e7          	jalr	-1228(ra) # 800014d4 <_Z10initializev>
    userMain();
    800019a8:	00004097          	auipc	ra,0x4
    800019ac:	cbc080e7          	jalr	-836(ra) # 80005664 <_Z8userMainv>

    List<int> lista;
    int x = 1;
    800019b0:	00100793          	li	a5,1
    800019b4:	fcf42e23          	sw	a5,-36(s0)
            return MemoryAllocator::_mem_alloc(size);
    800019b8:	01000513          	li	a0,16
    800019bc:	00001097          	auipc	ra,0x1
    800019c0:	f24080e7          	jalr	-220(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800019c4:	fdc40793          	addi	a5,s0,-36
    800019c8:	00f53023          	sd	a5,0(a0)
    800019cc:	00053423          	sd	zero,8(a0)
        if (!head) { return 0; }
    800019d0:	00050463          	beqz	a0,800019d8 <main+0x50>
        return head->data;
    800019d4:	00078513          	mv	a0,a5
    lista.addFirst(&x);
    print_integer(*lista.peekFirst());
    800019d8:	00052503          	lw	a0,0(a0)
    800019dc:	00001097          	auipc	ra,0x1
    800019e0:	0d8080e7          	jalr	216(ra) # 80002ab4 <_Z13print_integerm>

    auto* t2 = new Thread((void(*)(void*))workerBodyProba, nullptr);
    800019e4:	02000513          	li	a0,32
    800019e8:	00000097          	auipc	ra,0x0
    800019ec:	638080e7          	jalr	1592(ra) # 80002020 <_Znwm>
    800019f0:	00050913          	mv	s2,a0
    800019f4:	00000613          	li	a2,0
    800019f8:	0000a597          	auipc	a1,0xa
    800019fc:	c305b583          	ld	a1,-976(a1) # 8000b628 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	760080e7          	jalr	1888(ra) # 80002160 <_ZN6ThreadC1EPFvPvES0_>
    auto* t0 = new Thread((void(*)(void*))workerBodyProba, nullptr);
    80001a08:	02000513          	li	a0,32
    80001a0c:	00000097          	auipc	ra,0x0
    80001a10:	614080e7          	jalr	1556(ra) # 80002020 <_Znwm>
    80001a14:	00050493          	mv	s1,a0
    80001a18:	00000613          	li	a2,0
    80001a1c:	0000a597          	auipc	a1,0xa
    80001a20:	c0c5b583          	ld	a1,-1012(a1) # 8000b628 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	73c080e7          	jalr	1852(ra) # 80002160 <_ZN6ThreadC1EPFvPvES0_>
    print_string("Thread made\n");
    80001a2c:	00007517          	auipc	a0,0x7
    80001a30:	64c50513          	addi	a0,a0,1612 # 80009078 <CONSOLE_STATUS+0x68>
    80001a34:	00001097          	auipc	ra,0x1
    80001a38:	03c080e7          	jalr	60(ra) # 80002a70 <_Z12print_stringPKc>
//    //__asm__ volatile("csrc sstatus, 0x02");
//
////    main->dispatch();

//    t3->start();
    t0->start();
    80001a3c:	00048513          	mv	a0,s1
    80001a40:	00000097          	auipc	ra,0x0
    80001a44:	7e8080e7          	jalr	2024(ra) # 80002228 <_ZN6Thread5startEv>
    t2->start();
    80001a48:	00090513          	mv	a0,s2
    80001a4c:	00000097          	auipc	ra,0x0
    80001a50:	7dc080e7          	jalr	2012(ra) # 80002228 <_ZN6Thread5startEv>
    print_string("Thread started\n");
    80001a54:	00007517          	auipc	a0,0x7
    80001a58:	63450513          	addi	a0,a0,1588 # 80009088 <CONSOLE_STATUS+0x78>
    80001a5c:	00001097          	auipc	ra,0x1
    80001a60:	014080e7          	jalr	20(ra) # 80002a70 <_Z12print_stringPKc>
    80001a64:	00c0006f          	j	80001a70 <main+0xe8>
//
//    TCB::join(t3->myHandle);
//    printString("Finished\n");

    while(!(t0->myHandle->isFinished() && t2->myHandle->isFinished())) {
        Thread::dispatch();
    80001a68:	00000097          	auipc	ra,0x0
    80001a6c:	798080e7          	jalr	1944(ra) # 80002200 <_ZN6Thread8dispatchEv>
    while(!(t0->myHandle->isFinished() && t2->myHandle->isFinished())) {
    80001a70:	0084b783          	ld	a5,8(s1)
    bool isFinished() const { return finished; }
    80001a74:	0387c783          	lbu	a5,56(a5)
    80001a78:	fe0788e3          	beqz	a5,80001a68 <main+0xe0>
    80001a7c:	00893783          	ld	a5,8(s2)
    80001a80:	0387c783          	lbu	a5,56(a5)
    80001a84:	fe0782e3          	beqz	a5,80001a68 <main+0xe0>
    }
    delete t0;
    80001a88:	00048a63          	beqz	s1,80001a9c <main+0x114>
    80001a8c:	0004b783          	ld	a5,0(s1)
    80001a90:	0087b783          	ld	a5,8(a5)
    80001a94:	00048513          	mv	a0,s1
    80001a98:	000780e7          	jalr	a5
    delete t2;
    80001a9c:	00090a63          	beqz	s2,80001ab0 <main+0x128>
    80001aa0:	00093783          	ld	a5,0(s2)
    80001aa4:	0087b783          	ld	a5,8(a5)
    80001aa8:	00090513          	mv	a0,s2
    80001aac:	000780e7          	jalr	a5
    print_string("deleted");
    80001ab0:	00007517          	auipc	a0,0x7
    80001ab4:	5e850513          	addi	a0,a0,1512 # 80009098 <CONSOLE_STATUS+0x88>
    80001ab8:	00001097          	auipc	ra,0x1
    80001abc:	fb8080e7          	jalr	-72(ra) # 80002a70 <_Z12print_stringPKc>

    return 0;
}
    80001ac0:	00000513          	li	a0,0
    80001ac4:	02813083          	ld	ra,40(sp)
    80001ac8:	02013403          	ld	s0,32(sp)
    80001acc:	01813483          	ld	s1,24(sp)
    80001ad0:	01013903          	ld	s2,16(sp)
    80001ad4:	03010113          	addi	sp,sp,48
    80001ad8:	00008067          	ret
    80001adc:	00050493          	mv	s1,a0
    auto* t2 = new Thread((void(*)(void*))workerBodyProba, nullptr);
    80001ae0:	00090513          	mv	a0,s2
    80001ae4:	00000097          	auipc	ra,0x0
    80001ae8:	564080e7          	jalr	1380(ra) # 80002048 <_ZdlPv>
    80001aec:	00048513          	mv	a0,s1
    80001af0:	0000b097          	auipc	ra,0xb
    80001af4:	ce8080e7          	jalr	-792(ra) # 8000c7d8 <_Unwind_Resume>
    80001af8:	00050913          	mv	s2,a0
    auto* t0 = new Thread((void(*)(void*))workerBodyProba, nullptr);
    80001afc:	00048513          	mv	a0,s1
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	548080e7          	jalr	1352(ra) # 80002048 <_ZdlPv>
    80001b08:	00090513          	mv	a0,s2
    80001b0c:	0000b097          	auipc	ra,0xb
    80001b10:	ccc080e7          	jalr	-820(ra) # 8000c7d8 <_Unwind_Resume>

0000000080001b14 <_ZN3TCB12createThreadEPPS_PFvPvES2_>:
TCB *TCB::running = nullptr;
int TCB::id = 1;
uint64 TCB::timeSliceCounter = 0;

int TCB::createThread(thread_t* handle, Body body, void *arg)
{   *handle = new TCB(body,arg, TIME_SLICE);
    80001b14:	fd010113          	addi	sp,sp,-48
    80001b18:	02113423          	sd	ra,40(sp)
    80001b1c:	02813023          	sd	s0,32(sp)
    80001b20:	00913c23          	sd	s1,24(sp)
    80001b24:	01213823          	sd	s2,16(sp)
    80001b28:	01313423          	sd	s3,8(sp)
    80001b2c:	01413023          	sd	s4,0(sp)
    80001b30:	03010413          	addi	s0,sp,48
    80001b34:	00050993          	mv	s3,a0
    80001b38:	00058913          	mv	s2,a1
    80001b3c:	00060a13          	mv	s4,a2
    80001b40:	05000513          	li	a0,80
    80001b44:	00000097          	auipc	ra,0x0
    80001b48:	4dc080e7          	jalr	1244(ra) # 80002020 <_Znwm>
    80001b4c:	00050493          	mv	s1,a0
    static void dispatch();

private:

    TCB(Body body,void * arg, uint64 timeSlice) :
            pid(TCB::id++),
    80001b50:	0000a717          	auipc	a4,0xa
    80001b54:	8c870713          	addi	a4,a4,-1848 # 8000b418 <_ZN3TCB2idE>
    80001b58:	00072783          	lw	a5,0(a4)
    80001b5c:	0017869b          	addiw	a3,a5,1
    80001b60:	00d72023          	sw	a3,0(a4)
            context({(uint64) &threadWrapper,
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
                    }),
            timeSlice(timeSlice),
            finished(false),
            blocked(false)
    80001b64:	00f52023          	sw	a5,0(a0)
    80001b68:	01253423          	sd	s2,8(a0)
    80001b6c:	01453823          	sd	s4,16(a0)
            stack(body != nullptr ? new uint64[STACK_SIZE] : nullptr),
    80001b70:	00090a63          	beqz	s2,80001b84 <_ZN3TCB12createThreadEPPS_PFvPvES2_+0x70>
    80001b74:	00008537          	lui	a0,0x8
    80001b78:	00000097          	auipc	ra,0x0
    80001b7c:	480080e7          	jalr	1152(ra) # 80001ff8 <_Znam>
    80001b80:	0080006f          	j	80001b88 <_ZN3TCB12createThreadEPPS_PFvPvES2_+0x74>
    80001b84:	00000513          	li	a0,0
            blocked(false)
    80001b88:	00a4bc23          	sd	a0,24(s1)
    80001b8c:	00000797          	auipc	a5,0x0
    80001b90:	29c78793          	addi	a5,a5,668 # 80001e28 <_ZN3TCB13threadWrapperEv>
    80001b94:	02f4b023          	sd	a5,32(s1)
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80001b98:	06050263          	beqz	a0,80001bfc <_ZN3TCB12createThreadEPPS_PFvPvES2_+0xe8>
    80001b9c:	000087b7          	lui	a5,0x8
    80001ba0:	00f507b3          	add	a5,a0,a5
            blocked(false)
    80001ba4:	02f4b423          	sd	a5,40(s1)
    80001ba8:	00200793          	li	a5,2
    80001bac:	02f4b823          	sd	a5,48(s1)
    80001bb0:	02048c23          	sb	zero,56(s1)
    80001bb4:	02048ca3          	sb	zero,57(s1)
    List() : head(0), tail(0) {}
    80001bb8:	0404b023          	sd	zero,64(s1)
    80001bbc:	0404b423          	sd	zero,72(s1)
    80001bc0:	0099b023          	sd	s1,0(s3)
    if (body) {Scheduler::put(*handle); }
    80001bc4:	00090863          	beqz	s2,80001bd4 <_ZN3TCB12createThreadEPPS_PFvPvES2_+0xc0>
    80001bc8:	00048513          	mv	a0,s1
    80001bcc:	00001097          	auipc	ra,0x1
    80001bd0:	b88080e7          	jalr	-1144(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
    return (*handle)->pid;
    80001bd4:	0009b783          	ld	a5,0(s3)
    80001bd8:	0007a503          	lw	a0,0(a5) # 8000 <_entry-0x7fff8000>
}
    80001bdc:	02813083          	ld	ra,40(sp)
    80001be0:	02013403          	ld	s0,32(sp)
    80001be4:	01813483          	ld	s1,24(sp)
    80001be8:	01013903          	ld	s2,16(sp)
    80001bec:	00813983          	ld	s3,8(sp)
    80001bf0:	00013a03          	ld	s4,0(sp)
    80001bf4:	03010113          	addi	sp,sp,48
    80001bf8:	00008067          	ret
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80001bfc:	00000793          	li	a5,0
    80001c00:	fa5ff06f          	j	80001ba4 <_ZN3TCB12createThreadEPPS_PFvPvES2_+0x90>
    80001c04:	00050913          	mv	s2,a0
{   *handle = new TCB(body,arg, TIME_SLICE);
    80001c08:	00048513          	mv	a0,s1
    80001c0c:	00000097          	auipc	ra,0x0
    80001c10:	43c080e7          	jalr	1084(ra) # 80002048 <_ZdlPv>
    80001c14:	00090513          	mv	a0,s2
    80001c18:	0000b097          	auipc	ra,0xb
    80001c1c:	bc0080e7          	jalr	-1088(ra) # 8000c7d8 <_Unwind_Resume>

0000000080001c20 <_ZN3TCB8dispatchEv>:

    Riscv::popRegisters();
}

void TCB::dispatch()
{
    80001c20:	fe010113          	addi	sp,sp,-32
    80001c24:	00113c23          	sd	ra,24(sp)
    80001c28:	00813823          	sd	s0,16(sp)
    80001c2c:	00913423          	sd	s1,8(sp)
    80001c30:	02010413          	addi	s0,sp,32
    TCB *old = running;
    80001c34:	0000a497          	auipc	s1,0xa
    80001c38:	a5c4b483          	ld	s1,-1444(s1) # 8000b690 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    80001c3c:	0384c783          	lbu	a5,56(s1)
    if (!old->isFinished() and !old->isBlocked()) {
    80001c40:	00079663          	bnez	a5,80001c4c <_ZN3TCB8dispatchEv+0x2c>
    bool isBlocked() const { return blocked; }
    80001c44:	0394c783          	lbu	a5,57(s1)
    80001c48:	02078c63          	beqz	a5,80001c80 <_ZN3TCB8dispatchEv+0x60>
        Scheduler::put(old);
    }
    running = Scheduler::get();
    80001c4c:	00001097          	auipc	ra,0x1
    80001c50:	aa0080e7          	jalr	-1376(ra) # 800026ec <_ZN9Scheduler3getEv>
    80001c54:	0000a797          	auipc	a5,0xa
    80001c58:	a2a7be23          	sd	a0,-1476(a5) # 8000b690 <_ZN3TCB7runningE>

    TCB::contextSwitch(&old->context, &running->context);
    80001c5c:	02050593          	addi	a1,a0,32 # 8020 <_entry-0x7fff7fe0>
    80001c60:	02048513          	addi	a0,s1,32
    80001c64:	fffff097          	auipc	ra,0xfffff
    80001c68:	4dc080e7          	jalr	1244(ra) # 80001140 <_ZN3TCB13contextSwitchEPNS_7ContextES1_>
    if (running) {

    }
}
    80001c6c:	01813083          	ld	ra,24(sp)
    80001c70:	01013403          	ld	s0,16(sp)
    80001c74:	00813483          	ld	s1,8(sp)
    80001c78:	02010113          	addi	sp,sp,32
    80001c7c:	00008067          	ret
        Scheduler::put(old);
    80001c80:	00048513          	mv	a0,s1
    80001c84:	00001097          	auipc	ra,0x1
    80001c88:	ad0080e7          	jalr	-1328(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
    80001c8c:	fc1ff06f          	j	80001c4c <_ZN3TCB8dispatchEv+0x2c>

0000000080001c90 <_ZN3TCB5yieldEv>:
{
    80001c90:	ff010113          	addi	sp,sp,-16
    80001c94:	00113423          	sd	ra,8(sp)
    80001c98:	00813023          	sd	s0,0(sp)
    80001c9c:	01010413          	addi	s0,sp,16
    Riscv::pushRegisters();
    80001ca0:	fffff097          	auipc	ra,0xfffff
    80001ca4:	4b4080e7          	jalr	1204(ra) # 80001154 <_ZN5Riscv13pushRegistersEv>
    dispatch();
    80001ca8:	00000097          	auipc	ra,0x0
    80001cac:	f78080e7          	jalr	-136(ra) # 80001c20 <_ZN3TCB8dispatchEv>
    Riscv::popRegisters();
    80001cb0:	fffff097          	auipc	ra,0xfffff
    80001cb4:	520080e7          	jalr	1312(ra) # 800011d0 <_ZN5Riscv12popRegistersEv>
}
    80001cb8:	00813083          	ld	ra,8(sp)
    80001cbc:	00013403          	ld	s0,0(sp)
    80001cc0:	01010113          	addi	sp,sp,16
    80001cc4:	00008067          	ret

0000000080001cc8 <_ZN3TCB4joinEPS_>:
    bool isFinished() const { return finished; }
    80001cc8:	03854783          	lbu	a5,56(a0)

}

void TCB::join(thread_t handle)
{
    if (!handle->isFinished()) {
    80001ccc:	00078463          	beqz	a5,80001cd4 <_ZN3TCB4joinEPS_+0xc>
    80001cd0:	00008067          	ret
{
    80001cd4:	fe010113          	addi	sp,sp,-32
    80001cd8:	00113c23          	sd	ra,24(sp)
    80001cdc:	00813823          	sd	s0,16(sp)
    80001ce0:	00913423          	sd	s1,8(sp)
    80001ce4:	01213023          	sd	s2,0(sp)
    80001ce8:	02010413          	addi	s0,sp,32
    80001cec:	00050493          	mv	s1,a0
        handle->waitToJoin.addLast(running);
    80001cf0:	0000a917          	auipc	s2,0xa
    80001cf4:	9a093903          	ld	s2,-1632(s2) # 8000b690 <_ZN3TCB7runningE>
            return MemoryAllocator::_mem_alloc(size);
    80001cf8:	01000513          	li	a0,16
    80001cfc:	00001097          	auipc	ra,0x1
    80001d00:	be4080e7          	jalr	-1052(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001d04:	01253023          	sd	s2,0(a0)
    80001d08:	00053423          	sd	zero,8(a0)
        if (tail)
    80001d0c:	0484b783          	ld	a5,72(s1)
    80001d10:	02078e63          	beqz	a5,80001d4c <_ZN3TCB4joinEPS_+0x84>
            tail->next = elem;
    80001d14:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001d18:	04a4b423          	sd	a0,72(s1)
    void setBlocked(bool value) { blocked = value; }
    80001d1c:	0000a797          	auipc	a5,0xa
    80001d20:	9747b783          	ld	a5,-1676(a5) # 8000b690 <_ZN3TCB7runningE>
    80001d24:	00100713          	li	a4,1
    80001d28:	02e78ca3          	sb	a4,57(a5)
        running->setBlocked(true);
        TCB::yield();
    80001d2c:	00000097          	auipc	ra,0x0
    80001d30:	f64080e7          	jalr	-156(ra) # 80001c90 <_ZN3TCB5yieldEv>
    }

}
    80001d34:	01813083          	ld	ra,24(sp)
    80001d38:	01013403          	ld	s0,16(sp)
    80001d3c:	00813483          	ld	s1,8(sp)
    80001d40:	00013903          	ld	s2,0(sp)
    80001d44:	02010113          	addi	sp,sp,32
    80001d48:	00008067          	ret
            head = tail = elem;
    80001d4c:	04a4b423          	sd	a0,72(s1)
    80001d50:	04a4b023          	sd	a0,64(s1)
    80001d54:	fc9ff06f          	j	80001d1c <_ZN3TCB4joinEPS_+0x54>

0000000080001d58 <_ZN3TCB7unblockEv>:

void TCB::unblock()
{
    while(running->waitToJoin.peekFirst()) {
    80001d58:	0000a797          	auipc	a5,0xa
    80001d5c:	9387b783          	ld	a5,-1736(a5) # 8000b690 <_ZN3TCB7runningE>
        if (!head) { return 0; }
    80001d60:	0407b503          	ld	a0,64(a5)
    80001d64:	08050063          	beqz	a0,80001de4 <_ZN3TCB7unblockEv+0x8c>
        return head->data;
    80001d68:	00053703          	ld	a4,0(a0)
    80001d6c:	06070c63          	beqz	a4,80001de4 <_ZN3TCB7unblockEv+0x8c>
{
    80001d70:	fe010113          	addi	sp,sp,-32
    80001d74:	00113c23          	sd	ra,24(sp)
    80001d78:	00813823          	sd	s0,16(sp)
    80001d7c:	00913423          	sd	s1,8(sp)
    80001d80:	02010413          	addi	s0,sp,32
    80001d84:	03c0006f          	j	80001dc0 <_ZN3TCB7unblockEv+0x68>
        if (!head) { tail = 0; }
    80001d88:	0407b423          	sd	zero,72(a5)
        T *ret = elem->data;
    80001d8c:	00053483          	ld	s1,0(a0)
            MemoryAllocator::_mem_free(ptr);
    80001d90:	00001097          	auipc	ra,0x1
    80001d94:	c1c080e7          	jalr	-996(ra) # 800029ac <_ZN15MemoryAllocator9_mem_freeEPv>
    80001d98:	02048ca3          	sb	zero,57(s1)
        thread_t notBlocked = running->waitToJoin.removeFirst();
        notBlocked->setBlocked(false);
        Scheduler::put(notBlocked);
    80001d9c:	00048513          	mv	a0,s1
    80001da0:	00001097          	auipc	ra,0x1
    80001da4:	9b4080e7          	jalr	-1612(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
    while(running->waitToJoin.peekFirst()) {
    80001da8:	0000a797          	auipc	a5,0xa
    80001dac:	8e87b783          	ld	a5,-1816(a5) # 8000b690 <_ZN3TCB7runningE>
        if (!head) { return 0; }
    80001db0:	0407b503          	ld	a0,64(a5)
    80001db4:	00050e63          	beqz	a0,80001dd0 <_ZN3TCB7unblockEv+0x78>
        return head->data;
    80001db8:	00053703          	ld	a4,0(a0)
    80001dbc:	00070a63          	beqz	a4,80001dd0 <_ZN3TCB7unblockEv+0x78>
        head = head->next;
    80001dc0:	00853703          	ld	a4,8(a0)
    80001dc4:	04e7b023          	sd	a4,64(a5)
        if (!head) { tail = 0; }
    80001dc8:	fc0712e3          	bnez	a4,80001d8c <_ZN3TCB7unblockEv+0x34>
    80001dcc:	fbdff06f          	j	80001d88 <_ZN3TCB7unblockEv+0x30>
    }
}
    80001dd0:	01813083          	ld	ra,24(sp)
    80001dd4:	01013403          	ld	s0,16(sp)
    80001dd8:	00813483          	ld	s1,8(sp)
    80001ddc:	02010113          	addi	sp,sp,32
    80001de0:	00008067          	ret
    80001de4:	00008067          	ret

0000000080001de8 <_ZN3TCB10exitThreadEv>:
void TCB::exitThread() {
    80001de8:	ff010113          	addi	sp,sp,-16
    80001dec:	00113423          	sd	ra,8(sp)
    80001df0:	00813023          	sd	s0,0(sp)
    80001df4:	01010413          	addi	s0,sp,16
    void setFinished(bool value) { finished = value; }
    80001df8:	0000a797          	auipc	a5,0xa
    80001dfc:	8987b783          	ld	a5,-1896(a5) # 8000b690 <_ZN3TCB7runningE>
    80001e00:	00100713          	li	a4,1
    80001e04:	02e78c23          	sb	a4,56(a5)
    unblock();
    80001e08:	00000097          	auipc	ra,0x0
    80001e0c:	f50080e7          	jalr	-176(ra) # 80001d58 <_ZN3TCB7unblockEv>
    TCB::dispatch();
    80001e10:	00000097          	auipc	ra,0x0
    80001e14:	e10080e7          	jalr	-496(ra) # 80001c20 <_ZN3TCB8dispatchEv>
}
    80001e18:	00813083          	ld	ra,8(sp)
    80001e1c:	00013403          	ld	s0,0(sp)
    80001e20:	01010113          	addi	sp,sp,16
    80001e24:	00008067          	ret

0000000080001e28 <_ZN3TCB13threadWrapperEv>:
{
    80001e28:	fe010113          	addi	sp,sp,-32
    80001e2c:	00113c23          	sd	ra,24(sp)
    80001e30:	00813823          	sd	s0,16(sp)
    80001e34:	00913423          	sd	s1,8(sp)
    80001e38:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	574080e7          	jalr	1396(ra) # 800023b0 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80001e44:	0000a497          	auipc	s1,0xa
    80001e48:	84c48493          	addi	s1,s1,-1972 # 8000b690 <_ZN3TCB7runningE>
    80001e4c:	0004b783          	ld	a5,0(s1)
    80001e50:	0087b703          	ld	a4,8(a5)
    80001e54:	0107b503          	ld	a0,16(a5)
    80001e58:	000700e7          	jalr	a4
    running->setFinished(true);
    80001e5c:	0004b783          	ld	a5,0(s1)
    80001e60:	00100713          	li	a4,1
    80001e64:	02e78c23          	sb	a4,56(a5)
       unblock();
    80001e68:	00000097          	auipc	ra,0x0
    80001e6c:	ef0080e7          	jalr	-272(ra) # 80001d58 <_ZN3TCB7unblockEv>
    Thread::dispatch();
    80001e70:	00000097          	auipc	ra,0x0
    80001e74:	390080e7          	jalr	912(ra) # 80002200 <_ZN6Thread8dispatchEv>
}
    80001e78:	01813083          	ld	ra,24(sp)
    80001e7c:	01013403          	ld	s0,16(sp)
    80001e80:	00813483          	ld	s1,8(sp)
    80001e84:	02010113          	addi	sp,sp,32
    80001e88:	00008067          	ret

0000000080001e8c <_ZN3TCB5startEPPS_>:

int TCB::start(thread_t* handle)
{
    if (handle) {
    80001e8c:	02050a63          	beqz	a0,80001ec0 <_ZN3TCB5startEPPS_+0x34>
{
    80001e90:	ff010113          	addi	sp,sp,-16
    80001e94:	00113423          	sd	ra,8(sp)
    80001e98:	00813023          	sd	s0,0(sp)
    80001e9c:	01010413          	addi	s0,sp,16
        Scheduler::put(*handle);
    80001ea0:	00053503          	ld	a0,0(a0)
    80001ea4:	00001097          	auipc	ra,0x1
    80001ea8:	8b0080e7          	jalr	-1872(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
    }
    return 0;
}
    80001eac:	00000513          	li	a0,0
    80001eb0:	00813083          	ld	ra,8(sp)
    80001eb4:	00013403          	ld	s0,0(sp)
    80001eb8:	01010113          	addi	sp,sp,16
    80001ebc:	00008067          	ret
    80001ec0:	00000513          	li	a0,0
    80001ec4:	00008067          	ret

0000000080001ec8 <_ZN3TCB20createThreadNotStartEPPS_PFvPvES2_>:

int TCB::createThreadNotStart(thread_t *handle, TCB::Body body, void *arg)
{
    80001ec8:	fd010113          	addi	sp,sp,-48
    80001ecc:	02113423          	sd	ra,40(sp)
    80001ed0:	02813023          	sd	s0,32(sp)
    80001ed4:	00913c23          	sd	s1,24(sp)
    80001ed8:	01213823          	sd	s2,16(sp)
    80001edc:	01313423          	sd	s3,8(sp)
    80001ee0:	01413023          	sd	s4,0(sp)
    80001ee4:	03010413          	addi	s0,sp,48
    80001ee8:	00050993          	mv	s3,a0
    80001eec:	00058913          	mv	s2,a1
    80001ef0:	00060a13          	mv	s4,a2
    *handle = new TCB(body,arg, TIME_SLICE);
    80001ef4:	05000513          	li	a0,80
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	128080e7          	jalr	296(ra) # 80002020 <_Znwm>
    80001f00:	00050493          	mv	s1,a0
            pid(TCB::id++),
    80001f04:	00009717          	auipc	a4,0x9
    80001f08:	51470713          	addi	a4,a4,1300 # 8000b418 <_ZN3TCB2idE>
    80001f0c:	00072783          	lw	a5,0(a4)
    80001f10:	0017869b          	addiw	a3,a5,1
    80001f14:	00d72023          	sw	a3,0(a4)
            blocked(false)
    80001f18:	00f52023          	sw	a5,0(a0)
    80001f1c:	01253423          	sd	s2,8(a0)
    80001f20:	01453823          	sd	s4,16(a0)
            stack(body != nullptr ? new uint64[STACK_SIZE] : nullptr),
    80001f24:	00090a63          	beqz	s2,80001f38 <_ZN3TCB20createThreadNotStartEPPS_PFvPvES2_+0x70>
    80001f28:	00008537          	lui	a0,0x8
    80001f2c:	00000097          	auipc	ra,0x0
    80001f30:	0cc080e7          	jalr	204(ra) # 80001ff8 <_Znam>
    80001f34:	0080006f          	j	80001f3c <_ZN3TCB20createThreadNotStartEPPS_PFvPvES2_+0x74>
    80001f38:	00000513          	li	a0,0
            blocked(false)
    80001f3c:	00a4bc23          	sd	a0,24(s1)
    80001f40:	00000797          	auipc	a5,0x0
    80001f44:	ee878793          	addi	a5,a5,-280 # 80001e28 <_ZN3TCB13threadWrapperEv>
    80001f48:	02f4b023          	sd	a5,32(s1)
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80001f4c:	04050863          	beqz	a0,80001f9c <_ZN3TCB20createThreadNotStartEPPS_PFvPvES2_+0xd4>
    80001f50:	000087b7          	lui	a5,0x8
    80001f54:	00f507b3          	add	a5,a0,a5
            blocked(false)
    80001f58:	02f4b423          	sd	a5,40(s1)
    80001f5c:	00200793          	li	a5,2
    80001f60:	02f4b823          	sd	a5,48(s1)
    80001f64:	02048c23          	sb	zero,56(s1)
    80001f68:	02048ca3          	sb	zero,57(s1)
    List() : head(0), tail(0) {}
    80001f6c:	0404b023          	sd	zero,64(s1)
    80001f70:	0404b423          	sd	zero,72(s1)
    80001f74:	0099b023          	sd	s1,0(s3)
    return (*handle)->pid;
    80001f78:	0004a503          	lw	a0,0(s1)
}
    80001f7c:	02813083          	ld	ra,40(sp)
    80001f80:	02013403          	ld	s0,32(sp)
    80001f84:	01813483          	ld	s1,24(sp)
    80001f88:	01013903          	ld	s2,16(sp)
    80001f8c:	00813983          	ld	s3,8(sp)
    80001f90:	00013a03          	ld	s4,0(sp)
    80001f94:	03010113          	addi	sp,sp,48
    80001f98:	00008067          	ret
                     stack != nullptr ? (uint64) &stack[STACK_SIZE] : 0
    80001f9c:	00000793          	li	a5,0
    80001fa0:	fb9ff06f          	j	80001f58 <_ZN3TCB20createThreadNotStartEPPS_PFvPvES2_+0x90>
    80001fa4:	00050913          	mv	s2,a0
    *handle = new TCB(body,arg, TIME_SLICE);
    80001fa8:	00048513          	mv	a0,s1
    80001fac:	00000097          	auipc	ra,0x0
    80001fb0:	09c080e7          	jalr	156(ra) # 80002048 <_ZdlPv>
    80001fb4:	00090513          	mv	a0,s2
    80001fb8:	0000b097          	auipc	ra,0xb
    80001fbc:	820080e7          	jalr	-2016(ra) # 8000c7d8 <_Unwind_Resume>

0000000080001fc0 <_ZN9SemaphoreD1Ev>:

int Semaphore::signal() {
    sem_signal(myHandle);
    return 0;
}
Semaphore::~Semaphore () {
    80001fc0:	ff010113          	addi	sp,sp,-16
    80001fc4:	00113423          	sd	ra,8(sp)
    80001fc8:	00813023          	sd	s0,0(sp)
    80001fcc:	01010413          	addi	s0,sp,16
    80001fd0:	00009797          	auipc	a5,0x9
    80001fd4:	48878793          	addi	a5,a5,1160 # 8000b458 <_ZTV9Semaphore+0x10>
    80001fd8:	00f53023          	sd	a5,0(a0) # 8000 <_entry-0x7fff8000>
    sem_close(myHandle);
    80001fdc:	00853503          	ld	a0,8(a0)
    80001fe0:	fffff097          	auipc	ra,0xfffff
    80001fe4:	41c080e7          	jalr	1052(ra) # 800013fc <_Z9sem_closeP9semaphore>
}
    80001fe8:	00813083          	ld	ra,8(sp)
    80001fec:	00013403          	ld	s0,0(sp)
    80001ff0:	01010113          	addi	sp,sp,16
    80001ff4:	00008067          	ret

0000000080001ff8 <_Znam>:
void *operator new[](size_t n) {
    80001ff8:	ff010113          	addi	sp,sp,-16
    80001ffc:	00113423          	sd	ra,8(sp)
    80002000:	00813023          	sd	s0,0(sp)
    80002004:	01010413          	addi	s0,sp,16
    return (void*) mem_alloc(n);
    80002008:	fffff097          	auipc	ra,0xfffff
    8000200c:	264080e7          	jalr	612(ra) # 8000126c <_Z9mem_allocm>
}
    80002010:	00813083          	ld	ra,8(sp)
    80002014:	00013403          	ld	s0,0(sp)
    80002018:	01010113          	addi	sp,sp,16
    8000201c:	00008067          	ret

0000000080002020 <_Znwm>:
{
    80002020:	ff010113          	addi	sp,sp,-16
    80002024:	00113423          	sd	ra,8(sp)
    80002028:	00813023          	sd	s0,0(sp)
    8000202c:	01010413          	addi	s0,sp,16
    return (void*) mem_alloc(n);
    80002030:	fffff097          	auipc	ra,0xfffff
    80002034:	23c080e7          	jalr	572(ra) # 8000126c <_Z9mem_allocm>
}
    80002038:	00813083          	ld	ra,8(sp)
    8000203c:	00013403          	ld	s0,0(sp)
    80002040:	01010113          	addi	sp,sp,16
    80002044:	00008067          	ret

0000000080002048 <_ZdlPv>:
{
    80002048:	ff010113          	addi	sp,sp,-16
    8000204c:	00113423          	sd	ra,8(sp)
    80002050:	00813023          	sd	s0,0(sp)
    80002054:	01010413          	addi	s0,sp,16
    mem_free(addr);
    80002058:	fffff097          	auipc	ra,0xfffff
    8000205c:	244080e7          	jalr	580(ra) # 8000129c <_Z8mem_freePv>
}
    80002060:	00813083          	ld	ra,8(sp)
    80002064:	00013403          	ld	s0,0(sp)
    80002068:	01010113          	addi	sp,sp,16
    8000206c:	00008067          	ret

0000000080002070 <_ZN6ThreadD1Ev>:
Thread::~Thread()
    80002070:	00009797          	auipc	a5,0x9
    80002074:	3c078793          	addi	a5,a5,960 # 8000b430 <_ZTV6Thread+0x10>
    80002078:	00f53023          	sd	a5,0(a0)
    if (this->myHandle) {
    8000207c:	00853783          	ld	a5,8(a0)
    80002080:	02078a63          	beqz	a5,800020b4 <_ZN6ThreadD1Ev+0x44>
        delete &this->myHandle;
    80002084:	00850513          	addi	a0,a0,8
    80002088:	02050663          	beqz	a0,800020b4 <_ZN6ThreadD1Ev+0x44>
Thread::~Thread()
    8000208c:	ff010113          	addi	sp,sp,-16
    80002090:	00113423          	sd	ra,8(sp)
    80002094:	00813023          	sd	s0,0(sp)
    80002098:	01010413          	addi	s0,sp,16
        delete &this->myHandle;
    8000209c:	00000097          	auipc	ra,0x0
    800020a0:	fac080e7          	jalr	-84(ra) # 80002048 <_ZdlPv>
}
    800020a4:	00813083          	ld	ra,8(sp)
    800020a8:	00013403          	ld	s0,0(sp)
    800020ac:	01010113          	addi	sp,sp,16
    800020b0:	00008067          	ret
    800020b4:	00008067          	ret

00000000800020b8 <_ZN6ThreadD0Ev>:
Thread::~Thread()
    800020b8:	fe010113          	addi	sp,sp,-32
    800020bc:	00113c23          	sd	ra,24(sp)
    800020c0:	00813823          	sd	s0,16(sp)
    800020c4:	00913423          	sd	s1,8(sp)
    800020c8:	02010413          	addi	s0,sp,32
    800020cc:	00050493          	mv	s1,a0
}
    800020d0:	00000097          	auipc	ra,0x0
    800020d4:	fa0080e7          	jalr	-96(ra) # 80002070 <_ZN6ThreadD1Ev>
    800020d8:	00048513          	mv	a0,s1
    800020dc:	00000097          	auipc	ra,0x0
    800020e0:	f6c080e7          	jalr	-148(ra) # 80002048 <_ZdlPv>
    800020e4:	01813083          	ld	ra,24(sp)
    800020e8:	01013403          	ld	s0,16(sp)
    800020ec:	00813483          	ld	s1,8(sp)
    800020f0:	02010113          	addi	sp,sp,32
    800020f4:	00008067          	ret

00000000800020f8 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore () {
    800020f8:	fe010113          	addi	sp,sp,-32
    800020fc:	00113c23          	sd	ra,24(sp)
    80002100:	00813823          	sd	s0,16(sp)
    80002104:	00913423          	sd	s1,8(sp)
    80002108:	02010413          	addi	s0,sp,32
    8000210c:	00050493          	mv	s1,a0
}
    80002110:	00000097          	auipc	ra,0x0
    80002114:	eb0080e7          	jalr	-336(ra) # 80001fc0 <_ZN9SemaphoreD1Ev>
    80002118:	00048513          	mv	a0,s1
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	f2c080e7          	jalr	-212(ra) # 80002048 <_ZdlPv>
    80002124:	01813083          	ld	ra,24(sp)
    80002128:	01013403          	ld	s0,16(sp)
    8000212c:	00813483          	ld	s1,8(sp)
    80002130:	02010113          	addi	sp,sp,32
    80002134:	00008067          	ret

0000000080002138 <_ZdaPv>:
{
    80002138:	ff010113          	addi	sp,sp,-16
    8000213c:	00113423          	sd	ra,8(sp)
    80002140:	00813023          	sd	s0,0(sp)
    80002144:	01010413          	addi	s0,sp,16
    mem_free(addr);
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	154080e7          	jalr	340(ra) # 8000129c <_Z8mem_freePv>
}
    80002150:	00813083          	ld	ra,8(sp)
    80002154:	00013403          	ld	s0,0(sp)
    80002158:	01010113          	addi	sp,sp,16
    8000215c:	00008067          	ret

0000000080002160 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg)
    80002160:	ff010113          	addi	sp,sp,-16
    80002164:	00113423          	sd	ra,8(sp)
    80002168:	00813023          	sd	s0,0(sp)
    8000216c:	01010413          	addi	s0,sp,16
    80002170:	00009797          	auipc	a5,0x9
    80002174:	2c078793          	addi	a5,a5,704 # 8000b430 <_ZTV6Thread+0x10>
    80002178:	00f53023          	sd	a5,0(a0)
    this->body = body;
    8000217c:	00b53823          	sd	a1,16(a0)
    this->arg = arg;
    80002180:	00c53c23          	sd	a2,24(a0)
    thread_create_not_start(&this->myHandle, body, arg);
    80002184:	00850513          	addi	a0,a0,8
    80002188:	fffff097          	auipc	ra,0xfffff
    8000218c:	148080e7          	jalr	328(ra) # 800012d0 <_Z23thread_create_not_startPP3TCBPFvPvES2_>
}
    80002190:	00813083          	ld	ra,8(sp)
    80002194:	00013403          	ld	s0,0(sp)
    80002198:	01010113          	addi	sp,sp,16
    8000219c:	00008067          	ret

00000000800021a0 <_ZN6ThreadC1Ev>:
Thread::Thread()
    800021a0:	ff010113          	addi	sp,sp,-16
    800021a4:	00113423          	sd	ra,8(sp)
    800021a8:	00813023          	sd	s0,0(sp)
    800021ac:	01010413          	addi	s0,sp,16
    800021b0:	00009797          	auipc	a5,0x9
    800021b4:	28078793          	addi	a5,a5,640 # 8000b430 <_ZTV6Thread+0x10>
    800021b8:	00f53023          	sd	a5,0(a0)
    thread_create_not_start(&this->myHandle, wrapper, this);
    800021bc:	00050613          	mv	a2,a0
    800021c0:	00000597          	auipc	a1,0x0
    800021c4:	1c458593          	addi	a1,a1,452 # 80002384 <_ZN6Thread7wrapperEPv>
    800021c8:	00850513          	addi	a0,a0,8
    800021cc:	fffff097          	auipc	ra,0xfffff
    800021d0:	104080e7          	jalr	260(ra) # 800012d0 <_Z23thread_create_not_startPP3TCBPFvPvES2_>
}
    800021d4:	00813083          	ld	ra,8(sp)
    800021d8:	00013403          	ld	s0,0(sp)
    800021dc:	01010113          	addi	sp,sp,16
    800021e0:	00008067          	ret

00000000800021e4 <_ZN6Thread5sleepEm>:
{
    800021e4:	ff010113          	addi	sp,sp,-16
    800021e8:	00813423          	sd	s0,8(sp)
    800021ec:	01010413          	addi	s0,sp,16
}
    800021f0:	00000513          	li	a0,0
    800021f4:	00813403          	ld	s0,8(sp)
    800021f8:	01010113          	addi	sp,sp,16
    800021fc:	00008067          	ret

0000000080002200 <_ZN6Thread8dispatchEv>:
{
    80002200:	ff010113          	addi	sp,sp,-16
    80002204:	00113423          	sd	ra,8(sp)
    80002208:	00813023          	sd	s0,0(sp)
    8000220c:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002210:	fffff097          	auipc	ra,0xfffff
    80002214:	17c080e7          	jalr	380(ra) # 8000138c <_Z15thread_dispatchv>
}
    80002218:	00813083          	ld	ra,8(sp)
    8000221c:	00013403          	ld	s0,0(sp)
    80002220:	01010113          	addi	sp,sp,16
    80002224:	00008067          	ret

0000000080002228 <_ZN6Thread5startEv>:
{
    80002228:	ff010113          	addi	sp,sp,-16
    8000222c:	00113423          	sd	ra,8(sp)
    80002230:	00813023          	sd	s0,0(sp)
    80002234:	01010413          	addi	s0,sp,16
    Scheduler::put(myHandle);
    80002238:	00853503          	ld	a0,8(a0)
    8000223c:	00000097          	auipc	ra,0x0
    80002240:	518080e7          	jalr	1304(ra) # 80002754 <_ZN9Scheduler3putEP3TCB>
}
    80002244:	00000513          	li	a0,0
    80002248:	00813083          	ld	ra,8(sp)
    8000224c:	00013403          	ld	s0,0(sp)
    80002250:	01010113          	addi	sp,sp,16
    80002254:	00008067          	ret

0000000080002258 <_ZN6Thread4joinEv>:
{
    80002258:	ff010113          	addi	sp,sp,-16
    8000225c:	00113423          	sd	ra,8(sp)
    80002260:	00813023          	sd	s0,0(sp)
    80002264:	01010413          	addi	s0,sp,16
    thread_join(myHandle);
    80002268:	00853503          	ld	a0,8(a0)
    8000226c:	fffff097          	auipc	ra,0xfffff
    80002270:	140080e7          	jalr	320(ra) # 800013ac <_Z11thread_joinP3TCB>
}
    80002274:	00813083          	ld	ra,8(sp)
    80002278:	00013403          	ld	s0,0(sp)
    8000227c:	01010113          	addi	sp,sp,16
    80002280:	00008067          	ret

0000000080002284 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore (unsigned int init) {
    80002284:	ff010113          	addi	sp,sp,-16
    80002288:	00113423          	sd	ra,8(sp)
    8000228c:	00813023          	sd	s0,0(sp)
    80002290:	01010413          	addi	s0,sp,16
    80002294:	00009797          	auipc	a5,0x9
    80002298:	1c478793          	addi	a5,a5,452 # 8000b458 <_ZTV9Semaphore+0x10>
    8000229c:	00f53023          	sd	a5,0(a0)
    sem_open(&myHandle, init);
    800022a0:	00850513          	addi	a0,a0,8
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	12c080e7          	jalr	300(ra) # 800013d0 <_Z8sem_openPP9semaphorej>
}
    800022ac:	00813083          	ld	ra,8(sp)
    800022b0:	00013403          	ld	s0,0(sp)
    800022b4:	01010113          	addi	sp,sp,16
    800022b8:	00008067          	ret

00000000800022bc <_ZN9Semaphore4waitEv>:
int Semaphore::wait () {
    800022bc:	ff010113          	addi	sp,sp,-16
    800022c0:	00113423          	sd	ra,8(sp)
    800022c4:	00813023          	sd	s0,0(sp)
    800022c8:	01010413          	addi	s0,sp,16
    sem_wait(myHandle);
    800022cc:	00853503          	ld	a0,8(a0)
    800022d0:	fffff097          	auipc	ra,0xfffff
    800022d4:	154080e7          	jalr	340(ra) # 80001424 <_Z8sem_waitP9semaphore>
}
    800022d8:	00000513          	li	a0,0
    800022dc:	00813083          	ld	ra,8(sp)
    800022e0:	00013403          	ld	s0,0(sp)
    800022e4:	01010113          	addi	sp,sp,16
    800022e8:	00008067          	ret

00000000800022ec <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    800022ec:	ff010113          	addi	sp,sp,-16
    800022f0:	00113423          	sd	ra,8(sp)
    800022f4:	00813023          	sd	s0,0(sp)
    800022f8:	01010413          	addi	s0,sp,16
    sem_signal(myHandle);
    800022fc:	00853503          	ld	a0,8(a0)
    80002300:	fffff097          	auipc	ra,0xfffff
    80002304:	150080e7          	jalr	336(ra) # 80001450 <_Z10sem_signalP9semaphore>
}
    80002308:	00000513          	li	a0,0
    8000230c:	00813083          	ld	ra,8(sp)
    80002310:	00013403          	ld	s0,0(sp)
    80002314:	01010113          	addi	sp,sp,16
    80002318:	00008067          	ret

000000008000231c <_ZN7Console4getcEv>:

char Console::getc()
{
    8000231c:	ff010113          	addi	sp,sp,-16
    80002320:	00113423          	sd	ra,8(sp)
    80002324:	00813023          	sd	s0,0(sp)
    80002328:	01010413          	addi	s0,sp,16
    return ::getc();
    8000232c:	fffff097          	auipc	ra,0xfffff
    80002330:	150080e7          	jalr	336(ra) # 8000147c <_Z4getcv>
}
    80002334:	00813083          	ld	ra,8(sp)
    80002338:	00013403          	ld	s0,0(sp)
    8000233c:	01010113          	addi	sp,sp,16
    80002340:	00008067          	ret

0000000080002344 <_ZN7Console4putcEc>:

void Console::putc(char c)
{
    80002344:	ff010113          	addi	sp,sp,-16
    80002348:	00113423          	sd	ra,8(sp)
    8000234c:	00813023          	sd	s0,0(sp)
    80002350:	01010413          	addi	s0,sp,16
    ::putc(c);
    80002354:	fffff097          	auipc	ra,0xfffff
    80002358:	15c080e7          	jalr	348(ra) # 800014b0 <_Z4putcc>
}
    8000235c:	00813083          	ld	ra,8(sp)
    80002360:	00013403          	ld	s0,0(sp)
    80002364:	01010113          	addi	sp,sp,16
    80002368:	00008067          	ret

000000008000236c <_ZN6Thread3runEv>:
     static int sleep (time_t);

    thread_t myHandle;
protected:
     Thread ();
     virtual void run () { }
    8000236c:	ff010113          	addi	sp,sp,-16
    80002370:	00813423          	sd	s0,8(sp)
    80002374:	01010413          	addi	s0,sp,16
    80002378:	00813403          	ld	s0,8(sp)
    8000237c:	01010113          	addi	sp,sp,16
    80002380:	00008067          	ret

0000000080002384 <_ZN6Thread7wrapperEPv>:
 private:
    void (*body)(void*);
     void* arg;
     static void wrapper(void* args) {
    80002384:	ff010113          	addi	sp,sp,-16
    80002388:	00113423          	sd	ra,8(sp)
    8000238c:	00813023          	sd	s0,0(sp)
    80002390:	01010413          	addi	s0,sp,16
         Thread* thread = (Thread*) args;
         thread->run();
    80002394:	00053783          	ld	a5,0(a0)
    80002398:	0107b783          	ld	a5,16(a5)
    8000239c:	000780e7          	jalr	a5
     }
    800023a0:	00813083          	ld	ra,8(sp)
    800023a4:	00013403          	ld	s0,0(sp)
    800023a8:	01010113          	addi	sp,sp,16
    800023ac:	00008067          	ret

00000000800023b0 <_ZN5Riscv10popSppSpieEv>:
#include "../lib/console.h"
#include "../h/semaphore.hpp"


void Riscv::popSppSpie()
{
    800023b0:	ff010113          	addi	sp,sp,-16
    800023b4:	00813423          	sd	s0,8(sp)
    800023b8:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sstatus(uint64 mask)
{
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800023bc:	10000793          	li	a5,256
    800023c0:	1007b073          	csrc	sstatus,a5
//    Riscv::mc_sstatus(Riscv::SSTATUS_SPP);
    mc_sstatus(SSTATUS_SPP);
    __asm__ volatile("csrw sepc, ra");
    800023c4:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    800023c8:	10200073          	sret
}
    800023cc:	00813403          	ld	s0,8(sp)
    800023d0:	01010113          	addi	sp,sp,16
    800023d4:	00008067          	ret

00000000800023d8 <_ZN5Riscv20handleSupervisorTrapEv>:

void Riscv::handleSupervisorTrap()
{
    800023d8:	fc010113          	addi	sp,sp,-64
    800023dc:	02113c23          	sd	ra,56(sp)
    800023e0:	02813823          	sd	s0,48(sp)
    800023e4:	02913423          	sd	s1,40(sp)
    800023e8:	03213023          	sd	s2,32(sp)
    800023ec:	04010413          	addi	s0,sp,64
    __asm__ volatile ("mv %0, a0" : "=r"(a0));
    800023f0:	00050793          	mv	a5,a0
    __asm__ volatile ("mv %0, a1" : "=r"(a0));
    800023f4:	00058513          	mv	a0,a1
    __asm__ volatile ("mv %0, a2" : "=r"(a0));
    800023f8:	00060593          	mv	a1,a2
    __asm__ volatile ("mv %0, a3" : "=r"(a0));
    800023fc:	00068613          	mv	a2,a3
    uint64 a00 = Riscv::r_a0();
    uint64 a01  = Riscv::r_a1();
    uint64 a02  = Riscv::r_a2();
    uint64 a03  = Riscv::r_a3();
    void* sscratchsp;
    asm volatile("csrr %0, sscratch" : "=r"(sscratchsp));
    80002400:	140024f3          	csrr	s1,sscratch
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80002404:	14202773          	csrr	a4,scause
    80002408:	fce43823          	sd	a4,-48(s0)
    return scause;
    8000240c:	fd043703          	ld	a4,-48(s0)


    uint64 scause = r_scause();
    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    80002410:	ff870813          	addi	a6,a4,-8
    80002414:	00100693          	li	a3,1
    80002418:	0306f863          	bgeu	a3,a6,80002448 <_ZN5Riscv20handleSupervisorTrapEv+0x70>



        w_sepc(sepc);
    }
    else if (scause == 0x8000000000000001UL)
    8000241c:	fff00793          	li	a5,-1
    80002420:	03f79793          	slli	a5,a5,0x3f
    80002424:	00178793          	addi	a5,a5,1
    80002428:	26f70263          	beq	a4,a5,8000268c <_ZN5Riscv20handleSupervisorTrapEv+0x2b4>
//            TCB::dispatch();
//            w_sstatus(sstatus);
//            w_sepc(sepc);
//        }
    }
    else if (scause == 0x8000000000000009UL)
    8000242c:	fff00793          	li	a5,-1
    80002430:	03f79793          	slli	a5,a5,0x3f
    80002434:	00978793          	addi	a5,a5,9
    80002438:	0cf71e63          	bne	a4,a5,80002514 <_ZN5Riscv20handleSupervisorTrapEv+0x13c>
    {
        //prekid spolja, od konzole na primer
        console_handler();
    8000243c:	00006097          	auipc	ra,0x6
    80002440:	ed4080e7          	jalr	-300(ra) # 80008310 <console_handler>
    80002444:	0d00006f          	j	80002514 <_ZN5Riscv20handleSupervisorTrapEv+0x13c>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002448:	14102773          	csrr	a4,sepc
    8000244c:	fce43c23          	sd	a4,-40(s0)
    return sepc;
    80002450:	fd843703          	ld	a4,-40(s0)
        uint64 volatile sepc = r_sepc() + 4;
    80002454:	00470713          	addi	a4,a4,4
    80002458:	fce43423          	sd	a4,-56(s0)
        if(a00 == 0x01) {
    8000245c:	00100713          	li	a4,1
    80002460:	08e78a63          	beq	a5,a4,800024f4 <_ZN5Riscv20handleSupervisorTrapEv+0x11c>
        else if (a00 == 0x02) {
    80002464:	00200713          	li	a4,2
    80002468:	0ce78263          	beq	a5,a4,8000252c <_ZN5Riscv20handleSupervisorTrapEv+0x154>
        else if(a00 == 0x07) {
    8000246c:	00700713          	li	a4,7
    80002470:	0ce78c63          	beq	a5,a4,80002548 <_ZN5Riscv20handleSupervisorTrapEv+0x170>
        else if(a00 == 0x08) {
    80002474:	00800713          	li	a4,8
    80002478:	0ee78663          	beq	a5,a4,80002564 <_ZN5Riscv20handleSupervisorTrapEv+0x18c>
        else if(a00 == 0x11) {
    8000247c:	01100713          	li	a4,17
    80002480:	10e78063          	beq	a5,a4,80002580 <_ZN5Riscv20handleSupervisorTrapEv+0x1a8>
        else if(a00 ==  0x12) {
    80002484:	01200713          	li	a4,18
    80002488:	10e78a63          	beq	a5,a4,8000259c <_ZN5Riscv20handleSupervisorTrapEv+0x1c4>
        else if (a00 == 0x13) {
    8000248c:	01300713          	li	a4,19
    80002490:	12e78063          	beq	a5,a4,800025b0 <_ZN5Riscv20handleSupervisorTrapEv+0x1d8>
        else if(a00 ==  0x14) {
    80002494:	01400713          	li	a4,20
    80002498:	12e78c63          	beq	a5,a4,800025d0 <_ZN5Riscv20handleSupervisorTrapEv+0x1f8>
        else if(a00 ==  0x15) {
    8000249c:	01500713          	li	a4,21
    800024a0:	14e78263          	beq	a5,a4,800025e4 <_ZN5Riscv20handleSupervisorTrapEv+0x20c>
        else if(a00 ==  0x21) {
    800024a4:	02100713          	li	a4,33
    800024a8:	14e78863          	beq	a5,a4,800025f8 <_ZN5Riscv20handleSupervisorTrapEv+0x220>
        else if(a00 ==  0x22) {
    800024ac:	02200713          	li	a4,34
    800024b0:	16e78663          	beq	a5,a4,8000261c <_ZN5Riscv20handleSupervisorTrapEv+0x244>
        else if(a00 ==  0x23) {
    800024b4:	02300713          	li	a4,35
    800024b8:	16e78c63          	beq	a5,a4,80002630 <_ZN5Riscv20handleSupervisorTrapEv+0x258>
        else if(a00 ==  0x24) {
    800024bc:	02400713          	li	a4,36
    800024c0:	18e78263          	beq	a5,a4,80002644 <_ZN5Riscv20handleSupervisorTrapEv+0x26c>
        else if(a00 ==  0x41) {
    800024c4:	04100713          	li	a4,65
    800024c8:	18e78863          	beq	a5,a4,80002658 <_ZN5Riscv20handleSupervisorTrapEv+0x280>
        else if(a00 ==  0x42 ){
    800024cc:	04200713          	li	a4,66
    800024d0:	1ae78263          	beq	a5,a4,80002674 <_ZN5Riscv20handleSupervisorTrapEv+0x29c>
        else if(a00 ==  0x99) {
    800024d4:	09900713          	li	a4,153
    800024d8:	02e79a63          	bne	a5,a4,8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    800024dc:	100027f3          	csrr	a5,sstatus
    __asm__ volatile ("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800024e0:	10000793          	li	a5,256
    800024e4:	1007b073          	csrc	sstatus,a5
            w_sepc(sepc);
    800024e8:	fc843783          	ld	a5,-56(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800024ec:	14179073          	csrw	sepc,a5
            return;
    800024f0:	0240006f          	j	80002514 <_ZN5Riscv20handleSupervisorTrapEv+0x13c>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    800024f4:	10002973          	csrr	s2,sstatus
            void *ret=MemoryAllocator::_mem_alloc(a01);
    800024f8:	00000097          	auipc	ra,0x0
    800024fc:	3e8080e7          	jalr	1000(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002500:	10091073          	csrw	sstatus,s2
            __asm__ volatile("mv a0, %0" : : "r" (ret));
    80002504:	00050513          	mv	a0,a0
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));
    80002508:	04a4b823          	sd	a0,80(s1)
        w_sepc(sepc);
    8000250c:	fc843783          	ld	a5,-56(s0)
    80002510:	14179073          	csrw	sepc,a5
        // unexpected trap cause
//        print_integer(scause);
//        print_string("null");
//        print_integer(r_stval());
    }
    80002514:	03813083          	ld	ra,56(sp)
    80002518:	03013403          	ld	s0,48(sp)
    8000251c:	02813483          	ld	s1,40(sp)
    80002520:	02013903          	ld	s2,32(sp)
    80002524:	04010113          	addi	sp,sp,64
    80002528:	00008067          	ret
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    8000252c:	10002973          	csrr	s2,sstatus
            int ret=MemoryAllocator::_mem_free((void*)a01);
    80002530:	00000097          	auipc	ra,0x0
    80002534:	47c080e7          	jalr	1148(ra) # 800029ac <_ZN15MemoryAllocator9_mem_freeEPv>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002538:	10091073          	csrw	sstatus,s2
            __asm__ volatile("mv a0, %0" : : "r" (ret));
    8000253c:	00050513          	mv	a0,a0
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));
    80002540:	04a4b823          	sd	a0,80(s1)
    80002544:	fc9ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002548:	10002973          	csrr	s2,sstatus
            int ret=TCB::createThreadNotStart( (thread_t *)a01,(void (*)(void*))a02, (void*)a03);
    8000254c:	00000097          	auipc	ra,0x0
    80002550:	97c080e7          	jalr	-1668(ra) # 80001ec8 <_ZN3TCB20createThreadNotStartEPPS_PFvPvES2_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002554:	10091073          	csrw	sstatus,s2
            __asm__ volatile("mv a0, %0" : : "r" (ret));
    80002558:	00050513          	mv	a0,a0
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));
    8000255c:	04a4b823          	sd	a0,80(s1)
    80002560:	fadff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002564:	10002973          	csrr	s2,sstatus
            int ret=TCB::start(reinterpret_cast<thread_t *>(a01));
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	924080e7          	jalr	-1756(ra) # 80001e8c <_ZN3TCB5startEPPS_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002570:	10091073          	csrw	sstatus,s2
            __asm__ volatile("mv a0, %0" : : "r" (ret));
    80002574:	00050513          	mv	a0,a0
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));
    80002578:	04a4b823          	sd	a0,80(s1)
    8000257c:	f91ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002580:	10002973          	csrr	s2,sstatus
            int ret=TCB::createThread( (thread_t *)a01,(void (*)(void*))a02, (void*)a03);
    80002584:	fffff097          	auipc	ra,0xfffff
    80002588:	590080e7          	jalr	1424(ra) # 80001b14 <_ZN3TCB12createThreadEPPS_PFvPvES2_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    8000258c:	10091073          	csrw	sstatus,s2
            __asm__ volatile("mv a0, %0" : : "r" (ret));
    80002590:	00050513          	mv	a0,a0
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));
    80002594:	04a4b823          	sd	a0,80(s1)
    80002598:	f75ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    8000259c:	100024f3          	csrr	s1,sstatus
            TCB::exitThread();
    800025a0:	00000097          	auipc	ra,0x0
    800025a4:	848080e7          	jalr	-1976(ra) # 80001de8 <_ZN3TCB10exitThreadEv>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    800025a8:	10049073          	csrw	sstatus,s1
    800025ac:	f61ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    800025b0:	10002973          	csrr	s2,sstatus
            asm volatile("csrr %0, sepc" : "=r"(tmpsepc));
    800025b4:	141024f3          	csrr	s1,sepc
            TCB::dispatch();
    800025b8:	fffff097          	auipc	ra,0xfffff
    800025bc:	668080e7          	jalr	1640(ra) # 80001c20 <_ZN3TCB8dispatchEv>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    800025c0:	10091073          	csrw	sstatus,s2
            sepc=tmpsepc+4;
    800025c4:	00448493          	addi	s1,s1,4
    800025c8:	fc943423          	sd	s1,-56(s0)
    800025cc:	f41ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    800025d0:	100024f3          	csrr	s1,sstatus
            TCB::join((thread_t)a01);
    800025d4:	fffff097          	auipc	ra,0xfffff
    800025d8:	6f4080e7          	jalr	1780(ra) # 80001cc8 <_ZN3TCB4joinEPS_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    800025dc:	10049073          	csrw	sstatus,s1
    800025e0:	f2dff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    800025e4:	100024f3          	csrr	s1,sstatus
            TCB::yield();
    800025e8:	fffff097          	auipc	ra,0xfffff
    800025ec:	6a8080e7          	jalr	1704(ra) # 80001c90 <_ZN3TCB5yieldEv>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    800025f0:	10049073          	csrw	sstatus,s1
    800025f4:	f19ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    800025f8:	10002973          	csrr	s2,sstatus
            asm volatile("csrr %0, sepc" : "=r"(tmpsepc));
    800025fc:	141024f3          	csrr	s1,sepc
            semaphore::_sem_open((sem_t*)a01,(unsigned int)a02);
    80002600:	0005859b          	sext.w	a1,a1
    80002604:	fffff097          	auipc	ra,0xfffff
    80002608:	158080e7          	jalr	344(ra) # 8000175c <_ZN9semaphore9_sem_openEPPS_j>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    8000260c:	10091073          	csrw	sstatus,s2
            sepc=tmpsepc+4;
    80002610:	00448493          	addi	s1,s1,4
    80002614:	fc943423          	sd	s1,-56(s0)
    80002618:	ef5ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    8000261c:	100024f3          	csrr	s1,sstatus
            semaphore::_sem_close((sem_t)a01);
    80002620:	fffff097          	auipc	ra,0xfffff
    80002624:	1a0080e7          	jalr	416(ra) # 800017c0 <_ZN9semaphore10_sem_closeEPS_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002628:	10049073          	csrw	sstatus,s1
    8000262c:	ee1ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002630:	100024f3          	csrr	s1,sstatus
            semaphore::_sem_wait((sem_t)a01);
    80002634:	fffff097          	auipc	ra,0xfffff
    80002638:	23c080e7          	jalr	572(ra) # 80001870 <_ZN9semaphore9_sem_waitEPS_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    8000263c:	10049073          	csrw	sstatus,s1
    80002640:	ecdff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002644:	100024f3          	csrr	s1,sstatus
            semaphore::_sem_signal((sem_t)a01);
    80002648:	fffff097          	auipc	ra,0xfffff
    8000264c:	2d4080e7          	jalr	724(ra) # 8000191c <_ZN9semaphore11_sem_signalEPS_>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002650:	10049073          	csrw	sstatus,s1
    80002654:	eb9ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002658:	10002973          	csrr	s2,sstatus
            char ret=__getc();
    8000265c:	00006097          	auipc	ra,0x6
    80002660:	c7c080e7          	jalr	-900(ra) # 800082d8 <__getc>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002664:	10091073          	csrw	sstatus,s2
            __asm__ volatile("mv a0, %0" : : "r" (ret));
    80002668:	00050513          	mv	a0,a0
            __asm__ volatile("sd a0,0x50(%0)" : : "r"(sscratchsp));
    8000266c:	04a4b823          	sd	a0,80(s1)
    80002670:	e9dff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
            asm volatile("csrr  %0, sstatus" : "=r"(sstatus));
    80002674:	100024f3          	csrr	s1,sstatus
            __putc((char)a01);
    80002678:	0ff57513          	andi	a0,a0,255
    8000267c:	00006097          	auipc	ra,0x6
    80002680:	c20080e7          	jalr	-992(ra) # 8000829c <__putc>
            asm volatile("csrw sstatus, %0" : : "r"(sstatus));
    80002684:	10049073          	csrw	sstatus,s1
    80002688:	e85ff06f          	j	8000250c <_ZN5Riscv20handleSupervisorTrapEv+0x134>
        __asm__ volatile("csrc sip, 0x02");
    8000268c:	14417073          	csrci	sip,2
    80002690:	e85ff06f          	j	80002514 <_ZN5Riscv20handleSupervisorTrapEv+0x13c>

0000000080002694 <_Z41__static_initialization_and_destruction_0ii>:
    if (scheduler == nullptr) {
        scheduler  = new Scheduler();

    }
    return scheduler;
    80002694:	ff010113          	addi	sp,sp,-16
    80002698:	00813423          	sd	s0,8(sp)
    8000269c:	01010413          	addi	s0,sp,16
    800026a0:	00100793          	li	a5,1
    800026a4:	00f50863          	beq	a0,a5,800026b4 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800026a8:	00813403          	ld	s0,8(sp)
    800026ac:	01010113          	addi	sp,sp,16
    800026b0:	00008067          	ret
    800026b4:	000107b7          	lui	a5,0x10
    800026b8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800026bc:	fef596e3          	bne	a1,a5,800026a8 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    800026c0:	00009797          	auipc	a5,0x9
    800026c4:	fe078793          	addi	a5,a5,-32 # 8000b6a0 <_ZN9Scheduler12readyThreadsE>
    800026c8:	0007b023          	sd	zero,0(a5)
    800026cc:	0007b423          	sd	zero,8(a5)
    800026d0:	fd9ff06f          	j	800026a8 <_Z41__static_initialization_and_destruction_0ii+0x14>

00000000800026d4 <_ZN9SchedulerC1Ev>:
Scheduler::Scheduler() {
    800026d4:	ff010113          	addi	sp,sp,-16
    800026d8:	00813423          	sd	s0,8(sp)
    800026dc:	01010413          	addi	s0,sp,16
};
    800026e0:	00813403          	ld	s0,8(sp)
    800026e4:	01010113          	addi	sp,sp,16
    800026e8:	00008067          	ret

00000000800026ec <_ZN9Scheduler3getEv>:
{
    800026ec:	fe010113          	addi	sp,sp,-32
    800026f0:	00113c23          	sd	ra,24(sp)
    800026f4:	00813823          	sd	s0,16(sp)
    800026f8:	00913423          	sd	s1,8(sp)
    800026fc:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80002700:	00009517          	auipc	a0,0x9
    80002704:	fa053503          	ld	a0,-96(a0) # 8000b6a0 <_ZN9Scheduler12readyThreadsE>
    80002708:	04050263          	beqz	a0,8000274c <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    8000270c:	00853783          	ld	a5,8(a0)
    80002710:	00009717          	auipc	a4,0x9
    80002714:	f8f73823          	sd	a5,-112(a4) # 8000b6a0 <_ZN9Scheduler12readyThreadsE>
        if (!head) { tail = 0; }
    80002718:	02078463          	beqz	a5,80002740 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    8000271c:	00053483          	ld	s1,0(a0)
            MemoryAllocator::_mem_free(ptr);
    80002720:	00000097          	auipc	ra,0x0
    80002724:	28c080e7          	jalr	652(ra) # 800029ac <_ZN15MemoryAllocator9_mem_freeEPv>
}
    80002728:	00048513          	mv	a0,s1
    8000272c:	01813083          	ld	ra,24(sp)
    80002730:	01013403          	ld	s0,16(sp)
    80002734:	00813483          	ld	s1,8(sp)
    80002738:	02010113          	addi	sp,sp,32
    8000273c:	00008067          	ret
        if (!head) { tail = 0; }
    80002740:	00009797          	auipc	a5,0x9
    80002744:	f607b423          	sd	zero,-152(a5) # 8000b6a8 <_ZN9Scheduler12readyThreadsE+0x8>
    80002748:	fd5ff06f          	j	8000271c <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    8000274c:	00050493          	mv	s1,a0
    return readyThreads.removeFirst();
    80002750:	fd9ff06f          	j	80002728 <_ZN9Scheduler3getEv+0x3c>

0000000080002754 <_ZN9Scheduler3putEP3TCB>:
{
    80002754:	fe010113          	addi	sp,sp,-32
    80002758:	00113c23          	sd	ra,24(sp)
    8000275c:	00813823          	sd	s0,16(sp)
    80002760:	00913423          	sd	s1,8(sp)
    80002764:	02010413          	addi	s0,sp,32
    80002768:	00050493          	mv	s1,a0
            return MemoryAllocator::_mem_alloc(size);
    8000276c:	01000513          	li	a0,16
    80002770:	00000097          	auipc	ra,0x0
    80002774:	170080e7          	jalr	368(ra) # 800028e0 <_ZN15MemoryAllocator10_mem_allocEm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80002778:	00953023          	sd	s1,0(a0)
    8000277c:	00053423          	sd	zero,8(a0)
        if (tail)
    80002780:	00009797          	auipc	a5,0x9
    80002784:	f287b783          	ld	a5,-216(a5) # 8000b6a8 <_ZN9Scheduler12readyThreadsE+0x8>
    80002788:	02078263          	beqz	a5,800027ac <_ZN9Scheduler3putEP3TCB+0x58>
            tail->next = elem;
    8000278c:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80002790:	00009797          	auipc	a5,0x9
    80002794:	f0a7bc23          	sd	a0,-232(a5) # 8000b6a8 <_ZN9Scheduler12readyThreadsE+0x8>
}
    80002798:	01813083          	ld	ra,24(sp)
    8000279c:	01013403          	ld	s0,16(sp)
    800027a0:	00813483          	ld	s1,8(sp)
    800027a4:	02010113          	addi	sp,sp,32
    800027a8:	00008067          	ret
            head = tail = elem;
    800027ac:	00009797          	auipc	a5,0x9
    800027b0:	ef478793          	addi	a5,a5,-268 # 8000b6a0 <_ZN9Scheduler12readyThreadsE>
    800027b4:	00a7b423          	sd	a0,8(a5)
    800027b8:	00a7b023          	sd	a0,0(a5)
    800027bc:	fddff06f          	j	80002798 <_ZN9Scheduler3putEP3TCB+0x44>

00000000800027c0 <_ZN9Scheduler4initEv>:
    if (scheduler == nullptr) {
    800027c0:	00009797          	auipc	a5,0x9
    800027c4:	ef07b783          	ld	a5,-272(a5) # 8000b6b0 <_ZN9Scheduler9schedulerE>
    800027c8:	00078463          	beqz	a5,800027d0 <_ZN9Scheduler4initEv+0x10>
    800027cc:	00008067          	ret
void Scheduler::init() {
    800027d0:	ff010113          	addi	sp,sp,-16
    800027d4:	00113423          	sd	ra,8(sp)
    800027d8:	00813023          	sd	s0,0(sp)
    800027dc:	01010413          	addi	s0,sp,16
        scheduler  = new Scheduler();
    800027e0:	00100513          	li	a0,1
    800027e4:	00000097          	auipc	ra,0x0
    800027e8:	83c080e7          	jalr	-1988(ra) # 80002020 <_Znwm>
    800027ec:	00009797          	auipc	a5,0x9
    800027f0:	eca7b223          	sd	a0,-316(a5) # 8000b6b0 <_ZN9Scheduler9schedulerE>
}
    800027f4:	00813083          	ld	ra,8(sp)
    800027f8:	00013403          	ld	s0,0(sp)
    800027fc:	01010113          	addi	sp,sp,16
    80002800:	00008067          	ret

0000000080002804 <_ZN9Scheduler11getInstanceEv>:
    if (scheduler == nullptr) {
    80002804:	00009797          	auipc	a5,0x9
    80002808:	eac7b783          	ld	a5,-340(a5) # 8000b6b0 <_ZN9Scheduler9schedulerE>
    8000280c:	00078863          	beqz	a5,8000281c <_ZN9Scheduler11getInstanceEv+0x18>
    80002810:	00009517          	auipc	a0,0x9
    80002814:	ea053503          	ld	a0,-352(a0) # 8000b6b0 <_ZN9Scheduler9schedulerE>
    80002818:	00008067          	ret
{
    8000281c:	ff010113          	addi	sp,sp,-16
    80002820:	00113423          	sd	ra,8(sp)
    80002824:	00813023          	sd	s0,0(sp)
    80002828:	01010413          	addi	s0,sp,16
        scheduler  = new Scheduler();
    8000282c:	00100513          	li	a0,1
    80002830:	fffff097          	auipc	ra,0xfffff
    80002834:	7f0080e7          	jalr	2032(ra) # 80002020 <_Znwm>
    80002838:	00009797          	auipc	a5,0x9
    8000283c:	e6a7bc23          	sd	a0,-392(a5) # 8000b6b0 <_ZN9Scheduler9schedulerE>
    80002840:	00009517          	auipc	a0,0x9
    80002844:	e7053503          	ld	a0,-400(a0) # 8000b6b0 <_ZN9Scheduler9schedulerE>
    80002848:	00813083          	ld	ra,8(sp)
    8000284c:	00013403          	ld	s0,0(sp)
    80002850:	01010113          	addi	sp,sp,16
    80002854:	00008067          	ret

0000000080002858 <_GLOBAL__sub_I__ZN9Scheduler12readyThreadsE>:
    80002858:	ff010113          	addi	sp,sp,-16
    8000285c:	00113423          	sd	ra,8(sp)
    80002860:	00813023          	sd	s0,0(sp)
    80002864:	01010413          	addi	s0,sp,16
    80002868:	000105b7          	lui	a1,0x10
    8000286c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002870:	00100513          	li	a0,1
    80002874:	00000097          	auipc	ra,0x0
    80002878:	e20080e7          	jalr	-480(ra) # 80002694 <_Z41__static_initialization_and_destruction_0ii>
    8000287c:	00813083          	ld	ra,8(sp)
    80002880:	00013403          	ld	s0,0(sp)
    80002884:	01010113          	addi	sp,sp,16
    80002888:	00008067          	ret

000000008000288c <_ZN15MemoryAllocator10initMemoryEv>:

#include "../lib/hw.h"
#include "../h/print.hpp"


void MemoryAllocator::initMemory() {
    8000288c:	ff010113          	addi	sp,sp,-16
    80002890:	00813423          	sd	s0,8(sp)
    80002894:	01010413          	addi	s0,sp,16

    mem_seg* head = (mem_seg*) ((void*) HEAP_START_ADDR);
    80002898:	00009797          	auipc	a5,0x9
    8000289c:	d807b783          	ld	a5,-640(a5) # 8000b618 <_GLOBAL_OFFSET_TABLE_+0x8>
    800028a0:	0007b703          	ld	a4,0(a5)
    head->next = nullptr;
    800028a4:	00073023          	sd	zero,0(a4)
    head->prev = nullptr;
    800028a8:	00073423          	sd	zero,8(a4)
    head->addr = *((uint64*)&HEAP_START_ADDR)  + sizeof(mem_seg);
    800028ac:	0007b683          	ld	a3,0(a5)
    800028b0:	02068793          	addi	a5,a3,32
    800028b4:	00f73823          	sd	a5,16(a4)
    head->mem_block_num = (*((uint64*)&HEAP_END_ADDR) - *((uint64*)&HEAP_START_ADDR) - sizeof(mem_seg) -1) / MEM_BLOCK_SIZE;
    800028b8:	00009797          	auipc	a5,0x9
    800028bc:	d887b783          	ld	a5,-632(a5) # 8000b640 <_GLOBAL_OFFSET_TABLE_+0x30>
    800028c0:	0007b783          	ld	a5,0(a5)
    800028c4:	40d787b3          	sub	a5,a5,a3
    800028c8:	fdf78793          	addi	a5,a5,-33
    800028cc:	0067d793          	srli	a5,a5,0x6
    800028d0:	00f73c23          	sd	a5,24(a4)
}
    800028d4:	00813403          	ld	s0,8(sp)
    800028d8:	01010113          	addi	sp,sp,16
    800028dc:	00008067          	ret

00000000800028e0 <_ZN15MemoryAllocator10_mem_allocEm>:

void* MemoryAllocator::_mem_alloc(size_t size) {
    800028e0:	fe010113          	addi	sp,sp,-32
    800028e4:	00113c23          	sd	ra,24(sp)
    800028e8:	00813823          	sd	s0,16(sp)
    800028ec:	00913423          	sd	s1,8(sp)
    800028f0:	02010413          	addi	s0,sp,32
    uint64 num_block = ((uint64)size + sizeof(uint64)) / MEM_BLOCK_SIZE;
    800028f4:	00850513          	addi	a0,a0,8
    800028f8:	00655713          	srli	a4,a0,0x6
    if (((uint64)size + sizeof(uint64)) % MEM_BLOCK_SIZE != 0) {
    800028fc:	03f57513          	andi	a0,a0,63
    80002900:	00050463          	beqz	a0,80002908 <_ZN15MemoryAllocator10_mem_allocEm+0x28>
        num_block = num_block + 1;
    80002904:	00170713          	addi	a4,a4,1
    }
    mem_seg* head = (mem_seg*) ((void*) HEAP_START_ADDR);
    80002908:	00009797          	auipc	a5,0x9
    8000290c:	d107b783          	ld	a5,-752(a5) # 8000b618 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002910:	0007b783          	ld	a5,0(a5)
    mem_seg* temp = (mem_seg*) ((void*) HEAP_START_ADDR);
    temp = (mem_seg*) temp->next;
    80002914:	0007b483          	ld	s1,0(a5)


    if (head->mem_block_num >= num_block ) {
    80002918:	0187b683          	ld	a3,24(a5)
    8000291c:	00e6fc63          	bgeu	a3,a4,80002934 <_ZN15MemoryAllocator10_mem_allocEm+0x54>
        return (void*) (adr+1);

    }
        //proveri ispravnost nakon radjenja free
    else {
        while (temp) {
    80002920:	06048c63          	beqz	s1,80002998 <_ZN15MemoryAllocator10_mem_allocEm+0xb8>
            if (temp->mem_block_num >= num_block ) {
    80002924:	0184b783          	ld	a5,24(s1)
    80002928:	04e7f463          	bgeu	a5,a4,80002970 <_ZN15MemoryAllocator10_mem_allocEm+0x90>
                *adr = num_block;
                temp->addr = temp->addr + num_block * MEM_BLOCK_SIZE;
                return (void*) (adr+ 1);
            }
            else {
                temp = temp->next;
    8000292c:	0004b483          	ld	s1,0(s1)
        while (temp) {
    80002930:	ff1ff06f          	j	80002920 <_ZN15MemoryAllocator10_mem_allocEm+0x40>
        uint64 *adr = (uint64*) head->addr;
    80002934:	0107b483          	ld	s1,16(a5)
        head->mem_block_num = head->mem_block_num - num_block;
    80002938:	40e686b3          	sub	a3,a3,a4
    8000293c:	00d7bc23          	sd	a3,24(a5)
        *adr = num_block;
    80002940:	00e4b023          	sd	a4,0(s1)
        head->addr = head->addr + num_block * MEM_BLOCK_SIZE;
    80002944:	0107b683          	ld	a3,16(a5)
    80002948:	00671713          	slli	a4,a4,0x6
    8000294c:	00e68733          	add	a4,a3,a4
    80002950:	00e7b823          	sd	a4,16(a5)
        return (void*) (adr+1);
    80002954:	00848493          	addi	s1,s1,8
        }
        print_string("Nema mesta za alokaciju");
    }
    return (void*) 0;

}
    80002958:	00048513          	mv	a0,s1
    8000295c:	01813083          	ld	ra,24(sp)
    80002960:	01013403          	ld	s0,16(sp)
    80002964:	00813483          	ld	s1,8(sp)
    80002968:	02010113          	addi	sp,sp,32
    8000296c:	00008067          	ret
                uint64 *adr = (uint64*) temp->addr;
    80002970:	0104b683          	ld	a3,16(s1)
                temp->mem_block_num = temp->mem_block_num - num_block;
    80002974:	40e787b3          	sub	a5,a5,a4
    80002978:	00f4bc23          	sd	a5,24(s1)
                *adr = num_block;
    8000297c:	00e6b023          	sd	a4,0(a3)
                temp->addr = temp->addr + num_block * MEM_BLOCK_SIZE;
    80002980:	0104b783          	ld	a5,16(s1)
    80002984:	00671713          	slli	a4,a4,0x6
    80002988:	00e78733          	add	a4,a5,a4
    8000298c:	00e4b823          	sd	a4,16(s1)
                return (void*) (adr+ 1);
    80002990:	00868493          	addi	s1,a3,8
    80002994:	fc5ff06f          	j	80002958 <_ZN15MemoryAllocator10_mem_allocEm+0x78>
        print_string("Nema mesta za alokaciju");
    80002998:	00006517          	auipc	a0,0x6
    8000299c:	70850513          	addi	a0,a0,1800 # 800090a0 <CONSOLE_STATUS+0x90>
    800029a0:	00000097          	auipc	ra,0x0
    800029a4:	0d0080e7          	jalr	208(ra) # 80002a70 <_Z12print_stringPKc>
    return (void*) 0;
    800029a8:	fb1ff06f          	j	80002958 <_ZN15MemoryAllocator10_mem_allocEm+0x78>

00000000800029ac <_ZN15MemoryAllocator9_mem_freeEPv>:

int MemoryAllocator::_mem_free(void* addr) {
    800029ac:	ff010113          	addi	sp,sp,-16
    800029b0:	00813423          	sd	s0,8(sp)
    800029b4:	01010413          	addi	s0,sp,16
    uint64 *adr = (uint64*) addr;
    uint64 *adrBlock = (uint64*)(adr - 1);
    uint64 num = (uint64) *adrBlock;
    800029b8:	ff853603          	ld	a2,-8(a0)
    mem_seg* head = (mem_seg*) ((void*) HEAP_START_ADDR);
    800029bc:	00009797          	auipc	a5,0x9
    800029c0:	c5c7b783          	ld	a5,-932(a5) # 8000b618 <_GLOBAL_OFFSET_TABLE_+0x8>
    800029c4:	0007b703          	ld	a4,0(a5)
    mem_seg* temp = (mem_seg*) ((void*) HEAP_START_ADDR);
    mem_seg* free_seg= (mem_seg*) ((void*) head->addr);
    800029c8:	01073683          	ld	a3,16(a4)
    uint64 num_block = (sizeof(mem_seg)) / MEM_BLOCK_SIZE;
    num_block = num_block + 1;
    if (temp == nullptr) {
    800029cc:	08070e63          	beqz	a4,80002a68 <_ZN15MemoryAllocator9_mem_freeEPv+0xbc>
    800029d0:	ff850593          	addi	a1,a0,-8
        return -1;
    }
    if (head->mem_block_num >= num_block) {
    800029d4:	01873783          	ld	a5,24(a4)
    800029d8:	04078263          	beqz	a5,80002a1c <_ZN15MemoryAllocator9_mem_freeEPv+0x70>
        mem_seg * free_seg = (mem_seg*) ((void*) head->addr) ;
        head->addr = head->addr  + sizeof(mem_seg);
    800029dc:	02068513          	addi	a0,a3,32
    800029e0:	00a73823          	sd	a0,16(a4)
        head->mem_block_num = head->mem_block_num - num_block;
    800029e4:	fff78793          	addi	a5,a5,-1
    800029e8:	00f73c23          	sd	a5,24(a4)
        while(temp->next) {
    800029ec:	00070793          	mv	a5,a4
    800029f0:	00073703          	ld	a4,0(a4)
    800029f4:	fe071ce3          	bnez	a4,800029ec <_ZN15MemoryAllocator9_mem_freeEPv+0x40>
            temp = (mem_seg*) temp->next;
        }
        temp->next = free_seg;
    800029f8:	00d7b023          	sd	a3,0(a5)
            return -1;
        }

    }

    free_seg->next = nullptr;
    800029fc:	0006b023          	sd	zero,0(a3)
    free_seg->prev = temp; //posle sredi
    80002a00:	00f6b423          	sd	a5,8(a3)
    free_seg->addr = *((uint64*)&adrBlock);
    80002a04:	00b6b823          	sd	a1,16(a3)
    free_seg->mem_block_num = num;
    80002a08:	00c6bc23          	sd	a2,24(a3)
    return 0;
    80002a0c:	00000513          	li	a0,0
}
    80002a10:	00813403          	ld	s0,8(sp)
    80002a14:	01010113          	addi	sp,sp,16
    80002a18:	00008067          	ret
        temp = (mem_seg*) temp->next;
    80002a1c:	00073783          	ld	a5,0(a4)
        while(temp) {
    80002a20:	02078e63          	beqz	a5,80002a5c <_ZN15MemoryAllocator9_mem_freeEPv+0xb0>
            if (temp->mem_block_num >= num_block) {
    80002a24:	0187b703          	ld	a4,24(a5)
    80002a28:	00071663          	bnez	a4,80002a34 <_ZN15MemoryAllocator9_mem_freeEPv+0x88>
                temp = (mem_seg*) temp->next;
    80002a2c:	0007b783          	ld	a5,0(a5)
        while(temp) {
    80002a30:	ff1ff06f          	j	80002a20 <_ZN15MemoryAllocator9_mem_freeEPv+0x74>
                mem_seg * free_seg = (mem_seg*) ((void*) temp->addr) ;
    80002a34:	0107b503          	ld	a0,16(a5)
                temp->addr = temp->addr  + sizeof(mem_seg);
    80002a38:	02050813          	addi	a6,a0,32
    80002a3c:	0107b823          	sd	a6,16(a5)
                temp->mem_block_num = temp->mem_block_num - num_block;
    80002a40:	fff70713          	addi	a4,a4,-1
    80002a44:	00e7bc23          	sd	a4,24(a5)
                while(temp->next) {
    80002a48:	00078713          	mv	a4,a5
    80002a4c:	0007b783          	ld	a5,0(a5)
    80002a50:	fe079ce3          	bnez	a5,80002a48 <_ZN15MemoryAllocator9_mem_freeEPv+0x9c>
                temp->next = free_seg;
    80002a54:	00a73023          	sd	a0,0(a4)
                break;
    80002a58:	00070793          	mv	a5,a4
        if (temp == nullptr) {
    80002a5c:	fa0790e3          	bnez	a5,800029fc <_ZN15MemoryAllocator9_mem_freeEPv+0x50>
            return -1;
    80002a60:	fff00513          	li	a0,-1
    80002a64:	fadff06f          	j	80002a10 <_ZN15MemoryAllocator9_mem_freeEPv+0x64>
        return -1;
    80002a68:	fff00513          	li	a0,-1
    80002a6c:	fa5ff06f          	j	80002a10 <_ZN15MemoryAllocator9_mem_freeEPv+0x64>

0000000080002a70 <_Z12print_stringPKc>:
#include "../h/riscv.hpp"
#include "../lib/console.h"
#include "../h/syscall_cpp.hpp"

void print_string(char const *string)
{
    80002a70:	fe010113          	addi	sp,sp,-32
    80002a74:	00113c23          	sd	ra,24(sp)
    80002a78:	00813823          	sd	s0,16(sp)
    80002a7c:	00913423          	sd	s1,8(sp)
    80002a80:	02010413          	addi	s0,sp,32
    80002a84:	00050493          	mv	s1,a0
    while (*string != '\0')
    80002a88:	0004c503          	lbu	a0,0(s1)
    80002a8c:	00050a63          	beqz	a0,80002aa0 <_Z12print_stringPKc+0x30>
    {
        Console::putc(*string);
    80002a90:	00000097          	auipc	ra,0x0
    80002a94:	8b4080e7          	jalr	-1868(ra) # 80002344 <_ZN7Console4putcEc>
        string++;
    80002a98:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002a9c:	fedff06f          	j	80002a88 <_Z12print_stringPKc+0x18>
    }
}
    80002aa0:	01813083          	ld	ra,24(sp)
    80002aa4:	01013403          	ld	s0,16(sp)
    80002aa8:	00813483          	ld	s1,8(sp)
    80002aac:	02010113          	addi	sp,sp,32
    80002ab0:	00008067          	ret

0000000080002ab4 <_Z13print_integerm>:

void print_integer(uint64 integer)
{
    80002ab4:	fd010113          	addi	sp,sp,-48
    80002ab8:	02113423          	sd	ra,40(sp)
    80002abc:	02813023          	sd	s0,32(sp)
    80002ac0:	00913c23          	sd	s1,24(sp)
    80002ac4:	03010413          	addi	s0,sp,48
    {
        neg = 1;
        x = -integer;
    } else
    {
        x = integer;
    80002ac8:	0005051b          	sext.w	a0,a0
    }

    i = 0;
    80002acc:	00000493          	li	s1,0
    do
    {
        buf[i++] = digits[x % 10];
    80002ad0:	00a00613          	li	a2,10
    80002ad4:	02c5773b          	remuw	a4,a0,a2
    80002ad8:	02071693          	slli	a3,a4,0x20
    80002adc:	0206d693          	srli	a3,a3,0x20
    80002ae0:	00006717          	auipc	a4,0x6
    80002ae4:	5d870713          	addi	a4,a4,1496 # 800090b8 <_ZZ13print_integermE6digits>
    80002ae8:	00d70733          	add	a4,a4,a3
    80002aec:	00074703          	lbu	a4,0(a4)
    80002af0:	fe040693          	addi	a3,s0,-32
    80002af4:	009687b3          	add	a5,a3,s1
    80002af8:	0014849b          	addiw	s1,s1,1
    80002afc:	fee78823          	sb	a4,-16(a5)
    } while ((x /= 10) != 0);
    80002b00:	0005071b          	sext.w	a4,a0
    80002b04:	02c5553b          	divuw	a0,a0,a2
    80002b08:	00900793          	li	a5,9
    80002b0c:	fce7e2e3          	bltu	a5,a4,80002ad0 <_Z13print_integerm+0x1c>
    if (neg)
        buf[i++] = '-';

    while (--i >= 0) { Console::putc(buf[i]); }
    80002b10:	fff4849b          	addiw	s1,s1,-1
    80002b14:	0004ce63          	bltz	s1,80002b30 <_Z13print_integerm+0x7c>
    80002b18:	fe040793          	addi	a5,s0,-32
    80002b1c:	009787b3          	add	a5,a5,s1
    80002b20:	ff07c503          	lbu	a0,-16(a5)
    80002b24:	00000097          	auipc	ra,0x0
    80002b28:	820080e7          	jalr	-2016(ra) # 80002344 <_ZN7Console4putcEc>
    80002b2c:	fe5ff06f          	j	80002b10 <_Z13print_integerm+0x5c>
    80002b30:	02813083          	ld	ra,40(sp)
    80002b34:	02013403          	ld	s0,32(sp)
    80002b38:	01813483          	ld	s1,24(sp)
    80002b3c:	03010113          	addi	sp,sp,48
    80002b40:	00008067          	ret

0000000080002b44 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80002b44:	fe010113          	addi	sp,sp,-32
    80002b48:	00113c23          	sd	ra,24(sp)
    80002b4c:	00813823          	sd	s0,16(sp)
    80002b50:	00913423          	sd	s1,8(sp)
    80002b54:	01213023          	sd	s2,0(sp)
    80002b58:	02010413          	addi	s0,sp,32
    80002b5c:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002b60:	00000913          	li	s2,0
    80002b64:	00c0006f          	j	80002b70 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002b68:	fffff097          	auipc	ra,0xfffff
    80002b6c:	824080e7          	jalr	-2012(ra) # 8000138c <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002b70:	fffff097          	auipc	ra,0xfffff
    80002b74:	90c080e7          	jalr	-1780(ra) # 8000147c <_Z4getcv>
    80002b78:	0005059b          	sext.w	a1,a0
    80002b7c:	01b00793          	li	a5,27
    80002b80:	02f58a63          	beq	a1,a5,80002bb4 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80002b84:	0084b503          	ld	a0,8(s1)
    80002b88:	00003097          	auipc	ra,0x3
    80002b8c:	3d4080e7          	jalr	980(ra) # 80005f5c <_ZN6Buffer3putEi>
        i++;
    80002b90:	0019071b          	addiw	a4,s2,1
    80002b94:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002b98:	0004a683          	lw	a3,0(s1)
    80002b9c:	0026979b          	slliw	a5,a3,0x2
    80002ba0:	00d787bb          	addw	a5,a5,a3
    80002ba4:	0017979b          	slliw	a5,a5,0x1
    80002ba8:	02f767bb          	remw	a5,a4,a5
    80002bac:	fc0792e3          	bnez	a5,80002b70 <_ZL16producerKeyboardPv+0x2c>
    80002bb0:	fb9ff06f          	j	80002b68 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80002bb4:	00100793          	li	a5,1
    80002bb8:	00009717          	auipc	a4,0x9
    80002bbc:	b0f72023          	sw	a5,-1280(a4) # 8000b6b8 <_ZL9threadEnd>
    data->buffer->put('!');
    80002bc0:	02100593          	li	a1,33
    80002bc4:	0084b503          	ld	a0,8(s1)
    80002bc8:	00003097          	auipc	ra,0x3
    80002bcc:	394080e7          	jalr	916(ra) # 80005f5c <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    80002bd0:	0104b503          	ld	a0,16(s1)
    80002bd4:	fffff097          	auipc	ra,0xfffff
    80002bd8:	87c080e7          	jalr	-1924(ra) # 80001450 <_Z10sem_signalP9semaphore>
}
    80002bdc:	01813083          	ld	ra,24(sp)
    80002be0:	01013403          	ld	s0,16(sp)
    80002be4:	00813483          	ld	s1,8(sp)
    80002be8:	00013903          	ld	s2,0(sp)
    80002bec:	02010113          	addi	sp,sp,32
    80002bf0:	00008067          	ret

0000000080002bf4 <_ZL8producerPv>:

static void producer(void *arg) {
    80002bf4:	fe010113          	addi	sp,sp,-32
    80002bf8:	00113c23          	sd	ra,24(sp)
    80002bfc:	00813823          	sd	s0,16(sp)
    80002c00:	00913423          	sd	s1,8(sp)
    80002c04:	01213023          	sd	s2,0(sp)
    80002c08:	02010413          	addi	s0,sp,32
    80002c0c:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002c10:	00000913          	li	s2,0
    80002c14:	00c0006f          	j	80002c20 <_ZL8producerPv+0x2c>
    while (!threadEnd) {

        data->buffer->put(data->id + '0');
        i++;
        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002c18:	ffffe097          	auipc	ra,0xffffe
    80002c1c:	774080e7          	jalr	1908(ra) # 8000138c <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002c20:	00009797          	auipc	a5,0x9
    80002c24:	a987a783          	lw	a5,-1384(a5) # 8000b6b8 <_ZL9threadEnd>
    80002c28:	02079e63          	bnez	a5,80002c64 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80002c2c:	0004a583          	lw	a1,0(s1)
    80002c30:	0305859b          	addiw	a1,a1,48
    80002c34:	0084b503          	ld	a0,8(s1)
    80002c38:	00003097          	auipc	ra,0x3
    80002c3c:	324080e7          	jalr	804(ra) # 80005f5c <_ZN6Buffer3putEi>
        i++;
    80002c40:	0019071b          	addiw	a4,s2,1
    80002c44:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002c48:	0004a683          	lw	a3,0(s1)
    80002c4c:	0026979b          	slliw	a5,a3,0x2
    80002c50:	00d787bb          	addw	a5,a5,a3
    80002c54:	0017979b          	slliw	a5,a5,0x1
    80002c58:	02f767bb          	remw	a5,a4,a5
    80002c5c:	fc0792e3          	bnez	a5,80002c20 <_ZL8producerPv+0x2c>
    80002c60:	fb9ff06f          	j	80002c18 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80002c64:	0104b503          	ld	a0,16(s1)
    80002c68:	ffffe097          	auipc	ra,0xffffe
    80002c6c:	7e8080e7          	jalr	2024(ra) # 80001450 <_Z10sem_signalP9semaphore>
}
    80002c70:	01813083          	ld	ra,24(sp)
    80002c74:	01013403          	ld	s0,16(sp)
    80002c78:	00813483          	ld	s1,8(sp)
    80002c7c:	00013903          	ld	s2,0(sp)
    80002c80:	02010113          	addi	sp,sp,32
    80002c84:	00008067          	ret

0000000080002c88 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002c88:	fd010113          	addi	sp,sp,-48
    80002c8c:	02113423          	sd	ra,40(sp)
    80002c90:	02813023          	sd	s0,32(sp)
    80002c94:	00913c23          	sd	s1,24(sp)
    80002c98:	01213823          	sd	s2,16(sp)
    80002c9c:	01313423          	sd	s3,8(sp)
    80002ca0:	03010413          	addi	s0,sp,48
    80002ca4:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002ca8:	00000993          	li	s3,0
    80002cac:	01c0006f          	j	80002cc8 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    80002cb0:	ffffe097          	auipc	ra,0xffffe
    80002cb4:	6dc080e7          	jalr	1756(ra) # 8000138c <_Z15thread_dispatchv>
    80002cb8:	0500006f          	j	80002d08 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002cbc:	00a00513          	li	a0,10
    80002cc0:	ffffe097          	auipc	ra,0xffffe
    80002cc4:	7f0080e7          	jalr	2032(ra) # 800014b0 <_Z4putcc>
    while (!threadEnd) {
    80002cc8:	00009797          	auipc	a5,0x9
    80002ccc:	9f07a783          	lw	a5,-1552(a5) # 8000b6b8 <_ZL9threadEnd>
    80002cd0:	06079063          	bnez	a5,80002d30 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80002cd4:	00893503          	ld	a0,8(s2)
    80002cd8:	00003097          	auipc	ra,0x3
    80002cdc:	314080e7          	jalr	788(ra) # 80005fec <_ZN6Buffer3getEv>
        i++;
    80002ce0:	0019849b          	addiw	s1,s3,1
    80002ce4:	0004899b          	sext.w	s3,s1
        putc(key);
    80002ce8:	0ff57513          	andi	a0,a0,255
    80002cec:	ffffe097          	auipc	ra,0xffffe
    80002cf0:	7c4080e7          	jalr	1988(ra) # 800014b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80002cf4:	00092703          	lw	a4,0(s2)
    80002cf8:	0027179b          	slliw	a5,a4,0x2
    80002cfc:	00e787bb          	addw	a5,a5,a4
    80002d00:	02f4e7bb          	remw	a5,s1,a5
    80002d04:	fa0786e3          	beqz	a5,80002cb0 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    80002d08:	05000793          	li	a5,80
    80002d0c:	02f4e4bb          	remw	s1,s1,a5
    80002d10:	fa049ce3          	bnez	s1,80002cc8 <_ZL8consumerPv+0x40>
    80002d14:	fa9ff06f          	j	80002cbc <_ZL8consumerPv+0x34>


    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    80002d18:	00893503          	ld	a0,8(s2)
    80002d1c:	00003097          	auipc	ra,0x3
    80002d20:	2d0080e7          	jalr	720(ra) # 80005fec <_ZN6Buffer3getEv>
        putc(key);
    80002d24:	0ff57513          	andi	a0,a0,255
    80002d28:	ffffe097          	auipc	ra,0xffffe
    80002d2c:	788080e7          	jalr	1928(ra) # 800014b0 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80002d30:	00893503          	ld	a0,8(s2)
    80002d34:	00003097          	auipc	ra,0x3
    80002d38:	344080e7          	jalr	836(ra) # 80006078 <_ZN6Buffer6getCntEv>
    80002d3c:	fca04ee3          	bgtz	a0,80002d18 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80002d40:	01093503          	ld	a0,16(s2)
    80002d44:	ffffe097          	auipc	ra,0xffffe
    80002d48:	70c080e7          	jalr	1804(ra) # 80001450 <_Z10sem_signalP9semaphore>
}
    80002d4c:	02813083          	ld	ra,40(sp)
    80002d50:	02013403          	ld	s0,32(sp)
    80002d54:	01813483          	ld	s1,24(sp)
    80002d58:	01013903          	ld	s2,16(sp)
    80002d5c:	00813983          	ld	s3,8(sp)
    80002d60:	03010113          	addi	sp,sp,48
    80002d64:	00008067          	ret

0000000080002d68 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002d68:	f9010113          	addi	sp,sp,-112
    80002d6c:	06113423          	sd	ra,104(sp)
    80002d70:	06813023          	sd	s0,96(sp)
    80002d74:	04913c23          	sd	s1,88(sp)
    80002d78:	05213823          	sd	s2,80(sp)
    80002d7c:	05313423          	sd	s3,72(sp)
    80002d80:	05413023          	sd	s4,64(sp)
    80002d84:	03513c23          	sd	s5,56(sp)
    80002d88:	03613823          	sd	s6,48(sp)
    80002d8c:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80002d90:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80002d94:	00006517          	auipc	a0,0x6
    80002d98:	33450513          	addi	a0,a0,820 # 800090c8 <_ZZ13print_integermE6digits+0x10>
    80002d9c:	00002097          	auipc	ra,0x2
    80002da0:	200080e7          	jalr	512(ra) # 80004f9c <_Z11printStringPKc>
    getString(input, 30);
    80002da4:	01e00593          	li	a1,30
    80002da8:	fa040493          	addi	s1,s0,-96
    80002dac:	00048513          	mv	a0,s1
    80002db0:	00002097          	auipc	ra,0x2
    80002db4:	274080e7          	jalr	628(ra) # 80005024 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002db8:	00048513          	mv	a0,s1
    80002dbc:	00002097          	auipc	ra,0x2
    80002dc0:	340080e7          	jalr	832(ra) # 800050fc <_Z11stringToIntPKc>
    80002dc4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002dc8:	00006517          	auipc	a0,0x6
    80002dcc:	32050513          	addi	a0,a0,800 # 800090e8 <_ZZ13print_integermE6digits+0x30>
    80002dd0:	00002097          	auipc	ra,0x2
    80002dd4:	1cc080e7          	jalr	460(ra) # 80004f9c <_Z11printStringPKc>
    getString(input, 30);
    80002dd8:	01e00593          	li	a1,30
    80002ddc:	00048513          	mv	a0,s1
    80002de0:	00002097          	auipc	ra,0x2
    80002de4:	244080e7          	jalr	580(ra) # 80005024 <_Z9getStringPci>
    n = stringToInt(input);
    80002de8:	00048513          	mv	a0,s1
    80002dec:	00002097          	auipc	ra,0x2
    80002df0:	310080e7          	jalr	784(ra) # 800050fc <_Z11stringToIntPKc>
    80002df4:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80002df8:	00006517          	auipc	a0,0x6
    80002dfc:	31050513          	addi	a0,a0,784 # 80009108 <_ZZ13print_integermE6digits+0x50>
    80002e00:	00002097          	auipc	ra,0x2
    80002e04:	19c080e7          	jalr	412(ra) # 80004f9c <_Z11printStringPKc>
    80002e08:	00000613          	li	a2,0
    80002e0c:	00a00593          	li	a1,10
    80002e10:	00090513          	mv	a0,s2
    80002e14:	00002097          	auipc	ra,0x2
    80002e18:	338080e7          	jalr	824(ra) # 8000514c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80002e1c:	00006517          	auipc	a0,0x6
    80002e20:	30450513          	addi	a0,a0,772 # 80009120 <_ZZ13print_integermE6digits+0x68>
    80002e24:	00002097          	auipc	ra,0x2
    80002e28:	178080e7          	jalr	376(ra) # 80004f9c <_Z11printStringPKc>
    80002e2c:	00000613          	li	a2,0
    80002e30:	00a00593          	li	a1,10
    80002e34:	00048513          	mv	a0,s1
    80002e38:	00002097          	auipc	ra,0x2
    80002e3c:	314080e7          	jalr	788(ra) # 8000514c <_Z8printIntiii>
    printString(".\n");
    80002e40:	00006517          	auipc	a0,0x6
    80002e44:	2f850513          	addi	a0,a0,760 # 80009138 <_ZZ13print_integermE6digits+0x80>
    80002e48:	00002097          	auipc	ra,0x2
    80002e4c:	154080e7          	jalr	340(ra) # 80004f9c <_Z11printStringPKc>
    if(threadNum > n) {
    80002e50:	0324c463          	blt	s1,s2,80002e78 <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80002e54:	03205c63          	blez	s2,80002e8c <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    80002e58:	03800513          	li	a0,56
    80002e5c:	fffff097          	auipc	ra,0xfffff
    80002e60:	1c4080e7          	jalr	452(ra) # 80002020 <_Znwm>
    80002e64:	00050a13          	mv	s4,a0
    80002e68:	00048593          	mv	a1,s1
    80002e6c:	00003097          	auipc	ra,0x3
    80002e70:	054080e7          	jalr	84(ra) # 80005ec0 <_ZN6BufferC1Ei>
    80002e74:	0300006f          	j	80002ea4 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002e78:	00006517          	auipc	a0,0x6
    80002e7c:	2c850513          	addi	a0,a0,712 # 80009140 <_ZZ13print_integermE6digits+0x88>
    80002e80:	00002097          	auipc	ra,0x2
    80002e84:	11c080e7          	jalr	284(ra) # 80004f9c <_Z11printStringPKc>
        return;
    80002e88:	0140006f          	j	80002e9c <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002e8c:	00006517          	auipc	a0,0x6
    80002e90:	2f450513          	addi	a0,a0,756 # 80009180 <_ZZ13print_integermE6digits+0xc8>
    80002e94:	00002097          	auipc	ra,0x2
    80002e98:	108080e7          	jalr	264(ra) # 80004f9c <_Z11printStringPKc>
        return;
    80002e9c:	000b0113          	mv	sp,s6
    80002ea0:	1500006f          	j	80002ff0 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    80002ea4:	00000593          	li	a1,0
    80002ea8:	00009517          	auipc	a0,0x9
    80002eac:	81850513          	addi	a0,a0,-2024 # 8000b6c0 <_ZL10waitForAll>
    80002eb0:	ffffe097          	auipc	ra,0xffffe
    80002eb4:	520080e7          	jalr	1312(ra) # 800013d0 <_Z8sem_openPP9semaphorej>
    thread_t threads[threadNum];
    80002eb8:	00391793          	slli	a5,s2,0x3
    80002ebc:	00f78793          	addi	a5,a5,15
    80002ec0:	ff07f793          	andi	a5,a5,-16
    80002ec4:	40f10133          	sub	sp,sp,a5
    80002ec8:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002ecc:	0019071b          	addiw	a4,s2,1
    80002ed0:	00171793          	slli	a5,a4,0x1
    80002ed4:	00e787b3          	add	a5,a5,a4
    80002ed8:	00379793          	slli	a5,a5,0x3
    80002edc:	00f78793          	addi	a5,a5,15
    80002ee0:	ff07f793          	andi	a5,a5,-16
    80002ee4:	40f10133          	sub	sp,sp,a5
    80002ee8:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002eec:	00191613          	slli	a2,s2,0x1
    80002ef0:	012607b3          	add	a5,a2,s2
    80002ef4:	00379793          	slli	a5,a5,0x3
    80002ef8:	00f987b3          	add	a5,s3,a5
    80002efc:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80002f00:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80002f04:	00008717          	auipc	a4,0x8
    80002f08:	7bc73703          	ld	a4,1980(a4) # 8000b6c0 <_ZL10waitForAll>
    80002f0c:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80002f10:	00078613          	mv	a2,a5
    80002f14:	00000597          	auipc	a1,0x0
    80002f18:	d7458593          	addi	a1,a1,-652 # 80002c88 <_ZL8consumerPv>
    80002f1c:	f9840513          	addi	a0,s0,-104
    80002f20:	ffffe097          	auipc	ra,0xffffe
    80002f24:	3e8080e7          	jalr	1000(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002f28:	00000493          	li	s1,0
    80002f2c:	0280006f          	j	80002f54 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80002f30:	00000597          	auipc	a1,0x0
    80002f34:	c1458593          	addi	a1,a1,-1004 # 80002b44 <_ZL16producerKeyboardPv>
                      data + i);
    80002f38:	00179613          	slli	a2,a5,0x1
    80002f3c:	00f60633          	add	a2,a2,a5
    80002f40:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80002f44:	00c98633          	add	a2,s3,a2
    80002f48:	ffffe097          	auipc	ra,0xffffe
    80002f4c:	3c0080e7          	jalr	960(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80002f50:	0014849b          	addiw	s1,s1,1
    80002f54:	0524d263          	bge	s1,s2,80002f98 <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    80002f58:	00149793          	slli	a5,s1,0x1
    80002f5c:	009787b3          	add	a5,a5,s1
    80002f60:	00379793          	slli	a5,a5,0x3
    80002f64:	00f987b3          	add	a5,s3,a5
    80002f68:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002f6c:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002f70:	00008717          	auipc	a4,0x8
    80002f74:	75073703          	ld	a4,1872(a4) # 8000b6c0 <_ZL10waitForAll>
    80002f78:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002f7c:	00048793          	mv	a5,s1
    80002f80:	00349513          	slli	a0,s1,0x3
    80002f84:	00aa8533          	add	a0,s5,a0
    80002f88:	fa9054e3          	blez	s1,80002f30 <_Z22producerConsumer_C_APIv+0x1c8>
    80002f8c:	00000597          	auipc	a1,0x0
    80002f90:	c6858593          	addi	a1,a1,-920 # 80002bf4 <_ZL8producerPv>
    80002f94:	fa5ff06f          	j	80002f38 <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    80002f98:	ffffe097          	auipc	ra,0xffffe
    80002f9c:	3f4080e7          	jalr	1012(ra) # 8000138c <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002fa0:	00000493          	li	s1,0
    80002fa4:	00994e63          	blt	s2,s1,80002fc0 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    80002fa8:	00008517          	auipc	a0,0x8
    80002fac:	71853503          	ld	a0,1816(a0) # 8000b6c0 <_ZL10waitForAll>
    80002fb0:	ffffe097          	auipc	ra,0xffffe
    80002fb4:	474080e7          	jalr	1140(ra) # 80001424 <_Z8sem_waitP9semaphore>
    for (int i = 0; i <= threadNum; i++) {
    80002fb8:	0014849b          	addiw	s1,s1,1
    80002fbc:	fe9ff06f          	j	80002fa4 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    80002fc0:	00008517          	auipc	a0,0x8
    80002fc4:	70053503          	ld	a0,1792(a0) # 8000b6c0 <_ZL10waitForAll>
    80002fc8:	ffffe097          	auipc	ra,0xffffe
    80002fcc:	434080e7          	jalr	1076(ra) # 800013fc <_Z9sem_closeP9semaphore>
    delete buffer;
    80002fd0:	000a0e63          	beqz	s4,80002fec <_Z22producerConsumer_C_APIv+0x284>
    80002fd4:	000a0513          	mv	a0,s4
    80002fd8:	00003097          	auipc	ra,0x3
    80002fdc:	128080e7          	jalr	296(ra) # 80006100 <_ZN6BufferD1Ev>
    80002fe0:	000a0513          	mv	a0,s4
    80002fe4:	fffff097          	auipc	ra,0xfffff
    80002fe8:	064080e7          	jalr	100(ra) # 80002048 <_ZdlPv>
    80002fec:	000b0113          	mv	sp,s6

}
    80002ff0:	f9040113          	addi	sp,s0,-112
    80002ff4:	06813083          	ld	ra,104(sp)
    80002ff8:	06013403          	ld	s0,96(sp)
    80002ffc:	05813483          	ld	s1,88(sp)
    80003000:	05013903          	ld	s2,80(sp)
    80003004:	04813983          	ld	s3,72(sp)
    80003008:	04013a03          	ld	s4,64(sp)
    8000300c:	03813a83          	ld	s5,56(sp)
    80003010:	03013b03          	ld	s6,48(sp)
    80003014:	07010113          	addi	sp,sp,112
    80003018:	00008067          	ret
    8000301c:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80003020:	000a0513          	mv	a0,s4
    80003024:	fffff097          	auipc	ra,0xfffff
    80003028:	024080e7          	jalr	36(ra) # 80002048 <_ZdlPv>
    8000302c:	00048513          	mv	a0,s1
    80003030:	00009097          	auipc	ra,0x9
    80003034:	7a8080e7          	jalr	1960(ra) # 8000c7d8 <_Unwind_Resume>

0000000080003038 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003038:	fe010113          	addi	sp,sp,-32
    8000303c:	00113c23          	sd	ra,24(sp)
    80003040:	00813823          	sd	s0,16(sp)
    80003044:	00913423          	sd	s1,8(sp)
    80003048:	01213023          	sd	s2,0(sp)
    8000304c:	02010413          	addi	s0,sp,32
    80003050:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003054:	00100793          	li	a5,1
    80003058:	02a7f863          	bgeu	a5,a0,80003088 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000305c:	00a00793          	li	a5,10
    80003060:	02f577b3          	remu	a5,a0,a5
    80003064:	02078e63          	beqz	a5,800030a0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003068:	fff48513          	addi	a0,s1,-1
    8000306c:	00000097          	auipc	ra,0x0
    80003070:	fcc080e7          	jalr	-52(ra) # 80003038 <_ZL9fibonaccim>
    80003074:	00050913          	mv	s2,a0
    80003078:	ffe48513          	addi	a0,s1,-2
    8000307c:	00000097          	auipc	ra,0x0
    80003080:	fbc080e7          	jalr	-68(ra) # 80003038 <_ZL9fibonaccim>
    80003084:	00a90533          	add	a0,s2,a0
}
    80003088:	01813083          	ld	ra,24(sp)
    8000308c:	01013403          	ld	s0,16(sp)
    80003090:	00813483          	ld	s1,8(sp)
    80003094:	00013903          	ld	s2,0(sp)
    80003098:	02010113          	addi	sp,sp,32
    8000309c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800030a0:	ffffe097          	auipc	ra,0xffffe
    800030a4:	2ec080e7          	jalr	748(ra) # 8000138c <_Z15thread_dispatchv>
    800030a8:	fc1ff06f          	j	80003068 <_ZL9fibonaccim+0x30>

00000000800030ac <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    800030ac:	fe010113          	addi	sp,sp,-32
    800030b0:	00113c23          	sd	ra,24(sp)
    800030b4:	00813823          	sd	s0,16(sp)
    800030b8:	00913423          	sd	s1,8(sp)
    800030bc:	01213023          	sd	s2,0(sp)
    800030c0:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    800030c4:	00000913          	li	s2,0
    800030c8:	0300006f          	j	800030f8 <_ZN7WorkerA11workerBodyAEPv+0x4c>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 100; j++) {
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
            thread_dispatch();
    800030cc:	ffffe097          	auipc	ra,0xffffe
    800030d0:	2c0080e7          	jalr	704(ra) # 8000138c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 100; j++) {
    800030d4:	00148493          	addi	s1,s1,1
    800030d8:	06300793          	li	a5,99
    800030dc:	0097ec63          	bltu	a5,s1,800030f4 <_ZN7WorkerA11workerBodyAEPv+0x48>
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
    800030e0:	00000793          	li	a5,0
    800030e4:	12b00713          	li	a4,299
    800030e8:	fef762e3          	bltu	a4,a5,800030cc <_ZN7WorkerA11workerBodyAEPv+0x20>
    800030ec:	00178793          	addi	a5,a5,1
    800030f0:	ff5ff06f          	j	800030e4 <_ZN7WorkerA11workerBodyAEPv+0x38>
    for (uint64 i = 0; i < 10; i++) {
    800030f4:	00190913          	addi	s2,s2,1
    800030f8:	00900793          	li	a5,9
    800030fc:	0527e063          	bltu	a5,s2,8000313c <_ZN7WorkerA11workerBodyAEPv+0x90>
        printString("A: i="); printInt(i); printString("\n");
    80003100:	00006517          	auipc	a0,0x6
    80003104:	0b050513          	addi	a0,a0,176 # 800091b0 <_ZZ13print_integermE6digits+0xf8>
    80003108:	00002097          	auipc	ra,0x2
    8000310c:	e94080e7          	jalr	-364(ra) # 80004f9c <_Z11printStringPKc>
    80003110:	00000613          	li	a2,0
    80003114:	00a00593          	li	a1,10
    80003118:	0009051b          	sext.w	a0,s2
    8000311c:	00002097          	auipc	ra,0x2
    80003120:	030080e7          	jalr	48(ra) # 8000514c <_Z8printIntiii>
    80003124:	00006517          	auipc	a0,0x6
    80003128:	2c450513          	addi	a0,a0,708 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    8000312c:	00002097          	auipc	ra,0x2
    80003130:	e70080e7          	jalr	-400(ra) # 80004f9c <_Z11printStringPKc>
        for (uint64 j = 0; j < 100; j++) {
    80003134:	00000493          	li	s1,0
    80003138:	fa1ff06f          	j	800030d8 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    8000313c:	00006517          	auipc	a0,0x6
    80003140:	07c50513          	addi	a0,a0,124 # 800091b8 <_ZZ13print_integermE6digits+0x100>
    80003144:	00002097          	auipc	ra,0x2
    80003148:	e58080e7          	jalr	-424(ra) # 80004f9c <_Z11printStringPKc>
    finishedA = true;
    8000314c:	00100793          	li	a5,1
    80003150:	00008717          	auipc	a4,0x8
    80003154:	56f70c23          	sb	a5,1400(a4) # 8000b6c8 <_ZL9finishedA>
}
    80003158:	01813083          	ld	ra,24(sp)
    8000315c:	01013403          	ld	s0,16(sp)
    80003160:	00813483          	ld	s1,8(sp)
    80003164:	00013903          	ld	s2,0(sp)
    80003168:	02010113          	addi	sp,sp,32
    8000316c:	00008067          	ret

0000000080003170 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80003170:	fe010113          	addi	sp,sp,-32
    80003174:	00113c23          	sd	ra,24(sp)
    80003178:	00813823          	sd	s0,16(sp)
    8000317c:	00913423          	sd	s1,8(sp)
    80003180:	01213023          	sd	s2,0(sp)
    80003184:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003188:	00000913          	li	s2,0
    8000318c:	0300006f          	j	800031bc <_ZN7WorkerB11workerBodyBEPv+0x4c>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 100; j++) {
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
            thread_dispatch();
    80003190:	ffffe097          	auipc	ra,0xffffe
    80003194:	1fc080e7          	jalr	508(ra) # 8000138c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 100; j++) {
    80003198:	00148493          	addi	s1,s1,1
    8000319c:	06300793          	li	a5,99
    800031a0:	0097ec63          	bltu	a5,s1,800031b8 <_ZN7WorkerB11workerBodyBEPv+0x48>
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
    800031a4:	00000793          	li	a5,0
    800031a8:	12b00713          	li	a4,299
    800031ac:	fef762e3          	bltu	a4,a5,80003190 <_ZN7WorkerB11workerBodyBEPv+0x20>
    800031b0:	00178793          	addi	a5,a5,1
    800031b4:	ff5ff06f          	j	800031a8 <_ZN7WorkerB11workerBodyBEPv+0x38>
    for (uint64 i = 0; i < 16; i++) {
    800031b8:	00190913          	addi	s2,s2,1
    800031bc:	00f00793          	li	a5,15
    800031c0:	0527e063          	bltu	a5,s2,80003200 <_ZN7WorkerB11workerBodyBEPv+0x90>
        printString("B: i="); printInt(i); printString("\n");
    800031c4:	00006517          	auipc	a0,0x6
    800031c8:	00450513          	addi	a0,a0,4 # 800091c8 <_ZZ13print_integermE6digits+0x110>
    800031cc:	00002097          	auipc	ra,0x2
    800031d0:	dd0080e7          	jalr	-560(ra) # 80004f9c <_Z11printStringPKc>
    800031d4:	00000613          	li	a2,0
    800031d8:	00a00593          	li	a1,10
    800031dc:	0009051b          	sext.w	a0,s2
    800031e0:	00002097          	auipc	ra,0x2
    800031e4:	f6c080e7          	jalr	-148(ra) # 8000514c <_Z8printIntiii>
    800031e8:	00006517          	auipc	a0,0x6
    800031ec:	20050513          	addi	a0,a0,512 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800031f0:	00002097          	auipc	ra,0x2
    800031f4:	dac080e7          	jalr	-596(ra) # 80004f9c <_Z11printStringPKc>
        for (uint64 j = 0; j < 100; j++) {
    800031f8:	00000493          	li	s1,0
    800031fc:	fa1ff06f          	j	8000319c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80003200:	00006517          	auipc	a0,0x6
    80003204:	fd050513          	addi	a0,a0,-48 # 800091d0 <_ZZ13print_integermE6digits+0x118>
    80003208:	00002097          	auipc	ra,0x2
    8000320c:	d94080e7          	jalr	-620(ra) # 80004f9c <_Z11printStringPKc>
    finishedB = true;
    80003210:	00100793          	li	a5,1
    80003214:	00008717          	auipc	a4,0x8
    80003218:	4af70aa3          	sb	a5,1205(a4) # 8000b6c9 <_ZL9finishedB>
    thread_dispatch();
    8000321c:	ffffe097          	auipc	ra,0xffffe
    80003220:	170080e7          	jalr	368(ra) # 8000138c <_Z15thread_dispatchv>
}
    80003224:	01813083          	ld	ra,24(sp)
    80003228:	01013403          	ld	s0,16(sp)
    8000322c:	00813483          	ld	s1,8(sp)
    80003230:	00013903          	ld	s2,0(sp)
    80003234:	02010113          	addi	sp,sp,32
    80003238:	00008067          	ret

000000008000323c <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    8000323c:	fe010113          	addi	sp,sp,-32
    80003240:	00113c23          	sd	ra,24(sp)
    80003244:	00813823          	sd	s0,16(sp)
    80003248:	00913423          	sd	s1,8(sp)
    8000324c:	01213023          	sd	s2,0(sp)
    80003250:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003254:	00000493          	li	s1,0
    80003258:	0400006f          	j	80003298 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000325c:	00006517          	auipc	a0,0x6
    80003260:	f8450513          	addi	a0,a0,-124 # 800091e0 <_ZZ13print_integermE6digits+0x128>
    80003264:	00002097          	auipc	ra,0x2
    80003268:	d38080e7          	jalr	-712(ra) # 80004f9c <_Z11printStringPKc>
    8000326c:	00000613          	li	a2,0
    80003270:	00a00593          	li	a1,10
    80003274:	00048513          	mv	a0,s1
    80003278:	00002097          	auipc	ra,0x2
    8000327c:	ed4080e7          	jalr	-300(ra) # 8000514c <_Z8printIntiii>
    80003280:	00006517          	auipc	a0,0x6
    80003284:	16850513          	addi	a0,a0,360 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80003288:	00002097          	auipc	ra,0x2
    8000328c:	d14080e7          	jalr	-748(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003290:	0014849b          	addiw	s1,s1,1
    80003294:	0ff4f493          	andi	s1,s1,255
    80003298:	00200793          	li	a5,2
    8000329c:	fc97f0e3          	bgeu	a5,s1,8000325c <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    800032a0:	00006517          	auipc	a0,0x6
    800032a4:	f4850513          	addi	a0,a0,-184 # 800091e8 <_ZZ13print_integermE6digits+0x130>
    800032a8:	00002097          	auipc	ra,0x2
    800032ac:	cf4080e7          	jalr	-780(ra) # 80004f9c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    800032b0:	00700313          	li	t1,7
    thread_dispatch();
    800032b4:	ffffe097          	auipc	ra,0xffffe
    800032b8:	0d8080e7          	jalr	216(ra) # 8000138c <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    800032bc:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    800032c0:	00006517          	auipc	a0,0x6
    800032c4:	f3850513          	addi	a0,a0,-200 # 800091f8 <_ZZ13print_integermE6digits+0x140>
    800032c8:	00002097          	auipc	ra,0x2
    800032cc:	cd4080e7          	jalr	-812(ra) # 80004f9c <_Z11printStringPKc>
    800032d0:	00000613          	li	a2,0
    800032d4:	00a00593          	li	a1,10
    800032d8:	0009051b          	sext.w	a0,s2
    800032dc:	00002097          	auipc	ra,0x2
    800032e0:	e70080e7          	jalr	-400(ra) # 8000514c <_Z8printIntiii>
    800032e4:	00006517          	auipc	a0,0x6
    800032e8:	10450513          	addi	a0,a0,260 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800032ec:	00002097          	auipc	ra,0x2
    800032f0:	cb0080e7          	jalr	-848(ra) # 80004f9c <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800032f4:	00c00513          	li	a0,12
    800032f8:	00000097          	auipc	ra,0x0
    800032fc:	d40080e7          	jalr	-704(ra) # 80003038 <_ZL9fibonaccim>
    80003300:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003304:	00006517          	auipc	a0,0x6
    80003308:	efc50513          	addi	a0,a0,-260 # 80009200 <_ZZ13print_integermE6digits+0x148>
    8000330c:	00002097          	auipc	ra,0x2
    80003310:	c90080e7          	jalr	-880(ra) # 80004f9c <_Z11printStringPKc>
    80003314:	00000613          	li	a2,0
    80003318:	00a00593          	li	a1,10
    8000331c:	0009051b          	sext.w	a0,s2
    80003320:	00002097          	auipc	ra,0x2
    80003324:	e2c080e7          	jalr	-468(ra) # 8000514c <_Z8printIntiii>
    80003328:	00006517          	auipc	a0,0x6
    8000332c:	0c050513          	addi	a0,a0,192 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80003330:	00002097          	auipc	ra,0x2
    80003334:	c6c080e7          	jalr	-916(ra) # 80004f9c <_Z11printStringPKc>
    80003338:	0400006f          	j	80003378 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    8000333c:	00006517          	auipc	a0,0x6
    80003340:	ea450513          	addi	a0,a0,-348 # 800091e0 <_ZZ13print_integermE6digits+0x128>
    80003344:	00002097          	auipc	ra,0x2
    80003348:	c58080e7          	jalr	-936(ra) # 80004f9c <_Z11printStringPKc>
    8000334c:	00000613          	li	a2,0
    80003350:	00a00593          	li	a1,10
    80003354:	00048513          	mv	a0,s1
    80003358:	00002097          	auipc	ra,0x2
    8000335c:	df4080e7          	jalr	-524(ra) # 8000514c <_Z8printIntiii>
    80003360:	00006517          	auipc	a0,0x6
    80003364:	08850513          	addi	a0,a0,136 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80003368:	00002097          	auipc	ra,0x2
    8000336c:	c34080e7          	jalr	-972(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003370:	0014849b          	addiw	s1,s1,1
    80003374:	0ff4f493          	andi	s1,s1,255
    80003378:	00500793          	li	a5,5
    8000337c:	fc97f0e3          	bgeu	a5,s1,8000333c <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80003380:	00006517          	auipc	a0,0x6
    80003384:	e3850513          	addi	a0,a0,-456 # 800091b8 <_ZZ13print_integermE6digits+0x100>
    80003388:	00002097          	auipc	ra,0x2
    8000338c:	c14080e7          	jalr	-1004(ra) # 80004f9c <_Z11printStringPKc>
    finishedC = true;
    80003390:	00100793          	li	a5,1
    80003394:	00008717          	auipc	a4,0x8
    80003398:	32f70b23          	sb	a5,822(a4) # 8000b6ca <_ZL9finishedC>
    thread_dispatch();
    8000339c:	ffffe097          	auipc	ra,0xffffe
    800033a0:	ff0080e7          	jalr	-16(ra) # 8000138c <_Z15thread_dispatchv>
}
    800033a4:	01813083          	ld	ra,24(sp)
    800033a8:	01013403          	ld	s0,16(sp)
    800033ac:	00813483          	ld	s1,8(sp)
    800033b0:	00013903          	ld	s2,0(sp)
    800033b4:	02010113          	addi	sp,sp,32
    800033b8:	00008067          	ret

00000000800033bc <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    800033bc:	fe010113          	addi	sp,sp,-32
    800033c0:	00113c23          	sd	ra,24(sp)
    800033c4:	00813823          	sd	s0,16(sp)
    800033c8:	00913423          	sd	s1,8(sp)
    800033cc:	01213023          	sd	s2,0(sp)
    800033d0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800033d4:	00a00493          	li	s1,10
    800033d8:	0400006f          	j	80003418 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800033dc:	00006517          	auipc	a0,0x6
    800033e0:	c9450513          	addi	a0,a0,-876 # 80009070 <CONSOLE_STATUS+0x60>
    800033e4:	00002097          	auipc	ra,0x2
    800033e8:	bb8080e7          	jalr	-1096(ra) # 80004f9c <_Z11printStringPKc>
    800033ec:	00000613          	li	a2,0
    800033f0:	00a00593          	li	a1,10
    800033f4:	00048513          	mv	a0,s1
    800033f8:	00002097          	auipc	ra,0x2
    800033fc:	d54080e7          	jalr	-684(ra) # 8000514c <_Z8printIntiii>
    80003400:	00006517          	auipc	a0,0x6
    80003404:	fe850513          	addi	a0,a0,-24 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80003408:	00002097          	auipc	ra,0x2
    8000340c:	b94080e7          	jalr	-1132(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003410:	0014849b          	addiw	s1,s1,1
    80003414:	0ff4f493          	andi	s1,s1,255
    80003418:	00c00793          	li	a5,12
    8000341c:	fc97f0e3          	bgeu	a5,s1,800033dc <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80003420:	00006517          	auipc	a0,0x6
    80003424:	df050513          	addi	a0,a0,-528 # 80009210 <_ZZ13print_integermE6digits+0x158>
    80003428:	00002097          	auipc	ra,0x2
    8000342c:	b74080e7          	jalr	-1164(ra) # 80004f9c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003430:	00500313          	li	t1,5
    thread_dispatch();
    80003434:	ffffe097          	auipc	ra,0xffffe
    80003438:	f58080e7          	jalr	-168(ra) # 8000138c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000343c:	01000513          	li	a0,16
    80003440:	00000097          	auipc	ra,0x0
    80003444:	bf8080e7          	jalr	-1032(ra) # 80003038 <_ZL9fibonaccim>
    80003448:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000344c:	00006517          	auipc	a0,0x6
    80003450:	c1450513          	addi	a0,a0,-1004 # 80009060 <CONSOLE_STATUS+0x50>
    80003454:	00002097          	auipc	ra,0x2
    80003458:	b48080e7          	jalr	-1208(ra) # 80004f9c <_Z11printStringPKc>
    8000345c:	00000613          	li	a2,0
    80003460:	00a00593          	li	a1,10
    80003464:	0009051b          	sext.w	a0,s2
    80003468:	00002097          	auipc	ra,0x2
    8000346c:	ce4080e7          	jalr	-796(ra) # 8000514c <_Z8printIntiii>
    80003470:	00006517          	auipc	a0,0x6
    80003474:	f7850513          	addi	a0,a0,-136 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80003478:	00002097          	auipc	ra,0x2
    8000347c:	b24080e7          	jalr	-1244(ra) # 80004f9c <_Z11printStringPKc>
    80003480:	0400006f          	j	800034c0 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003484:	00006517          	auipc	a0,0x6
    80003488:	bec50513          	addi	a0,a0,-1044 # 80009070 <CONSOLE_STATUS+0x60>
    8000348c:	00002097          	auipc	ra,0x2
    80003490:	b10080e7          	jalr	-1264(ra) # 80004f9c <_Z11printStringPKc>
    80003494:	00000613          	li	a2,0
    80003498:	00a00593          	li	a1,10
    8000349c:	00048513          	mv	a0,s1
    800034a0:	00002097          	auipc	ra,0x2
    800034a4:	cac080e7          	jalr	-852(ra) # 8000514c <_Z8printIntiii>
    800034a8:	00006517          	auipc	a0,0x6
    800034ac:	f4050513          	addi	a0,a0,-192 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800034b0:	00002097          	auipc	ra,0x2
    800034b4:	aec080e7          	jalr	-1300(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 16; i++) {
    800034b8:	0014849b          	addiw	s1,s1,1
    800034bc:	0ff4f493          	andi	s1,s1,255
    800034c0:	00f00793          	li	a5,15
    800034c4:	fc97f0e3          	bgeu	a5,s1,80003484 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    800034c8:	00006517          	auipc	a0,0x6
    800034cc:	d5850513          	addi	a0,a0,-680 # 80009220 <_ZZ13print_integermE6digits+0x168>
    800034d0:	00002097          	auipc	ra,0x2
    800034d4:	acc080e7          	jalr	-1332(ra) # 80004f9c <_Z11printStringPKc>
    finishedD = true;
    800034d8:	00100793          	li	a5,1
    800034dc:	00008717          	auipc	a4,0x8
    800034e0:	1ef707a3          	sb	a5,495(a4) # 8000b6cb <_ZL9finishedD>
    thread_dispatch();
    800034e4:	ffffe097          	auipc	ra,0xffffe
    800034e8:	ea8080e7          	jalr	-344(ra) # 8000138c <_Z15thread_dispatchv>
}
    800034ec:	01813083          	ld	ra,24(sp)
    800034f0:	01013403          	ld	s0,16(sp)
    800034f4:	00813483          	ld	s1,8(sp)
    800034f8:	00013903          	ld	s2,0(sp)
    800034fc:	02010113          	addi	sp,sp,32
    80003500:	00008067          	ret

0000000080003504 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80003504:	fc010113          	addi	sp,sp,-64
    80003508:	02113c23          	sd	ra,56(sp)
    8000350c:	02813823          	sd	s0,48(sp)
    80003510:	02913423          	sd	s1,40(sp)
    80003514:	03213023          	sd	s2,32(sp)
    80003518:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    8000351c:	02000513          	li	a0,32
    80003520:	fffff097          	auipc	ra,0xfffff
    80003524:	b00080e7          	jalr	-1280(ra) # 80002020 <_Znwm>
    80003528:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    8000352c:	fffff097          	auipc	ra,0xfffff
    80003530:	c74080e7          	jalr	-908(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80003534:	00008797          	auipc	a5,0x8
    80003538:	f4478793          	addi	a5,a5,-188 # 8000b478 <_ZTV7WorkerA+0x10>
    8000353c:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80003540:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80003544:	00006517          	auipc	a0,0x6
    80003548:	cec50513          	addi	a0,a0,-788 # 80009230 <_ZZ13print_integermE6digits+0x178>
    8000354c:	00002097          	auipc	ra,0x2
    80003550:	a50080e7          	jalr	-1456(ra) # 80004f9c <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80003554:	02000513          	li	a0,32
    80003558:	fffff097          	auipc	ra,0xfffff
    8000355c:	ac8080e7          	jalr	-1336(ra) # 80002020 <_Znwm>
    80003560:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80003564:	fffff097          	auipc	ra,0xfffff
    80003568:	c3c080e7          	jalr	-964(ra) # 800021a0 <_ZN6ThreadC1Ev>
    8000356c:	00008797          	auipc	a5,0x8
    80003570:	f3478793          	addi	a5,a5,-204 # 8000b4a0 <_ZTV7WorkerB+0x10>
    80003574:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80003578:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    8000357c:	00006517          	auipc	a0,0x6
    80003580:	ccc50513          	addi	a0,a0,-820 # 80009248 <_ZZ13print_integermE6digits+0x190>
    80003584:	00002097          	auipc	ra,0x2
    80003588:	a18080e7          	jalr	-1512(ra) # 80004f9c <_Z11printStringPKc>

    threads[2] = new WorkerC();
    8000358c:	02000513          	li	a0,32
    80003590:	fffff097          	auipc	ra,0xfffff
    80003594:	a90080e7          	jalr	-1392(ra) # 80002020 <_Znwm>
    80003598:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    8000359c:	fffff097          	auipc	ra,0xfffff
    800035a0:	c04080e7          	jalr	-1020(ra) # 800021a0 <_ZN6ThreadC1Ev>
    800035a4:	00008797          	auipc	a5,0x8
    800035a8:	f2478793          	addi	a5,a5,-220 # 8000b4c8 <_ZTV7WorkerC+0x10>
    800035ac:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    800035b0:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    800035b4:	00006517          	auipc	a0,0x6
    800035b8:	cac50513          	addi	a0,a0,-852 # 80009260 <_ZZ13print_integermE6digits+0x1a8>
    800035bc:	00002097          	auipc	ra,0x2
    800035c0:	9e0080e7          	jalr	-1568(ra) # 80004f9c <_Z11printStringPKc>

    threads[3] = new WorkerD();
    800035c4:	02000513          	li	a0,32
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	a58080e7          	jalr	-1448(ra) # 80002020 <_Znwm>
    800035d0:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    800035d4:	fffff097          	auipc	ra,0xfffff
    800035d8:	bcc080e7          	jalr	-1076(ra) # 800021a0 <_ZN6ThreadC1Ev>
    800035dc:	00008797          	auipc	a5,0x8
    800035e0:	f1478793          	addi	a5,a5,-236 # 8000b4f0 <_ZTV7WorkerD+0x10>
    800035e4:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    800035e8:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    800035ec:	00006517          	auipc	a0,0x6
    800035f0:	c8c50513          	addi	a0,a0,-884 # 80009278 <_ZZ13print_integermE6digits+0x1c0>
    800035f4:	00002097          	auipc	ra,0x2
    800035f8:	9a8080e7          	jalr	-1624(ra) # 80004f9c <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    800035fc:	00000493          	li	s1,0
    80003600:	00300793          	li	a5,3
    80003604:	0297c663          	blt	a5,s1,80003630 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    80003608:	00349793          	slli	a5,s1,0x3
    8000360c:	fe040713          	addi	a4,s0,-32
    80003610:	00f707b3          	add	a5,a4,a5
    80003614:	fe07b503          	ld	a0,-32(a5)
    80003618:	fffff097          	auipc	ra,0xfffff
    8000361c:	c10080e7          	jalr	-1008(ra) # 80002228 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80003620:	0014849b          	addiw	s1,s1,1
    80003624:	fddff06f          	j	80003600 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    80003628:	fffff097          	auipc	ra,0xfffff
    8000362c:	bd8080e7          	jalr	-1064(ra) # 80002200 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80003630:	00008797          	auipc	a5,0x8
    80003634:	0987c783          	lbu	a5,152(a5) # 8000b6c8 <_ZL9finishedA>
    80003638:	fe0788e3          	beqz	a5,80003628 <_Z20Threads_CPP_API_testv+0x124>
    8000363c:	00008797          	auipc	a5,0x8
    80003640:	08d7c783          	lbu	a5,141(a5) # 8000b6c9 <_ZL9finishedB>
    80003644:	fe0782e3          	beqz	a5,80003628 <_Z20Threads_CPP_API_testv+0x124>
    80003648:	00008797          	auipc	a5,0x8
    8000364c:	0827c783          	lbu	a5,130(a5) # 8000b6ca <_ZL9finishedC>
    80003650:	fc078ce3          	beqz	a5,80003628 <_Z20Threads_CPP_API_testv+0x124>
    80003654:	00008797          	auipc	a5,0x8
    80003658:	0777c783          	lbu	a5,119(a5) # 8000b6cb <_ZL9finishedD>
    8000365c:	fc0786e3          	beqz	a5,80003628 <_Z20Threads_CPP_API_testv+0x124>
    80003660:	fc040493          	addi	s1,s0,-64
    80003664:	0080006f          	j	8000366c <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    80003668:	00848493          	addi	s1,s1,8
    8000366c:	fe040793          	addi	a5,s0,-32
    80003670:	08f48663          	beq	s1,a5,800036fc <_Z20Threads_CPP_API_testv+0x1f8>
    80003674:	0004b503          	ld	a0,0(s1)
    80003678:	fe0508e3          	beqz	a0,80003668 <_Z20Threads_CPP_API_testv+0x164>
    8000367c:	00053783          	ld	a5,0(a0)
    80003680:	0087b783          	ld	a5,8(a5)
    80003684:	000780e7          	jalr	a5
    80003688:	fe1ff06f          	j	80003668 <_Z20Threads_CPP_API_testv+0x164>
    8000368c:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    80003690:	00048513          	mv	a0,s1
    80003694:	fffff097          	auipc	ra,0xfffff
    80003698:	9b4080e7          	jalr	-1612(ra) # 80002048 <_ZdlPv>
    8000369c:	00090513          	mv	a0,s2
    800036a0:	00009097          	auipc	ra,0x9
    800036a4:	138080e7          	jalr	312(ra) # 8000c7d8 <_Unwind_Resume>
    800036a8:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    800036ac:	00048513          	mv	a0,s1
    800036b0:	fffff097          	auipc	ra,0xfffff
    800036b4:	998080e7          	jalr	-1640(ra) # 80002048 <_ZdlPv>
    800036b8:	00090513          	mv	a0,s2
    800036bc:	00009097          	auipc	ra,0x9
    800036c0:	11c080e7          	jalr	284(ra) # 8000c7d8 <_Unwind_Resume>
    800036c4:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    800036c8:	00048513          	mv	a0,s1
    800036cc:	fffff097          	auipc	ra,0xfffff
    800036d0:	97c080e7          	jalr	-1668(ra) # 80002048 <_ZdlPv>
    800036d4:	00090513          	mv	a0,s2
    800036d8:	00009097          	auipc	ra,0x9
    800036dc:	100080e7          	jalr	256(ra) # 8000c7d8 <_Unwind_Resume>
    800036e0:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    800036e4:	00048513          	mv	a0,s1
    800036e8:	fffff097          	auipc	ra,0xfffff
    800036ec:	960080e7          	jalr	-1696(ra) # 80002048 <_ZdlPv>
    800036f0:	00090513          	mv	a0,s2
    800036f4:	00009097          	auipc	ra,0x9
    800036f8:	0e4080e7          	jalr	228(ra) # 8000c7d8 <_Unwind_Resume>
}
    800036fc:	03813083          	ld	ra,56(sp)
    80003700:	03013403          	ld	s0,48(sp)
    80003704:	02813483          	ld	s1,40(sp)
    80003708:	02013903          	ld	s2,32(sp)
    8000370c:	04010113          	addi	sp,sp,64
    80003710:	00008067          	ret

0000000080003714 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80003714:	ff010113          	addi	sp,sp,-16
    80003718:	00113423          	sd	ra,8(sp)
    8000371c:	00813023          	sd	s0,0(sp)
    80003720:	01010413          	addi	s0,sp,16
    80003724:	00008797          	auipc	a5,0x8
    80003728:	d5478793          	addi	a5,a5,-684 # 8000b478 <_ZTV7WorkerA+0x10>
    8000372c:	00f53023          	sd	a5,0(a0)
    80003730:	fffff097          	auipc	ra,0xfffff
    80003734:	940080e7          	jalr	-1728(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003738:	00813083          	ld	ra,8(sp)
    8000373c:	00013403          	ld	s0,0(sp)
    80003740:	01010113          	addi	sp,sp,16
    80003744:	00008067          	ret

0000000080003748 <_ZN7WorkerAD0Ev>:
    80003748:	fe010113          	addi	sp,sp,-32
    8000374c:	00113c23          	sd	ra,24(sp)
    80003750:	00813823          	sd	s0,16(sp)
    80003754:	00913423          	sd	s1,8(sp)
    80003758:	02010413          	addi	s0,sp,32
    8000375c:	00050493          	mv	s1,a0
    80003760:	00008797          	auipc	a5,0x8
    80003764:	d1878793          	addi	a5,a5,-744 # 8000b478 <_ZTV7WorkerA+0x10>
    80003768:	00f53023          	sd	a5,0(a0)
    8000376c:	fffff097          	auipc	ra,0xfffff
    80003770:	904080e7          	jalr	-1788(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003774:	00048513          	mv	a0,s1
    80003778:	fffff097          	auipc	ra,0xfffff
    8000377c:	8d0080e7          	jalr	-1840(ra) # 80002048 <_ZdlPv>
    80003780:	01813083          	ld	ra,24(sp)
    80003784:	01013403          	ld	s0,16(sp)
    80003788:	00813483          	ld	s1,8(sp)
    8000378c:	02010113          	addi	sp,sp,32
    80003790:	00008067          	ret

0000000080003794 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80003794:	ff010113          	addi	sp,sp,-16
    80003798:	00113423          	sd	ra,8(sp)
    8000379c:	00813023          	sd	s0,0(sp)
    800037a0:	01010413          	addi	s0,sp,16
    800037a4:	00008797          	auipc	a5,0x8
    800037a8:	cfc78793          	addi	a5,a5,-772 # 8000b4a0 <_ZTV7WorkerB+0x10>
    800037ac:	00f53023          	sd	a5,0(a0)
    800037b0:	fffff097          	auipc	ra,0xfffff
    800037b4:	8c0080e7          	jalr	-1856(ra) # 80002070 <_ZN6ThreadD1Ev>
    800037b8:	00813083          	ld	ra,8(sp)
    800037bc:	00013403          	ld	s0,0(sp)
    800037c0:	01010113          	addi	sp,sp,16
    800037c4:	00008067          	ret

00000000800037c8 <_ZN7WorkerBD0Ev>:
    800037c8:	fe010113          	addi	sp,sp,-32
    800037cc:	00113c23          	sd	ra,24(sp)
    800037d0:	00813823          	sd	s0,16(sp)
    800037d4:	00913423          	sd	s1,8(sp)
    800037d8:	02010413          	addi	s0,sp,32
    800037dc:	00050493          	mv	s1,a0
    800037e0:	00008797          	auipc	a5,0x8
    800037e4:	cc078793          	addi	a5,a5,-832 # 8000b4a0 <_ZTV7WorkerB+0x10>
    800037e8:	00f53023          	sd	a5,0(a0)
    800037ec:	fffff097          	auipc	ra,0xfffff
    800037f0:	884080e7          	jalr	-1916(ra) # 80002070 <_ZN6ThreadD1Ev>
    800037f4:	00048513          	mv	a0,s1
    800037f8:	fffff097          	auipc	ra,0xfffff
    800037fc:	850080e7          	jalr	-1968(ra) # 80002048 <_ZdlPv>
    80003800:	01813083          	ld	ra,24(sp)
    80003804:	01013403          	ld	s0,16(sp)
    80003808:	00813483          	ld	s1,8(sp)
    8000380c:	02010113          	addi	sp,sp,32
    80003810:	00008067          	ret

0000000080003814 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80003814:	ff010113          	addi	sp,sp,-16
    80003818:	00113423          	sd	ra,8(sp)
    8000381c:	00813023          	sd	s0,0(sp)
    80003820:	01010413          	addi	s0,sp,16
    80003824:	00008797          	auipc	a5,0x8
    80003828:	ca478793          	addi	a5,a5,-860 # 8000b4c8 <_ZTV7WorkerC+0x10>
    8000382c:	00f53023          	sd	a5,0(a0)
    80003830:	fffff097          	auipc	ra,0xfffff
    80003834:	840080e7          	jalr	-1984(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003838:	00813083          	ld	ra,8(sp)
    8000383c:	00013403          	ld	s0,0(sp)
    80003840:	01010113          	addi	sp,sp,16
    80003844:	00008067          	ret

0000000080003848 <_ZN7WorkerCD0Ev>:
    80003848:	fe010113          	addi	sp,sp,-32
    8000384c:	00113c23          	sd	ra,24(sp)
    80003850:	00813823          	sd	s0,16(sp)
    80003854:	00913423          	sd	s1,8(sp)
    80003858:	02010413          	addi	s0,sp,32
    8000385c:	00050493          	mv	s1,a0
    80003860:	00008797          	auipc	a5,0x8
    80003864:	c6878793          	addi	a5,a5,-920 # 8000b4c8 <_ZTV7WorkerC+0x10>
    80003868:	00f53023          	sd	a5,0(a0)
    8000386c:	fffff097          	auipc	ra,0xfffff
    80003870:	804080e7          	jalr	-2044(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003874:	00048513          	mv	a0,s1
    80003878:	ffffe097          	auipc	ra,0xffffe
    8000387c:	7d0080e7          	jalr	2000(ra) # 80002048 <_ZdlPv>
    80003880:	01813083          	ld	ra,24(sp)
    80003884:	01013403          	ld	s0,16(sp)
    80003888:	00813483          	ld	s1,8(sp)
    8000388c:	02010113          	addi	sp,sp,32
    80003890:	00008067          	ret

0000000080003894 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80003894:	ff010113          	addi	sp,sp,-16
    80003898:	00113423          	sd	ra,8(sp)
    8000389c:	00813023          	sd	s0,0(sp)
    800038a0:	01010413          	addi	s0,sp,16
    800038a4:	00008797          	auipc	a5,0x8
    800038a8:	c4c78793          	addi	a5,a5,-948 # 8000b4f0 <_ZTV7WorkerD+0x10>
    800038ac:	00f53023          	sd	a5,0(a0)
    800038b0:	ffffe097          	auipc	ra,0xffffe
    800038b4:	7c0080e7          	jalr	1984(ra) # 80002070 <_ZN6ThreadD1Ev>
    800038b8:	00813083          	ld	ra,8(sp)
    800038bc:	00013403          	ld	s0,0(sp)
    800038c0:	01010113          	addi	sp,sp,16
    800038c4:	00008067          	ret

00000000800038c8 <_ZN7WorkerDD0Ev>:
    800038c8:	fe010113          	addi	sp,sp,-32
    800038cc:	00113c23          	sd	ra,24(sp)
    800038d0:	00813823          	sd	s0,16(sp)
    800038d4:	00913423          	sd	s1,8(sp)
    800038d8:	02010413          	addi	s0,sp,32
    800038dc:	00050493          	mv	s1,a0
    800038e0:	00008797          	auipc	a5,0x8
    800038e4:	c1078793          	addi	a5,a5,-1008 # 8000b4f0 <_ZTV7WorkerD+0x10>
    800038e8:	00f53023          	sd	a5,0(a0)
    800038ec:	ffffe097          	auipc	ra,0xffffe
    800038f0:	784080e7          	jalr	1924(ra) # 80002070 <_ZN6ThreadD1Ev>
    800038f4:	00048513          	mv	a0,s1
    800038f8:	ffffe097          	auipc	ra,0xffffe
    800038fc:	750080e7          	jalr	1872(ra) # 80002048 <_ZdlPv>
    80003900:	01813083          	ld	ra,24(sp)
    80003904:	01013403          	ld	s0,16(sp)
    80003908:	00813483          	ld	s1,8(sp)
    8000390c:	02010113          	addi	sp,sp,32
    80003910:	00008067          	ret

0000000080003914 <_ZN7WorkerA3runEv>:
    void run() override {
    80003914:	ff010113          	addi	sp,sp,-16
    80003918:	00113423          	sd	ra,8(sp)
    8000391c:	00813023          	sd	s0,0(sp)
    80003920:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80003924:	00000593          	li	a1,0
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	784080e7          	jalr	1924(ra) # 800030ac <_ZN7WorkerA11workerBodyAEPv>
    }
    80003930:	00813083          	ld	ra,8(sp)
    80003934:	00013403          	ld	s0,0(sp)
    80003938:	01010113          	addi	sp,sp,16
    8000393c:	00008067          	ret

0000000080003940 <_ZN7WorkerB3runEv>:
    void run() override {
    80003940:	ff010113          	addi	sp,sp,-16
    80003944:	00113423          	sd	ra,8(sp)
    80003948:	00813023          	sd	s0,0(sp)
    8000394c:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80003950:	00000593          	li	a1,0
    80003954:	00000097          	auipc	ra,0x0
    80003958:	81c080e7          	jalr	-2020(ra) # 80003170 <_ZN7WorkerB11workerBodyBEPv>
    }
    8000395c:	00813083          	ld	ra,8(sp)
    80003960:	00013403          	ld	s0,0(sp)
    80003964:	01010113          	addi	sp,sp,16
    80003968:	00008067          	ret

000000008000396c <_ZN7WorkerC3runEv>:
    void run() override {
    8000396c:	ff010113          	addi	sp,sp,-16
    80003970:	00113423          	sd	ra,8(sp)
    80003974:	00813023          	sd	s0,0(sp)
    80003978:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    8000397c:	00000593          	li	a1,0
    80003980:	00000097          	auipc	ra,0x0
    80003984:	8bc080e7          	jalr	-1860(ra) # 8000323c <_ZN7WorkerC11workerBodyCEPv>
    }
    80003988:	00813083          	ld	ra,8(sp)
    8000398c:	00013403          	ld	s0,0(sp)
    80003990:	01010113          	addi	sp,sp,16
    80003994:	00008067          	ret

0000000080003998 <_ZN7WorkerD3runEv>:
    void run() override {
    80003998:	ff010113          	addi	sp,sp,-16
    8000399c:	00113423          	sd	ra,8(sp)
    800039a0:	00813023          	sd	s0,0(sp)
    800039a4:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800039a8:	00000593          	li	a1,0
    800039ac:	00000097          	auipc	ra,0x0
    800039b0:	a10080e7          	jalr	-1520(ra) # 800033bc <_ZN7WorkerD11workerBodyDEPv>
    }
    800039b4:	00813083          	ld	ra,8(sp)
    800039b8:	00013403          	ld	s0,0(sp)
    800039bc:	01010113          	addi	sp,sp,16
    800039c0:	00008067          	ret

00000000800039c4 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800039c4:	f8010113          	addi	sp,sp,-128
    800039c8:	06113c23          	sd	ra,120(sp)
    800039cc:	06813823          	sd	s0,112(sp)
    800039d0:	06913423          	sd	s1,104(sp)
    800039d4:	07213023          	sd	s2,96(sp)
    800039d8:	05313c23          	sd	s3,88(sp)
    800039dc:	05413823          	sd	s4,80(sp)
    800039e0:	05513423          	sd	s5,72(sp)
    800039e4:	05613023          	sd	s6,64(sp)
    800039e8:	03713c23          	sd	s7,56(sp)
    800039ec:	03813823          	sd	s8,48(sp)
    800039f0:	03913423          	sd	s9,40(sp)
    800039f4:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    800039f8:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    800039fc:	00005517          	auipc	a0,0x5
    80003a00:	6cc50513          	addi	a0,a0,1740 # 800090c8 <_ZZ13print_integermE6digits+0x10>
    80003a04:	00001097          	auipc	ra,0x1
    80003a08:	598080e7          	jalr	1432(ra) # 80004f9c <_Z11printStringPKc>
    getString(input, 30);
    80003a0c:	01e00593          	li	a1,30
    80003a10:	f8040493          	addi	s1,s0,-128
    80003a14:	00048513          	mv	a0,s1
    80003a18:	00001097          	auipc	ra,0x1
    80003a1c:	60c080e7          	jalr	1548(ra) # 80005024 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003a20:	00048513          	mv	a0,s1
    80003a24:	00001097          	auipc	ra,0x1
    80003a28:	6d8080e7          	jalr	1752(ra) # 800050fc <_Z11stringToIntPKc>
    80003a2c:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80003a30:	00005517          	auipc	a0,0x5
    80003a34:	6b850513          	addi	a0,a0,1720 # 800090e8 <_ZZ13print_integermE6digits+0x30>
    80003a38:	00001097          	auipc	ra,0x1
    80003a3c:	564080e7          	jalr	1380(ra) # 80004f9c <_Z11printStringPKc>
    getString(input, 30);
    80003a40:	01e00593          	li	a1,30
    80003a44:	00048513          	mv	a0,s1
    80003a48:	00001097          	auipc	ra,0x1
    80003a4c:	5dc080e7          	jalr	1500(ra) # 80005024 <_Z9getStringPci>
    n = stringToInt(input);
    80003a50:	00048513          	mv	a0,s1
    80003a54:	00001097          	auipc	ra,0x1
    80003a58:	6a8080e7          	jalr	1704(ra) # 800050fc <_Z11stringToIntPKc>
    80003a5c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80003a60:	00005517          	auipc	a0,0x5
    80003a64:	6a850513          	addi	a0,a0,1704 # 80009108 <_ZZ13print_integermE6digits+0x50>
    80003a68:	00001097          	auipc	ra,0x1
    80003a6c:	534080e7          	jalr	1332(ra) # 80004f9c <_Z11printStringPKc>
    printInt(threadNum);
    80003a70:	00000613          	li	a2,0
    80003a74:	00a00593          	li	a1,10
    80003a78:	00098513          	mv	a0,s3
    80003a7c:	00001097          	auipc	ra,0x1
    80003a80:	6d0080e7          	jalr	1744(ra) # 8000514c <_Z8printIntiii>
    printString(" i velicina bafera ");
    80003a84:	00005517          	auipc	a0,0x5
    80003a88:	69c50513          	addi	a0,a0,1692 # 80009120 <_ZZ13print_integermE6digits+0x68>
    80003a8c:	00001097          	auipc	ra,0x1
    80003a90:	510080e7          	jalr	1296(ra) # 80004f9c <_Z11printStringPKc>
    printInt(n);
    80003a94:	00000613          	li	a2,0
    80003a98:	00a00593          	li	a1,10
    80003a9c:	00048513          	mv	a0,s1
    80003aa0:	00001097          	auipc	ra,0x1
    80003aa4:	6ac080e7          	jalr	1708(ra) # 8000514c <_Z8printIntiii>
    printString(".\n");
    80003aa8:	00005517          	auipc	a0,0x5
    80003aac:	69050513          	addi	a0,a0,1680 # 80009138 <_ZZ13print_integermE6digits+0x80>
    80003ab0:	00001097          	auipc	ra,0x1
    80003ab4:	4ec080e7          	jalr	1260(ra) # 80004f9c <_Z11printStringPKc>
    if (threadNum > n) {
    80003ab8:	0334c463          	blt	s1,s3,80003ae0 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    80003abc:	03305c63          	blez	s3,80003af4 <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80003ac0:	03800513          	li	a0,56
    80003ac4:	ffffe097          	auipc	ra,0xffffe
    80003ac8:	55c080e7          	jalr	1372(ra) # 80002020 <_Znwm>
    80003acc:	00050a93          	mv	s5,a0
    80003ad0:	00048593          	mv	a1,s1
    80003ad4:	00001097          	auipc	ra,0x1
    80003ad8:	798080e7          	jalr	1944(ra) # 8000526c <_ZN9BufferCPPC1Ei>
    80003adc:	0300006f          	j	80003b0c <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003ae0:	00005517          	auipc	a0,0x5
    80003ae4:	66050513          	addi	a0,a0,1632 # 80009140 <_ZZ13print_integermE6digits+0x88>
    80003ae8:	00001097          	auipc	ra,0x1
    80003aec:	4b4080e7          	jalr	1204(ra) # 80004f9c <_Z11printStringPKc>
        return;
    80003af0:	0140006f          	j	80003b04 <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003af4:	00005517          	auipc	a0,0x5
    80003af8:	68c50513          	addi	a0,a0,1676 # 80009180 <_ZZ13print_integermE6digits+0xc8>
    80003afc:	00001097          	auipc	ra,0x1
    80003b00:	4a0080e7          	jalr	1184(ra) # 80004f9c <_Z11printStringPKc>
        return;
    80003b04:	000c0113          	mv	sp,s8
    80003b08:	2140006f          	j	80003d1c <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    80003b0c:	01000513          	li	a0,16
    80003b10:	ffffe097          	auipc	ra,0xffffe
    80003b14:	510080e7          	jalr	1296(ra) # 80002020 <_Znwm>
    80003b18:	00050913          	mv	s2,a0
    80003b1c:	00000593          	li	a1,0
    80003b20:	ffffe097          	auipc	ra,0xffffe
    80003b24:	764080e7          	jalr	1892(ra) # 80002284 <_ZN9SemaphoreC1Ej>
    80003b28:	00008797          	auipc	a5,0x8
    80003b2c:	bb27b823          	sd	s2,-1104(a5) # 8000b6d8 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80003b30:	00399793          	slli	a5,s3,0x3
    80003b34:	00f78793          	addi	a5,a5,15
    80003b38:	ff07f793          	andi	a5,a5,-16
    80003b3c:	40f10133          	sub	sp,sp,a5
    80003b40:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80003b44:	0019871b          	addiw	a4,s3,1
    80003b48:	00171793          	slli	a5,a4,0x1
    80003b4c:	00e787b3          	add	a5,a5,a4
    80003b50:	00379793          	slli	a5,a5,0x3
    80003b54:	00f78793          	addi	a5,a5,15
    80003b58:	ff07f793          	andi	a5,a5,-16
    80003b5c:	40f10133          	sub	sp,sp,a5
    80003b60:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    80003b64:	00199493          	slli	s1,s3,0x1
    80003b68:	013484b3          	add	s1,s1,s3
    80003b6c:	00349493          	slli	s1,s1,0x3
    80003b70:	009b04b3          	add	s1,s6,s1
    80003b74:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    80003b78:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80003b7c:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80003b80:	02800513          	li	a0,40
    80003b84:	ffffe097          	auipc	ra,0xffffe
    80003b88:	49c080e7          	jalr	1180(ra) # 80002020 <_Znwm>
    80003b8c:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    80003b90:	ffffe097          	auipc	ra,0xffffe
    80003b94:	610080e7          	jalr	1552(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80003b98:	00008797          	auipc	a5,0x8
    80003b9c:	9d078793          	addi	a5,a5,-1584 # 8000b568 <_ZTV8Consumer+0x10>
    80003ba0:	00fbb023          	sd	a5,0(s7)
    80003ba4:	029bb023          	sd	s1,32(s7)
    consumer->start();
    80003ba8:	000b8513          	mv	a0,s7
    80003bac:	ffffe097          	auipc	ra,0xffffe
    80003bb0:	67c080e7          	jalr	1660(ra) # 80002228 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    80003bb4:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    80003bb8:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    80003bbc:	00008797          	auipc	a5,0x8
    80003bc0:	b1c7b783          	ld	a5,-1252(a5) # 8000b6d8 <_ZL10waitForAll>
    80003bc4:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003bc8:	02800513          	li	a0,40
    80003bcc:	ffffe097          	auipc	ra,0xffffe
    80003bd0:	454080e7          	jalr	1108(ra) # 80002020 <_Znwm>
    80003bd4:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    80003bd8:	ffffe097          	auipc	ra,0xffffe
    80003bdc:	5c8080e7          	jalr	1480(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80003be0:	00008797          	auipc	a5,0x8
    80003be4:	93878793          	addi	a5,a5,-1736 # 8000b518 <_ZTV16ProducerKeyborad+0x10>
    80003be8:	00f4b023          	sd	a5,0(s1)
    80003bec:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003bf0:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    80003bf4:	00048513          	mv	a0,s1
    80003bf8:	ffffe097          	auipc	ra,0xffffe
    80003bfc:	630080e7          	jalr	1584(ra) # 80002228 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80003c00:	00100913          	li	s2,1
    80003c04:	0300006f          	j	80003c34 <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80003c08:	00008797          	auipc	a5,0x8
    80003c0c:	93878793          	addi	a5,a5,-1736 # 8000b540 <_ZTV8Producer+0x10>
    80003c10:	00fcb023          	sd	a5,0(s9)
    80003c14:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    80003c18:	00391793          	slli	a5,s2,0x3
    80003c1c:	00fa07b3          	add	a5,s4,a5
    80003c20:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    80003c24:	000c8513          	mv	a0,s9
    80003c28:	ffffe097          	auipc	ra,0xffffe
    80003c2c:	600080e7          	jalr	1536(ra) # 80002228 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80003c30:	0019091b          	addiw	s2,s2,1
    80003c34:	05395263          	bge	s2,s3,80003c78 <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    80003c38:	00191493          	slli	s1,s2,0x1
    80003c3c:	012484b3          	add	s1,s1,s2
    80003c40:	00349493          	slli	s1,s1,0x3
    80003c44:	009b04b3          	add	s1,s6,s1
    80003c48:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80003c4c:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80003c50:	00008797          	auipc	a5,0x8
    80003c54:	a887b783          	ld	a5,-1400(a5) # 8000b6d8 <_ZL10waitForAll>
    80003c58:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80003c5c:	02800513          	li	a0,40
    80003c60:	ffffe097          	auipc	ra,0xffffe
    80003c64:	3c0080e7          	jalr	960(ra) # 80002020 <_Znwm>
    80003c68:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80003c6c:	ffffe097          	auipc	ra,0xffffe
    80003c70:	534080e7          	jalr	1332(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80003c74:	f95ff06f          	j	80003c08 <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    80003c78:	ffffe097          	auipc	ra,0xffffe
    80003c7c:	588080e7          	jalr	1416(ra) # 80002200 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80003c80:	00000493          	li	s1,0
    80003c84:	0099ce63          	blt	s3,s1,80003ca0 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    80003c88:	00008517          	auipc	a0,0x8
    80003c8c:	a5053503          	ld	a0,-1456(a0) # 8000b6d8 <_ZL10waitForAll>
    80003c90:	ffffe097          	auipc	ra,0xffffe
    80003c94:	62c080e7          	jalr	1580(ra) # 800022bc <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80003c98:	0014849b          	addiw	s1,s1,1
    80003c9c:	fe9ff06f          	j	80003c84 <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    80003ca0:	00008517          	auipc	a0,0x8
    80003ca4:	a3853503          	ld	a0,-1480(a0) # 8000b6d8 <_ZL10waitForAll>
    80003ca8:	00050863          	beqz	a0,80003cb8 <_Z20testConsumerProducerv+0x2f4>
    80003cac:	00053783          	ld	a5,0(a0)
    80003cb0:	0087b783          	ld	a5,8(a5)
    80003cb4:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    80003cb8:	00000493          	li	s1,0
    80003cbc:	0080006f          	j	80003cc4 <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    80003cc0:	0014849b          	addiw	s1,s1,1
    80003cc4:	0334d263          	bge	s1,s3,80003ce8 <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    80003cc8:	00349793          	slli	a5,s1,0x3
    80003ccc:	00fa07b3          	add	a5,s4,a5
    80003cd0:	0007b503          	ld	a0,0(a5)
    80003cd4:	fe0506e3          	beqz	a0,80003cc0 <_Z20testConsumerProducerv+0x2fc>
    80003cd8:	00053783          	ld	a5,0(a0)
    80003cdc:	0087b783          	ld	a5,8(a5)
    80003ce0:	000780e7          	jalr	a5
    80003ce4:	fddff06f          	j	80003cc0 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    80003ce8:	000b8a63          	beqz	s7,80003cfc <_Z20testConsumerProducerv+0x338>
    80003cec:	000bb783          	ld	a5,0(s7)
    80003cf0:	0087b783          	ld	a5,8(a5)
    80003cf4:	000b8513          	mv	a0,s7
    80003cf8:	000780e7          	jalr	a5
    delete buffer;
    80003cfc:	000a8e63          	beqz	s5,80003d18 <_Z20testConsumerProducerv+0x354>
    80003d00:	000a8513          	mv	a0,s5
    80003d04:	00002097          	auipc	ra,0x2
    80003d08:	860080e7          	jalr	-1952(ra) # 80005564 <_ZN9BufferCPPD1Ev>
    80003d0c:	000a8513          	mv	a0,s5
    80003d10:	ffffe097          	auipc	ra,0xffffe
    80003d14:	338080e7          	jalr	824(ra) # 80002048 <_ZdlPv>
    80003d18:	000c0113          	mv	sp,s8
}
    80003d1c:	f8040113          	addi	sp,s0,-128
    80003d20:	07813083          	ld	ra,120(sp)
    80003d24:	07013403          	ld	s0,112(sp)
    80003d28:	06813483          	ld	s1,104(sp)
    80003d2c:	06013903          	ld	s2,96(sp)
    80003d30:	05813983          	ld	s3,88(sp)
    80003d34:	05013a03          	ld	s4,80(sp)
    80003d38:	04813a83          	ld	s5,72(sp)
    80003d3c:	04013b03          	ld	s6,64(sp)
    80003d40:	03813b83          	ld	s7,56(sp)
    80003d44:	03013c03          	ld	s8,48(sp)
    80003d48:	02813c83          	ld	s9,40(sp)
    80003d4c:	08010113          	addi	sp,sp,128
    80003d50:	00008067          	ret
    80003d54:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80003d58:	000a8513          	mv	a0,s5
    80003d5c:	ffffe097          	auipc	ra,0xffffe
    80003d60:	2ec080e7          	jalr	748(ra) # 80002048 <_ZdlPv>
    80003d64:	00048513          	mv	a0,s1
    80003d68:	00009097          	auipc	ra,0x9
    80003d6c:	a70080e7          	jalr	-1424(ra) # 8000c7d8 <_Unwind_Resume>
    80003d70:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80003d74:	00090513          	mv	a0,s2
    80003d78:	ffffe097          	auipc	ra,0xffffe
    80003d7c:	2d0080e7          	jalr	720(ra) # 80002048 <_ZdlPv>
    80003d80:	00048513          	mv	a0,s1
    80003d84:	00009097          	auipc	ra,0x9
    80003d88:	a54080e7          	jalr	-1452(ra) # 8000c7d8 <_Unwind_Resume>
    80003d8c:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80003d90:	000b8513          	mv	a0,s7
    80003d94:	ffffe097          	auipc	ra,0xffffe
    80003d98:	2b4080e7          	jalr	692(ra) # 80002048 <_ZdlPv>
    80003d9c:	00048513          	mv	a0,s1
    80003da0:	00009097          	auipc	ra,0x9
    80003da4:	a38080e7          	jalr	-1480(ra) # 8000c7d8 <_Unwind_Resume>
    80003da8:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80003dac:	00048513          	mv	a0,s1
    80003db0:	ffffe097          	auipc	ra,0xffffe
    80003db4:	298080e7          	jalr	664(ra) # 80002048 <_ZdlPv>
    80003db8:	00090513          	mv	a0,s2
    80003dbc:	00009097          	auipc	ra,0x9
    80003dc0:	a1c080e7          	jalr	-1508(ra) # 8000c7d8 <_Unwind_Resume>
    80003dc4:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    80003dc8:	000c8513          	mv	a0,s9
    80003dcc:	ffffe097          	auipc	ra,0xffffe
    80003dd0:	27c080e7          	jalr	636(ra) # 80002048 <_ZdlPv>
    80003dd4:	00048513          	mv	a0,s1
    80003dd8:	00009097          	auipc	ra,0x9
    80003ddc:	a00080e7          	jalr	-1536(ra) # 8000c7d8 <_Unwind_Resume>

0000000080003de0 <_ZN8Consumer3runEv>:
    void run() override {
    80003de0:	fd010113          	addi	sp,sp,-48
    80003de4:	02113423          	sd	ra,40(sp)
    80003de8:	02813023          	sd	s0,32(sp)
    80003dec:	00913c23          	sd	s1,24(sp)
    80003df0:	01213823          	sd	s2,16(sp)
    80003df4:	01313423          	sd	s3,8(sp)
    80003df8:	03010413          	addi	s0,sp,48
    80003dfc:	00050913          	mv	s2,a0
        int i = 0;
    80003e00:	00000993          	li	s3,0
    80003e04:	0100006f          	j	80003e14 <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    80003e08:	00a00513          	li	a0,10
    80003e0c:	ffffe097          	auipc	ra,0xffffe
    80003e10:	538080e7          	jalr	1336(ra) # 80002344 <_ZN7Console4putcEc>
        while (!threadEnd) {
    80003e14:	00008797          	auipc	a5,0x8
    80003e18:	8bc7a783          	lw	a5,-1860(a5) # 8000b6d0 <_ZL9threadEnd>
    80003e1c:	04079a63          	bnez	a5,80003e70 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80003e20:	02093783          	ld	a5,32(s2)
    80003e24:	0087b503          	ld	a0,8(a5)
    80003e28:	00001097          	auipc	ra,0x1
    80003e2c:	628080e7          	jalr	1576(ra) # 80005450 <_ZN9BufferCPP3getEv>
            i++;
    80003e30:	0019849b          	addiw	s1,s3,1
    80003e34:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    80003e38:	0ff57513          	andi	a0,a0,255
    80003e3c:	ffffe097          	auipc	ra,0xffffe
    80003e40:	508080e7          	jalr	1288(ra) # 80002344 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80003e44:	05000793          	li	a5,80
    80003e48:	02f4e4bb          	remw	s1,s1,a5
    80003e4c:	fc0494e3          	bnez	s1,80003e14 <_ZN8Consumer3runEv+0x34>
    80003e50:	fb9ff06f          	j	80003e08 <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80003e54:	02093783          	ld	a5,32(s2)
    80003e58:	0087b503          	ld	a0,8(a5)
    80003e5c:	00001097          	auipc	ra,0x1
    80003e60:	5f4080e7          	jalr	1524(ra) # 80005450 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    80003e64:	0ff57513          	andi	a0,a0,255
    80003e68:	ffffe097          	auipc	ra,0xffffe
    80003e6c:	4dc080e7          	jalr	1244(ra) # 80002344 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    80003e70:	02093783          	ld	a5,32(s2)
    80003e74:	0087b503          	ld	a0,8(a5)
    80003e78:	00001097          	auipc	ra,0x1
    80003e7c:	664080e7          	jalr	1636(ra) # 800054dc <_ZN9BufferCPP6getCntEv>
    80003e80:	fca04ae3          	bgtz	a0,80003e54 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80003e84:	02093783          	ld	a5,32(s2)
    80003e88:	0107b503          	ld	a0,16(a5)
    80003e8c:	ffffe097          	auipc	ra,0xffffe
    80003e90:	460080e7          	jalr	1120(ra) # 800022ec <_ZN9Semaphore6signalEv>
    }
    80003e94:	02813083          	ld	ra,40(sp)
    80003e98:	02013403          	ld	s0,32(sp)
    80003e9c:	01813483          	ld	s1,24(sp)
    80003ea0:	01013903          	ld	s2,16(sp)
    80003ea4:	00813983          	ld	s3,8(sp)
    80003ea8:	03010113          	addi	sp,sp,48
    80003eac:	00008067          	ret

0000000080003eb0 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    80003eb0:	ff010113          	addi	sp,sp,-16
    80003eb4:	00113423          	sd	ra,8(sp)
    80003eb8:	00813023          	sd	s0,0(sp)
    80003ebc:	01010413          	addi	s0,sp,16
    80003ec0:	00007797          	auipc	a5,0x7
    80003ec4:	6a878793          	addi	a5,a5,1704 # 8000b568 <_ZTV8Consumer+0x10>
    80003ec8:	00f53023          	sd	a5,0(a0)
    80003ecc:	ffffe097          	auipc	ra,0xffffe
    80003ed0:	1a4080e7          	jalr	420(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003ed4:	00813083          	ld	ra,8(sp)
    80003ed8:	00013403          	ld	s0,0(sp)
    80003edc:	01010113          	addi	sp,sp,16
    80003ee0:	00008067          	ret

0000000080003ee4 <_ZN8ConsumerD0Ev>:
    80003ee4:	fe010113          	addi	sp,sp,-32
    80003ee8:	00113c23          	sd	ra,24(sp)
    80003eec:	00813823          	sd	s0,16(sp)
    80003ef0:	00913423          	sd	s1,8(sp)
    80003ef4:	02010413          	addi	s0,sp,32
    80003ef8:	00050493          	mv	s1,a0
    80003efc:	00007797          	auipc	a5,0x7
    80003f00:	66c78793          	addi	a5,a5,1644 # 8000b568 <_ZTV8Consumer+0x10>
    80003f04:	00f53023          	sd	a5,0(a0)
    80003f08:	ffffe097          	auipc	ra,0xffffe
    80003f0c:	168080e7          	jalr	360(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003f10:	00048513          	mv	a0,s1
    80003f14:	ffffe097          	auipc	ra,0xffffe
    80003f18:	134080e7          	jalr	308(ra) # 80002048 <_ZdlPv>
    80003f1c:	01813083          	ld	ra,24(sp)
    80003f20:	01013403          	ld	s0,16(sp)
    80003f24:	00813483          	ld	s1,8(sp)
    80003f28:	02010113          	addi	sp,sp,32
    80003f2c:	00008067          	ret

0000000080003f30 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80003f30:	ff010113          	addi	sp,sp,-16
    80003f34:	00113423          	sd	ra,8(sp)
    80003f38:	00813023          	sd	s0,0(sp)
    80003f3c:	01010413          	addi	s0,sp,16
    80003f40:	00007797          	auipc	a5,0x7
    80003f44:	5d878793          	addi	a5,a5,1496 # 8000b518 <_ZTV16ProducerKeyborad+0x10>
    80003f48:	00f53023          	sd	a5,0(a0)
    80003f4c:	ffffe097          	auipc	ra,0xffffe
    80003f50:	124080e7          	jalr	292(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003f54:	00813083          	ld	ra,8(sp)
    80003f58:	00013403          	ld	s0,0(sp)
    80003f5c:	01010113          	addi	sp,sp,16
    80003f60:	00008067          	ret

0000000080003f64 <_ZN16ProducerKeyboradD0Ev>:
    80003f64:	fe010113          	addi	sp,sp,-32
    80003f68:	00113c23          	sd	ra,24(sp)
    80003f6c:	00813823          	sd	s0,16(sp)
    80003f70:	00913423          	sd	s1,8(sp)
    80003f74:	02010413          	addi	s0,sp,32
    80003f78:	00050493          	mv	s1,a0
    80003f7c:	00007797          	auipc	a5,0x7
    80003f80:	59c78793          	addi	a5,a5,1436 # 8000b518 <_ZTV16ProducerKeyborad+0x10>
    80003f84:	00f53023          	sd	a5,0(a0)
    80003f88:	ffffe097          	auipc	ra,0xffffe
    80003f8c:	0e8080e7          	jalr	232(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003f90:	00048513          	mv	a0,s1
    80003f94:	ffffe097          	auipc	ra,0xffffe
    80003f98:	0b4080e7          	jalr	180(ra) # 80002048 <_ZdlPv>
    80003f9c:	01813083          	ld	ra,24(sp)
    80003fa0:	01013403          	ld	s0,16(sp)
    80003fa4:	00813483          	ld	s1,8(sp)
    80003fa8:	02010113          	addi	sp,sp,32
    80003fac:	00008067          	ret

0000000080003fb0 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    80003fb0:	ff010113          	addi	sp,sp,-16
    80003fb4:	00113423          	sd	ra,8(sp)
    80003fb8:	00813023          	sd	s0,0(sp)
    80003fbc:	01010413          	addi	s0,sp,16
    80003fc0:	00007797          	auipc	a5,0x7
    80003fc4:	58078793          	addi	a5,a5,1408 # 8000b540 <_ZTV8Producer+0x10>
    80003fc8:	00f53023          	sd	a5,0(a0)
    80003fcc:	ffffe097          	auipc	ra,0xffffe
    80003fd0:	0a4080e7          	jalr	164(ra) # 80002070 <_ZN6ThreadD1Ev>
    80003fd4:	00813083          	ld	ra,8(sp)
    80003fd8:	00013403          	ld	s0,0(sp)
    80003fdc:	01010113          	addi	sp,sp,16
    80003fe0:	00008067          	ret

0000000080003fe4 <_ZN8ProducerD0Ev>:
    80003fe4:	fe010113          	addi	sp,sp,-32
    80003fe8:	00113c23          	sd	ra,24(sp)
    80003fec:	00813823          	sd	s0,16(sp)
    80003ff0:	00913423          	sd	s1,8(sp)
    80003ff4:	02010413          	addi	s0,sp,32
    80003ff8:	00050493          	mv	s1,a0
    80003ffc:	00007797          	auipc	a5,0x7
    80004000:	54478793          	addi	a5,a5,1348 # 8000b540 <_ZTV8Producer+0x10>
    80004004:	00f53023          	sd	a5,0(a0)
    80004008:	ffffe097          	auipc	ra,0xffffe
    8000400c:	068080e7          	jalr	104(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004010:	00048513          	mv	a0,s1
    80004014:	ffffe097          	auipc	ra,0xffffe
    80004018:	034080e7          	jalr	52(ra) # 80002048 <_ZdlPv>
    8000401c:	01813083          	ld	ra,24(sp)
    80004020:	01013403          	ld	s0,16(sp)
    80004024:	00813483          	ld	s1,8(sp)
    80004028:	02010113          	addi	sp,sp,32
    8000402c:	00008067          	ret

0000000080004030 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80004030:	fe010113          	addi	sp,sp,-32
    80004034:	00113c23          	sd	ra,24(sp)
    80004038:	00813823          	sd	s0,16(sp)
    8000403c:	00913423          	sd	s1,8(sp)
    80004040:	02010413          	addi	s0,sp,32
    80004044:	00050493          	mv	s1,a0
        while ((key = getc()) != 0x1b) {
    80004048:	ffffd097          	auipc	ra,0xffffd
    8000404c:	434080e7          	jalr	1076(ra) # 8000147c <_Z4getcv>
    80004050:	0005059b          	sext.w	a1,a0
    80004054:	01b00793          	li	a5,27
    80004058:	00f58c63          	beq	a1,a5,80004070 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    8000405c:	0204b783          	ld	a5,32(s1)
    80004060:	0087b503          	ld	a0,8(a5)
    80004064:	00001097          	auipc	ra,0x1
    80004068:	35c080e7          	jalr	860(ra) # 800053c0 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 0x1b) {
    8000406c:	fddff06f          	j	80004048 <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80004070:	00100793          	li	a5,1
    80004074:	00007717          	auipc	a4,0x7
    80004078:	64f72e23          	sw	a5,1628(a4) # 8000b6d0 <_ZL9threadEnd>
        td->buffer->put('!');
    8000407c:	0204b783          	ld	a5,32(s1)
    80004080:	02100593          	li	a1,33
    80004084:	0087b503          	ld	a0,8(a5)
    80004088:	00001097          	auipc	ra,0x1
    8000408c:	338080e7          	jalr	824(ra) # 800053c0 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80004090:	0204b783          	ld	a5,32(s1)
    80004094:	0107b503          	ld	a0,16(a5)
    80004098:	ffffe097          	auipc	ra,0xffffe
    8000409c:	254080e7          	jalr	596(ra) # 800022ec <_ZN9Semaphore6signalEv>
    }
    800040a0:	01813083          	ld	ra,24(sp)
    800040a4:	01013403          	ld	s0,16(sp)
    800040a8:	00813483          	ld	s1,8(sp)
    800040ac:	02010113          	addi	sp,sp,32
    800040b0:	00008067          	ret

00000000800040b4 <_ZN8Producer3runEv>:
    void run() override {
    800040b4:	fe010113          	addi	sp,sp,-32
    800040b8:	00113c23          	sd	ra,24(sp)
    800040bc:	00813823          	sd	s0,16(sp)
    800040c0:	00913423          	sd	s1,8(sp)
    800040c4:	01213023          	sd	s2,0(sp)
    800040c8:	02010413          	addi	s0,sp,32
    800040cc:	00050493          	mv	s1,a0
        int i = 0;
    800040d0:	00000913          	li	s2,0
        while (!threadEnd) {
    800040d4:	00007797          	auipc	a5,0x7
    800040d8:	5fc7a783          	lw	a5,1532(a5) # 8000b6d0 <_ZL9threadEnd>
    800040dc:	04079263          	bnez	a5,80004120 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    800040e0:	0204b783          	ld	a5,32(s1)
    800040e4:	0007a583          	lw	a1,0(a5)
    800040e8:	0305859b          	addiw	a1,a1,48
    800040ec:	0087b503          	ld	a0,8(a5)
    800040f0:	00001097          	auipc	ra,0x1
    800040f4:	2d0080e7          	jalr	720(ra) # 800053c0 <_ZN9BufferCPP3putEi>
            i++;
    800040f8:	0019071b          	addiw	a4,s2,1
    800040fc:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80004100:	0204b783          	ld	a5,32(s1)
    80004104:	0007a783          	lw	a5,0(a5)
    80004108:	00e787bb          	addw	a5,a5,a4
    8000410c:	00500513          	li	a0,5
    80004110:	02a7e53b          	remw	a0,a5,a0
    80004114:	ffffe097          	auipc	ra,0xffffe
    80004118:	0d0080e7          	jalr	208(ra) # 800021e4 <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    8000411c:	fb9ff06f          	j	800040d4 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80004120:	0204b783          	ld	a5,32(s1)
    80004124:	0107b503          	ld	a0,16(a5)
    80004128:	ffffe097          	auipc	ra,0xffffe
    8000412c:	1c4080e7          	jalr	452(ra) # 800022ec <_ZN9Semaphore6signalEv>
    }
    80004130:	01813083          	ld	ra,24(sp)
    80004134:	01013403          	ld	s0,16(sp)
    80004138:	00813483          	ld	s1,8(sp)
    8000413c:	00013903          	ld	s2,0(sp)
    80004140:	02010113          	addi	sp,sp,32
    80004144:	00008067          	ret

0000000080004148 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004148:	fe010113          	addi	sp,sp,-32
    8000414c:	00113c23          	sd	ra,24(sp)
    80004150:	00813823          	sd	s0,16(sp)
    80004154:	00913423          	sd	s1,8(sp)
    80004158:	01213023          	sd	s2,0(sp)
    8000415c:	02010413          	addi	s0,sp,32
    80004160:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004164:	00100793          	li	a5,1
    80004168:	02a7f863          	bgeu	a5,a0,80004198 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    8000416c:	00a00793          	li	a5,10
    80004170:	02f577b3          	remu	a5,a0,a5
    80004174:	02078e63          	beqz	a5,800041b0 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004178:	fff48513          	addi	a0,s1,-1
    8000417c:	00000097          	auipc	ra,0x0
    80004180:	fcc080e7          	jalr	-52(ra) # 80004148 <_ZL9fibonaccim>
    80004184:	00050913          	mv	s2,a0
    80004188:	ffe48513          	addi	a0,s1,-2
    8000418c:	00000097          	auipc	ra,0x0
    80004190:	fbc080e7          	jalr	-68(ra) # 80004148 <_ZL9fibonaccim>
    80004194:	00a90533          	add	a0,s2,a0
}
    80004198:	01813083          	ld	ra,24(sp)
    8000419c:	01013403          	ld	s0,16(sp)
    800041a0:	00813483          	ld	s1,8(sp)
    800041a4:	00013903          	ld	s2,0(sp)
    800041a8:	02010113          	addi	sp,sp,32
    800041ac:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    800041b0:	ffffd097          	auipc	ra,0xffffd
    800041b4:	1dc080e7          	jalr	476(ra) # 8000138c <_Z15thread_dispatchv>
    800041b8:	fc1ff06f          	j	80004178 <_ZL9fibonaccim+0x30>

00000000800041bc <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    800041bc:	fe010113          	addi	sp,sp,-32
    800041c0:	00113c23          	sd	ra,24(sp)
    800041c4:	00813823          	sd	s0,16(sp)
    800041c8:	00913423          	sd	s1,8(sp)
    800041cc:	01213023          	sd	s2,0(sp)
    800041d0:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800041d4:	00a00493          	li	s1,10
    800041d8:	0400006f          	j	80004218 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800041dc:	00005517          	auipc	a0,0x5
    800041e0:	e9450513          	addi	a0,a0,-364 # 80009070 <CONSOLE_STATUS+0x60>
    800041e4:	00001097          	auipc	ra,0x1
    800041e8:	db8080e7          	jalr	-584(ra) # 80004f9c <_Z11printStringPKc>
    800041ec:	00000613          	li	a2,0
    800041f0:	00a00593          	li	a1,10
    800041f4:	00048513          	mv	a0,s1
    800041f8:	00001097          	auipc	ra,0x1
    800041fc:	f54080e7          	jalr	-172(ra) # 8000514c <_Z8printIntiii>
    80004200:	00005517          	auipc	a0,0x5
    80004204:	1e850513          	addi	a0,a0,488 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80004208:	00001097          	auipc	ra,0x1
    8000420c:	d94080e7          	jalr	-620(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004210:	0014849b          	addiw	s1,s1,1
    80004214:	0ff4f493          	andi	s1,s1,255
    80004218:	00c00793          	li	a5,12
    8000421c:	fc97f0e3          	bgeu	a5,s1,800041dc <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004220:	00005517          	auipc	a0,0x5
    80004224:	ff050513          	addi	a0,a0,-16 # 80009210 <_ZZ13print_integermE6digits+0x158>
    80004228:	00001097          	auipc	ra,0x1
    8000422c:	d74080e7          	jalr	-652(ra) # 80004f9c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004230:	00500313          	li	t1,5
    thread_dispatch();
    80004234:	ffffd097          	auipc	ra,0xffffd
    80004238:	158080e7          	jalr	344(ra) # 8000138c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    8000423c:	01000513          	li	a0,16
    80004240:	00000097          	auipc	ra,0x0
    80004244:	f08080e7          	jalr	-248(ra) # 80004148 <_ZL9fibonaccim>
    80004248:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    8000424c:	00005517          	auipc	a0,0x5
    80004250:	e1450513          	addi	a0,a0,-492 # 80009060 <CONSOLE_STATUS+0x50>
    80004254:	00001097          	auipc	ra,0x1
    80004258:	d48080e7          	jalr	-696(ra) # 80004f9c <_Z11printStringPKc>
    8000425c:	00000613          	li	a2,0
    80004260:	00a00593          	li	a1,10
    80004264:	0009051b          	sext.w	a0,s2
    80004268:	00001097          	auipc	ra,0x1
    8000426c:	ee4080e7          	jalr	-284(ra) # 8000514c <_Z8printIntiii>
    80004270:	00005517          	auipc	a0,0x5
    80004274:	17850513          	addi	a0,a0,376 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80004278:	00001097          	auipc	ra,0x1
    8000427c:	d24080e7          	jalr	-732(ra) # 80004f9c <_Z11printStringPKc>
    80004280:	0400006f          	j	800042c0 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004284:	00005517          	auipc	a0,0x5
    80004288:	dec50513          	addi	a0,a0,-532 # 80009070 <CONSOLE_STATUS+0x60>
    8000428c:	00001097          	auipc	ra,0x1
    80004290:	d10080e7          	jalr	-752(ra) # 80004f9c <_Z11printStringPKc>
    80004294:	00000613          	li	a2,0
    80004298:	00a00593          	li	a1,10
    8000429c:	00048513          	mv	a0,s1
    800042a0:	00001097          	auipc	ra,0x1
    800042a4:	eac080e7          	jalr	-340(ra) # 8000514c <_Z8printIntiii>
    800042a8:	00005517          	auipc	a0,0x5
    800042ac:	14050513          	addi	a0,a0,320 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800042b0:	00001097          	auipc	ra,0x1
    800042b4:	cec080e7          	jalr	-788(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 16; i++) {
    800042b8:	0014849b          	addiw	s1,s1,1
    800042bc:	0ff4f493          	andi	s1,s1,255
    800042c0:	00f00793          	li	a5,15
    800042c4:	fc97f0e3          	bgeu	a5,s1,80004284 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800042c8:	00005517          	auipc	a0,0x5
    800042cc:	f5850513          	addi	a0,a0,-168 # 80009220 <_ZZ13print_integermE6digits+0x168>
    800042d0:	00001097          	auipc	ra,0x1
    800042d4:	ccc080e7          	jalr	-820(ra) # 80004f9c <_Z11printStringPKc>
    finishedD = true;
    800042d8:	00100793          	li	a5,1
    800042dc:	00007717          	auipc	a4,0x7
    800042e0:	40f70223          	sb	a5,1028(a4) # 8000b6e0 <_ZL9finishedD>
    thread_dispatch();
    800042e4:	ffffd097          	auipc	ra,0xffffd
    800042e8:	0a8080e7          	jalr	168(ra) # 8000138c <_Z15thread_dispatchv>
}
    800042ec:	01813083          	ld	ra,24(sp)
    800042f0:	01013403          	ld	s0,16(sp)
    800042f4:	00813483          	ld	s1,8(sp)
    800042f8:	00013903          	ld	s2,0(sp)
    800042fc:	02010113          	addi	sp,sp,32
    80004300:	00008067          	ret

0000000080004304 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004304:	fe010113          	addi	sp,sp,-32
    80004308:	00113c23          	sd	ra,24(sp)
    8000430c:	00813823          	sd	s0,16(sp)
    80004310:	00913423          	sd	s1,8(sp)
    80004314:	01213023          	sd	s2,0(sp)
    80004318:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    8000431c:	00000493          	li	s1,0
    80004320:	0400006f          	j	80004360 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004324:	00005517          	auipc	a0,0x5
    80004328:	ebc50513          	addi	a0,a0,-324 # 800091e0 <_ZZ13print_integermE6digits+0x128>
    8000432c:	00001097          	auipc	ra,0x1
    80004330:	c70080e7          	jalr	-912(ra) # 80004f9c <_Z11printStringPKc>
    80004334:	00000613          	li	a2,0
    80004338:	00a00593          	li	a1,10
    8000433c:	00048513          	mv	a0,s1
    80004340:	00001097          	auipc	ra,0x1
    80004344:	e0c080e7          	jalr	-500(ra) # 8000514c <_Z8printIntiii>
    80004348:	00005517          	auipc	a0,0x5
    8000434c:	0a050513          	addi	a0,a0,160 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80004350:	00001097          	auipc	ra,0x1
    80004354:	c4c080e7          	jalr	-948(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004358:	0014849b          	addiw	s1,s1,1
    8000435c:	0ff4f493          	andi	s1,s1,255
    80004360:	00200793          	li	a5,2
    80004364:	fc97f0e3          	bgeu	a5,s1,80004324 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004368:	00005517          	auipc	a0,0x5
    8000436c:	e8050513          	addi	a0,a0,-384 # 800091e8 <_ZZ13print_integermE6digits+0x130>
    80004370:	00001097          	auipc	ra,0x1
    80004374:	c2c080e7          	jalr	-980(ra) # 80004f9c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004378:	00700313          	li	t1,7
    thread_dispatch();
    8000437c:	ffffd097          	auipc	ra,0xffffd
    80004380:	010080e7          	jalr	16(ra) # 8000138c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004384:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004388:	00005517          	auipc	a0,0x5
    8000438c:	e7050513          	addi	a0,a0,-400 # 800091f8 <_ZZ13print_integermE6digits+0x140>
    80004390:	00001097          	auipc	ra,0x1
    80004394:	c0c080e7          	jalr	-1012(ra) # 80004f9c <_Z11printStringPKc>
    80004398:	00000613          	li	a2,0
    8000439c:	00a00593          	li	a1,10
    800043a0:	0009051b          	sext.w	a0,s2
    800043a4:	00001097          	auipc	ra,0x1
    800043a8:	da8080e7          	jalr	-600(ra) # 8000514c <_Z8printIntiii>
    800043ac:	00005517          	auipc	a0,0x5
    800043b0:	03c50513          	addi	a0,a0,60 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800043b4:	00001097          	auipc	ra,0x1
    800043b8:	be8080e7          	jalr	-1048(ra) # 80004f9c <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    800043bc:	00c00513          	li	a0,12
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	d88080e7          	jalr	-632(ra) # 80004148 <_ZL9fibonaccim>
    800043c8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800043cc:	00005517          	auipc	a0,0x5
    800043d0:	e3450513          	addi	a0,a0,-460 # 80009200 <_ZZ13print_integermE6digits+0x148>
    800043d4:	00001097          	auipc	ra,0x1
    800043d8:	bc8080e7          	jalr	-1080(ra) # 80004f9c <_Z11printStringPKc>
    800043dc:	00000613          	li	a2,0
    800043e0:	00a00593          	li	a1,10
    800043e4:	0009051b          	sext.w	a0,s2
    800043e8:	00001097          	auipc	ra,0x1
    800043ec:	d64080e7          	jalr	-668(ra) # 8000514c <_Z8printIntiii>
    800043f0:	00005517          	auipc	a0,0x5
    800043f4:	ff850513          	addi	a0,a0,-8 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800043f8:	00001097          	auipc	ra,0x1
    800043fc:	ba4080e7          	jalr	-1116(ra) # 80004f9c <_Z11printStringPKc>
    80004400:	0400006f          	j	80004440 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004404:	00005517          	auipc	a0,0x5
    80004408:	ddc50513          	addi	a0,a0,-548 # 800091e0 <_ZZ13print_integermE6digits+0x128>
    8000440c:	00001097          	auipc	ra,0x1
    80004410:	b90080e7          	jalr	-1136(ra) # 80004f9c <_Z11printStringPKc>
    80004414:	00000613          	li	a2,0
    80004418:	00a00593          	li	a1,10
    8000441c:	00048513          	mv	a0,s1
    80004420:	00001097          	auipc	ra,0x1
    80004424:	d2c080e7          	jalr	-724(ra) # 8000514c <_Z8printIntiii>
    80004428:	00005517          	auipc	a0,0x5
    8000442c:	fc050513          	addi	a0,a0,-64 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80004430:	00001097          	auipc	ra,0x1
    80004434:	b6c080e7          	jalr	-1172(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004438:	0014849b          	addiw	s1,s1,1
    8000443c:	0ff4f493          	andi	s1,s1,255
    80004440:	00500793          	li	a5,5
    80004444:	fc97f0e3          	bgeu	a5,s1,80004404 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004448:	00005517          	auipc	a0,0x5
    8000444c:	d7050513          	addi	a0,a0,-656 # 800091b8 <_ZZ13print_integermE6digits+0x100>
    80004450:	00001097          	auipc	ra,0x1
    80004454:	b4c080e7          	jalr	-1204(ra) # 80004f9c <_Z11printStringPKc>
    finishedC = true;
    80004458:	00100793          	li	a5,1
    8000445c:	00007717          	auipc	a4,0x7
    80004460:	28f702a3          	sb	a5,645(a4) # 8000b6e1 <_ZL9finishedC>
    thread_dispatch();
    80004464:	ffffd097          	auipc	ra,0xffffd
    80004468:	f28080e7          	jalr	-216(ra) # 8000138c <_Z15thread_dispatchv>
}
    8000446c:	01813083          	ld	ra,24(sp)
    80004470:	01013403          	ld	s0,16(sp)
    80004474:	00813483          	ld	s1,8(sp)
    80004478:	00013903          	ld	s2,0(sp)
    8000447c:	02010113          	addi	sp,sp,32
    80004480:	00008067          	ret

0000000080004484 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004484:	fe010113          	addi	sp,sp,-32
    80004488:	00113c23          	sd	ra,24(sp)
    8000448c:	00813823          	sd	s0,16(sp)
    80004490:	00913423          	sd	s1,8(sp)
    80004494:	01213023          	sd	s2,0(sp)
    80004498:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    8000449c:	00000913          	li	s2,0
    800044a0:	0300006f          	j	800044d0 <_ZL11workerBodyBPv+0x4c>
            thread_dispatch();
    800044a4:	ffffd097          	auipc	ra,0xffffd
    800044a8:	ee8080e7          	jalr	-280(ra) # 8000138c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 1000; j++) {
    800044ac:	00148493          	addi	s1,s1,1
    800044b0:	3e700793          	li	a5,999
    800044b4:	0097ec63          	bltu	a5,s1,800044cc <_ZL11workerBodyBPv+0x48>
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
    800044b8:	00000793          	li	a5,0
    800044bc:	12b00713          	li	a4,299
    800044c0:	fef762e3          	bltu	a4,a5,800044a4 <_ZL11workerBodyBPv+0x20>
    800044c4:	00178793          	addi	a5,a5,1
    800044c8:	ff5ff06f          	j	800044bc <_ZL11workerBodyBPv+0x38>
    for (uint64 i = 0; i < 16; i++) {
    800044cc:	00190913          	addi	s2,s2,1
    800044d0:	00f00793          	li	a5,15
    800044d4:	0527e063          	bltu	a5,s2,80004514 <_ZL11workerBodyBPv+0x90>
        printString("B: i="); printInt(i); printString("\n");
    800044d8:	00005517          	auipc	a0,0x5
    800044dc:	cf050513          	addi	a0,a0,-784 # 800091c8 <_ZZ13print_integermE6digits+0x110>
    800044e0:	00001097          	auipc	ra,0x1
    800044e4:	abc080e7          	jalr	-1348(ra) # 80004f9c <_Z11printStringPKc>
    800044e8:	00000613          	li	a2,0
    800044ec:	00a00593          	li	a1,10
    800044f0:	0009051b          	sext.w	a0,s2
    800044f4:	00001097          	auipc	ra,0x1
    800044f8:	c58080e7          	jalr	-936(ra) # 8000514c <_Z8printIntiii>
    800044fc:	00005517          	auipc	a0,0x5
    80004500:	eec50513          	addi	a0,a0,-276 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80004504:	00001097          	auipc	ra,0x1
    80004508:	a98080e7          	jalr	-1384(ra) # 80004f9c <_Z11printStringPKc>
        for (uint64 j = 0; j < 1000; j++) {
    8000450c:	00000493          	li	s1,0
    80004510:	fa1ff06f          	j	800044b0 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80004514:	00005517          	auipc	a0,0x5
    80004518:	cbc50513          	addi	a0,a0,-836 # 800091d0 <_ZZ13print_integermE6digits+0x118>
    8000451c:	00001097          	auipc	ra,0x1
    80004520:	a80080e7          	jalr	-1408(ra) # 80004f9c <_Z11printStringPKc>
    finishedB = true;
    80004524:	00100793          	li	a5,1
    80004528:	00007717          	auipc	a4,0x7
    8000452c:	1af70d23          	sb	a5,442(a4) # 8000b6e2 <_ZL9finishedB>
    thread_dispatch();
    80004530:	ffffd097          	auipc	ra,0xffffd
    80004534:	e5c080e7          	jalr	-420(ra) # 8000138c <_Z15thread_dispatchv>
}
    80004538:	01813083          	ld	ra,24(sp)
    8000453c:	01013403          	ld	s0,16(sp)
    80004540:	00813483          	ld	s1,8(sp)
    80004544:	00013903          	ld	s2,0(sp)
    80004548:	02010113          	addi	sp,sp,32
    8000454c:	00008067          	ret

0000000080004550 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004550:	fe010113          	addi	sp,sp,-32
    80004554:	00113c23          	sd	ra,24(sp)
    80004558:	00813823          	sd	s0,16(sp)
    8000455c:	00913423          	sd	s1,8(sp)
    80004560:	01213023          	sd	s2,0(sp)
    80004564:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004568:	00000913          	li	s2,0
    8000456c:	0300006f          	j	8000459c <_ZL11workerBodyAPv+0x4c>
            thread_dispatch();
    80004570:	ffffd097          	auipc	ra,0xffffd
    80004574:	e1c080e7          	jalr	-484(ra) # 8000138c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 1000; j++) {
    80004578:	00148493          	addi	s1,s1,1
    8000457c:	3e700793          	li	a5,999
    80004580:	0097ec63          	bltu	a5,s1,80004598 <_ZL11workerBodyAPv+0x48>
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
    80004584:	00000793          	li	a5,0
    80004588:	12b00713          	li	a4,299
    8000458c:	fef762e3          	bltu	a4,a5,80004570 <_ZL11workerBodyAPv+0x20>
    80004590:	00178793          	addi	a5,a5,1
    80004594:	ff5ff06f          	j	80004588 <_ZL11workerBodyAPv+0x38>
    for (uint64 i = 0; i < 10; i++) {
    80004598:	00190913          	addi	s2,s2,1
    8000459c:	00900793          	li	a5,9
    800045a0:	0527e063          	bltu	a5,s2,800045e0 <_ZL11workerBodyAPv+0x90>
        printString("A: i="); printInt(i); printString("\n");
    800045a4:	00005517          	auipc	a0,0x5
    800045a8:	c0c50513          	addi	a0,a0,-1012 # 800091b0 <_ZZ13print_integermE6digits+0xf8>
    800045ac:	00001097          	auipc	ra,0x1
    800045b0:	9f0080e7          	jalr	-1552(ra) # 80004f9c <_Z11printStringPKc>
    800045b4:	00000613          	li	a2,0
    800045b8:	00a00593          	li	a1,10
    800045bc:	0009051b          	sext.w	a0,s2
    800045c0:	00001097          	auipc	ra,0x1
    800045c4:	b8c080e7          	jalr	-1140(ra) # 8000514c <_Z8printIntiii>
    800045c8:	00005517          	auipc	a0,0x5
    800045cc:	e2050513          	addi	a0,a0,-480 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800045d0:	00001097          	auipc	ra,0x1
    800045d4:	9cc080e7          	jalr	-1588(ra) # 80004f9c <_Z11printStringPKc>
        for (uint64 j = 0; j < 1000; j++) {
    800045d8:	00000493          	li	s1,0
    800045dc:	fa1ff06f          	j	8000457c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800045e0:	00005517          	auipc	a0,0x5
    800045e4:	bd850513          	addi	a0,a0,-1064 # 800091b8 <_ZZ13print_integermE6digits+0x100>
    800045e8:	00001097          	auipc	ra,0x1
    800045ec:	9b4080e7          	jalr	-1612(ra) # 80004f9c <_Z11printStringPKc>
    finishedA = true;
    800045f0:	00100793          	li	a5,1
    800045f4:	00007717          	auipc	a4,0x7
    800045f8:	0ef707a3          	sb	a5,239(a4) # 8000b6e3 <_ZL9finishedA>
}
    800045fc:	01813083          	ld	ra,24(sp)
    80004600:	01013403          	ld	s0,16(sp)
    80004604:	00813483          	ld	s1,8(sp)
    80004608:	00013903          	ld	s2,0(sp)
    8000460c:	02010113          	addi	sp,sp,32
    80004610:	00008067          	ret

0000000080004614 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80004614:	fd010113          	addi	sp,sp,-48
    80004618:	02113423          	sd	ra,40(sp)
    8000461c:	02813023          	sd	s0,32(sp)
    80004620:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80004624:	00000613          	li	a2,0
    80004628:	00000597          	auipc	a1,0x0
    8000462c:	f2858593          	addi	a1,a1,-216 # 80004550 <_ZL11workerBodyAPv>
    80004630:	fd040513          	addi	a0,s0,-48
    80004634:	ffffd097          	auipc	ra,0xffffd
    80004638:	cd4080e7          	jalr	-812(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    8000463c:	00005517          	auipc	a0,0x5
    80004640:	bf450513          	addi	a0,a0,-1036 # 80009230 <_ZZ13print_integermE6digits+0x178>
    80004644:	00001097          	auipc	ra,0x1
    80004648:	958080e7          	jalr	-1704(ra) # 80004f9c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000464c:	00000613          	li	a2,0
    80004650:	00000597          	auipc	a1,0x0
    80004654:	e3458593          	addi	a1,a1,-460 # 80004484 <_ZL11workerBodyBPv>
    80004658:	fd840513          	addi	a0,s0,-40
    8000465c:	ffffd097          	auipc	ra,0xffffd
    80004660:	cac080e7          	jalr	-852(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80004664:	00005517          	auipc	a0,0x5
    80004668:	be450513          	addi	a0,a0,-1052 # 80009248 <_ZZ13print_integermE6digits+0x190>
    8000466c:	00001097          	auipc	ra,0x1
    80004670:	930080e7          	jalr	-1744(ra) # 80004f9c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004674:	00000613          	li	a2,0
    80004678:	00000597          	auipc	a1,0x0
    8000467c:	c8c58593          	addi	a1,a1,-884 # 80004304 <_ZL11workerBodyCPv>
    80004680:	fe040513          	addi	a0,s0,-32
    80004684:	ffffd097          	auipc	ra,0xffffd
    80004688:	c84080e7          	jalr	-892(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    8000468c:	00005517          	auipc	a0,0x5
    80004690:	bd450513          	addi	a0,a0,-1068 # 80009260 <_ZZ13print_integermE6digits+0x1a8>
    80004694:	00001097          	auipc	ra,0x1
    80004698:	908080e7          	jalr	-1784(ra) # 80004f9c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000469c:	00000613          	li	a2,0
    800046a0:	00000597          	auipc	a1,0x0
    800046a4:	b1c58593          	addi	a1,a1,-1252 # 800041bc <_ZL11workerBodyDPv>
    800046a8:	fe840513          	addi	a0,s0,-24
    800046ac:	ffffd097          	auipc	ra,0xffffd
    800046b0:	c5c080e7          	jalr	-932(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800046b4:	00005517          	auipc	a0,0x5
    800046b8:	bc450513          	addi	a0,a0,-1084 # 80009278 <_ZZ13print_integermE6digits+0x1c0>
    800046bc:	00001097          	auipc	ra,0x1
    800046c0:	8e0080e7          	jalr	-1824(ra) # 80004f9c <_Z11printStringPKc>
    800046c4:	00c0006f          	j	800046d0 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800046c8:	ffffd097          	auipc	ra,0xffffd
    800046cc:	cc4080e7          	jalr	-828(ra) # 8000138c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800046d0:	00007797          	auipc	a5,0x7
    800046d4:	0137c783          	lbu	a5,19(a5) # 8000b6e3 <_ZL9finishedA>
    800046d8:	fe0788e3          	beqz	a5,800046c8 <_Z18Threads_C_API_testv+0xb4>
    800046dc:	00007797          	auipc	a5,0x7
    800046e0:	0067c783          	lbu	a5,6(a5) # 8000b6e2 <_ZL9finishedB>
    800046e4:	fe0782e3          	beqz	a5,800046c8 <_Z18Threads_C_API_testv+0xb4>
    800046e8:	00007797          	auipc	a5,0x7
    800046ec:	ff97c783          	lbu	a5,-7(a5) # 8000b6e1 <_ZL9finishedC>
    800046f0:	fc078ce3          	beqz	a5,800046c8 <_Z18Threads_C_API_testv+0xb4>
    800046f4:	00007797          	auipc	a5,0x7
    800046f8:	fec7c783          	lbu	a5,-20(a5) # 8000b6e0 <_ZL9finishedD>
    800046fc:	fc0786e3          	beqz	a5,800046c8 <_Z18Threads_C_API_testv+0xb4>
    }

}
    80004700:	02813083          	ld	ra,40(sp)
    80004704:	02013403          	ld	s0,32(sp)
    80004708:	03010113          	addi	sp,sp,48
    8000470c:	00008067          	ret

0000000080004710 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80004710:	fd010113          	addi	sp,sp,-48
    80004714:	02113423          	sd	ra,40(sp)
    80004718:	02813023          	sd	s0,32(sp)
    8000471c:	00913c23          	sd	s1,24(sp)
    80004720:	01213823          	sd	s2,16(sp)
    80004724:	01313423          	sd	s3,8(sp)
    80004728:	03010413          	addi	s0,sp,48
    8000472c:	00050993          	mv	s3,a0
    80004730:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80004734:	00000913          	li	s2,0
    80004738:	00c0006f          	j	80004744 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    8000473c:	ffffe097          	auipc	ra,0xffffe
    80004740:	ac4080e7          	jalr	-1340(ra) # 80002200 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80004744:	ffffd097          	auipc	ra,0xffffd
    80004748:	d38080e7          	jalr	-712(ra) # 8000147c <_Z4getcv>
    8000474c:	0005059b          	sext.w	a1,a0
    80004750:	01b00793          	li	a5,27
    80004754:	02f58a63          	beq	a1,a5,80004788 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80004758:	0084b503          	ld	a0,8(s1)
    8000475c:	00001097          	auipc	ra,0x1
    80004760:	c64080e7          	jalr	-924(ra) # 800053c0 <_ZN9BufferCPP3putEi>
        i++;
    80004764:	0019071b          	addiw	a4,s2,1
    80004768:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000476c:	0004a683          	lw	a3,0(s1)
    80004770:	0026979b          	slliw	a5,a3,0x2
    80004774:	00d787bb          	addw	a5,a5,a3
    80004778:	0017979b          	slliw	a5,a5,0x1
    8000477c:	02f767bb          	remw	a5,a4,a5
    80004780:	fc0792e3          	bnez	a5,80004744 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80004784:	fb9ff06f          	j	8000473c <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    80004788:	00100793          	li	a5,1
    8000478c:	00007717          	auipc	a4,0x7
    80004790:	f4f72e23          	sw	a5,-164(a4) # 8000b6e8 <_ZL9threadEnd>
    td->buffer->put('!');
    80004794:	0209b783          	ld	a5,32(s3)
    80004798:	02100593          	li	a1,33
    8000479c:	0087b503          	ld	a0,8(a5)
    800047a0:	00001097          	auipc	ra,0x1
    800047a4:	c20080e7          	jalr	-992(ra) # 800053c0 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800047a8:	0104b503          	ld	a0,16(s1)
    800047ac:	ffffe097          	auipc	ra,0xffffe
    800047b0:	b40080e7          	jalr	-1216(ra) # 800022ec <_ZN9Semaphore6signalEv>
}
    800047b4:	02813083          	ld	ra,40(sp)
    800047b8:	02013403          	ld	s0,32(sp)
    800047bc:	01813483          	ld	s1,24(sp)
    800047c0:	01013903          	ld	s2,16(sp)
    800047c4:	00813983          	ld	s3,8(sp)
    800047c8:	03010113          	addi	sp,sp,48
    800047cc:	00008067          	ret

00000000800047d0 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800047d0:	fe010113          	addi	sp,sp,-32
    800047d4:	00113c23          	sd	ra,24(sp)
    800047d8:	00813823          	sd	s0,16(sp)
    800047dc:	00913423          	sd	s1,8(sp)
    800047e0:	01213023          	sd	s2,0(sp)
    800047e4:	02010413          	addi	s0,sp,32
    800047e8:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800047ec:	00000913          	li	s2,0
    800047f0:	00c0006f          	j	800047fc <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    800047f4:	ffffe097          	auipc	ra,0xffffe
    800047f8:	a0c080e7          	jalr	-1524(ra) # 80002200 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    800047fc:	00007797          	auipc	a5,0x7
    80004800:	eec7a783          	lw	a5,-276(a5) # 8000b6e8 <_ZL9threadEnd>
    80004804:	02079e63          	bnez	a5,80004840 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80004808:	0004a583          	lw	a1,0(s1)
    8000480c:	0305859b          	addiw	a1,a1,48
    80004810:	0084b503          	ld	a0,8(s1)
    80004814:	00001097          	auipc	ra,0x1
    80004818:	bac080e7          	jalr	-1108(ra) # 800053c0 <_ZN9BufferCPP3putEi>
        i++;
    8000481c:	0019071b          	addiw	a4,s2,1
    80004820:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80004824:	0004a683          	lw	a3,0(s1)
    80004828:	0026979b          	slliw	a5,a3,0x2
    8000482c:	00d787bb          	addw	a5,a5,a3
    80004830:	0017979b          	slliw	a5,a5,0x1
    80004834:	02f767bb          	remw	a5,a4,a5
    80004838:	fc0792e3          	bnez	a5,800047fc <_ZN12ProducerSync8producerEPv+0x2c>
    8000483c:	fb9ff06f          	j	800047f4 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80004840:	0104b503          	ld	a0,16(s1)
    80004844:	ffffe097          	auipc	ra,0xffffe
    80004848:	aa8080e7          	jalr	-1368(ra) # 800022ec <_ZN9Semaphore6signalEv>
}
    8000484c:	01813083          	ld	ra,24(sp)
    80004850:	01013403          	ld	s0,16(sp)
    80004854:	00813483          	ld	s1,8(sp)
    80004858:	00013903          	ld	s2,0(sp)
    8000485c:	02010113          	addi	sp,sp,32
    80004860:	00008067          	ret

0000000080004864 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80004864:	fd010113          	addi	sp,sp,-48
    80004868:	02113423          	sd	ra,40(sp)
    8000486c:	02813023          	sd	s0,32(sp)
    80004870:	00913c23          	sd	s1,24(sp)
    80004874:	01213823          	sd	s2,16(sp)
    80004878:	01313423          	sd	s3,8(sp)
    8000487c:	01413023          	sd	s4,0(sp)
    80004880:	03010413          	addi	s0,sp,48
    80004884:	00050993          	mv	s3,a0
    80004888:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    8000488c:	00000a13          	li	s4,0
    80004890:	01c0006f          	j	800048ac <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    80004894:	ffffe097          	auipc	ra,0xffffe
    80004898:	96c080e7          	jalr	-1684(ra) # 80002200 <_ZN6Thread8dispatchEv>
    8000489c:	0500006f          	j	800048ec <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800048a0:	00a00513          	li	a0,10
    800048a4:	ffffd097          	auipc	ra,0xffffd
    800048a8:	c0c080e7          	jalr	-1012(ra) # 800014b0 <_Z4putcc>
    while (!threadEnd) {
    800048ac:	00007797          	auipc	a5,0x7
    800048b0:	e3c7a783          	lw	a5,-452(a5) # 8000b6e8 <_ZL9threadEnd>
    800048b4:	06079263          	bnez	a5,80004918 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800048b8:	00893503          	ld	a0,8(s2)
    800048bc:	00001097          	auipc	ra,0x1
    800048c0:	b94080e7          	jalr	-1132(ra) # 80005450 <_ZN9BufferCPP3getEv>
        i++;
    800048c4:	001a049b          	addiw	s1,s4,1
    800048c8:	00048a1b          	sext.w	s4,s1
        putc(key);
    800048cc:	0ff57513          	andi	a0,a0,255
    800048d0:	ffffd097          	auipc	ra,0xffffd
    800048d4:	be0080e7          	jalr	-1056(ra) # 800014b0 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800048d8:	00092703          	lw	a4,0(s2)
    800048dc:	0027179b          	slliw	a5,a4,0x2
    800048e0:	00e787bb          	addw	a5,a5,a4
    800048e4:	02f4e7bb          	remw	a5,s1,a5
    800048e8:	fa0786e3          	beqz	a5,80004894 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    800048ec:	05000793          	li	a5,80
    800048f0:	02f4e4bb          	remw	s1,s1,a5
    800048f4:	fa049ce3          	bnez	s1,800048ac <_ZN12ConsumerSync8consumerEPv+0x48>
    800048f8:	fa9ff06f          	j	800048a0 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    800048fc:	0209b783          	ld	a5,32(s3)
    80004900:	0087b503          	ld	a0,8(a5)
    80004904:	00001097          	auipc	ra,0x1
    80004908:	b4c080e7          	jalr	-1204(ra) # 80005450 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    8000490c:	0ff57513          	andi	a0,a0,255
    80004910:	ffffe097          	auipc	ra,0xffffe
    80004914:	a34080e7          	jalr	-1484(ra) # 80002344 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    80004918:	0209b783          	ld	a5,32(s3)
    8000491c:	0087b503          	ld	a0,8(a5)
    80004920:	00001097          	auipc	ra,0x1
    80004924:	bbc080e7          	jalr	-1092(ra) # 800054dc <_ZN9BufferCPP6getCntEv>
    80004928:	fca04ae3          	bgtz	a0,800048fc <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    8000492c:	01093503          	ld	a0,16(s2)
    80004930:	ffffe097          	auipc	ra,0xffffe
    80004934:	9bc080e7          	jalr	-1604(ra) # 800022ec <_ZN9Semaphore6signalEv>
}
    80004938:	02813083          	ld	ra,40(sp)
    8000493c:	02013403          	ld	s0,32(sp)
    80004940:	01813483          	ld	s1,24(sp)
    80004944:	01013903          	ld	s2,16(sp)
    80004948:	00813983          	ld	s3,8(sp)
    8000494c:	00013a03          	ld	s4,0(sp)
    80004950:	03010113          	addi	sp,sp,48
    80004954:	00008067          	ret

0000000080004958 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    80004958:	f8010113          	addi	sp,sp,-128
    8000495c:	06113c23          	sd	ra,120(sp)
    80004960:	06813823          	sd	s0,112(sp)
    80004964:	06913423          	sd	s1,104(sp)
    80004968:	07213023          	sd	s2,96(sp)
    8000496c:	05313c23          	sd	s3,88(sp)
    80004970:	05413823          	sd	s4,80(sp)
    80004974:	05513423          	sd	s5,72(sp)
    80004978:	05613023          	sd	s6,64(sp)
    8000497c:	03713c23          	sd	s7,56(sp)
    80004980:	03813823          	sd	s8,48(sp)
    80004984:	03913423          	sd	s9,40(sp)
    80004988:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    8000498c:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80004990:	00004517          	auipc	a0,0x4
    80004994:	73850513          	addi	a0,a0,1848 # 800090c8 <_ZZ13print_integermE6digits+0x10>
    80004998:	00000097          	auipc	ra,0x0
    8000499c:	604080e7          	jalr	1540(ra) # 80004f9c <_Z11printStringPKc>
    getString(input, 30);
    800049a0:	01e00593          	li	a1,30
    800049a4:	f8040493          	addi	s1,s0,-128
    800049a8:	00048513          	mv	a0,s1
    800049ac:	00000097          	auipc	ra,0x0
    800049b0:	678080e7          	jalr	1656(ra) # 80005024 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800049b4:	00048513          	mv	a0,s1
    800049b8:	00000097          	auipc	ra,0x0
    800049bc:	744080e7          	jalr	1860(ra) # 800050fc <_Z11stringToIntPKc>
    800049c0:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800049c4:	00004517          	auipc	a0,0x4
    800049c8:	72450513          	addi	a0,a0,1828 # 800090e8 <_ZZ13print_integermE6digits+0x30>
    800049cc:	00000097          	auipc	ra,0x0
    800049d0:	5d0080e7          	jalr	1488(ra) # 80004f9c <_Z11printStringPKc>
    getString(input, 30);
    800049d4:	01e00593          	li	a1,30
    800049d8:	00048513          	mv	a0,s1
    800049dc:	00000097          	auipc	ra,0x0
    800049e0:	648080e7          	jalr	1608(ra) # 80005024 <_Z9getStringPci>
    n = stringToInt(input);
    800049e4:	00048513          	mv	a0,s1
    800049e8:	00000097          	auipc	ra,0x0
    800049ec:	714080e7          	jalr	1812(ra) # 800050fc <_Z11stringToIntPKc>
    800049f0:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800049f4:	00004517          	auipc	a0,0x4
    800049f8:	71450513          	addi	a0,a0,1812 # 80009108 <_ZZ13print_integermE6digits+0x50>
    800049fc:	00000097          	auipc	ra,0x0
    80004a00:	5a0080e7          	jalr	1440(ra) # 80004f9c <_Z11printStringPKc>
    80004a04:	00000613          	li	a2,0
    80004a08:	00a00593          	li	a1,10
    80004a0c:	00090513          	mv	a0,s2
    80004a10:	00000097          	auipc	ra,0x0
    80004a14:	73c080e7          	jalr	1852(ra) # 8000514c <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80004a18:	00004517          	auipc	a0,0x4
    80004a1c:	70850513          	addi	a0,a0,1800 # 80009120 <_ZZ13print_integermE6digits+0x68>
    80004a20:	00000097          	auipc	ra,0x0
    80004a24:	57c080e7          	jalr	1404(ra) # 80004f9c <_Z11printStringPKc>
    80004a28:	00000613          	li	a2,0
    80004a2c:	00a00593          	li	a1,10
    80004a30:	00048513          	mv	a0,s1
    80004a34:	00000097          	auipc	ra,0x0
    80004a38:	718080e7          	jalr	1816(ra) # 8000514c <_Z8printIntiii>
    printString(".\n");
    80004a3c:	00004517          	auipc	a0,0x4
    80004a40:	6fc50513          	addi	a0,a0,1788 # 80009138 <_ZZ13print_integermE6digits+0x80>
    80004a44:	00000097          	auipc	ra,0x0
    80004a48:	558080e7          	jalr	1368(ra) # 80004f9c <_Z11printStringPKc>
    if(threadNum > n) {
    80004a4c:	0324c463          	blt	s1,s2,80004a74 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80004a50:	03205c63          	blez	s2,80004a88 <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80004a54:	03800513          	li	a0,56
    80004a58:	ffffd097          	auipc	ra,0xffffd
    80004a5c:	5c8080e7          	jalr	1480(ra) # 80002020 <_Znwm>
    80004a60:	00050a93          	mv	s5,a0
    80004a64:	00048593          	mv	a1,s1
    80004a68:	00001097          	auipc	ra,0x1
    80004a6c:	804080e7          	jalr	-2044(ra) # 8000526c <_ZN9BufferCPPC1Ei>
    80004a70:	0300006f          	j	80004aa0 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80004a74:	00004517          	auipc	a0,0x4
    80004a78:	6cc50513          	addi	a0,a0,1740 # 80009140 <_ZZ13print_integermE6digits+0x88>
    80004a7c:	00000097          	auipc	ra,0x0
    80004a80:	520080e7          	jalr	1312(ra) # 80004f9c <_Z11printStringPKc>
        return;
    80004a84:	0140006f          	j	80004a98 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004a88:	00004517          	auipc	a0,0x4
    80004a8c:	6f850513          	addi	a0,a0,1784 # 80009180 <_ZZ13print_integermE6digits+0xc8>
    80004a90:	00000097          	auipc	ra,0x0
    80004a94:	50c080e7          	jalr	1292(ra) # 80004f9c <_Z11printStringPKc>
        return;
    80004a98:	000b8113          	mv	sp,s7
    80004a9c:	2380006f          	j	80004cd4 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    80004aa0:	01000513          	li	a0,16
    80004aa4:	ffffd097          	auipc	ra,0xffffd
    80004aa8:	57c080e7          	jalr	1404(ra) # 80002020 <_Znwm>
    80004aac:	00050493          	mv	s1,a0
    80004ab0:	00000593          	li	a1,0
    80004ab4:	ffffd097          	auipc	ra,0xffffd
    80004ab8:	7d0080e7          	jalr	2000(ra) # 80002284 <_ZN9SemaphoreC1Ej>
    80004abc:	00007797          	auipc	a5,0x7
    80004ac0:	c297ba23          	sd	s1,-972(a5) # 8000b6f0 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80004ac4:	00391793          	slli	a5,s2,0x3
    80004ac8:	00f78793          	addi	a5,a5,15
    80004acc:	ff07f793          	andi	a5,a5,-16
    80004ad0:	40f10133          	sub	sp,sp,a5
    80004ad4:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    80004ad8:	0019071b          	addiw	a4,s2,1
    80004adc:	00171793          	slli	a5,a4,0x1
    80004ae0:	00e787b3          	add	a5,a5,a4
    80004ae4:	00379793          	slli	a5,a5,0x3
    80004ae8:	00f78793          	addi	a5,a5,15
    80004aec:	ff07f793          	andi	a5,a5,-16
    80004af0:	40f10133          	sub	sp,sp,a5
    80004af4:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    80004af8:	00191c13          	slli	s8,s2,0x1
    80004afc:	012c07b3          	add	a5,s8,s2
    80004b00:	00379793          	slli	a5,a5,0x3
    80004b04:	00fa07b3          	add	a5,s4,a5
    80004b08:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80004b0c:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80004b10:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80004b14:	02800513          	li	a0,40
    80004b18:	ffffd097          	auipc	ra,0xffffd
    80004b1c:	508080e7          	jalr	1288(ra) # 80002020 <_Znwm>
    80004b20:	00050b13          	mv	s6,a0
    80004b24:	012c0c33          	add	s8,s8,s2
    80004b28:	003c1c13          	slli	s8,s8,0x3
    80004b2c:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80004b30:	ffffd097          	auipc	ra,0xffffd
    80004b34:	670080e7          	jalr	1648(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80004b38:	00007797          	auipc	a5,0x7
    80004b3c:	aa878793          	addi	a5,a5,-1368 # 8000b5e0 <_ZTV12ConsumerSync+0x10>
    80004b40:	00fb3023          	sd	a5,0(s6)
    80004b44:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    80004b48:	000b0513          	mv	a0,s6
    80004b4c:	ffffd097          	auipc	ra,0xffffd
    80004b50:	6dc080e7          	jalr	1756(ra) # 80002228 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80004b54:	00000493          	li	s1,0
    80004b58:	0380006f          	j	80004b90 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80004b5c:	00007797          	auipc	a5,0x7
    80004b60:	a5c78793          	addi	a5,a5,-1444 # 8000b5b8 <_ZTV12ProducerSync+0x10>
    80004b64:	00fcb023          	sd	a5,0(s9)
    80004b68:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80004b6c:	00349793          	slli	a5,s1,0x3
    80004b70:	00f987b3          	add	a5,s3,a5
    80004b74:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    80004b78:	00349793          	slli	a5,s1,0x3
    80004b7c:	00f987b3          	add	a5,s3,a5
    80004b80:	0007b503          	ld	a0,0(a5)
    80004b84:	ffffd097          	auipc	ra,0xffffd
    80004b88:	6a4080e7          	jalr	1700(ra) # 80002228 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80004b8c:	0014849b          	addiw	s1,s1,1
    80004b90:	0b24d063          	bge	s1,s2,80004c30 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    80004b94:	00149793          	slli	a5,s1,0x1
    80004b98:	009787b3          	add	a5,a5,s1
    80004b9c:	00379793          	slli	a5,a5,0x3
    80004ba0:	00fa07b3          	add	a5,s4,a5
    80004ba4:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80004ba8:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80004bac:	00007717          	auipc	a4,0x7
    80004bb0:	b4473703          	ld	a4,-1212(a4) # 8000b6f0 <_ZL10waitForAll>
    80004bb4:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    80004bb8:	02905863          	blez	s1,80004be8 <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    80004bbc:	02800513          	li	a0,40
    80004bc0:	ffffd097          	auipc	ra,0xffffd
    80004bc4:	460080e7          	jalr	1120(ra) # 80002020 <_Znwm>
    80004bc8:	00050c93          	mv	s9,a0
    80004bcc:	00149c13          	slli	s8,s1,0x1
    80004bd0:	009c0c33          	add	s8,s8,s1
    80004bd4:	003c1c13          	slli	s8,s8,0x3
    80004bd8:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80004bdc:	ffffd097          	auipc	ra,0xffffd
    80004be0:	5c4080e7          	jalr	1476(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80004be4:	f79ff06f          	j	80004b5c <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    80004be8:	02800513          	li	a0,40
    80004bec:	ffffd097          	auipc	ra,0xffffd
    80004bf0:	434080e7          	jalr	1076(ra) # 80002020 <_Znwm>
    80004bf4:	00050c93          	mv	s9,a0
    80004bf8:	00149c13          	slli	s8,s1,0x1
    80004bfc:	009c0c33          	add	s8,s8,s1
    80004c00:	003c1c13          	slli	s8,s8,0x3
    80004c04:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80004c08:	ffffd097          	auipc	ra,0xffffd
    80004c0c:	598080e7          	jalr	1432(ra) # 800021a0 <_ZN6ThreadC1Ev>
    80004c10:	00007797          	auipc	a5,0x7
    80004c14:	98078793          	addi	a5,a5,-1664 # 8000b590 <_ZTV16ProducerKeyboard+0x10>
    80004c18:	00fcb023          	sd	a5,0(s9)
    80004c1c:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80004c20:	00349793          	slli	a5,s1,0x3
    80004c24:	00f987b3          	add	a5,s3,a5
    80004c28:	0197b023          	sd	s9,0(a5)
    80004c2c:	f4dff06f          	j	80004b78 <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80004c30:	ffffd097          	auipc	ra,0xffffd
    80004c34:	5d0080e7          	jalr	1488(ra) # 80002200 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80004c38:	00000493          	li	s1,0
    80004c3c:	00994e63          	blt	s2,s1,80004c58 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80004c40:	00007517          	auipc	a0,0x7
    80004c44:	ab053503          	ld	a0,-1360(a0) # 8000b6f0 <_ZL10waitForAll>
    80004c48:	ffffd097          	auipc	ra,0xffffd
    80004c4c:	674080e7          	jalr	1652(ra) # 800022bc <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80004c50:	0014849b          	addiw	s1,s1,1
    80004c54:	fe9ff06f          	j	80004c3c <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    80004c58:	00000493          	li	s1,0
    80004c5c:	0080006f          	j	80004c64 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80004c60:	0014849b          	addiw	s1,s1,1
    80004c64:	0324d263          	bge	s1,s2,80004c88 <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    80004c68:	00349793          	slli	a5,s1,0x3
    80004c6c:	00f987b3          	add	a5,s3,a5
    80004c70:	0007b503          	ld	a0,0(a5)
    80004c74:	fe0506e3          	beqz	a0,80004c60 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    80004c78:	00053783          	ld	a5,0(a0)
    80004c7c:	0087b783          	ld	a5,8(a5)
    80004c80:	000780e7          	jalr	a5
    80004c84:	fddff06f          	j	80004c60 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    80004c88:	000b0a63          	beqz	s6,80004c9c <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    80004c8c:	000b3783          	ld	a5,0(s6)
    80004c90:	0087b783          	ld	a5,8(a5)
    80004c94:	000b0513          	mv	a0,s6
    80004c98:	000780e7          	jalr	a5
    delete waitForAll;
    80004c9c:	00007517          	auipc	a0,0x7
    80004ca0:	a5453503          	ld	a0,-1452(a0) # 8000b6f0 <_ZL10waitForAll>
    80004ca4:	00050863          	beqz	a0,80004cb4 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    80004ca8:	00053783          	ld	a5,0(a0)
    80004cac:	0087b783          	ld	a5,8(a5)
    80004cb0:	000780e7          	jalr	a5
    delete buffer;
    80004cb4:	000a8e63          	beqz	s5,80004cd0 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    80004cb8:	000a8513          	mv	a0,s5
    80004cbc:	00001097          	auipc	ra,0x1
    80004cc0:	8a8080e7          	jalr	-1880(ra) # 80005564 <_ZN9BufferCPPD1Ev>
    80004cc4:	000a8513          	mv	a0,s5
    80004cc8:	ffffd097          	auipc	ra,0xffffd
    80004ccc:	380080e7          	jalr	896(ra) # 80002048 <_ZdlPv>
    80004cd0:	000b8113          	mv	sp,s7

}
    80004cd4:	f8040113          	addi	sp,s0,-128
    80004cd8:	07813083          	ld	ra,120(sp)
    80004cdc:	07013403          	ld	s0,112(sp)
    80004ce0:	06813483          	ld	s1,104(sp)
    80004ce4:	06013903          	ld	s2,96(sp)
    80004ce8:	05813983          	ld	s3,88(sp)
    80004cec:	05013a03          	ld	s4,80(sp)
    80004cf0:	04813a83          	ld	s5,72(sp)
    80004cf4:	04013b03          	ld	s6,64(sp)
    80004cf8:	03813b83          	ld	s7,56(sp)
    80004cfc:	03013c03          	ld	s8,48(sp)
    80004d00:	02813c83          	ld	s9,40(sp)
    80004d04:	08010113          	addi	sp,sp,128
    80004d08:	00008067          	ret
    80004d0c:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80004d10:	000a8513          	mv	a0,s5
    80004d14:	ffffd097          	auipc	ra,0xffffd
    80004d18:	334080e7          	jalr	820(ra) # 80002048 <_ZdlPv>
    80004d1c:	00048513          	mv	a0,s1
    80004d20:	00008097          	auipc	ra,0x8
    80004d24:	ab8080e7          	jalr	-1352(ra) # 8000c7d8 <_Unwind_Resume>
    80004d28:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80004d2c:	00048513          	mv	a0,s1
    80004d30:	ffffd097          	auipc	ra,0xffffd
    80004d34:	318080e7          	jalr	792(ra) # 80002048 <_ZdlPv>
    80004d38:	00090513          	mv	a0,s2
    80004d3c:	00008097          	auipc	ra,0x8
    80004d40:	a9c080e7          	jalr	-1380(ra) # 8000c7d8 <_Unwind_Resume>
    80004d44:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    80004d48:	000b0513          	mv	a0,s6
    80004d4c:	ffffd097          	auipc	ra,0xffffd
    80004d50:	2fc080e7          	jalr	764(ra) # 80002048 <_ZdlPv>
    80004d54:	00048513          	mv	a0,s1
    80004d58:	00008097          	auipc	ra,0x8
    80004d5c:	a80080e7          	jalr	-1408(ra) # 8000c7d8 <_Unwind_Resume>
    80004d60:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80004d64:	000c8513          	mv	a0,s9
    80004d68:	ffffd097          	auipc	ra,0xffffd
    80004d6c:	2e0080e7          	jalr	736(ra) # 80002048 <_ZdlPv>
    80004d70:	00048513          	mv	a0,s1
    80004d74:	00008097          	auipc	ra,0x8
    80004d78:	a64080e7          	jalr	-1436(ra) # 8000c7d8 <_Unwind_Resume>
    80004d7c:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    80004d80:	000c8513          	mv	a0,s9
    80004d84:	ffffd097          	auipc	ra,0xffffd
    80004d88:	2c4080e7          	jalr	708(ra) # 80002048 <_ZdlPv>
    80004d8c:	00048513          	mv	a0,s1
    80004d90:	00008097          	auipc	ra,0x8
    80004d94:	a48080e7          	jalr	-1464(ra) # 8000c7d8 <_Unwind_Resume>

0000000080004d98 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    80004d98:	ff010113          	addi	sp,sp,-16
    80004d9c:	00113423          	sd	ra,8(sp)
    80004da0:	00813023          	sd	s0,0(sp)
    80004da4:	01010413          	addi	s0,sp,16
    80004da8:	00007797          	auipc	a5,0x7
    80004dac:	83878793          	addi	a5,a5,-1992 # 8000b5e0 <_ZTV12ConsumerSync+0x10>
    80004db0:	00f53023          	sd	a5,0(a0)
    80004db4:	ffffd097          	auipc	ra,0xffffd
    80004db8:	2bc080e7          	jalr	700(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004dbc:	00813083          	ld	ra,8(sp)
    80004dc0:	00013403          	ld	s0,0(sp)
    80004dc4:	01010113          	addi	sp,sp,16
    80004dc8:	00008067          	ret

0000000080004dcc <_ZN12ConsumerSyncD0Ev>:
    80004dcc:	fe010113          	addi	sp,sp,-32
    80004dd0:	00113c23          	sd	ra,24(sp)
    80004dd4:	00813823          	sd	s0,16(sp)
    80004dd8:	00913423          	sd	s1,8(sp)
    80004ddc:	02010413          	addi	s0,sp,32
    80004de0:	00050493          	mv	s1,a0
    80004de4:	00006797          	auipc	a5,0x6
    80004de8:	7fc78793          	addi	a5,a5,2044 # 8000b5e0 <_ZTV12ConsumerSync+0x10>
    80004dec:	00f53023          	sd	a5,0(a0)
    80004df0:	ffffd097          	auipc	ra,0xffffd
    80004df4:	280080e7          	jalr	640(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004df8:	00048513          	mv	a0,s1
    80004dfc:	ffffd097          	auipc	ra,0xffffd
    80004e00:	24c080e7          	jalr	588(ra) # 80002048 <_ZdlPv>
    80004e04:	01813083          	ld	ra,24(sp)
    80004e08:	01013403          	ld	s0,16(sp)
    80004e0c:	00813483          	ld	s1,8(sp)
    80004e10:	02010113          	addi	sp,sp,32
    80004e14:	00008067          	ret

0000000080004e18 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80004e18:	ff010113          	addi	sp,sp,-16
    80004e1c:	00113423          	sd	ra,8(sp)
    80004e20:	00813023          	sd	s0,0(sp)
    80004e24:	01010413          	addi	s0,sp,16
    80004e28:	00006797          	auipc	a5,0x6
    80004e2c:	79078793          	addi	a5,a5,1936 # 8000b5b8 <_ZTV12ProducerSync+0x10>
    80004e30:	00f53023          	sd	a5,0(a0)
    80004e34:	ffffd097          	auipc	ra,0xffffd
    80004e38:	23c080e7          	jalr	572(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004e3c:	00813083          	ld	ra,8(sp)
    80004e40:	00013403          	ld	s0,0(sp)
    80004e44:	01010113          	addi	sp,sp,16
    80004e48:	00008067          	ret

0000000080004e4c <_ZN12ProducerSyncD0Ev>:
    80004e4c:	fe010113          	addi	sp,sp,-32
    80004e50:	00113c23          	sd	ra,24(sp)
    80004e54:	00813823          	sd	s0,16(sp)
    80004e58:	00913423          	sd	s1,8(sp)
    80004e5c:	02010413          	addi	s0,sp,32
    80004e60:	00050493          	mv	s1,a0
    80004e64:	00006797          	auipc	a5,0x6
    80004e68:	75478793          	addi	a5,a5,1876 # 8000b5b8 <_ZTV12ProducerSync+0x10>
    80004e6c:	00f53023          	sd	a5,0(a0)
    80004e70:	ffffd097          	auipc	ra,0xffffd
    80004e74:	200080e7          	jalr	512(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004e78:	00048513          	mv	a0,s1
    80004e7c:	ffffd097          	auipc	ra,0xffffd
    80004e80:	1cc080e7          	jalr	460(ra) # 80002048 <_ZdlPv>
    80004e84:	01813083          	ld	ra,24(sp)
    80004e88:	01013403          	ld	s0,16(sp)
    80004e8c:	00813483          	ld	s1,8(sp)
    80004e90:	02010113          	addi	sp,sp,32
    80004e94:	00008067          	ret

0000000080004e98 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    80004e98:	ff010113          	addi	sp,sp,-16
    80004e9c:	00113423          	sd	ra,8(sp)
    80004ea0:	00813023          	sd	s0,0(sp)
    80004ea4:	01010413          	addi	s0,sp,16
    80004ea8:	00006797          	auipc	a5,0x6
    80004eac:	6e878793          	addi	a5,a5,1768 # 8000b590 <_ZTV16ProducerKeyboard+0x10>
    80004eb0:	00f53023          	sd	a5,0(a0)
    80004eb4:	ffffd097          	auipc	ra,0xffffd
    80004eb8:	1bc080e7          	jalr	444(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004ebc:	00813083          	ld	ra,8(sp)
    80004ec0:	00013403          	ld	s0,0(sp)
    80004ec4:	01010113          	addi	sp,sp,16
    80004ec8:	00008067          	ret

0000000080004ecc <_ZN16ProducerKeyboardD0Ev>:
    80004ecc:	fe010113          	addi	sp,sp,-32
    80004ed0:	00113c23          	sd	ra,24(sp)
    80004ed4:	00813823          	sd	s0,16(sp)
    80004ed8:	00913423          	sd	s1,8(sp)
    80004edc:	02010413          	addi	s0,sp,32
    80004ee0:	00050493          	mv	s1,a0
    80004ee4:	00006797          	auipc	a5,0x6
    80004ee8:	6ac78793          	addi	a5,a5,1708 # 8000b590 <_ZTV16ProducerKeyboard+0x10>
    80004eec:	00f53023          	sd	a5,0(a0)
    80004ef0:	ffffd097          	auipc	ra,0xffffd
    80004ef4:	180080e7          	jalr	384(ra) # 80002070 <_ZN6ThreadD1Ev>
    80004ef8:	00048513          	mv	a0,s1
    80004efc:	ffffd097          	auipc	ra,0xffffd
    80004f00:	14c080e7          	jalr	332(ra) # 80002048 <_ZdlPv>
    80004f04:	01813083          	ld	ra,24(sp)
    80004f08:	01013403          	ld	s0,16(sp)
    80004f0c:	00813483          	ld	s1,8(sp)
    80004f10:	02010113          	addi	sp,sp,32
    80004f14:	00008067          	ret

0000000080004f18 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80004f18:	ff010113          	addi	sp,sp,-16
    80004f1c:	00113423          	sd	ra,8(sp)
    80004f20:	00813023          	sd	s0,0(sp)
    80004f24:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80004f28:	02053583          	ld	a1,32(a0)
    80004f2c:	fffff097          	auipc	ra,0xfffff
    80004f30:	7e4080e7          	jalr	2020(ra) # 80004710 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80004f34:	00813083          	ld	ra,8(sp)
    80004f38:	00013403          	ld	s0,0(sp)
    80004f3c:	01010113          	addi	sp,sp,16
    80004f40:	00008067          	ret

0000000080004f44 <_ZN12ProducerSync3runEv>:
    void run() override {
    80004f44:	ff010113          	addi	sp,sp,-16
    80004f48:	00113423          	sd	ra,8(sp)
    80004f4c:	00813023          	sd	s0,0(sp)
    80004f50:	01010413          	addi	s0,sp,16
        producer(td);
    80004f54:	02053583          	ld	a1,32(a0)
    80004f58:	00000097          	auipc	ra,0x0
    80004f5c:	878080e7          	jalr	-1928(ra) # 800047d0 <_ZN12ProducerSync8producerEPv>
    }
    80004f60:	00813083          	ld	ra,8(sp)
    80004f64:	00013403          	ld	s0,0(sp)
    80004f68:	01010113          	addi	sp,sp,16
    80004f6c:	00008067          	ret

0000000080004f70 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80004f70:	ff010113          	addi	sp,sp,-16
    80004f74:	00113423          	sd	ra,8(sp)
    80004f78:	00813023          	sd	s0,0(sp)
    80004f7c:	01010413          	addi	s0,sp,16
        consumer(td);
    80004f80:	02053583          	ld	a1,32(a0)
    80004f84:	00000097          	auipc	ra,0x0
    80004f88:	8e0080e7          	jalr	-1824(ra) # 80004864 <_ZN12ConsumerSync8consumerEPv>
    }
    80004f8c:	00813083          	ld	ra,8(sp)
    80004f90:	00013403          	ld	s0,0(sp)
    80004f94:	01010113          	addi	sp,sp,16
    80004f98:	00008067          	ret

0000000080004f9c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80004f9c:	fe010113          	addi	sp,sp,-32
    80004fa0:	00113c23          	sd	ra,24(sp)
    80004fa4:	00813823          	sd	s0,16(sp)
    80004fa8:	00913423          	sd	s1,8(sp)
    80004fac:	02010413          	addi	s0,sp,32
    80004fb0:	00050493          	mv	s1,a0
    LOCK();
    80004fb4:	00100613          	li	a2,1
    80004fb8:	00000593          	li	a1,0
    80004fbc:	00006517          	auipc	a0,0x6
    80004fc0:	73c50513          	addi	a0,a0,1852 # 8000b6f8 <lockPrint>
    80004fc4:	ffffc097          	auipc	ra,0xffffc
    80004fc8:	03c080e7          	jalr	60(ra) # 80001000 <copy_and_swap>
    80004fcc:	00050863          	beqz	a0,80004fdc <_Z11printStringPKc+0x40>
    80004fd0:	ffffc097          	auipc	ra,0xffffc
    80004fd4:	3bc080e7          	jalr	956(ra) # 8000138c <_Z15thread_dispatchv>
    80004fd8:	fddff06f          	j	80004fb4 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80004fdc:	0004c503          	lbu	a0,0(s1)
    80004fe0:	00050a63          	beqz	a0,80004ff4 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80004fe4:	ffffc097          	auipc	ra,0xffffc
    80004fe8:	4cc080e7          	jalr	1228(ra) # 800014b0 <_Z4putcc>
        string++;
    80004fec:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80004ff0:	fedff06f          	j	80004fdc <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80004ff4:	00000613          	li	a2,0
    80004ff8:	00100593          	li	a1,1
    80004ffc:	00006517          	auipc	a0,0x6
    80005000:	6fc50513          	addi	a0,a0,1788 # 8000b6f8 <lockPrint>
    80005004:	ffffc097          	auipc	ra,0xffffc
    80005008:	ffc080e7          	jalr	-4(ra) # 80001000 <copy_and_swap>
    8000500c:	fe0514e3          	bnez	a0,80004ff4 <_Z11printStringPKc+0x58>
}
    80005010:	01813083          	ld	ra,24(sp)
    80005014:	01013403          	ld	s0,16(sp)
    80005018:	00813483          	ld	s1,8(sp)
    8000501c:	02010113          	addi	sp,sp,32
    80005020:	00008067          	ret

0000000080005024 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80005024:	fd010113          	addi	sp,sp,-48
    80005028:	02113423          	sd	ra,40(sp)
    8000502c:	02813023          	sd	s0,32(sp)
    80005030:	00913c23          	sd	s1,24(sp)
    80005034:	01213823          	sd	s2,16(sp)
    80005038:	01313423          	sd	s3,8(sp)
    8000503c:	01413023          	sd	s4,0(sp)
    80005040:	03010413          	addi	s0,sp,48
    80005044:	00050993          	mv	s3,a0
    80005048:	00058a13          	mv	s4,a1
    LOCK();
    8000504c:	00100613          	li	a2,1
    80005050:	00000593          	li	a1,0
    80005054:	00006517          	auipc	a0,0x6
    80005058:	6a450513          	addi	a0,a0,1700 # 8000b6f8 <lockPrint>
    8000505c:	ffffc097          	auipc	ra,0xffffc
    80005060:	fa4080e7          	jalr	-92(ra) # 80001000 <copy_and_swap>
    80005064:	00050863          	beqz	a0,80005074 <_Z9getStringPci+0x50>
    80005068:	ffffc097          	auipc	ra,0xffffc
    8000506c:	324080e7          	jalr	804(ra) # 8000138c <_Z15thread_dispatchv>
    80005070:	fddff06f          	j	8000504c <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80005074:	00000913          	li	s2,0
    80005078:	00090493          	mv	s1,s2
    8000507c:	0019091b          	addiw	s2,s2,1
    80005080:	03495a63          	bge	s2,s4,800050b4 <_Z9getStringPci+0x90>
        cc = getc();
    80005084:	ffffc097          	auipc	ra,0xffffc
    80005088:	3f8080e7          	jalr	1016(ra) # 8000147c <_Z4getcv>
        if(cc < 1)
    8000508c:	02050463          	beqz	a0,800050b4 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80005090:	009984b3          	add	s1,s3,s1
    80005094:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80005098:	00a00793          	li	a5,10
    8000509c:	00f50a63          	beq	a0,a5,800050b0 <_Z9getStringPci+0x8c>
    800050a0:	00d00793          	li	a5,13
    800050a4:	fcf51ae3          	bne	a0,a5,80005078 <_Z9getStringPci+0x54>
        buf[i++] = c;
    800050a8:	00090493          	mv	s1,s2
    800050ac:	0080006f          	j	800050b4 <_Z9getStringPci+0x90>
    800050b0:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800050b4:	009984b3          	add	s1,s3,s1
    800050b8:	00048023          	sb	zero,0(s1)

    UNLOCK();
    800050bc:	00000613          	li	a2,0
    800050c0:	00100593          	li	a1,1
    800050c4:	00006517          	auipc	a0,0x6
    800050c8:	63450513          	addi	a0,a0,1588 # 8000b6f8 <lockPrint>
    800050cc:	ffffc097          	auipc	ra,0xffffc
    800050d0:	f34080e7          	jalr	-204(ra) # 80001000 <copy_and_swap>
    800050d4:	fe0514e3          	bnez	a0,800050bc <_Z9getStringPci+0x98>
    return buf;
}
    800050d8:	00098513          	mv	a0,s3
    800050dc:	02813083          	ld	ra,40(sp)
    800050e0:	02013403          	ld	s0,32(sp)
    800050e4:	01813483          	ld	s1,24(sp)
    800050e8:	01013903          	ld	s2,16(sp)
    800050ec:	00813983          	ld	s3,8(sp)
    800050f0:	00013a03          	ld	s4,0(sp)
    800050f4:	03010113          	addi	sp,sp,48
    800050f8:	00008067          	ret

00000000800050fc <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    800050fc:	ff010113          	addi	sp,sp,-16
    80005100:	00813423          	sd	s0,8(sp)
    80005104:	01010413          	addi	s0,sp,16
    80005108:	00050693          	mv	a3,a0
    int n;

    n = 0;
    8000510c:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80005110:	0006c603          	lbu	a2,0(a3)
    80005114:	fd06071b          	addiw	a4,a2,-48
    80005118:	0ff77713          	andi	a4,a4,255
    8000511c:	00900793          	li	a5,9
    80005120:	02e7e063          	bltu	a5,a4,80005140 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80005124:	0025179b          	slliw	a5,a0,0x2
    80005128:	00a787bb          	addw	a5,a5,a0
    8000512c:	0017979b          	slliw	a5,a5,0x1
    80005130:	00168693          	addi	a3,a3,1
    80005134:	00c787bb          	addw	a5,a5,a2
    80005138:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    8000513c:	fd5ff06f          	j	80005110 <_Z11stringToIntPKc+0x14>
    return n;
}
    80005140:	00813403          	ld	s0,8(sp)
    80005144:	01010113          	addi	sp,sp,16
    80005148:	00008067          	ret

000000008000514c <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    8000514c:	fc010113          	addi	sp,sp,-64
    80005150:	02113c23          	sd	ra,56(sp)
    80005154:	02813823          	sd	s0,48(sp)
    80005158:	02913423          	sd	s1,40(sp)
    8000515c:	03213023          	sd	s2,32(sp)
    80005160:	01313c23          	sd	s3,24(sp)
    80005164:	04010413          	addi	s0,sp,64
    80005168:	00050493          	mv	s1,a0
    8000516c:	00058913          	mv	s2,a1
    80005170:	00060993          	mv	s3,a2
    LOCK();
    80005174:	00100613          	li	a2,1
    80005178:	00000593          	li	a1,0
    8000517c:	00006517          	auipc	a0,0x6
    80005180:	57c50513          	addi	a0,a0,1404 # 8000b6f8 <lockPrint>
    80005184:	ffffc097          	auipc	ra,0xffffc
    80005188:	e7c080e7          	jalr	-388(ra) # 80001000 <copy_and_swap>
    8000518c:	00050863          	beqz	a0,8000519c <_Z8printIntiii+0x50>
    80005190:	ffffc097          	auipc	ra,0xffffc
    80005194:	1fc080e7          	jalr	508(ra) # 8000138c <_Z15thread_dispatchv>
    80005198:	fddff06f          	j	80005174 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    8000519c:	00098463          	beqz	s3,800051a4 <_Z8printIntiii+0x58>
    800051a0:	0804c463          	bltz	s1,80005228 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800051a4:	0004851b          	sext.w	a0,s1
    neg = 0;
    800051a8:	00000593          	li	a1,0
    }

    i = 0;
    800051ac:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800051b0:	0009079b          	sext.w	a5,s2
    800051b4:	0325773b          	remuw	a4,a0,s2
    800051b8:	00048613          	mv	a2,s1
    800051bc:	0014849b          	addiw	s1,s1,1
    800051c0:	02071693          	slli	a3,a4,0x20
    800051c4:	0206d693          	srli	a3,a3,0x20
    800051c8:	00006717          	auipc	a4,0x6
    800051cc:	43070713          	addi	a4,a4,1072 # 8000b5f8 <digits>
    800051d0:	00d70733          	add	a4,a4,a3
    800051d4:	00074683          	lbu	a3,0(a4)
    800051d8:	fd040713          	addi	a4,s0,-48
    800051dc:	00c70733          	add	a4,a4,a2
    800051e0:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    800051e4:	0005071b          	sext.w	a4,a0
    800051e8:	0325553b          	divuw	a0,a0,s2
    800051ec:	fcf772e3          	bgeu	a4,a5,800051b0 <_Z8printIntiii+0x64>
    if(neg)
    800051f0:	00058c63          	beqz	a1,80005208 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    800051f4:	fd040793          	addi	a5,s0,-48
    800051f8:	009784b3          	add	s1,a5,s1
    800051fc:	02d00793          	li	a5,45
    80005200:	fef48823          	sb	a5,-16(s1)
    80005204:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80005208:	fff4849b          	addiw	s1,s1,-1
    8000520c:	0204c463          	bltz	s1,80005234 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80005210:	fd040793          	addi	a5,s0,-48
    80005214:	009787b3          	add	a5,a5,s1
    80005218:	ff07c503          	lbu	a0,-16(a5)
    8000521c:	ffffc097          	auipc	ra,0xffffc
    80005220:	294080e7          	jalr	660(ra) # 800014b0 <_Z4putcc>
    80005224:	fe5ff06f          	j	80005208 <_Z8printIntiii+0xbc>
        x = -xx;
    80005228:	4090053b          	negw	a0,s1
        neg = 1;
    8000522c:	00100593          	li	a1,1
        x = -xx;
    80005230:	f7dff06f          	j	800051ac <_Z8printIntiii+0x60>

    UNLOCK();
    80005234:	00000613          	li	a2,0
    80005238:	00100593          	li	a1,1
    8000523c:	00006517          	auipc	a0,0x6
    80005240:	4bc50513          	addi	a0,a0,1212 # 8000b6f8 <lockPrint>
    80005244:	ffffc097          	auipc	ra,0xffffc
    80005248:	dbc080e7          	jalr	-580(ra) # 80001000 <copy_and_swap>
    8000524c:	fe0514e3          	bnez	a0,80005234 <_Z8printIntiii+0xe8>
    80005250:	03813083          	ld	ra,56(sp)
    80005254:	03013403          	ld	s0,48(sp)
    80005258:	02813483          	ld	s1,40(sp)
    8000525c:	02013903          	ld	s2,32(sp)
    80005260:	01813983          	ld	s3,24(sp)
    80005264:	04010113          	addi	sp,sp,64
    80005268:	00008067          	ret

000000008000526c <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    8000526c:	fd010113          	addi	sp,sp,-48
    80005270:	02113423          	sd	ra,40(sp)
    80005274:	02813023          	sd	s0,32(sp)
    80005278:	00913c23          	sd	s1,24(sp)
    8000527c:	01213823          	sd	s2,16(sp)
    80005280:	01313423          	sd	s3,8(sp)
    80005284:	03010413          	addi	s0,sp,48
    80005288:	00050493          	mv	s1,a0
    8000528c:	00058913          	mv	s2,a1
    80005290:	0015879b          	addiw	a5,a1,1
    80005294:	0007851b          	sext.w	a0,a5
    80005298:	00f4a023          	sw	a5,0(s1)
    8000529c:	0004a823          	sw	zero,16(s1)
    800052a0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    800052a4:	00251513          	slli	a0,a0,0x2
    800052a8:	ffffc097          	auipc	ra,0xffffc
    800052ac:	fc4080e7          	jalr	-60(ra) # 8000126c <_Z9mem_allocm>
    800052b0:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800052b4:	01000513          	li	a0,16
    800052b8:	ffffd097          	auipc	ra,0xffffd
    800052bc:	d68080e7          	jalr	-664(ra) # 80002020 <_Znwm>
    800052c0:	00050993          	mv	s3,a0
    800052c4:	00000593          	li	a1,0
    800052c8:	ffffd097          	auipc	ra,0xffffd
    800052cc:	fbc080e7          	jalr	-68(ra) # 80002284 <_ZN9SemaphoreC1Ej>
    800052d0:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    800052d4:	01000513          	li	a0,16
    800052d8:	ffffd097          	auipc	ra,0xffffd
    800052dc:	d48080e7          	jalr	-696(ra) # 80002020 <_Znwm>
    800052e0:	00050993          	mv	s3,a0
    800052e4:	00090593          	mv	a1,s2
    800052e8:	ffffd097          	auipc	ra,0xffffd
    800052ec:	f9c080e7          	jalr	-100(ra) # 80002284 <_ZN9SemaphoreC1Ej>
    800052f0:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    800052f4:	01000513          	li	a0,16
    800052f8:	ffffd097          	auipc	ra,0xffffd
    800052fc:	d28080e7          	jalr	-728(ra) # 80002020 <_Znwm>
    80005300:	00050913          	mv	s2,a0
    80005304:	00100593          	li	a1,1
    80005308:	ffffd097          	auipc	ra,0xffffd
    8000530c:	f7c080e7          	jalr	-132(ra) # 80002284 <_ZN9SemaphoreC1Ej>
    80005310:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005314:	01000513          	li	a0,16
    80005318:	ffffd097          	auipc	ra,0xffffd
    8000531c:	d08080e7          	jalr	-760(ra) # 80002020 <_Znwm>
    80005320:	00050913          	mv	s2,a0
    80005324:	00100593          	li	a1,1
    80005328:	ffffd097          	auipc	ra,0xffffd
    8000532c:	f5c080e7          	jalr	-164(ra) # 80002284 <_ZN9SemaphoreC1Ej>
    80005330:	0324b823          	sd	s2,48(s1)
}
    80005334:	02813083          	ld	ra,40(sp)
    80005338:	02013403          	ld	s0,32(sp)
    8000533c:	01813483          	ld	s1,24(sp)
    80005340:	01013903          	ld	s2,16(sp)
    80005344:	00813983          	ld	s3,8(sp)
    80005348:	03010113          	addi	sp,sp,48
    8000534c:	00008067          	ret
    80005350:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005354:	00098513          	mv	a0,s3
    80005358:	ffffd097          	auipc	ra,0xffffd
    8000535c:	cf0080e7          	jalr	-784(ra) # 80002048 <_ZdlPv>
    80005360:	00048513          	mv	a0,s1
    80005364:	00007097          	auipc	ra,0x7
    80005368:	474080e7          	jalr	1140(ra) # 8000c7d8 <_Unwind_Resume>
    8000536c:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005370:	00098513          	mv	a0,s3
    80005374:	ffffd097          	auipc	ra,0xffffd
    80005378:	cd4080e7          	jalr	-812(ra) # 80002048 <_ZdlPv>
    8000537c:	00048513          	mv	a0,s1
    80005380:	00007097          	auipc	ra,0x7
    80005384:	458080e7          	jalr	1112(ra) # 8000c7d8 <_Unwind_Resume>
    80005388:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    8000538c:	00090513          	mv	a0,s2
    80005390:	ffffd097          	auipc	ra,0xffffd
    80005394:	cb8080e7          	jalr	-840(ra) # 80002048 <_ZdlPv>
    80005398:	00048513          	mv	a0,s1
    8000539c:	00007097          	auipc	ra,0x7
    800053a0:	43c080e7          	jalr	1084(ra) # 8000c7d8 <_Unwind_Resume>
    800053a4:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    800053a8:	00090513          	mv	a0,s2
    800053ac:	ffffd097          	auipc	ra,0xffffd
    800053b0:	c9c080e7          	jalr	-868(ra) # 80002048 <_ZdlPv>
    800053b4:	00048513          	mv	a0,s1
    800053b8:	00007097          	auipc	ra,0x7
    800053bc:	420080e7          	jalr	1056(ra) # 8000c7d8 <_Unwind_Resume>

00000000800053c0 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    800053c0:	fe010113          	addi	sp,sp,-32
    800053c4:	00113c23          	sd	ra,24(sp)
    800053c8:	00813823          	sd	s0,16(sp)
    800053cc:	00913423          	sd	s1,8(sp)
    800053d0:	01213023          	sd	s2,0(sp)
    800053d4:	02010413          	addi	s0,sp,32
    800053d8:	00050493          	mv	s1,a0
    800053dc:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    800053e0:	01853503          	ld	a0,24(a0)
    800053e4:	ffffd097          	auipc	ra,0xffffd
    800053e8:	ed8080e7          	jalr	-296(ra) # 800022bc <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    800053ec:	0304b503          	ld	a0,48(s1)
    800053f0:	ffffd097          	auipc	ra,0xffffd
    800053f4:	ecc080e7          	jalr	-308(ra) # 800022bc <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    800053f8:	0084b783          	ld	a5,8(s1)
    800053fc:	0144a703          	lw	a4,20(s1)
    80005400:	00271713          	slli	a4,a4,0x2
    80005404:	00e787b3          	add	a5,a5,a4
    80005408:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    8000540c:	0144a783          	lw	a5,20(s1)
    80005410:	0017879b          	addiw	a5,a5,1
    80005414:	0004a703          	lw	a4,0(s1)
    80005418:	02e7e7bb          	remw	a5,a5,a4
    8000541c:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005420:	0304b503          	ld	a0,48(s1)
    80005424:	ffffd097          	auipc	ra,0xffffd
    80005428:	ec8080e7          	jalr	-312(ra) # 800022ec <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    8000542c:	0204b503          	ld	a0,32(s1)
    80005430:	ffffd097          	auipc	ra,0xffffd
    80005434:	ebc080e7          	jalr	-324(ra) # 800022ec <_ZN9Semaphore6signalEv>

}
    80005438:	01813083          	ld	ra,24(sp)
    8000543c:	01013403          	ld	s0,16(sp)
    80005440:	00813483          	ld	s1,8(sp)
    80005444:	00013903          	ld	s2,0(sp)
    80005448:	02010113          	addi	sp,sp,32
    8000544c:	00008067          	ret

0000000080005450 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005450:	fe010113          	addi	sp,sp,-32
    80005454:	00113c23          	sd	ra,24(sp)
    80005458:	00813823          	sd	s0,16(sp)
    8000545c:	00913423          	sd	s1,8(sp)
    80005460:	01213023          	sd	s2,0(sp)
    80005464:	02010413          	addi	s0,sp,32
    80005468:	00050493          	mv	s1,a0
    itemAvailable->wait();
    8000546c:	02053503          	ld	a0,32(a0)
    80005470:	ffffd097          	auipc	ra,0xffffd
    80005474:	e4c080e7          	jalr	-436(ra) # 800022bc <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005478:	0284b503          	ld	a0,40(s1)
    8000547c:	ffffd097          	auipc	ra,0xffffd
    80005480:	e40080e7          	jalr	-448(ra) # 800022bc <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80005484:	0084b703          	ld	a4,8(s1)
    80005488:	0104a783          	lw	a5,16(s1)
    8000548c:	00279693          	slli	a3,a5,0x2
    80005490:	00d70733          	add	a4,a4,a3
    80005494:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005498:	0017879b          	addiw	a5,a5,1
    8000549c:	0004a703          	lw	a4,0(s1)
    800054a0:	02e7e7bb          	remw	a5,a5,a4
    800054a4:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    800054a8:	0284b503          	ld	a0,40(s1)
    800054ac:	ffffd097          	auipc	ra,0xffffd
    800054b0:	e40080e7          	jalr	-448(ra) # 800022ec <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    800054b4:	0184b503          	ld	a0,24(s1)
    800054b8:	ffffd097          	auipc	ra,0xffffd
    800054bc:	e34080e7          	jalr	-460(ra) # 800022ec <_ZN9Semaphore6signalEv>

    return ret;
}
    800054c0:	00090513          	mv	a0,s2
    800054c4:	01813083          	ld	ra,24(sp)
    800054c8:	01013403          	ld	s0,16(sp)
    800054cc:	00813483          	ld	s1,8(sp)
    800054d0:	00013903          	ld	s2,0(sp)
    800054d4:	02010113          	addi	sp,sp,32
    800054d8:	00008067          	ret

00000000800054dc <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    800054dc:	fe010113          	addi	sp,sp,-32
    800054e0:	00113c23          	sd	ra,24(sp)
    800054e4:	00813823          	sd	s0,16(sp)
    800054e8:	00913423          	sd	s1,8(sp)
    800054ec:	01213023          	sd	s2,0(sp)
    800054f0:	02010413          	addi	s0,sp,32
    800054f4:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    800054f8:	02853503          	ld	a0,40(a0)
    800054fc:	ffffd097          	auipc	ra,0xffffd
    80005500:	dc0080e7          	jalr	-576(ra) # 800022bc <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005504:	0304b503          	ld	a0,48(s1)
    80005508:	ffffd097          	auipc	ra,0xffffd
    8000550c:	db4080e7          	jalr	-588(ra) # 800022bc <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005510:	0144a783          	lw	a5,20(s1)
    80005514:	0104a903          	lw	s2,16(s1)
    80005518:	0327ce63          	blt	a5,s2,80005554 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    8000551c:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005520:	0304b503          	ld	a0,48(s1)
    80005524:	ffffd097          	auipc	ra,0xffffd
    80005528:	dc8080e7          	jalr	-568(ra) # 800022ec <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    8000552c:	0284b503          	ld	a0,40(s1)
    80005530:	ffffd097          	auipc	ra,0xffffd
    80005534:	dbc080e7          	jalr	-580(ra) # 800022ec <_ZN9Semaphore6signalEv>

    return ret;
}
    80005538:	00090513          	mv	a0,s2
    8000553c:	01813083          	ld	ra,24(sp)
    80005540:	01013403          	ld	s0,16(sp)
    80005544:	00813483          	ld	s1,8(sp)
    80005548:	00013903          	ld	s2,0(sp)
    8000554c:	02010113          	addi	sp,sp,32
    80005550:	00008067          	ret
        ret = cap - head + tail;
    80005554:	0004a703          	lw	a4,0(s1)
    80005558:	4127093b          	subw	s2,a4,s2
    8000555c:	00f9093b          	addw	s2,s2,a5
    80005560:	fc1ff06f          	j	80005520 <_ZN9BufferCPP6getCntEv+0x44>

0000000080005564 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005564:	fe010113          	addi	sp,sp,-32
    80005568:	00113c23          	sd	ra,24(sp)
    8000556c:	00813823          	sd	s0,16(sp)
    80005570:	00913423          	sd	s1,8(sp)
    80005574:	02010413          	addi	s0,sp,32
    80005578:	00050493          	mv	s1,a0
    Console::putc('\n');
    8000557c:	00a00513          	li	a0,10
    80005580:	ffffd097          	auipc	ra,0xffffd
    80005584:	dc4080e7          	jalr	-572(ra) # 80002344 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005588:	00004517          	auipc	a0,0x4
    8000558c:	d0850513          	addi	a0,a0,-760 # 80009290 <_ZZ13print_integermE6digits+0x1d8>
    80005590:	00000097          	auipc	ra,0x0
    80005594:	a0c080e7          	jalr	-1524(ra) # 80004f9c <_Z11printStringPKc>
    while (getCnt()) {
    80005598:	00048513          	mv	a0,s1
    8000559c:	00000097          	auipc	ra,0x0
    800055a0:	f40080e7          	jalr	-192(ra) # 800054dc <_ZN9BufferCPP6getCntEv>
    800055a4:	02050c63          	beqz	a0,800055dc <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    800055a8:	0084b783          	ld	a5,8(s1)
    800055ac:	0104a703          	lw	a4,16(s1)
    800055b0:	00271713          	slli	a4,a4,0x2
    800055b4:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    800055b8:	0007c503          	lbu	a0,0(a5)
    800055bc:	ffffd097          	auipc	ra,0xffffd
    800055c0:	d88080e7          	jalr	-632(ra) # 80002344 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    800055c4:	0104a783          	lw	a5,16(s1)
    800055c8:	0017879b          	addiw	a5,a5,1
    800055cc:	0004a703          	lw	a4,0(s1)
    800055d0:	02e7e7bb          	remw	a5,a5,a4
    800055d4:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    800055d8:	fc1ff06f          	j	80005598 <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    800055dc:	02100513          	li	a0,33
    800055e0:	ffffd097          	auipc	ra,0xffffd
    800055e4:	d64080e7          	jalr	-668(ra) # 80002344 <_ZN7Console4putcEc>
    Console::putc('\n');
    800055e8:	00a00513          	li	a0,10
    800055ec:	ffffd097          	auipc	ra,0xffffd
    800055f0:	d58080e7          	jalr	-680(ra) # 80002344 <_ZN7Console4putcEc>
    mem_free(buffer);
    800055f4:	0084b503          	ld	a0,8(s1)
    800055f8:	ffffc097          	auipc	ra,0xffffc
    800055fc:	ca4080e7          	jalr	-860(ra) # 8000129c <_Z8mem_freePv>
    delete itemAvailable;
    80005600:	0204b503          	ld	a0,32(s1)
    80005604:	00050863          	beqz	a0,80005614 <_ZN9BufferCPPD1Ev+0xb0>
    80005608:	00053783          	ld	a5,0(a0)
    8000560c:	0087b783          	ld	a5,8(a5)
    80005610:	000780e7          	jalr	a5
    delete spaceAvailable;
    80005614:	0184b503          	ld	a0,24(s1)
    80005618:	00050863          	beqz	a0,80005628 <_ZN9BufferCPPD1Ev+0xc4>
    8000561c:	00053783          	ld	a5,0(a0)
    80005620:	0087b783          	ld	a5,8(a5)
    80005624:	000780e7          	jalr	a5
    delete mutexTail;
    80005628:	0304b503          	ld	a0,48(s1)
    8000562c:	00050863          	beqz	a0,8000563c <_ZN9BufferCPPD1Ev+0xd8>
    80005630:	00053783          	ld	a5,0(a0)
    80005634:	0087b783          	ld	a5,8(a5)
    80005638:	000780e7          	jalr	a5
    delete mutexHead;
    8000563c:	0284b503          	ld	a0,40(s1)
    80005640:	00050863          	beqz	a0,80005650 <_ZN9BufferCPPD1Ev+0xec>
    80005644:	00053783          	ld	a5,0(a0)
    80005648:	0087b783          	ld	a5,8(a5)
    8000564c:	000780e7          	jalr	a5
}
    80005650:	01813083          	ld	ra,24(sp)
    80005654:	01013403          	ld	s0,16(sp)
    80005658:	00813483          	ld	s1,8(sp)
    8000565c:	02010113          	addi	sp,sp,32
    80005660:	00008067          	ret

0000000080005664 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80005664:	fe010113          	addi	sp,sp,-32
    80005668:	00113c23          	sd	ra,24(sp)
    8000566c:	00813823          	sd	s0,16(sp)
    80005670:	00913423          	sd	s1,8(sp)
    80005674:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80005678:	00004517          	auipc	a0,0x4
    8000567c:	c3050513          	addi	a0,a0,-976 # 800092a8 <_ZZ13print_integermE6digits+0x1f0>
    80005680:	00000097          	auipc	ra,0x0
    80005684:	91c080e7          	jalr	-1764(ra) # 80004f9c <_Z11printStringPKc>
    int test = getc() - '0';
    80005688:	ffffc097          	auipc	ra,0xffffc
    8000568c:	df4080e7          	jalr	-524(ra) # 8000147c <_Z4getcv>
    80005690:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80005694:	ffffc097          	auipc	ra,0xffffc
    80005698:	de8080e7          	jalr	-536(ra) # 8000147c <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    8000569c:	00700793          	li	a5,7
    800056a0:	1097e263          	bltu	a5,s1,800057a4 <_Z8userMainv+0x140>
    800056a4:	00249493          	slli	s1,s1,0x2
    800056a8:	00004717          	auipc	a4,0x4
    800056ac:	e5870713          	addi	a4,a4,-424 # 80009500 <_ZZ13print_integermE6digits+0x448>
    800056b0:	00e484b3          	add	s1,s1,a4
    800056b4:	0004a783          	lw	a5,0(s1)
    800056b8:	00e787b3          	add	a5,a5,a4
    800056bc:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    800056c0:	fffff097          	auipc	ra,0xfffff
    800056c4:	f54080e7          	jalr	-172(ra) # 80004614 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800056c8:	00004517          	auipc	a0,0x4
    800056cc:	c0050513          	addi	a0,a0,-1024 # 800092c8 <_ZZ13print_integermE6digits+0x210>
    800056d0:	00000097          	auipc	ra,0x0
    800056d4:	8cc080e7          	jalr	-1844(ra) # 80004f9c <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    800056d8:	01813083          	ld	ra,24(sp)
    800056dc:	01013403          	ld	s0,16(sp)
    800056e0:	00813483          	ld	s1,8(sp)
    800056e4:	02010113          	addi	sp,sp,32
    800056e8:	00008067          	ret
            Threads_CPP_API_test();
    800056ec:	ffffe097          	auipc	ra,0xffffe
    800056f0:	e18080e7          	jalr	-488(ra) # 80003504 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    800056f4:	00004517          	auipc	a0,0x4
    800056f8:	c1450513          	addi	a0,a0,-1004 # 80009308 <_ZZ13print_integermE6digits+0x250>
    800056fc:	00000097          	auipc	ra,0x0
    80005700:	8a0080e7          	jalr	-1888(ra) # 80004f9c <_Z11printStringPKc>
            break;
    80005704:	fd5ff06f          	j	800056d8 <_Z8userMainv+0x74>
            producerConsumer_C_API();
    80005708:	ffffd097          	auipc	ra,0xffffd
    8000570c:	660080e7          	jalr	1632(ra) # 80002d68 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80005710:	00004517          	auipc	a0,0x4
    80005714:	c3850513          	addi	a0,a0,-968 # 80009348 <_ZZ13print_integermE6digits+0x290>
    80005718:	00000097          	auipc	ra,0x0
    8000571c:	884080e7          	jalr	-1916(ra) # 80004f9c <_Z11printStringPKc>
            break;
    80005720:	fb9ff06f          	j	800056d8 <_Z8userMainv+0x74>
            producerConsumer_CPP_Sync_API();
    80005724:	fffff097          	auipc	ra,0xfffff
    80005728:	234080e7          	jalr	564(ra) # 80004958 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    8000572c:	00004517          	auipc	a0,0x4
    80005730:	c6c50513          	addi	a0,a0,-916 # 80009398 <_ZZ13print_integermE6digits+0x2e0>
    80005734:	00000097          	auipc	ra,0x0
    80005738:	868080e7          	jalr	-1944(ra) # 80004f9c <_Z11printStringPKc>
            break;
    8000573c:	f9dff06f          	j	800056d8 <_Z8userMainv+0x74>
            testSleeping();
    80005740:	00000097          	auipc	ra,0x0
    80005744:	110080e7          	jalr	272(ra) # 80005850 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80005748:	00004517          	auipc	a0,0x4
    8000574c:	ca850513          	addi	a0,a0,-856 # 800093f0 <_ZZ13print_integermE6digits+0x338>
    80005750:	00000097          	auipc	ra,0x0
    80005754:	84c080e7          	jalr	-1972(ra) # 80004f9c <_Z11printStringPKc>
            break;
    80005758:	f81ff06f          	j	800056d8 <_Z8userMainv+0x74>
            testConsumerProducer();
    8000575c:	ffffe097          	auipc	ra,0xffffe
    80005760:	268080e7          	jalr	616(ra) # 800039c4 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    80005764:	00004517          	auipc	a0,0x4
    80005768:	cbc50513          	addi	a0,a0,-836 # 80009420 <_ZZ13print_integermE6digits+0x368>
    8000576c:	00000097          	auipc	ra,0x0
    80005770:	830080e7          	jalr	-2000(ra) # 80004f9c <_Z11printStringPKc>
            break;
    80005774:	f65ff06f          	j	800056d8 <_Z8userMainv+0x74>
            System_Mode_test();
    80005778:	00000097          	auipc	ra,0x0
    8000577c:	64c080e7          	jalr	1612(ra) # 80005dc4 <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    80005780:	00004517          	auipc	a0,0x4
    80005784:	ce050513          	addi	a0,a0,-800 # 80009460 <_ZZ13print_integermE6digits+0x3a8>
    80005788:	00000097          	auipc	ra,0x0
    8000578c:	814080e7          	jalr	-2028(ra) # 80004f9c <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80005790:	00004517          	auipc	a0,0x4
    80005794:	cf050513          	addi	a0,a0,-784 # 80009480 <_ZZ13print_integermE6digits+0x3c8>
    80005798:	00000097          	auipc	ra,0x0
    8000579c:	804080e7          	jalr	-2044(ra) # 80004f9c <_Z11printStringPKc>
            break;
    800057a0:	f39ff06f          	j	800056d8 <_Z8userMainv+0x74>
            printString("Niste uneli odgovarajuci broj za test\n");
    800057a4:	00004517          	auipc	a0,0x4
    800057a8:	d3450513          	addi	a0,a0,-716 # 800094d8 <_ZZ13print_integermE6digits+0x420>
    800057ac:	fffff097          	auipc	ra,0xfffff
    800057b0:	7f0080e7          	jalr	2032(ra) # 80004f9c <_Z11printStringPKc>
    800057b4:	f25ff06f          	j	800056d8 <_Z8userMainv+0x74>

00000000800057b8 <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    800057b8:	fe010113          	addi	sp,sp,-32
    800057bc:	00113c23          	sd	ra,24(sp)
    800057c0:	00813823          	sd	s0,16(sp)
    800057c4:	00913423          	sd	s1,8(sp)
    800057c8:	01213023          	sd	s2,0(sp)
    800057cc:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    800057d0:	00053903          	ld	s2,0(a0)
    int i = 6;
    800057d4:	00600493          	li	s1,6
    while (--i > 0) {
    800057d8:	fff4849b          	addiw	s1,s1,-1
    800057dc:	02905e63          	blez	s1,80005818 <_ZL9sleepyRunPv+0x60>

        printString("Hello ");
    800057e0:	00004517          	auipc	a0,0x4
    800057e4:	d4050513          	addi	a0,a0,-704 # 80009520 <_ZZ13print_integermE6digits+0x468>
    800057e8:	fffff097          	auipc	ra,0xfffff
    800057ec:	7b4080e7          	jalr	1972(ra) # 80004f9c <_Z11printStringPKc>
        printInt(sleep_time);
    800057f0:	00000613          	li	a2,0
    800057f4:	00a00593          	li	a1,10
    800057f8:	0009051b          	sext.w	a0,s2
    800057fc:	00000097          	auipc	ra,0x0
    80005800:	950080e7          	jalr	-1712(ra) # 8000514c <_Z8printIntiii>
        printString(" !\n");
    80005804:	00004517          	auipc	a0,0x4
    80005808:	d2450513          	addi	a0,a0,-732 # 80009528 <_ZZ13print_integermE6digits+0x470>
    8000580c:	fffff097          	auipc	ra,0xfffff
    80005810:	790080e7          	jalr	1936(ra) # 80004f9c <_Z11printStringPKc>
    while (--i > 0) {
    80005814:	fc5ff06f          	j	800057d8 <_ZL9sleepyRunPv+0x20>
       // time_sleep(sleep_time);
    }
    finished[sleep_time/10-1] = true;
    80005818:	00a00793          	li	a5,10
    8000581c:	02f95933          	divu	s2,s2,a5
    80005820:	fff90913          	addi	s2,s2,-1
    80005824:	00006797          	auipc	a5,0x6
    80005828:	edc78793          	addi	a5,a5,-292 # 8000b700 <_ZL8finished>
    8000582c:	01278933          	add	s2,a5,s2
    80005830:	00100793          	li	a5,1
    80005834:	00f90023          	sb	a5,0(s2)
}
    80005838:	01813083          	ld	ra,24(sp)
    8000583c:	01013403          	ld	s0,16(sp)
    80005840:	00813483          	ld	s1,8(sp)
    80005844:	00013903          	ld	s2,0(sp)
    80005848:	02010113          	addi	sp,sp,32
    8000584c:	00008067          	ret

0000000080005850 <_Z12testSleepingv>:

void testSleeping() {
    80005850:	fc010113          	addi	sp,sp,-64
    80005854:	02113c23          	sd	ra,56(sp)
    80005858:	02813823          	sd	s0,48(sp)
    8000585c:	02913423          	sd	s1,40(sp)
    80005860:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    80005864:	00a00793          	li	a5,10
    80005868:	fcf43823          	sd	a5,-48(s0)
    8000586c:	01400793          	li	a5,20
    80005870:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    80005874:	00000493          	li	s1,0
    80005878:	02c0006f          	j	800058a4 <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    8000587c:	00349793          	slli	a5,s1,0x3
    80005880:	fd040613          	addi	a2,s0,-48
    80005884:	00f60633          	add	a2,a2,a5
    80005888:	00000597          	auipc	a1,0x0
    8000588c:	f3058593          	addi	a1,a1,-208 # 800057b8 <_ZL9sleepyRunPv>
    80005890:	fc040513          	addi	a0,s0,-64
    80005894:	00f50533          	add	a0,a0,a5
    80005898:	ffffc097          	auipc	ra,0xffffc
    8000589c:	a70080e7          	jalr	-1424(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800058a0:	0014849b          	addiw	s1,s1,1
    800058a4:	00100793          	li	a5,1
    800058a8:	fc97dae3          	bge	a5,s1,8000587c <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800058ac:	00006797          	auipc	a5,0x6
    800058b0:	e547c783          	lbu	a5,-428(a5) # 8000b700 <_ZL8finished>
    800058b4:	fe078ce3          	beqz	a5,800058ac <_Z12testSleepingv+0x5c>
    800058b8:	00006797          	auipc	a5,0x6
    800058bc:	e497c783          	lbu	a5,-439(a5) # 8000b701 <_ZL8finished+0x1>
    800058c0:	fe0786e3          	beqz	a5,800058ac <_Z12testSleepingv+0x5c>
}
    800058c4:	03813083          	ld	ra,56(sp)
    800058c8:	03013403          	ld	s0,48(sp)
    800058cc:	02813483          	ld	s1,40(sp)
    800058d0:	04010113          	addi	sp,sp,64
    800058d4:	00008067          	ret

00000000800058d8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800058d8:	fe010113          	addi	sp,sp,-32
    800058dc:	00113c23          	sd	ra,24(sp)
    800058e0:	00813823          	sd	s0,16(sp)
    800058e4:	00913423          	sd	s1,8(sp)
    800058e8:	01213023          	sd	s2,0(sp)
    800058ec:	02010413          	addi	s0,sp,32
    800058f0:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800058f4:	00100793          	li	a5,1
    800058f8:	02a7f863          	bgeu	a5,a0,80005928 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800058fc:	00a00793          	li	a5,10
    80005900:	02f577b3          	remu	a5,a0,a5
    80005904:	02078e63          	beqz	a5,80005940 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80005908:	fff48513          	addi	a0,s1,-1
    8000590c:	00000097          	auipc	ra,0x0
    80005910:	fcc080e7          	jalr	-52(ra) # 800058d8 <_ZL9fibonaccim>
    80005914:	00050913          	mv	s2,a0
    80005918:	ffe48513          	addi	a0,s1,-2
    8000591c:	00000097          	auipc	ra,0x0
    80005920:	fbc080e7          	jalr	-68(ra) # 800058d8 <_ZL9fibonaccim>
    80005924:	00a90533          	add	a0,s2,a0
}
    80005928:	01813083          	ld	ra,24(sp)
    8000592c:	01013403          	ld	s0,16(sp)
    80005930:	00813483          	ld	s1,8(sp)
    80005934:	00013903          	ld	s2,0(sp)
    80005938:	02010113          	addi	sp,sp,32
    8000593c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80005940:	ffffc097          	auipc	ra,0xffffc
    80005944:	a4c080e7          	jalr	-1460(ra) # 8000138c <_Z15thread_dispatchv>
    80005948:	fc1ff06f          	j	80005908 <_ZL9fibonaccim+0x30>

000000008000594c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    8000594c:	fe010113          	addi	sp,sp,-32
    80005950:	00113c23          	sd	ra,24(sp)
    80005954:	00813823          	sd	s0,16(sp)
    80005958:	00913423          	sd	s1,8(sp)
    8000595c:	01213023          	sd	s2,0(sp)
    80005960:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80005964:	00a00493          	li	s1,10
    80005968:	0400006f          	j	800059a8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000596c:	00003517          	auipc	a0,0x3
    80005970:	70450513          	addi	a0,a0,1796 # 80009070 <CONSOLE_STATUS+0x60>
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	628080e7          	jalr	1576(ra) # 80004f9c <_Z11printStringPKc>
    8000597c:	00000613          	li	a2,0
    80005980:	00a00593          	li	a1,10
    80005984:	00048513          	mv	a0,s1
    80005988:	fffff097          	auipc	ra,0xfffff
    8000598c:	7c4080e7          	jalr	1988(ra) # 8000514c <_Z8printIntiii>
    80005990:	00004517          	auipc	a0,0x4
    80005994:	a5850513          	addi	a0,a0,-1448 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005998:	fffff097          	auipc	ra,0xfffff
    8000599c:	604080e7          	jalr	1540(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 13; i++) {
    800059a0:	0014849b          	addiw	s1,s1,1
    800059a4:	0ff4f493          	andi	s1,s1,255
    800059a8:	00c00793          	li	a5,12
    800059ac:	fc97f0e3          	bgeu	a5,s1,8000596c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800059b0:	00004517          	auipc	a0,0x4
    800059b4:	86050513          	addi	a0,a0,-1952 # 80009210 <_ZZ13print_integermE6digits+0x158>
    800059b8:	fffff097          	auipc	ra,0xfffff
    800059bc:	5e4080e7          	jalr	1508(ra) # 80004f9c <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800059c0:	00500313          	li	t1,5
    thread_dispatch();
    800059c4:	ffffc097          	auipc	ra,0xffffc
    800059c8:	9c8080e7          	jalr	-1592(ra) # 8000138c <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800059cc:	01000513          	li	a0,16
    800059d0:	00000097          	auipc	ra,0x0
    800059d4:	f08080e7          	jalr	-248(ra) # 800058d8 <_ZL9fibonaccim>
    800059d8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800059dc:	00003517          	auipc	a0,0x3
    800059e0:	68450513          	addi	a0,a0,1668 # 80009060 <CONSOLE_STATUS+0x50>
    800059e4:	fffff097          	auipc	ra,0xfffff
    800059e8:	5b8080e7          	jalr	1464(ra) # 80004f9c <_Z11printStringPKc>
    800059ec:	00000613          	li	a2,0
    800059f0:	00a00593          	li	a1,10
    800059f4:	0009051b          	sext.w	a0,s2
    800059f8:	fffff097          	auipc	ra,0xfffff
    800059fc:	754080e7          	jalr	1876(ra) # 8000514c <_Z8printIntiii>
    80005a00:	00004517          	auipc	a0,0x4
    80005a04:	9e850513          	addi	a0,a0,-1560 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005a08:	fffff097          	auipc	ra,0xfffff
    80005a0c:	594080e7          	jalr	1428(ra) # 80004f9c <_Z11printStringPKc>
    80005a10:	0400006f          	j	80005a50 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80005a14:	00003517          	auipc	a0,0x3
    80005a18:	65c50513          	addi	a0,a0,1628 # 80009070 <CONSOLE_STATUS+0x60>
    80005a1c:	fffff097          	auipc	ra,0xfffff
    80005a20:	580080e7          	jalr	1408(ra) # 80004f9c <_Z11printStringPKc>
    80005a24:	00000613          	li	a2,0
    80005a28:	00a00593          	li	a1,10
    80005a2c:	00048513          	mv	a0,s1
    80005a30:	fffff097          	auipc	ra,0xfffff
    80005a34:	71c080e7          	jalr	1820(ra) # 8000514c <_Z8printIntiii>
    80005a38:	00004517          	auipc	a0,0x4
    80005a3c:	9b050513          	addi	a0,a0,-1616 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005a40:	fffff097          	auipc	ra,0xfffff
    80005a44:	55c080e7          	jalr	1372(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 16; i++) {
    80005a48:	0014849b          	addiw	s1,s1,1
    80005a4c:	0ff4f493          	andi	s1,s1,255
    80005a50:	00f00793          	li	a5,15
    80005a54:	fc97f0e3          	bgeu	a5,s1,80005a14 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80005a58:	00003517          	auipc	a0,0x3
    80005a5c:	7c850513          	addi	a0,a0,1992 # 80009220 <_ZZ13print_integermE6digits+0x168>
    80005a60:	fffff097          	auipc	ra,0xfffff
    80005a64:	53c080e7          	jalr	1340(ra) # 80004f9c <_Z11printStringPKc>
    finishedD = true;
    80005a68:	00100793          	li	a5,1
    80005a6c:	00006717          	auipc	a4,0x6
    80005a70:	c8f70b23          	sb	a5,-874(a4) # 8000b702 <_ZL9finishedD>
    thread_dispatch();
    80005a74:	ffffc097          	auipc	ra,0xffffc
    80005a78:	918080e7          	jalr	-1768(ra) # 8000138c <_Z15thread_dispatchv>
}
    80005a7c:	01813083          	ld	ra,24(sp)
    80005a80:	01013403          	ld	s0,16(sp)
    80005a84:	00813483          	ld	s1,8(sp)
    80005a88:	00013903          	ld	s2,0(sp)
    80005a8c:	02010113          	addi	sp,sp,32
    80005a90:	00008067          	ret

0000000080005a94 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80005a94:	fe010113          	addi	sp,sp,-32
    80005a98:	00113c23          	sd	ra,24(sp)
    80005a9c:	00813823          	sd	s0,16(sp)
    80005aa0:	00913423          	sd	s1,8(sp)
    80005aa4:	01213023          	sd	s2,0(sp)
    80005aa8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80005aac:	00000493          	li	s1,0
    80005ab0:	0400006f          	j	80005af0 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80005ab4:	00003517          	auipc	a0,0x3
    80005ab8:	72c50513          	addi	a0,a0,1836 # 800091e0 <_ZZ13print_integermE6digits+0x128>
    80005abc:	fffff097          	auipc	ra,0xfffff
    80005ac0:	4e0080e7          	jalr	1248(ra) # 80004f9c <_Z11printStringPKc>
    80005ac4:	00000613          	li	a2,0
    80005ac8:	00a00593          	li	a1,10
    80005acc:	00048513          	mv	a0,s1
    80005ad0:	fffff097          	auipc	ra,0xfffff
    80005ad4:	67c080e7          	jalr	1660(ra) # 8000514c <_Z8printIntiii>
    80005ad8:	00004517          	auipc	a0,0x4
    80005adc:	91050513          	addi	a0,a0,-1776 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005ae0:	fffff097          	auipc	ra,0xfffff
    80005ae4:	4bc080e7          	jalr	1212(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 3; i++) {
    80005ae8:	0014849b          	addiw	s1,s1,1
    80005aec:	0ff4f493          	andi	s1,s1,255
    80005af0:	00200793          	li	a5,2
    80005af4:	fc97f0e3          	bgeu	a5,s1,80005ab4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80005af8:	00003517          	auipc	a0,0x3
    80005afc:	6f050513          	addi	a0,a0,1776 # 800091e8 <_ZZ13print_integermE6digits+0x130>
    80005b00:	fffff097          	auipc	ra,0xfffff
    80005b04:	49c080e7          	jalr	1180(ra) # 80004f9c <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80005b08:	00700313          	li	t1,7
    thread_dispatch();
    80005b0c:	ffffc097          	auipc	ra,0xffffc
    80005b10:	880080e7          	jalr	-1920(ra) # 8000138c <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80005b14:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80005b18:	00003517          	auipc	a0,0x3
    80005b1c:	6e050513          	addi	a0,a0,1760 # 800091f8 <_ZZ13print_integermE6digits+0x140>
    80005b20:	fffff097          	auipc	ra,0xfffff
    80005b24:	47c080e7          	jalr	1148(ra) # 80004f9c <_Z11printStringPKc>
    80005b28:	00000613          	li	a2,0
    80005b2c:	00a00593          	li	a1,10
    80005b30:	0009051b          	sext.w	a0,s2
    80005b34:	fffff097          	auipc	ra,0xfffff
    80005b38:	618080e7          	jalr	1560(ra) # 8000514c <_Z8printIntiii>
    80005b3c:	00004517          	auipc	a0,0x4
    80005b40:	8ac50513          	addi	a0,a0,-1876 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005b44:	fffff097          	auipc	ra,0xfffff
    80005b48:	458080e7          	jalr	1112(ra) # 80004f9c <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80005b4c:	00c00513          	li	a0,12
    80005b50:	00000097          	auipc	ra,0x0
    80005b54:	d88080e7          	jalr	-632(ra) # 800058d8 <_ZL9fibonaccim>
    80005b58:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80005b5c:	00003517          	auipc	a0,0x3
    80005b60:	6a450513          	addi	a0,a0,1700 # 80009200 <_ZZ13print_integermE6digits+0x148>
    80005b64:	fffff097          	auipc	ra,0xfffff
    80005b68:	438080e7          	jalr	1080(ra) # 80004f9c <_Z11printStringPKc>
    80005b6c:	00000613          	li	a2,0
    80005b70:	00a00593          	li	a1,10
    80005b74:	0009051b          	sext.w	a0,s2
    80005b78:	fffff097          	auipc	ra,0xfffff
    80005b7c:	5d4080e7          	jalr	1492(ra) # 8000514c <_Z8printIntiii>
    80005b80:	00004517          	auipc	a0,0x4
    80005b84:	86850513          	addi	a0,a0,-1944 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005b88:	fffff097          	auipc	ra,0xfffff
    80005b8c:	414080e7          	jalr	1044(ra) # 80004f9c <_Z11printStringPKc>
    80005b90:	0400006f          	j	80005bd0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80005b94:	00003517          	auipc	a0,0x3
    80005b98:	64c50513          	addi	a0,a0,1612 # 800091e0 <_ZZ13print_integermE6digits+0x128>
    80005b9c:	fffff097          	auipc	ra,0xfffff
    80005ba0:	400080e7          	jalr	1024(ra) # 80004f9c <_Z11printStringPKc>
    80005ba4:	00000613          	li	a2,0
    80005ba8:	00a00593          	li	a1,10
    80005bac:	00048513          	mv	a0,s1
    80005bb0:	fffff097          	auipc	ra,0xfffff
    80005bb4:	59c080e7          	jalr	1436(ra) # 8000514c <_Z8printIntiii>
    80005bb8:	00004517          	auipc	a0,0x4
    80005bbc:	83050513          	addi	a0,a0,-2000 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005bc0:	fffff097          	auipc	ra,0xfffff
    80005bc4:	3dc080e7          	jalr	988(ra) # 80004f9c <_Z11printStringPKc>
    for (; i < 6; i++) {
    80005bc8:	0014849b          	addiw	s1,s1,1
    80005bcc:	0ff4f493          	andi	s1,s1,255
    80005bd0:	00500793          	li	a5,5
    80005bd4:	fc97f0e3          	bgeu	a5,s1,80005b94 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80005bd8:	00003517          	auipc	a0,0x3
    80005bdc:	5e050513          	addi	a0,a0,1504 # 800091b8 <_ZZ13print_integermE6digits+0x100>
    80005be0:	fffff097          	auipc	ra,0xfffff
    80005be4:	3bc080e7          	jalr	956(ra) # 80004f9c <_Z11printStringPKc>
    finishedC = true;
    80005be8:	00100793          	li	a5,1
    80005bec:	00006717          	auipc	a4,0x6
    80005bf0:	b0f70ba3          	sb	a5,-1257(a4) # 8000b703 <_ZL9finishedC>
    thread_dispatch();
    80005bf4:	ffffb097          	auipc	ra,0xffffb
    80005bf8:	798080e7          	jalr	1944(ra) # 8000138c <_Z15thread_dispatchv>
}
    80005bfc:	01813083          	ld	ra,24(sp)
    80005c00:	01013403          	ld	s0,16(sp)
    80005c04:	00813483          	ld	s1,8(sp)
    80005c08:	00013903          	ld	s2,0(sp)
    80005c0c:	02010113          	addi	sp,sp,32
    80005c10:	00008067          	ret

0000000080005c14 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80005c14:	fe010113          	addi	sp,sp,-32
    80005c18:	00113c23          	sd	ra,24(sp)
    80005c1c:	00813823          	sd	s0,16(sp)
    80005c20:	00913423          	sd	s1,8(sp)
    80005c24:	01213023          	sd	s2,0(sp)
    80005c28:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80005c2c:	00000913          	li	s2,0
    80005c30:	0380006f          	j	80005c68 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80005c34:	ffffb097          	auipc	ra,0xffffb
    80005c38:	758080e7          	jalr	1880(ra) # 8000138c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 100; j++) {
    80005c3c:	00148493          	addi	s1,s1,1
    80005c40:	06300793          	li	a5,99
    80005c44:	0097ec63          	bltu	a5,s1,80005c5c <_ZL11workerBodyBPv+0x48>
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
    80005c48:	00000793          	li	a5,0
    80005c4c:	12b00713          	li	a4,299
    80005c50:	fef762e3          	bltu	a4,a5,80005c34 <_ZL11workerBodyBPv+0x20>
    80005c54:	00178793          	addi	a5,a5,1
    80005c58:	ff5ff06f          	j	80005c4c <_ZL11workerBodyBPv+0x38>
        if (i == 10) {
    80005c5c:	00a00793          	li	a5,10
    80005c60:	04f90663          	beq	s2,a5,80005cac <_ZL11workerBodyBPv+0x98>
    for (uint64 i = 0; i < 16; i++) {
    80005c64:	00190913          	addi	s2,s2,1
    80005c68:	00f00793          	li	a5,15
    80005c6c:	0527ec63          	bltu	a5,s2,80005cc4 <_ZL11workerBodyBPv+0xb0>
        printString("B: i="); printInt(i); printString("\n");
    80005c70:	00003517          	auipc	a0,0x3
    80005c74:	55850513          	addi	a0,a0,1368 # 800091c8 <_ZZ13print_integermE6digits+0x110>
    80005c78:	fffff097          	auipc	ra,0xfffff
    80005c7c:	324080e7          	jalr	804(ra) # 80004f9c <_Z11printStringPKc>
    80005c80:	00000613          	li	a2,0
    80005c84:	00a00593          	li	a1,10
    80005c88:	0009051b          	sext.w	a0,s2
    80005c8c:	fffff097          	auipc	ra,0xfffff
    80005c90:	4c0080e7          	jalr	1216(ra) # 8000514c <_Z8printIntiii>
    80005c94:	00003517          	auipc	a0,0x3
    80005c98:	75450513          	addi	a0,a0,1876 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005c9c:	fffff097          	auipc	ra,0xfffff
    80005ca0:	300080e7          	jalr	768(ra) # 80004f9c <_Z11printStringPKc>
        for (uint64 j = 0; j < 100; j++) {
    80005ca4:	00000493          	li	s1,0
    80005ca8:	f99ff06f          	j	80005c40 <_ZL11workerBodyBPv+0x2c>
            printString("jel ovo");
    80005cac:	00004517          	auipc	a0,0x4
    80005cb0:	88450513          	addi	a0,a0,-1916 # 80009530 <_ZZ13print_integermE6digits+0x478>
    80005cb4:	fffff097          	auipc	ra,0xfffff
    80005cb8:	2e8080e7          	jalr	744(ra) # 80004f9c <_Z11printStringPKc>
            asm volatile("csrr t6, sepc");
    80005cbc:	14102ff3          	csrr	t6,sepc
    80005cc0:	fa5ff06f          	j	80005c64 <_ZL11workerBodyBPv+0x50>
    printString("B finished!\n");
    80005cc4:	00003517          	auipc	a0,0x3
    80005cc8:	50c50513          	addi	a0,a0,1292 # 800091d0 <_ZZ13print_integermE6digits+0x118>
    80005ccc:	fffff097          	auipc	ra,0xfffff
    80005cd0:	2d0080e7          	jalr	720(ra) # 80004f9c <_Z11printStringPKc>
    finishedB = true;
    80005cd4:	00100793          	li	a5,1
    80005cd8:	00006717          	auipc	a4,0x6
    80005cdc:	a2f70623          	sb	a5,-1492(a4) # 8000b704 <_ZL9finishedB>
    thread_dispatch();
    80005ce0:	ffffb097          	auipc	ra,0xffffb
    80005ce4:	6ac080e7          	jalr	1708(ra) # 8000138c <_Z15thread_dispatchv>
}
    80005ce8:	01813083          	ld	ra,24(sp)
    80005cec:	01013403          	ld	s0,16(sp)
    80005cf0:	00813483          	ld	s1,8(sp)
    80005cf4:	00013903          	ld	s2,0(sp)
    80005cf8:	02010113          	addi	sp,sp,32
    80005cfc:	00008067          	ret

0000000080005d00 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80005d00:	fe010113          	addi	sp,sp,-32
    80005d04:	00113c23          	sd	ra,24(sp)
    80005d08:	00813823          	sd	s0,16(sp)
    80005d0c:	00913423          	sd	s1,8(sp)
    80005d10:	01213023          	sd	s2,0(sp)
    80005d14:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80005d18:	00000913          	li	s2,0
    80005d1c:	0300006f          	j	80005d4c <_ZL11workerBodyAPv+0x4c>
            thread_dispatch();
    80005d20:	ffffb097          	auipc	ra,0xffffb
    80005d24:	66c080e7          	jalr	1644(ra) # 8000138c <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 100; j++) {
    80005d28:	00148493          	addi	s1,s1,1
    80005d2c:	06300793          	li	a5,99
    80005d30:	0097ec63          	bltu	a5,s1,80005d48 <_ZL11workerBodyAPv+0x48>
            for (uint64 k = 0; k < 300; k++) { /* busy wait */ }
    80005d34:	00000793          	li	a5,0
    80005d38:	12b00713          	li	a4,299
    80005d3c:	fef762e3          	bltu	a4,a5,80005d20 <_ZL11workerBodyAPv+0x20>
    80005d40:	00178793          	addi	a5,a5,1
    80005d44:	ff5ff06f          	j	80005d38 <_ZL11workerBodyAPv+0x38>
    for (uint64 i = 0; i < 10; i++) {
    80005d48:	00190913          	addi	s2,s2,1
    80005d4c:	00900793          	li	a5,9
    80005d50:	0527e063          	bltu	a5,s2,80005d90 <_ZL11workerBodyAPv+0x90>
        printString("A: i="); printInt(i); printString("\n");
    80005d54:	00003517          	auipc	a0,0x3
    80005d58:	45c50513          	addi	a0,a0,1116 # 800091b0 <_ZZ13print_integermE6digits+0xf8>
    80005d5c:	fffff097          	auipc	ra,0xfffff
    80005d60:	240080e7          	jalr	576(ra) # 80004f9c <_Z11printStringPKc>
    80005d64:	00000613          	li	a2,0
    80005d68:	00a00593          	li	a1,10
    80005d6c:	0009051b          	sext.w	a0,s2
    80005d70:	fffff097          	auipc	ra,0xfffff
    80005d74:	3dc080e7          	jalr	988(ra) # 8000514c <_Z8printIntiii>
    80005d78:	00003517          	auipc	a0,0x3
    80005d7c:	67050513          	addi	a0,a0,1648 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80005d80:	fffff097          	auipc	ra,0xfffff
    80005d84:	21c080e7          	jalr	540(ra) # 80004f9c <_Z11printStringPKc>
        for (uint64 j = 0; j < 100; j++) {
    80005d88:	00000493          	li	s1,0
    80005d8c:	fa1ff06f          	j	80005d2c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005d90:	00003517          	auipc	a0,0x3
    80005d94:	42850513          	addi	a0,a0,1064 # 800091b8 <_ZZ13print_integermE6digits+0x100>
    80005d98:	fffff097          	auipc	ra,0xfffff
    80005d9c:	204080e7          	jalr	516(ra) # 80004f9c <_Z11printStringPKc>
    finishedA = true;
    80005da0:	00100793          	li	a5,1
    80005da4:	00006717          	auipc	a4,0x6
    80005da8:	96f700a3          	sb	a5,-1695(a4) # 8000b705 <_ZL9finishedA>
}
    80005dac:	01813083          	ld	ra,24(sp)
    80005db0:	01013403          	ld	s0,16(sp)
    80005db4:	00813483          	ld	s1,8(sp)
    80005db8:	00013903          	ld	s2,0(sp)
    80005dbc:	02010113          	addi	sp,sp,32
    80005dc0:	00008067          	ret

0000000080005dc4 <_Z16System_Mode_testv>:


void System_Mode_test() {
    80005dc4:	fd010113          	addi	sp,sp,-48
    80005dc8:	02113423          	sd	ra,40(sp)
    80005dcc:	02813023          	sd	s0,32(sp)
    80005dd0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005dd4:	00000613          	li	a2,0
    80005dd8:	00000597          	auipc	a1,0x0
    80005ddc:	f2858593          	addi	a1,a1,-216 # 80005d00 <_ZL11workerBodyAPv>
    80005de0:	fd040513          	addi	a0,s0,-48
    80005de4:	ffffb097          	auipc	ra,0xffffb
    80005de8:	524080e7          	jalr	1316(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80005dec:	00003517          	auipc	a0,0x3
    80005df0:	44450513          	addi	a0,a0,1092 # 80009230 <_ZZ13print_integermE6digits+0x178>
    80005df4:	fffff097          	auipc	ra,0xfffff
    80005df8:	1a8080e7          	jalr	424(ra) # 80004f9c <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005dfc:	00000613          	li	a2,0
    80005e00:	00000597          	auipc	a1,0x0
    80005e04:	e1458593          	addi	a1,a1,-492 # 80005c14 <_ZL11workerBodyBPv>
    80005e08:	fd840513          	addi	a0,s0,-40
    80005e0c:	ffffb097          	auipc	ra,0xffffb
    80005e10:	4fc080e7          	jalr	1276(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80005e14:	00003517          	auipc	a0,0x3
    80005e18:	43450513          	addi	a0,a0,1076 # 80009248 <_ZZ13print_integermE6digits+0x190>
    80005e1c:	fffff097          	auipc	ra,0xfffff
    80005e20:	180080e7          	jalr	384(ra) # 80004f9c <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005e24:	00000613          	li	a2,0
    80005e28:	00000597          	auipc	a1,0x0
    80005e2c:	c6c58593          	addi	a1,a1,-916 # 80005a94 <_ZL11workerBodyCPv>
    80005e30:	fe040513          	addi	a0,s0,-32
    80005e34:	ffffb097          	auipc	ra,0xffffb
    80005e38:	4d4080e7          	jalr	1236(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80005e3c:	00003517          	auipc	a0,0x3
    80005e40:	42450513          	addi	a0,a0,1060 # 80009260 <_ZZ13print_integermE6digits+0x1a8>
    80005e44:	fffff097          	auipc	ra,0xfffff
    80005e48:	158080e7          	jalr	344(ra) # 80004f9c <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80005e4c:	00000613          	li	a2,0
    80005e50:	00000597          	auipc	a1,0x0
    80005e54:	afc58593          	addi	a1,a1,-1284 # 8000594c <_ZL11workerBodyDPv>
    80005e58:	fe840513          	addi	a0,s0,-24
    80005e5c:	ffffb097          	auipc	ra,0xffffb
    80005e60:	4ac080e7          	jalr	1196(ra) # 80001308 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    80005e64:	00003517          	auipc	a0,0x3
    80005e68:	41450513          	addi	a0,a0,1044 # 80009278 <_ZZ13print_integermE6digits+0x1c0>
    80005e6c:	fffff097          	auipc	ra,0xfffff
    80005e70:	130080e7          	jalr	304(ra) # 80004f9c <_Z11printStringPKc>
    80005e74:	00c0006f          	j	80005e80 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80005e78:	ffffb097          	auipc	ra,0xffffb
    80005e7c:	514080e7          	jalr	1300(ra) # 8000138c <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80005e80:	00006797          	auipc	a5,0x6
    80005e84:	8857c783          	lbu	a5,-1915(a5) # 8000b705 <_ZL9finishedA>
    80005e88:	fe0788e3          	beqz	a5,80005e78 <_Z16System_Mode_testv+0xb4>
    80005e8c:	00006797          	auipc	a5,0x6
    80005e90:	8787c783          	lbu	a5,-1928(a5) # 8000b704 <_ZL9finishedB>
    80005e94:	fe0782e3          	beqz	a5,80005e78 <_Z16System_Mode_testv+0xb4>
    80005e98:	00006797          	auipc	a5,0x6
    80005e9c:	86b7c783          	lbu	a5,-1941(a5) # 8000b703 <_ZL9finishedC>
    80005ea0:	fc078ce3          	beqz	a5,80005e78 <_Z16System_Mode_testv+0xb4>
    80005ea4:	00006797          	auipc	a5,0x6
    80005ea8:	85e7c783          	lbu	a5,-1954(a5) # 8000b702 <_ZL9finishedD>
    80005eac:	fc0786e3          	beqz	a5,80005e78 <_Z16System_Mode_testv+0xb4>
    }

}
    80005eb0:	02813083          	ld	ra,40(sp)
    80005eb4:	02013403          	ld	s0,32(sp)
    80005eb8:	03010113          	addi	sp,sp,48
    80005ebc:	00008067          	ret

0000000080005ec0 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005ec0:	fe010113          	addi	sp,sp,-32
    80005ec4:	00113c23          	sd	ra,24(sp)
    80005ec8:	00813823          	sd	s0,16(sp)
    80005ecc:	00913423          	sd	s1,8(sp)
    80005ed0:	01213023          	sd	s2,0(sp)
    80005ed4:	02010413          	addi	s0,sp,32
    80005ed8:	00050493          	mv	s1,a0
    80005edc:	00058913          	mv	s2,a1
    80005ee0:	0015879b          	addiw	a5,a1,1
    80005ee4:	0007851b          	sext.w	a0,a5
    80005ee8:	00f4a023          	sw	a5,0(s1)
    80005eec:	0004a823          	sw	zero,16(s1)
    80005ef0:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005ef4:	00251513          	slli	a0,a0,0x2
    80005ef8:	ffffb097          	auipc	ra,0xffffb
    80005efc:	374080e7          	jalr	884(ra) # 8000126c <_Z9mem_allocm>
    80005f00:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    80005f04:	00000593          	li	a1,0
    80005f08:	02048513          	addi	a0,s1,32
    80005f0c:	ffffb097          	auipc	ra,0xffffb
    80005f10:	4c4080e7          	jalr	1220(ra) # 800013d0 <_Z8sem_openPP9semaphorej>
    sem_open(&spaceAvailable, _cap);
    80005f14:	00090593          	mv	a1,s2
    80005f18:	01848513          	addi	a0,s1,24
    80005f1c:	ffffb097          	auipc	ra,0xffffb
    80005f20:	4b4080e7          	jalr	1204(ra) # 800013d0 <_Z8sem_openPP9semaphorej>
    sem_open(&mutexHead, 1);
    80005f24:	00100593          	li	a1,1
    80005f28:	02848513          	addi	a0,s1,40
    80005f2c:	ffffb097          	auipc	ra,0xffffb
    80005f30:	4a4080e7          	jalr	1188(ra) # 800013d0 <_Z8sem_openPP9semaphorej>
    sem_open(&mutexTail, 1);
    80005f34:	00100593          	li	a1,1
    80005f38:	03048513          	addi	a0,s1,48
    80005f3c:	ffffb097          	auipc	ra,0xffffb
    80005f40:	494080e7          	jalr	1172(ra) # 800013d0 <_Z8sem_openPP9semaphorej>
}
    80005f44:	01813083          	ld	ra,24(sp)
    80005f48:	01013403          	ld	s0,16(sp)
    80005f4c:	00813483          	ld	s1,8(sp)
    80005f50:	00013903          	ld	s2,0(sp)
    80005f54:	02010113          	addi	sp,sp,32
    80005f58:	00008067          	ret

0000000080005f5c <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80005f5c:	fe010113          	addi	sp,sp,-32
    80005f60:	00113c23          	sd	ra,24(sp)
    80005f64:	00813823          	sd	s0,16(sp)
    80005f68:	00913423          	sd	s1,8(sp)
    80005f6c:	01213023          	sd	s2,0(sp)
    80005f70:	02010413          	addi	s0,sp,32
    80005f74:	00050493          	mv	s1,a0
    80005f78:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80005f7c:	01853503          	ld	a0,24(a0)
    80005f80:	ffffb097          	auipc	ra,0xffffb
    80005f84:	4a4080e7          	jalr	1188(ra) # 80001424 <_Z8sem_waitP9semaphore>

    sem_wait(mutexTail);
    80005f88:	0304b503          	ld	a0,48(s1)
    80005f8c:	ffffb097          	auipc	ra,0xffffb
    80005f90:	498080e7          	jalr	1176(ra) # 80001424 <_Z8sem_waitP9semaphore>
    buffer[tail] = val;
    80005f94:	0084b783          	ld	a5,8(s1)
    80005f98:	0144a703          	lw	a4,20(s1)
    80005f9c:	00271713          	slli	a4,a4,0x2
    80005fa0:	00e787b3          	add	a5,a5,a4
    80005fa4:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005fa8:	0144a783          	lw	a5,20(s1)
    80005fac:	0017879b          	addiw	a5,a5,1
    80005fb0:	0004a703          	lw	a4,0(s1)
    80005fb4:	02e7e7bb          	remw	a5,a5,a4
    80005fb8:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80005fbc:	0304b503          	ld	a0,48(s1)
    80005fc0:	ffffb097          	auipc	ra,0xffffb
    80005fc4:	490080e7          	jalr	1168(ra) # 80001450 <_Z10sem_signalP9semaphore>

    sem_signal(itemAvailable);
    80005fc8:	0204b503          	ld	a0,32(s1)
    80005fcc:	ffffb097          	auipc	ra,0xffffb
    80005fd0:	484080e7          	jalr	1156(ra) # 80001450 <_Z10sem_signalP9semaphore>

}
    80005fd4:	01813083          	ld	ra,24(sp)
    80005fd8:	01013403          	ld	s0,16(sp)
    80005fdc:	00813483          	ld	s1,8(sp)
    80005fe0:	00013903          	ld	s2,0(sp)
    80005fe4:	02010113          	addi	sp,sp,32
    80005fe8:	00008067          	ret

0000000080005fec <_ZN6Buffer3getEv>:

int Buffer::get() {
    80005fec:	fe010113          	addi	sp,sp,-32
    80005ff0:	00113c23          	sd	ra,24(sp)
    80005ff4:	00813823          	sd	s0,16(sp)
    80005ff8:	00913423          	sd	s1,8(sp)
    80005ffc:	01213023          	sd	s2,0(sp)
    80006000:	02010413          	addi	s0,sp,32
    80006004:	00050493          	mv	s1,a0

    sem_wait(itemAvailable);
    80006008:	02053503          	ld	a0,32(a0)
    8000600c:	ffffb097          	auipc	ra,0xffffb
    80006010:	418080e7          	jalr	1048(ra) # 80001424 <_Z8sem_waitP9semaphore>
    sem_wait(mutexHead);
    80006014:	0284b503          	ld	a0,40(s1)
    80006018:	ffffb097          	auipc	ra,0xffffb
    8000601c:	40c080e7          	jalr	1036(ra) # 80001424 <_Z8sem_waitP9semaphore>

    int ret = buffer[head];
    80006020:	0084b703          	ld	a4,8(s1)
    80006024:	0104a783          	lw	a5,16(s1)
    80006028:	00279693          	slli	a3,a5,0x2
    8000602c:	00d70733          	add	a4,a4,a3
    80006030:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006034:	0017879b          	addiw	a5,a5,1
    80006038:	0004a703          	lw	a4,0(s1)
    8000603c:	02e7e7bb          	remw	a5,a5,a4
    80006040:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006044:	0284b503          	ld	a0,40(s1)
    80006048:	ffffb097          	auipc	ra,0xffffb
    8000604c:	408080e7          	jalr	1032(ra) # 80001450 <_Z10sem_signalP9semaphore>

    sem_signal(spaceAvailable);
    80006050:	0184b503          	ld	a0,24(s1)
    80006054:	ffffb097          	auipc	ra,0xffffb
    80006058:	3fc080e7          	jalr	1020(ra) # 80001450 <_Z10sem_signalP9semaphore>

    return ret;
}
    8000605c:	00090513          	mv	a0,s2
    80006060:	01813083          	ld	ra,24(sp)
    80006064:	01013403          	ld	s0,16(sp)
    80006068:	00813483          	ld	s1,8(sp)
    8000606c:	00013903          	ld	s2,0(sp)
    80006070:	02010113          	addi	sp,sp,32
    80006074:	00008067          	ret

0000000080006078 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006078:	fe010113          	addi	sp,sp,-32
    8000607c:	00113c23          	sd	ra,24(sp)
    80006080:	00813823          	sd	s0,16(sp)
    80006084:	00913423          	sd	s1,8(sp)
    80006088:	01213023          	sd	s2,0(sp)
    8000608c:	02010413          	addi	s0,sp,32
    80006090:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006094:	02853503          	ld	a0,40(a0)
    80006098:	ffffb097          	auipc	ra,0xffffb
    8000609c:	38c080e7          	jalr	908(ra) # 80001424 <_Z8sem_waitP9semaphore>
    sem_wait(mutexTail);
    800060a0:	0304b503          	ld	a0,48(s1)
    800060a4:	ffffb097          	auipc	ra,0xffffb
    800060a8:	380080e7          	jalr	896(ra) # 80001424 <_Z8sem_waitP9semaphore>

    if (tail >= head) {
    800060ac:	0144a783          	lw	a5,20(s1)
    800060b0:	0104a903          	lw	s2,16(s1)
    800060b4:	0327ce63          	blt	a5,s2,800060f0 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800060b8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800060bc:	0304b503          	ld	a0,48(s1)
    800060c0:	ffffb097          	auipc	ra,0xffffb
    800060c4:	390080e7          	jalr	912(ra) # 80001450 <_Z10sem_signalP9semaphore>
    sem_signal(mutexHead);
    800060c8:	0284b503          	ld	a0,40(s1)
    800060cc:	ffffb097          	auipc	ra,0xffffb
    800060d0:	384080e7          	jalr	900(ra) # 80001450 <_Z10sem_signalP9semaphore>

    return ret;
}
    800060d4:	00090513          	mv	a0,s2
    800060d8:	01813083          	ld	ra,24(sp)
    800060dc:	01013403          	ld	s0,16(sp)
    800060e0:	00813483          	ld	s1,8(sp)
    800060e4:	00013903          	ld	s2,0(sp)
    800060e8:	02010113          	addi	sp,sp,32
    800060ec:	00008067          	ret
        ret = cap - head + tail;
    800060f0:	0004a703          	lw	a4,0(s1)
    800060f4:	4127093b          	subw	s2,a4,s2
    800060f8:	00f9093b          	addw	s2,s2,a5
    800060fc:	fc1ff06f          	j	800060bc <_ZN6Buffer6getCntEv+0x44>

0000000080006100 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006100:	fe010113          	addi	sp,sp,-32
    80006104:	00113c23          	sd	ra,24(sp)
    80006108:	00813823          	sd	s0,16(sp)
    8000610c:	00913423          	sd	s1,8(sp)
    80006110:	02010413          	addi	s0,sp,32
    80006114:	00050493          	mv	s1,a0
    putc('\n');
    80006118:	00a00513          	li	a0,10
    8000611c:	ffffb097          	auipc	ra,0xffffb
    80006120:	394080e7          	jalr	916(ra) # 800014b0 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006124:	00003517          	auipc	a0,0x3
    80006128:	16c50513          	addi	a0,a0,364 # 80009290 <_ZZ13print_integermE6digits+0x1d8>
    8000612c:	fffff097          	auipc	ra,0xfffff
    80006130:	e70080e7          	jalr	-400(ra) # 80004f9c <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006134:	00048513          	mv	a0,s1
    80006138:	00000097          	auipc	ra,0x0
    8000613c:	f40080e7          	jalr	-192(ra) # 80006078 <_ZN6Buffer6getCntEv>
    80006140:	02a05c63          	blez	a0,80006178 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006144:	0084b783          	ld	a5,8(s1)
    80006148:	0104a703          	lw	a4,16(s1)
    8000614c:	00271713          	slli	a4,a4,0x2
    80006150:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006154:	0007c503          	lbu	a0,0(a5)
    80006158:	ffffb097          	auipc	ra,0xffffb
    8000615c:	358080e7          	jalr	856(ra) # 800014b0 <_Z4putcc>
        head = (head + 1) % cap;
    80006160:	0104a783          	lw	a5,16(s1)
    80006164:	0017879b          	addiw	a5,a5,1
    80006168:	0004a703          	lw	a4,0(s1)
    8000616c:	02e7e7bb          	remw	a5,a5,a4
    80006170:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006174:	fc1ff06f          	j	80006134 <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006178:	02100513          	li	a0,33
    8000617c:	ffffb097          	auipc	ra,0xffffb
    80006180:	334080e7          	jalr	820(ra) # 800014b0 <_Z4putcc>
    putc('\n');
    80006184:	00a00513          	li	a0,10
    80006188:	ffffb097          	auipc	ra,0xffffb
    8000618c:	328080e7          	jalr	808(ra) # 800014b0 <_Z4putcc>
    mem_free(buffer);
    80006190:	0084b503          	ld	a0,8(s1)
    80006194:	ffffb097          	auipc	ra,0xffffb
    80006198:	108080e7          	jalr	264(ra) # 8000129c <_Z8mem_freePv>
    sem_close(itemAvailable);
    8000619c:	0204b503          	ld	a0,32(s1)
    800061a0:	ffffb097          	auipc	ra,0xffffb
    800061a4:	25c080e7          	jalr	604(ra) # 800013fc <_Z9sem_closeP9semaphore>
    sem_close(spaceAvailable);
    800061a8:	0184b503          	ld	a0,24(s1)
    800061ac:	ffffb097          	auipc	ra,0xffffb
    800061b0:	250080e7          	jalr	592(ra) # 800013fc <_Z9sem_closeP9semaphore>
    sem_close(mutexTail);
    800061b4:	0304b503          	ld	a0,48(s1)
    800061b8:	ffffb097          	auipc	ra,0xffffb
    800061bc:	244080e7          	jalr	580(ra) # 800013fc <_Z9sem_closeP9semaphore>
    sem_close(mutexHead);
    800061c0:	0284b503          	ld	a0,40(s1)
    800061c4:	ffffb097          	auipc	ra,0xffffb
    800061c8:	238080e7          	jalr	568(ra) # 800013fc <_Z9sem_closeP9semaphore>
}
    800061cc:	01813083          	ld	ra,24(sp)
    800061d0:	01013403          	ld	s0,16(sp)
    800061d4:	00813483          	ld	s1,8(sp)
    800061d8:	02010113          	addi	sp,sp,32
    800061dc:	00008067          	ret

00000000800061e0 <start>:
    800061e0:	ff010113          	addi	sp,sp,-16
    800061e4:	00813423          	sd	s0,8(sp)
    800061e8:	01010413          	addi	s0,sp,16
    800061ec:	300027f3          	csrr	a5,mstatus
    800061f0:	ffffe737          	lui	a4,0xffffe
    800061f4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff1e8f>
    800061f8:	00e7f7b3          	and	a5,a5,a4
    800061fc:	00001737          	lui	a4,0x1
    80006200:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006204:	00e7e7b3          	or	a5,a5,a4
    80006208:	30079073          	csrw	mstatus,a5
    8000620c:	00000797          	auipc	a5,0x0
    80006210:	16078793          	addi	a5,a5,352 # 8000636c <system_main>
    80006214:	34179073          	csrw	mepc,a5
    80006218:	00000793          	li	a5,0
    8000621c:	18079073          	csrw	satp,a5
    80006220:	000107b7          	lui	a5,0x10
    80006224:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006228:	30279073          	csrw	medeleg,a5
    8000622c:	30379073          	csrw	mideleg,a5
    80006230:	104027f3          	csrr	a5,sie
    80006234:	2227e793          	ori	a5,a5,546
    80006238:	10479073          	csrw	sie,a5
    8000623c:	fff00793          	li	a5,-1
    80006240:	00a7d793          	srli	a5,a5,0xa
    80006244:	3b079073          	csrw	pmpaddr0,a5
    80006248:	00f00793          	li	a5,15
    8000624c:	3a079073          	csrw	pmpcfg0,a5
    80006250:	f14027f3          	csrr	a5,mhartid
    80006254:	0200c737          	lui	a4,0x200c
    80006258:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000625c:	0007869b          	sext.w	a3,a5
    80006260:	00269713          	slli	a4,a3,0x2
    80006264:	000f4637          	lui	a2,0xf4
    80006268:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000626c:	00d70733          	add	a4,a4,a3
    80006270:	0037979b          	slliw	a5,a5,0x3
    80006274:	020046b7          	lui	a3,0x2004
    80006278:	00d787b3          	add	a5,a5,a3
    8000627c:	00c585b3          	add	a1,a1,a2
    80006280:	00371693          	slli	a3,a4,0x3
    80006284:	00005717          	auipc	a4,0x5
    80006288:	48c70713          	addi	a4,a4,1164 # 8000b710 <timer_scratch>
    8000628c:	00b7b023          	sd	a1,0(a5)
    80006290:	00d70733          	add	a4,a4,a3
    80006294:	00f73c23          	sd	a5,24(a4)
    80006298:	02c73023          	sd	a2,32(a4)
    8000629c:	34071073          	csrw	mscratch,a4
    800062a0:	00000797          	auipc	a5,0x0
    800062a4:	6e078793          	addi	a5,a5,1760 # 80006980 <timervec>
    800062a8:	30579073          	csrw	mtvec,a5
    800062ac:	300027f3          	csrr	a5,mstatus
    800062b0:	0087e793          	ori	a5,a5,8
    800062b4:	30079073          	csrw	mstatus,a5
    800062b8:	304027f3          	csrr	a5,mie
    800062bc:	0807e793          	ori	a5,a5,128
    800062c0:	30479073          	csrw	mie,a5
    800062c4:	f14027f3          	csrr	a5,mhartid
    800062c8:	0007879b          	sext.w	a5,a5
    800062cc:	00078213          	mv	tp,a5
    800062d0:	30200073          	mret
    800062d4:	00813403          	ld	s0,8(sp)
    800062d8:	01010113          	addi	sp,sp,16
    800062dc:	00008067          	ret

00000000800062e0 <timerinit>:
    800062e0:	ff010113          	addi	sp,sp,-16
    800062e4:	00813423          	sd	s0,8(sp)
    800062e8:	01010413          	addi	s0,sp,16
    800062ec:	f14027f3          	csrr	a5,mhartid
    800062f0:	0200c737          	lui	a4,0x200c
    800062f4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800062f8:	0007869b          	sext.w	a3,a5
    800062fc:	00269713          	slli	a4,a3,0x2
    80006300:	000f4637          	lui	a2,0xf4
    80006304:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006308:	00d70733          	add	a4,a4,a3
    8000630c:	0037979b          	slliw	a5,a5,0x3
    80006310:	020046b7          	lui	a3,0x2004
    80006314:	00d787b3          	add	a5,a5,a3
    80006318:	00c585b3          	add	a1,a1,a2
    8000631c:	00371693          	slli	a3,a4,0x3
    80006320:	00005717          	auipc	a4,0x5
    80006324:	3f070713          	addi	a4,a4,1008 # 8000b710 <timer_scratch>
    80006328:	00b7b023          	sd	a1,0(a5)
    8000632c:	00d70733          	add	a4,a4,a3
    80006330:	00f73c23          	sd	a5,24(a4)
    80006334:	02c73023          	sd	a2,32(a4)
    80006338:	34071073          	csrw	mscratch,a4
    8000633c:	00000797          	auipc	a5,0x0
    80006340:	64478793          	addi	a5,a5,1604 # 80006980 <timervec>
    80006344:	30579073          	csrw	mtvec,a5
    80006348:	300027f3          	csrr	a5,mstatus
    8000634c:	0087e793          	ori	a5,a5,8
    80006350:	30079073          	csrw	mstatus,a5
    80006354:	304027f3          	csrr	a5,mie
    80006358:	0807e793          	ori	a5,a5,128
    8000635c:	30479073          	csrw	mie,a5
    80006360:	00813403          	ld	s0,8(sp)
    80006364:	01010113          	addi	sp,sp,16
    80006368:	00008067          	ret

000000008000636c <system_main>:
    8000636c:	fe010113          	addi	sp,sp,-32
    80006370:	00813823          	sd	s0,16(sp)
    80006374:	00913423          	sd	s1,8(sp)
    80006378:	00113c23          	sd	ra,24(sp)
    8000637c:	02010413          	addi	s0,sp,32
    80006380:	00000097          	auipc	ra,0x0
    80006384:	0c4080e7          	jalr	196(ra) # 80006444 <cpuid>
    80006388:	00005497          	auipc	s1,0x5
    8000638c:	2d848493          	addi	s1,s1,728 # 8000b660 <started>
    80006390:	02050263          	beqz	a0,800063b4 <system_main+0x48>
    80006394:	0004a783          	lw	a5,0(s1)
    80006398:	0007879b          	sext.w	a5,a5
    8000639c:	fe078ce3          	beqz	a5,80006394 <system_main+0x28>
    800063a0:	0ff0000f          	fence
    800063a4:	00003517          	auipc	a0,0x3
    800063a8:	1c450513          	addi	a0,a0,452 # 80009568 <_ZZ13print_integermE6digits+0x4b0>
    800063ac:	00001097          	auipc	ra,0x1
    800063b0:	a70080e7          	jalr	-1424(ra) # 80006e1c <panic>
    800063b4:	00001097          	auipc	ra,0x1
    800063b8:	9c4080e7          	jalr	-1596(ra) # 80006d78 <consoleinit>
    800063bc:	00001097          	auipc	ra,0x1
    800063c0:	150080e7          	jalr	336(ra) # 8000750c <printfinit>
    800063c4:	00003517          	auipc	a0,0x3
    800063c8:	02450513          	addi	a0,a0,36 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800063cc:	00001097          	auipc	ra,0x1
    800063d0:	aac080e7          	jalr	-1364(ra) # 80006e78 <__printf>
    800063d4:	00003517          	auipc	a0,0x3
    800063d8:	16450513          	addi	a0,a0,356 # 80009538 <_ZZ13print_integermE6digits+0x480>
    800063dc:	00001097          	auipc	ra,0x1
    800063e0:	a9c080e7          	jalr	-1380(ra) # 80006e78 <__printf>
    800063e4:	00003517          	auipc	a0,0x3
    800063e8:	00450513          	addi	a0,a0,4 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    800063ec:	00001097          	auipc	ra,0x1
    800063f0:	a8c080e7          	jalr	-1396(ra) # 80006e78 <__printf>
    800063f4:	00001097          	auipc	ra,0x1
    800063f8:	4a4080e7          	jalr	1188(ra) # 80007898 <kinit>
    800063fc:	00000097          	auipc	ra,0x0
    80006400:	148080e7          	jalr	328(ra) # 80006544 <trapinit>
    80006404:	00000097          	auipc	ra,0x0
    80006408:	16c080e7          	jalr	364(ra) # 80006570 <trapinithart>
    8000640c:	00000097          	auipc	ra,0x0
    80006410:	5b4080e7          	jalr	1460(ra) # 800069c0 <plicinit>
    80006414:	00000097          	auipc	ra,0x0
    80006418:	5d4080e7          	jalr	1492(ra) # 800069e8 <plicinithart>
    8000641c:	00000097          	auipc	ra,0x0
    80006420:	078080e7          	jalr	120(ra) # 80006494 <userinit>
    80006424:	0ff0000f          	fence
    80006428:	00100793          	li	a5,1
    8000642c:	00003517          	auipc	a0,0x3
    80006430:	12450513          	addi	a0,a0,292 # 80009550 <_ZZ13print_integermE6digits+0x498>
    80006434:	00f4a023          	sw	a5,0(s1)
    80006438:	00001097          	auipc	ra,0x1
    8000643c:	a40080e7          	jalr	-1472(ra) # 80006e78 <__printf>
    80006440:	0000006f          	j	80006440 <system_main+0xd4>

0000000080006444 <cpuid>:
    80006444:	ff010113          	addi	sp,sp,-16
    80006448:	00813423          	sd	s0,8(sp)
    8000644c:	01010413          	addi	s0,sp,16
    80006450:	00020513          	mv	a0,tp
    80006454:	00813403          	ld	s0,8(sp)
    80006458:	0005051b          	sext.w	a0,a0
    8000645c:	01010113          	addi	sp,sp,16
    80006460:	00008067          	ret

0000000080006464 <mycpu>:
    80006464:	ff010113          	addi	sp,sp,-16
    80006468:	00813423          	sd	s0,8(sp)
    8000646c:	01010413          	addi	s0,sp,16
    80006470:	00020793          	mv	a5,tp
    80006474:	00813403          	ld	s0,8(sp)
    80006478:	0007879b          	sext.w	a5,a5
    8000647c:	00779793          	slli	a5,a5,0x7
    80006480:	00006517          	auipc	a0,0x6
    80006484:	2c050513          	addi	a0,a0,704 # 8000c740 <cpus>
    80006488:	00f50533          	add	a0,a0,a5
    8000648c:	01010113          	addi	sp,sp,16
    80006490:	00008067          	ret

0000000080006494 <userinit>:
    80006494:	ff010113          	addi	sp,sp,-16
    80006498:	00813423          	sd	s0,8(sp)
    8000649c:	01010413          	addi	s0,sp,16
    800064a0:	00813403          	ld	s0,8(sp)
    800064a4:	01010113          	addi	sp,sp,16
    800064a8:	ffffb317          	auipc	t1,0xffffb
    800064ac:	4e030067          	jr	1248(t1) # 80001988 <main>

00000000800064b0 <either_copyout>:
    800064b0:	ff010113          	addi	sp,sp,-16
    800064b4:	00813023          	sd	s0,0(sp)
    800064b8:	00113423          	sd	ra,8(sp)
    800064bc:	01010413          	addi	s0,sp,16
    800064c0:	02051663          	bnez	a0,800064ec <either_copyout+0x3c>
    800064c4:	00058513          	mv	a0,a1
    800064c8:	00060593          	mv	a1,a2
    800064cc:	0006861b          	sext.w	a2,a3
    800064d0:	00002097          	auipc	ra,0x2
    800064d4:	c54080e7          	jalr	-940(ra) # 80008124 <__memmove>
    800064d8:	00813083          	ld	ra,8(sp)
    800064dc:	00013403          	ld	s0,0(sp)
    800064e0:	00000513          	li	a0,0
    800064e4:	01010113          	addi	sp,sp,16
    800064e8:	00008067          	ret
    800064ec:	00003517          	auipc	a0,0x3
    800064f0:	0a450513          	addi	a0,a0,164 # 80009590 <_ZZ13print_integermE6digits+0x4d8>
    800064f4:	00001097          	auipc	ra,0x1
    800064f8:	928080e7          	jalr	-1752(ra) # 80006e1c <panic>

00000000800064fc <either_copyin>:
    800064fc:	ff010113          	addi	sp,sp,-16
    80006500:	00813023          	sd	s0,0(sp)
    80006504:	00113423          	sd	ra,8(sp)
    80006508:	01010413          	addi	s0,sp,16
    8000650c:	02059463          	bnez	a1,80006534 <either_copyin+0x38>
    80006510:	00060593          	mv	a1,a2
    80006514:	0006861b          	sext.w	a2,a3
    80006518:	00002097          	auipc	ra,0x2
    8000651c:	c0c080e7          	jalr	-1012(ra) # 80008124 <__memmove>
    80006520:	00813083          	ld	ra,8(sp)
    80006524:	00013403          	ld	s0,0(sp)
    80006528:	00000513          	li	a0,0
    8000652c:	01010113          	addi	sp,sp,16
    80006530:	00008067          	ret
    80006534:	00003517          	auipc	a0,0x3
    80006538:	08450513          	addi	a0,a0,132 # 800095b8 <_ZZ13print_integermE6digits+0x500>
    8000653c:	00001097          	auipc	ra,0x1
    80006540:	8e0080e7          	jalr	-1824(ra) # 80006e1c <panic>

0000000080006544 <trapinit>:
    80006544:	ff010113          	addi	sp,sp,-16
    80006548:	00813423          	sd	s0,8(sp)
    8000654c:	01010413          	addi	s0,sp,16
    80006550:	00813403          	ld	s0,8(sp)
    80006554:	00003597          	auipc	a1,0x3
    80006558:	08c58593          	addi	a1,a1,140 # 800095e0 <_ZZ13print_integermE6digits+0x528>
    8000655c:	00006517          	auipc	a0,0x6
    80006560:	26450513          	addi	a0,a0,612 # 8000c7c0 <tickslock>
    80006564:	01010113          	addi	sp,sp,16
    80006568:	00001317          	auipc	t1,0x1
    8000656c:	5c030067          	jr	1472(t1) # 80007b28 <initlock>

0000000080006570 <trapinithart>:
    80006570:	ff010113          	addi	sp,sp,-16
    80006574:	00813423          	sd	s0,8(sp)
    80006578:	01010413          	addi	s0,sp,16
    8000657c:	00000797          	auipc	a5,0x0
    80006580:	2f478793          	addi	a5,a5,756 # 80006870 <kernelvec>
    80006584:	10579073          	csrw	stvec,a5
    80006588:	00813403          	ld	s0,8(sp)
    8000658c:	01010113          	addi	sp,sp,16
    80006590:	00008067          	ret

0000000080006594 <usertrap>:
    80006594:	ff010113          	addi	sp,sp,-16
    80006598:	00813423          	sd	s0,8(sp)
    8000659c:	01010413          	addi	s0,sp,16
    800065a0:	00813403          	ld	s0,8(sp)
    800065a4:	01010113          	addi	sp,sp,16
    800065a8:	00008067          	ret

00000000800065ac <usertrapret>:
    800065ac:	ff010113          	addi	sp,sp,-16
    800065b0:	00813423          	sd	s0,8(sp)
    800065b4:	01010413          	addi	s0,sp,16
    800065b8:	00813403          	ld	s0,8(sp)
    800065bc:	01010113          	addi	sp,sp,16
    800065c0:	00008067          	ret

00000000800065c4 <kerneltrap>:
    800065c4:	fe010113          	addi	sp,sp,-32
    800065c8:	00813823          	sd	s0,16(sp)
    800065cc:	00113c23          	sd	ra,24(sp)
    800065d0:	00913423          	sd	s1,8(sp)
    800065d4:	02010413          	addi	s0,sp,32
    800065d8:	142025f3          	csrr	a1,scause
    800065dc:	100027f3          	csrr	a5,sstatus
    800065e0:	0027f793          	andi	a5,a5,2
    800065e4:	10079c63          	bnez	a5,800066fc <kerneltrap+0x138>
    800065e8:	142027f3          	csrr	a5,scause
    800065ec:	0207ce63          	bltz	a5,80006628 <kerneltrap+0x64>
    800065f0:	00003517          	auipc	a0,0x3
    800065f4:	03850513          	addi	a0,a0,56 # 80009628 <_ZZ13print_integermE6digits+0x570>
    800065f8:	00001097          	auipc	ra,0x1
    800065fc:	880080e7          	jalr	-1920(ra) # 80006e78 <__printf>
    80006600:	141025f3          	csrr	a1,sepc
    80006604:	14302673          	csrr	a2,stval
    80006608:	00003517          	auipc	a0,0x3
    8000660c:	03050513          	addi	a0,a0,48 # 80009638 <_ZZ13print_integermE6digits+0x580>
    80006610:	00001097          	auipc	ra,0x1
    80006614:	868080e7          	jalr	-1944(ra) # 80006e78 <__printf>
    80006618:	00003517          	auipc	a0,0x3
    8000661c:	03850513          	addi	a0,a0,56 # 80009650 <_ZZ13print_integermE6digits+0x598>
    80006620:	00000097          	auipc	ra,0x0
    80006624:	7fc080e7          	jalr	2044(ra) # 80006e1c <panic>
    80006628:	0ff7f713          	andi	a4,a5,255
    8000662c:	00900693          	li	a3,9
    80006630:	04d70063          	beq	a4,a3,80006670 <kerneltrap+0xac>
    80006634:	fff00713          	li	a4,-1
    80006638:	03f71713          	slli	a4,a4,0x3f
    8000663c:	00170713          	addi	a4,a4,1
    80006640:	fae798e3          	bne	a5,a4,800065f0 <kerneltrap+0x2c>
    80006644:	00000097          	auipc	ra,0x0
    80006648:	e00080e7          	jalr	-512(ra) # 80006444 <cpuid>
    8000664c:	06050663          	beqz	a0,800066b8 <kerneltrap+0xf4>
    80006650:	144027f3          	csrr	a5,sip
    80006654:	ffd7f793          	andi	a5,a5,-3
    80006658:	14479073          	csrw	sip,a5
    8000665c:	01813083          	ld	ra,24(sp)
    80006660:	01013403          	ld	s0,16(sp)
    80006664:	00813483          	ld	s1,8(sp)
    80006668:	02010113          	addi	sp,sp,32
    8000666c:	00008067          	ret
    80006670:	00000097          	auipc	ra,0x0
    80006674:	3c4080e7          	jalr	964(ra) # 80006a34 <plic_claim>
    80006678:	00a00793          	li	a5,10
    8000667c:	00050493          	mv	s1,a0
    80006680:	06f50863          	beq	a0,a5,800066f0 <kerneltrap+0x12c>
    80006684:	fc050ce3          	beqz	a0,8000665c <kerneltrap+0x98>
    80006688:	00050593          	mv	a1,a0
    8000668c:	00003517          	auipc	a0,0x3
    80006690:	f7c50513          	addi	a0,a0,-132 # 80009608 <_ZZ13print_integermE6digits+0x550>
    80006694:	00000097          	auipc	ra,0x0
    80006698:	7e4080e7          	jalr	2020(ra) # 80006e78 <__printf>
    8000669c:	01013403          	ld	s0,16(sp)
    800066a0:	01813083          	ld	ra,24(sp)
    800066a4:	00048513          	mv	a0,s1
    800066a8:	00813483          	ld	s1,8(sp)
    800066ac:	02010113          	addi	sp,sp,32
    800066b0:	00000317          	auipc	t1,0x0
    800066b4:	3bc30067          	jr	956(t1) # 80006a6c <plic_complete>
    800066b8:	00006517          	auipc	a0,0x6
    800066bc:	10850513          	addi	a0,a0,264 # 8000c7c0 <tickslock>
    800066c0:	00001097          	auipc	ra,0x1
    800066c4:	48c080e7          	jalr	1164(ra) # 80007b4c <acquire>
    800066c8:	00005717          	auipc	a4,0x5
    800066cc:	f9c70713          	addi	a4,a4,-100 # 8000b664 <ticks>
    800066d0:	00072783          	lw	a5,0(a4)
    800066d4:	00006517          	auipc	a0,0x6
    800066d8:	0ec50513          	addi	a0,a0,236 # 8000c7c0 <tickslock>
    800066dc:	0017879b          	addiw	a5,a5,1
    800066e0:	00f72023          	sw	a5,0(a4)
    800066e4:	00001097          	auipc	ra,0x1
    800066e8:	534080e7          	jalr	1332(ra) # 80007c18 <release>
    800066ec:	f65ff06f          	j	80006650 <kerneltrap+0x8c>
    800066f0:	00001097          	auipc	ra,0x1
    800066f4:	090080e7          	jalr	144(ra) # 80007780 <uartintr>
    800066f8:	fa5ff06f          	j	8000669c <kerneltrap+0xd8>
    800066fc:	00003517          	auipc	a0,0x3
    80006700:	eec50513          	addi	a0,a0,-276 # 800095e8 <_ZZ13print_integermE6digits+0x530>
    80006704:	00000097          	auipc	ra,0x0
    80006708:	718080e7          	jalr	1816(ra) # 80006e1c <panic>

000000008000670c <clockintr>:
    8000670c:	fe010113          	addi	sp,sp,-32
    80006710:	00813823          	sd	s0,16(sp)
    80006714:	00913423          	sd	s1,8(sp)
    80006718:	00113c23          	sd	ra,24(sp)
    8000671c:	02010413          	addi	s0,sp,32
    80006720:	00006497          	auipc	s1,0x6
    80006724:	0a048493          	addi	s1,s1,160 # 8000c7c0 <tickslock>
    80006728:	00048513          	mv	a0,s1
    8000672c:	00001097          	auipc	ra,0x1
    80006730:	420080e7          	jalr	1056(ra) # 80007b4c <acquire>
    80006734:	00005717          	auipc	a4,0x5
    80006738:	f3070713          	addi	a4,a4,-208 # 8000b664 <ticks>
    8000673c:	00072783          	lw	a5,0(a4)
    80006740:	01013403          	ld	s0,16(sp)
    80006744:	01813083          	ld	ra,24(sp)
    80006748:	00048513          	mv	a0,s1
    8000674c:	0017879b          	addiw	a5,a5,1
    80006750:	00813483          	ld	s1,8(sp)
    80006754:	00f72023          	sw	a5,0(a4)
    80006758:	02010113          	addi	sp,sp,32
    8000675c:	00001317          	auipc	t1,0x1
    80006760:	4bc30067          	jr	1212(t1) # 80007c18 <release>

0000000080006764 <devintr>:
    80006764:	142027f3          	csrr	a5,scause
    80006768:	00000513          	li	a0,0
    8000676c:	0007c463          	bltz	a5,80006774 <devintr+0x10>
    80006770:	00008067          	ret
    80006774:	fe010113          	addi	sp,sp,-32
    80006778:	00813823          	sd	s0,16(sp)
    8000677c:	00113c23          	sd	ra,24(sp)
    80006780:	00913423          	sd	s1,8(sp)
    80006784:	02010413          	addi	s0,sp,32
    80006788:	0ff7f713          	andi	a4,a5,255
    8000678c:	00900693          	li	a3,9
    80006790:	04d70c63          	beq	a4,a3,800067e8 <devintr+0x84>
    80006794:	fff00713          	li	a4,-1
    80006798:	03f71713          	slli	a4,a4,0x3f
    8000679c:	00170713          	addi	a4,a4,1
    800067a0:	00e78c63          	beq	a5,a4,800067b8 <devintr+0x54>
    800067a4:	01813083          	ld	ra,24(sp)
    800067a8:	01013403          	ld	s0,16(sp)
    800067ac:	00813483          	ld	s1,8(sp)
    800067b0:	02010113          	addi	sp,sp,32
    800067b4:	00008067          	ret
    800067b8:	00000097          	auipc	ra,0x0
    800067bc:	c8c080e7          	jalr	-884(ra) # 80006444 <cpuid>
    800067c0:	06050663          	beqz	a0,8000682c <devintr+0xc8>
    800067c4:	144027f3          	csrr	a5,sip
    800067c8:	ffd7f793          	andi	a5,a5,-3
    800067cc:	14479073          	csrw	sip,a5
    800067d0:	01813083          	ld	ra,24(sp)
    800067d4:	01013403          	ld	s0,16(sp)
    800067d8:	00813483          	ld	s1,8(sp)
    800067dc:	00200513          	li	a0,2
    800067e0:	02010113          	addi	sp,sp,32
    800067e4:	00008067          	ret
    800067e8:	00000097          	auipc	ra,0x0
    800067ec:	24c080e7          	jalr	588(ra) # 80006a34 <plic_claim>
    800067f0:	00a00793          	li	a5,10
    800067f4:	00050493          	mv	s1,a0
    800067f8:	06f50663          	beq	a0,a5,80006864 <devintr+0x100>
    800067fc:	00100513          	li	a0,1
    80006800:	fa0482e3          	beqz	s1,800067a4 <devintr+0x40>
    80006804:	00048593          	mv	a1,s1
    80006808:	00003517          	auipc	a0,0x3
    8000680c:	e0050513          	addi	a0,a0,-512 # 80009608 <_ZZ13print_integermE6digits+0x550>
    80006810:	00000097          	auipc	ra,0x0
    80006814:	668080e7          	jalr	1640(ra) # 80006e78 <__printf>
    80006818:	00048513          	mv	a0,s1
    8000681c:	00000097          	auipc	ra,0x0
    80006820:	250080e7          	jalr	592(ra) # 80006a6c <plic_complete>
    80006824:	00100513          	li	a0,1
    80006828:	f7dff06f          	j	800067a4 <devintr+0x40>
    8000682c:	00006517          	auipc	a0,0x6
    80006830:	f9450513          	addi	a0,a0,-108 # 8000c7c0 <tickslock>
    80006834:	00001097          	auipc	ra,0x1
    80006838:	318080e7          	jalr	792(ra) # 80007b4c <acquire>
    8000683c:	00005717          	auipc	a4,0x5
    80006840:	e2870713          	addi	a4,a4,-472 # 8000b664 <ticks>
    80006844:	00072783          	lw	a5,0(a4)
    80006848:	00006517          	auipc	a0,0x6
    8000684c:	f7850513          	addi	a0,a0,-136 # 8000c7c0 <tickslock>
    80006850:	0017879b          	addiw	a5,a5,1
    80006854:	00f72023          	sw	a5,0(a4)
    80006858:	00001097          	auipc	ra,0x1
    8000685c:	3c0080e7          	jalr	960(ra) # 80007c18 <release>
    80006860:	f65ff06f          	j	800067c4 <devintr+0x60>
    80006864:	00001097          	auipc	ra,0x1
    80006868:	f1c080e7          	jalr	-228(ra) # 80007780 <uartintr>
    8000686c:	fadff06f          	j	80006818 <devintr+0xb4>

0000000080006870 <kernelvec>:
    80006870:	f0010113          	addi	sp,sp,-256
    80006874:	00113023          	sd	ra,0(sp)
    80006878:	00213423          	sd	sp,8(sp)
    8000687c:	00313823          	sd	gp,16(sp)
    80006880:	00413c23          	sd	tp,24(sp)
    80006884:	02513023          	sd	t0,32(sp)
    80006888:	02613423          	sd	t1,40(sp)
    8000688c:	02713823          	sd	t2,48(sp)
    80006890:	02813c23          	sd	s0,56(sp)
    80006894:	04913023          	sd	s1,64(sp)
    80006898:	04a13423          	sd	a0,72(sp)
    8000689c:	04b13823          	sd	a1,80(sp)
    800068a0:	04c13c23          	sd	a2,88(sp)
    800068a4:	06d13023          	sd	a3,96(sp)
    800068a8:	06e13423          	sd	a4,104(sp)
    800068ac:	06f13823          	sd	a5,112(sp)
    800068b0:	07013c23          	sd	a6,120(sp)
    800068b4:	09113023          	sd	a7,128(sp)
    800068b8:	09213423          	sd	s2,136(sp)
    800068bc:	09313823          	sd	s3,144(sp)
    800068c0:	09413c23          	sd	s4,152(sp)
    800068c4:	0b513023          	sd	s5,160(sp)
    800068c8:	0b613423          	sd	s6,168(sp)
    800068cc:	0b713823          	sd	s7,176(sp)
    800068d0:	0b813c23          	sd	s8,184(sp)
    800068d4:	0d913023          	sd	s9,192(sp)
    800068d8:	0da13423          	sd	s10,200(sp)
    800068dc:	0db13823          	sd	s11,208(sp)
    800068e0:	0dc13c23          	sd	t3,216(sp)
    800068e4:	0fd13023          	sd	t4,224(sp)
    800068e8:	0fe13423          	sd	t5,232(sp)
    800068ec:	0ff13823          	sd	t6,240(sp)
    800068f0:	cd5ff0ef          	jal	ra,800065c4 <kerneltrap>
    800068f4:	00013083          	ld	ra,0(sp)
    800068f8:	00813103          	ld	sp,8(sp)
    800068fc:	01013183          	ld	gp,16(sp)
    80006900:	02013283          	ld	t0,32(sp)
    80006904:	02813303          	ld	t1,40(sp)
    80006908:	03013383          	ld	t2,48(sp)
    8000690c:	03813403          	ld	s0,56(sp)
    80006910:	04013483          	ld	s1,64(sp)
    80006914:	04813503          	ld	a0,72(sp)
    80006918:	05013583          	ld	a1,80(sp)
    8000691c:	05813603          	ld	a2,88(sp)
    80006920:	06013683          	ld	a3,96(sp)
    80006924:	06813703          	ld	a4,104(sp)
    80006928:	07013783          	ld	a5,112(sp)
    8000692c:	07813803          	ld	a6,120(sp)
    80006930:	08013883          	ld	a7,128(sp)
    80006934:	08813903          	ld	s2,136(sp)
    80006938:	09013983          	ld	s3,144(sp)
    8000693c:	09813a03          	ld	s4,152(sp)
    80006940:	0a013a83          	ld	s5,160(sp)
    80006944:	0a813b03          	ld	s6,168(sp)
    80006948:	0b013b83          	ld	s7,176(sp)
    8000694c:	0b813c03          	ld	s8,184(sp)
    80006950:	0c013c83          	ld	s9,192(sp)
    80006954:	0c813d03          	ld	s10,200(sp)
    80006958:	0d013d83          	ld	s11,208(sp)
    8000695c:	0d813e03          	ld	t3,216(sp)
    80006960:	0e013e83          	ld	t4,224(sp)
    80006964:	0e813f03          	ld	t5,232(sp)
    80006968:	0f013f83          	ld	t6,240(sp)
    8000696c:	10010113          	addi	sp,sp,256
    80006970:	10200073          	sret
    80006974:	00000013          	nop
    80006978:	00000013          	nop
    8000697c:	00000013          	nop

0000000080006980 <timervec>:
    80006980:	34051573          	csrrw	a0,mscratch,a0
    80006984:	00b53023          	sd	a1,0(a0)
    80006988:	00c53423          	sd	a2,8(a0)
    8000698c:	00d53823          	sd	a3,16(a0)
    80006990:	01853583          	ld	a1,24(a0)
    80006994:	02053603          	ld	a2,32(a0)
    80006998:	0005b683          	ld	a3,0(a1)
    8000699c:	00c686b3          	add	a3,a3,a2
    800069a0:	00d5b023          	sd	a3,0(a1)
    800069a4:	00200593          	li	a1,2
    800069a8:	14459073          	csrw	sip,a1
    800069ac:	01053683          	ld	a3,16(a0)
    800069b0:	00853603          	ld	a2,8(a0)
    800069b4:	00053583          	ld	a1,0(a0)
    800069b8:	34051573          	csrrw	a0,mscratch,a0
    800069bc:	30200073          	mret

00000000800069c0 <plicinit>:
    800069c0:	ff010113          	addi	sp,sp,-16
    800069c4:	00813423          	sd	s0,8(sp)
    800069c8:	01010413          	addi	s0,sp,16
    800069cc:	00813403          	ld	s0,8(sp)
    800069d0:	0c0007b7          	lui	a5,0xc000
    800069d4:	00100713          	li	a4,1
    800069d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800069dc:	00e7a223          	sw	a4,4(a5)
    800069e0:	01010113          	addi	sp,sp,16
    800069e4:	00008067          	ret

00000000800069e8 <plicinithart>:
    800069e8:	ff010113          	addi	sp,sp,-16
    800069ec:	00813023          	sd	s0,0(sp)
    800069f0:	00113423          	sd	ra,8(sp)
    800069f4:	01010413          	addi	s0,sp,16
    800069f8:	00000097          	auipc	ra,0x0
    800069fc:	a4c080e7          	jalr	-1460(ra) # 80006444 <cpuid>
    80006a00:	0085171b          	slliw	a4,a0,0x8
    80006a04:	0c0027b7          	lui	a5,0xc002
    80006a08:	00e787b3          	add	a5,a5,a4
    80006a0c:	40200713          	li	a4,1026
    80006a10:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80006a14:	00813083          	ld	ra,8(sp)
    80006a18:	00013403          	ld	s0,0(sp)
    80006a1c:	00d5151b          	slliw	a0,a0,0xd
    80006a20:	0c2017b7          	lui	a5,0xc201
    80006a24:	00a78533          	add	a0,a5,a0
    80006a28:	00052023          	sw	zero,0(a0)
    80006a2c:	01010113          	addi	sp,sp,16
    80006a30:	00008067          	ret

0000000080006a34 <plic_claim>:
    80006a34:	ff010113          	addi	sp,sp,-16
    80006a38:	00813023          	sd	s0,0(sp)
    80006a3c:	00113423          	sd	ra,8(sp)
    80006a40:	01010413          	addi	s0,sp,16
    80006a44:	00000097          	auipc	ra,0x0
    80006a48:	a00080e7          	jalr	-1536(ra) # 80006444 <cpuid>
    80006a4c:	00813083          	ld	ra,8(sp)
    80006a50:	00013403          	ld	s0,0(sp)
    80006a54:	00d5151b          	slliw	a0,a0,0xd
    80006a58:	0c2017b7          	lui	a5,0xc201
    80006a5c:	00a78533          	add	a0,a5,a0
    80006a60:	00452503          	lw	a0,4(a0)
    80006a64:	01010113          	addi	sp,sp,16
    80006a68:	00008067          	ret

0000000080006a6c <plic_complete>:
    80006a6c:	fe010113          	addi	sp,sp,-32
    80006a70:	00813823          	sd	s0,16(sp)
    80006a74:	00913423          	sd	s1,8(sp)
    80006a78:	00113c23          	sd	ra,24(sp)
    80006a7c:	02010413          	addi	s0,sp,32
    80006a80:	00050493          	mv	s1,a0
    80006a84:	00000097          	auipc	ra,0x0
    80006a88:	9c0080e7          	jalr	-1600(ra) # 80006444 <cpuid>
    80006a8c:	01813083          	ld	ra,24(sp)
    80006a90:	01013403          	ld	s0,16(sp)
    80006a94:	00d5179b          	slliw	a5,a0,0xd
    80006a98:	0c201737          	lui	a4,0xc201
    80006a9c:	00f707b3          	add	a5,a4,a5
    80006aa0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80006aa4:	00813483          	ld	s1,8(sp)
    80006aa8:	02010113          	addi	sp,sp,32
    80006aac:	00008067          	ret

0000000080006ab0 <consolewrite>:
    80006ab0:	fb010113          	addi	sp,sp,-80
    80006ab4:	04813023          	sd	s0,64(sp)
    80006ab8:	04113423          	sd	ra,72(sp)
    80006abc:	02913c23          	sd	s1,56(sp)
    80006ac0:	03213823          	sd	s2,48(sp)
    80006ac4:	03313423          	sd	s3,40(sp)
    80006ac8:	03413023          	sd	s4,32(sp)
    80006acc:	01513c23          	sd	s5,24(sp)
    80006ad0:	05010413          	addi	s0,sp,80
    80006ad4:	06c05c63          	blez	a2,80006b4c <consolewrite+0x9c>
    80006ad8:	00060993          	mv	s3,a2
    80006adc:	00050a13          	mv	s4,a0
    80006ae0:	00058493          	mv	s1,a1
    80006ae4:	00000913          	li	s2,0
    80006ae8:	fff00a93          	li	s5,-1
    80006aec:	01c0006f          	j	80006b08 <consolewrite+0x58>
    80006af0:	fbf44503          	lbu	a0,-65(s0)
    80006af4:	0019091b          	addiw	s2,s2,1
    80006af8:	00148493          	addi	s1,s1,1
    80006afc:	00001097          	auipc	ra,0x1
    80006b00:	a9c080e7          	jalr	-1380(ra) # 80007598 <uartputc>
    80006b04:	03298063          	beq	s3,s2,80006b24 <consolewrite+0x74>
    80006b08:	00048613          	mv	a2,s1
    80006b0c:	00100693          	li	a3,1
    80006b10:	000a0593          	mv	a1,s4
    80006b14:	fbf40513          	addi	a0,s0,-65
    80006b18:	00000097          	auipc	ra,0x0
    80006b1c:	9e4080e7          	jalr	-1564(ra) # 800064fc <either_copyin>
    80006b20:	fd5518e3          	bne	a0,s5,80006af0 <consolewrite+0x40>
    80006b24:	04813083          	ld	ra,72(sp)
    80006b28:	04013403          	ld	s0,64(sp)
    80006b2c:	03813483          	ld	s1,56(sp)
    80006b30:	02813983          	ld	s3,40(sp)
    80006b34:	02013a03          	ld	s4,32(sp)
    80006b38:	01813a83          	ld	s5,24(sp)
    80006b3c:	00090513          	mv	a0,s2
    80006b40:	03013903          	ld	s2,48(sp)
    80006b44:	05010113          	addi	sp,sp,80
    80006b48:	00008067          	ret
    80006b4c:	00000913          	li	s2,0
    80006b50:	fd5ff06f          	j	80006b24 <consolewrite+0x74>

0000000080006b54 <consoleread>:
    80006b54:	f9010113          	addi	sp,sp,-112
    80006b58:	06813023          	sd	s0,96(sp)
    80006b5c:	04913c23          	sd	s1,88(sp)
    80006b60:	05213823          	sd	s2,80(sp)
    80006b64:	05313423          	sd	s3,72(sp)
    80006b68:	05413023          	sd	s4,64(sp)
    80006b6c:	03513c23          	sd	s5,56(sp)
    80006b70:	03613823          	sd	s6,48(sp)
    80006b74:	03713423          	sd	s7,40(sp)
    80006b78:	03813023          	sd	s8,32(sp)
    80006b7c:	06113423          	sd	ra,104(sp)
    80006b80:	01913c23          	sd	s9,24(sp)
    80006b84:	07010413          	addi	s0,sp,112
    80006b88:	00060b93          	mv	s7,a2
    80006b8c:	00050913          	mv	s2,a0
    80006b90:	00058c13          	mv	s8,a1
    80006b94:	00060b1b          	sext.w	s6,a2
    80006b98:	00006497          	auipc	s1,0x6
    80006b9c:	c5048493          	addi	s1,s1,-944 # 8000c7e8 <cons>
    80006ba0:	00400993          	li	s3,4
    80006ba4:	fff00a13          	li	s4,-1
    80006ba8:	00a00a93          	li	s5,10
    80006bac:	05705e63          	blez	s7,80006c08 <consoleread+0xb4>
    80006bb0:	09c4a703          	lw	a4,156(s1)
    80006bb4:	0984a783          	lw	a5,152(s1)
    80006bb8:	0007071b          	sext.w	a4,a4
    80006bbc:	08e78463          	beq	a5,a4,80006c44 <consoleread+0xf0>
    80006bc0:	07f7f713          	andi	a4,a5,127
    80006bc4:	00e48733          	add	a4,s1,a4
    80006bc8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80006bcc:	0017869b          	addiw	a3,a5,1
    80006bd0:	08d4ac23          	sw	a3,152(s1)
    80006bd4:	00070c9b          	sext.w	s9,a4
    80006bd8:	0b370663          	beq	a4,s3,80006c84 <consoleread+0x130>
    80006bdc:	00100693          	li	a3,1
    80006be0:	f9f40613          	addi	a2,s0,-97
    80006be4:	000c0593          	mv	a1,s8
    80006be8:	00090513          	mv	a0,s2
    80006bec:	f8e40fa3          	sb	a4,-97(s0)
    80006bf0:	00000097          	auipc	ra,0x0
    80006bf4:	8c0080e7          	jalr	-1856(ra) # 800064b0 <either_copyout>
    80006bf8:	01450863          	beq	a0,s4,80006c08 <consoleread+0xb4>
    80006bfc:	001c0c13          	addi	s8,s8,1
    80006c00:	fffb8b9b          	addiw	s7,s7,-1
    80006c04:	fb5c94e3          	bne	s9,s5,80006bac <consoleread+0x58>
    80006c08:	000b851b          	sext.w	a0,s7
    80006c0c:	06813083          	ld	ra,104(sp)
    80006c10:	06013403          	ld	s0,96(sp)
    80006c14:	05813483          	ld	s1,88(sp)
    80006c18:	05013903          	ld	s2,80(sp)
    80006c1c:	04813983          	ld	s3,72(sp)
    80006c20:	04013a03          	ld	s4,64(sp)
    80006c24:	03813a83          	ld	s5,56(sp)
    80006c28:	02813b83          	ld	s7,40(sp)
    80006c2c:	02013c03          	ld	s8,32(sp)
    80006c30:	01813c83          	ld	s9,24(sp)
    80006c34:	40ab053b          	subw	a0,s6,a0
    80006c38:	03013b03          	ld	s6,48(sp)
    80006c3c:	07010113          	addi	sp,sp,112
    80006c40:	00008067          	ret
    80006c44:	00001097          	auipc	ra,0x1
    80006c48:	1d8080e7          	jalr	472(ra) # 80007e1c <push_on>
    80006c4c:	0984a703          	lw	a4,152(s1)
    80006c50:	09c4a783          	lw	a5,156(s1)
    80006c54:	0007879b          	sext.w	a5,a5
    80006c58:	fef70ce3          	beq	a4,a5,80006c50 <consoleread+0xfc>
    80006c5c:	00001097          	auipc	ra,0x1
    80006c60:	234080e7          	jalr	564(ra) # 80007e90 <pop_on>
    80006c64:	0984a783          	lw	a5,152(s1)
    80006c68:	07f7f713          	andi	a4,a5,127
    80006c6c:	00e48733          	add	a4,s1,a4
    80006c70:	01874703          	lbu	a4,24(a4)
    80006c74:	0017869b          	addiw	a3,a5,1
    80006c78:	08d4ac23          	sw	a3,152(s1)
    80006c7c:	00070c9b          	sext.w	s9,a4
    80006c80:	f5371ee3          	bne	a4,s3,80006bdc <consoleread+0x88>
    80006c84:	000b851b          	sext.w	a0,s7
    80006c88:	f96bf2e3          	bgeu	s7,s6,80006c0c <consoleread+0xb8>
    80006c8c:	08f4ac23          	sw	a5,152(s1)
    80006c90:	f7dff06f          	j	80006c0c <consoleread+0xb8>

0000000080006c94 <consputc>:
    80006c94:	10000793          	li	a5,256
    80006c98:	00f50663          	beq	a0,a5,80006ca4 <consputc+0x10>
    80006c9c:	00001317          	auipc	t1,0x1
    80006ca0:	9f430067          	jr	-1548(t1) # 80007690 <uartputc_sync>
    80006ca4:	ff010113          	addi	sp,sp,-16
    80006ca8:	00113423          	sd	ra,8(sp)
    80006cac:	00813023          	sd	s0,0(sp)
    80006cb0:	01010413          	addi	s0,sp,16
    80006cb4:	00800513          	li	a0,8
    80006cb8:	00001097          	auipc	ra,0x1
    80006cbc:	9d8080e7          	jalr	-1576(ra) # 80007690 <uartputc_sync>
    80006cc0:	02000513          	li	a0,32
    80006cc4:	00001097          	auipc	ra,0x1
    80006cc8:	9cc080e7          	jalr	-1588(ra) # 80007690 <uartputc_sync>
    80006ccc:	00013403          	ld	s0,0(sp)
    80006cd0:	00813083          	ld	ra,8(sp)
    80006cd4:	00800513          	li	a0,8
    80006cd8:	01010113          	addi	sp,sp,16
    80006cdc:	00001317          	auipc	t1,0x1
    80006ce0:	9b430067          	jr	-1612(t1) # 80007690 <uartputc_sync>

0000000080006ce4 <consoleintr>:
    80006ce4:	fe010113          	addi	sp,sp,-32
    80006ce8:	00813823          	sd	s0,16(sp)
    80006cec:	00913423          	sd	s1,8(sp)
    80006cf0:	01213023          	sd	s2,0(sp)
    80006cf4:	00113c23          	sd	ra,24(sp)
    80006cf8:	02010413          	addi	s0,sp,32
    80006cfc:	00006917          	auipc	s2,0x6
    80006d00:	aec90913          	addi	s2,s2,-1300 # 8000c7e8 <cons>
    80006d04:	00050493          	mv	s1,a0
    80006d08:	00090513          	mv	a0,s2
    80006d0c:	00001097          	auipc	ra,0x1
    80006d10:	e40080e7          	jalr	-448(ra) # 80007b4c <acquire>
    80006d14:	02048c63          	beqz	s1,80006d4c <consoleintr+0x68>
    80006d18:	0a092783          	lw	a5,160(s2)
    80006d1c:	09892703          	lw	a4,152(s2)
    80006d20:	07f00693          	li	a3,127
    80006d24:	40e7873b          	subw	a4,a5,a4
    80006d28:	02e6e263          	bltu	a3,a4,80006d4c <consoleintr+0x68>
    80006d2c:	00d00713          	li	a4,13
    80006d30:	04e48063          	beq	s1,a4,80006d70 <consoleintr+0x8c>
    80006d34:	07f7f713          	andi	a4,a5,127
    80006d38:	00e90733          	add	a4,s2,a4
    80006d3c:	0017879b          	addiw	a5,a5,1
    80006d40:	0af92023          	sw	a5,160(s2)
    80006d44:	00970c23          	sb	s1,24(a4)
    80006d48:	08f92e23          	sw	a5,156(s2)
    80006d4c:	01013403          	ld	s0,16(sp)
    80006d50:	01813083          	ld	ra,24(sp)
    80006d54:	00813483          	ld	s1,8(sp)
    80006d58:	00013903          	ld	s2,0(sp)
    80006d5c:	00006517          	auipc	a0,0x6
    80006d60:	a8c50513          	addi	a0,a0,-1396 # 8000c7e8 <cons>
    80006d64:	02010113          	addi	sp,sp,32
    80006d68:	00001317          	auipc	t1,0x1
    80006d6c:	eb030067          	jr	-336(t1) # 80007c18 <release>
    80006d70:	00a00493          	li	s1,10
    80006d74:	fc1ff06f          	j	80006d34 <consoleintr+0x50>

0000000080006d78 <consoleinit>:
    80006d78:	fe010113          	addi	sp,sp,-32
    80006d7c:	00113c23          	sd	ra,24(sp)
    80006d80:	00813823          	sd	s0,16(sp)
    80006d84:	00913423          	sd	s1,8(sp)
    80006d88:	02010413          	addi	s0,sp,32
    80006d8c:	00006497          	auipc	s1,0x6
    80006d90:	a5c48493          	addi	s1,s1,-1444 # 8000c7e8 <cons>
    80006d94:	00048513          	mv	a0,s1
    80006d98:	00003597          	auipc	a1,0x3
    80006d9c:	8c858593          	addi	a1,a1,-1848 # 80009660 <_ZZ13print_integermE6digits+0x5a8>
    80006da0:	00001097          	auipc	ra,0x1
    80006da4:	d88080e7          	jalr	-632(ra) # 80007b28 <initlock>
    80006da8:	00000097          	auipc	ra,0x0
    80006dac:	7ac080e7          	jalr	1964(ra) # 80007554 <uartinit>
    80006db0:	01813083          	ld	ra,24(sp)
    80006db4:	01013403          	ld	s0,16(sp)
    80006db8:	00000797          	auipc	a5,0x0
    80006dbc:	d9c78793          	addi	a5,a5,-612 # 80006b54 <consoleread>
    80006dc0:	0af4bc23          	sd	a5,184(s1)
    80006dc4:	00000797          	auipc	a5,0x0
    80006dc8:	cec78793          	addi	a5,a5,-788 # 80006ab0 <consolewrite>
    80006dcc:	0cf4b023          	sd	a5,192(s1)
    80006dd0:	00813483          	ld	s1,8(sp)
    80006dd4:	02010113          	addi	sp,sp,32
    80006dd8:	00008067          	ret

0000000080006ddc <console_read>:
    80006ddc:	ff010113          	addi	sp,sp,-16
    80006de0:	00813423          	sd	s0,8(sp)
    80006de4:	01010413          	addi	s0,sp,16
    80006de8:	00813403          	ld	s0,8(sp)
    80006dec:	00006317          	auipc	t1,0x6
    80006df0:	ab433303          	ld	t1,-1356(t1) # 8000c8a0 <devsw+0x10>
    80006df4:	01010113          	addi	sp,sp,16
    80006df8:	00030067          	jr	t1

0000000080006dfc <console_write>:
    80006dfc:	ff010113          	addi	sp,sp,-16
    80006e00:	00813423          	sd	s0,8(sp)
    80006e04:	01010413          	addi	s0,sp,16
    80006e08:	00813403          	ld	s0,8(sp)
    80006e0c:	00006317          	auipc	t1,0x6
    80006e10:	a9c33303          	ld	t1,-1380(t1) # 8000c8a8 <devsw+0x18>
    80006e14:	01010113          	addi	sp,sp,16
    80006e18:	00030067          	jr	t1

0000000080006e1c <panic>:
    80006e1c:	fe010113          	addi	sp,sp,-32
    80006e20:	00113c23          	sd	ra,24(sp)
    80006e24:	00813823          	sd	s0,16(sp)
    80006e28:	00913423          	sd	s1,8(sp)
    80006e2c:	02010413          	addi	s0,sp,32
    80006e30:	00050493          	mv	s1,a0
    80006e34:	00003517          	auipc	a0,0x3
    80006e38:	83450513          	addi	a0,a0,-1996 # 80009668 <_ZZ13print_integermE6digits+0x5b0>
    80006e3c:	00006797          	auipc	a5,0x6
    80006e40:	b007a623          	sw	zero,-1268(a5) # 8000c948 <pr+0x18>
    80006e44:	00000097          	auipc	ra,0x0
    80006e48:	034080e7          	jalr	52(ra) # 80006e78 <__printf>
    80006e4c:	00048513          	mv	a0,s1
    80006e50:	00000097          	auipc	ra,0x0
    80006e54:	028080e7          	jalr	40(ra) # 80006e78 <__printf>
    80006e58:	00002517          	auipc	a0,0x2
    80006e5c:	59050513          	addi	a0,a0,1424 # 800093e8 <_ZZ13print_integermE6digits+0x330>
    80006e60:	00000097          	auipc	ra,0x0
    80006e64:	018080e7          	jalr	24(ra) # 80006e78 <__printf>
    80006e68:	00100793          	li	a5,1
    80006e6c:	00004717          	auipc	a4,0x4
    80006e70:	7ef72e23          	sw	a5,2044(a4) # 8000b668 <panicked>
    80006e74:	0000006f          	j	80006e74 <panic+0x58>

0000000080006e78 <__printf>:
    80006e78:	f3010113          	addi	sp,sp,-208
    80006e7c:	08813023          	sd	s0,128(sp)
    80006e80:	07313423          	sd	s3,104(sp)
    80006e84:	09010413          	addi	s0,sp,144
    80006e88:	05813023          	sd	s8,64(sp)
    80006e8c:	08113423          	sd	ra,136(sp)
    80006e90:	06913c23          	sd	s1,120(sp)
    80006e94:	07213823          	sd	s2,112(sp)
    80006e98:	07413023          	sd	s4,96(sp)
    80006e9c:	05513c23          	sd	s5,88(sp)
    80006ea0:	05613823          	sd	s6,80(sp)
    80006ea4:	05713423          	sd	s7,72(sp)
    80006ea8:	03913c23          	sd	s9,56(sp)
    80006eac:	03a13823          	sd	s10,48(sp)
    80006eb0:	03b13423          	sd	s11,40(sp)
    80006eb4:	00006317          	auipc	t1,0x6
    80006eb8:	a7c30313          	addi	t1,t1,-1412 # 8000c930 <pr>
    80006ebc:	01832c03          	lw	s8,24(t1)
    80006ec0:	00b43423          	sd	a1,8(s0)
    80006ec4:	00c43823          	sd	a2,16(s0)
    80006ec8:	00d43c23          	sd	a3,24(s0)
    80006ecc:	02e43023          	sd	a4,32(s0)
    80006ed0:	02f43423          	sd	a5,40(s0)
    80006ed4:	03043823          	sd	a6,48(s0)
    80006ed8:	03143c23          	sd	a7,56(s0)
    80006edc:	00050993          	mv	s3,a0
    80006ee0:	4a0c1663          	bnez	s8,8000738c <__printf+0x514>
    80006ee4:	60098c63          	beqz	s3,800074fc <__printf+0x684>
    80006ee8:	0009c503          	lbu	a0,0(s3)
    80006eec:	00840793          	addi	a5,s0,8
    80006ef0:	f6f43c23          	sd	a5,-136(s0)
    80006ef4:	00000493          	li	s1,0
    80006ef8:	22050063          	beqz	a0,80007118 <__printf+0x2a0>
    80006efc:	00002a37          	lui	s4,0x2
    80006f00:	00018ab7          	lui	s5,0x18
    80006f04:	000f4b37          	lui	s6,0xf4
    80006f08:	00989bb7          	lui	s7,0x989
    80006f0c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80006f10:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80006f14:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80006f18:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80006f1c:	00148c9b          	addiw	s9,s1,1
    80006f20:	02500793          	li	a5,37
    80006f24:	01998933          	add	s2,s3,s9
    80006f28:	38f51263          	bne	a0,a5,800072ac <__printf+0x434>
    80006f2c:	00094783          	lbu	a5,0(s2)
    80006f30:	00078c9b          	sext.w	s9,a5
    80006f34:	1e078263          	beqz	a5,80007118 <__printf+0x2a0>
    80006f38:	0024849b          	addiw	s1,s1,2
    80006f3c:	07000713          	li	a4,112
    80006f40:	00998933          	add	s2,s3,s1
    80006f44:	38e78a63          	beq	a5,a4,800072d8 <__printf+0x460>
    80006f48:	20f76863          	bltu	a4,a5,80007158 <__printf+0x2e0>
    80006f4c:	42a78863          	beq	a5,a0,8000737c <__printf+0x504>
    80006f50:	06400713          	li	a4,100
    80006f54:	40e79663          	bne	a5,a4,80007360 <__printf+0x4e8>
    80006f58:	f7843783          	ld	a5,-136(s0)
    80006f5c:	0007a603          	lw	a2,0(a5)
    80006f60:	00878793          	addi	a5,a5,8
    80006f64:	f6f43c23          	sd	a5,-136(s0)
    80006f68:	42064a63          	bltz	a2,8000739c <__printf+0x524>
    80006f6c:	00a00713          	li	a4,10
    80006f70:	02e677bb          	remuw	a5,a2,a4
    80006f74:	00002d97          	auipc	s11,0x2
    80006f78:	71cd8d93          	addi	s11,s11,1820 # 80009690 <digits>
    80006f7c:	00900593          	li	a1,9
    80006f80:	0006051b          	sext.w	a0,a2
    80006f84:	00000c93          	li	s9,0
    80006f88:	02079793          	slli	a5,a5,0x20
    80006f8c:	0207d793          	srli	a5,a5,0x20
    80006f90:	00fd87b3          	add	a5,s11,a5
    80006f94:	0007c783          	lbu	a5,0(a5)
    80006f98:	02e656bb          	divuw	a3,a2,a4
    80006f9c:	f8f40023          	sb	a5,-128(s0)
    80006fa0:	14c5d863          	bge	a1,a2,800070f0 <__printf+0x278>
    80006fa4:	06300593          	li	a1,99
    80006fa8:	00100c93          	li	s9,1
    80006fac:	02e6f7bb          	remuw	a5,a3,a4
    80006fb0:	02079793          	slli	a5,a5,0x20
    80006fb4:	0207d793          	srli	a5,a5,0x20
    80006fb8:	00fd87b3          	add	a5,s11,a5
    80006fbc:	0007c783          	lbu	a5,0(a5)
    80006fc0:	02e6d73b          	divuw	a4,a3,a4
    80006fc4:	f8f400a3          	sb	a5,-127(s0)
    80006fc8:	12a5f463          	bgeu	a1,a0,800070f0 <__printf+0x278>
    80006fcc:	00a00693          	li	a3,10
    80006fd0:	00900593          	li	a1,9
    80006fd4:	02d777bb          	remuw	a5,a4,a3
    80006fd8:	02079793          	slli	a5,a5,0x20
    80006fdc:	0207d793          	srli	a5,a5,0x20
    80006fe0:	00fd87b3          	add	a5,s11,a5
    80006fe4:	0007c503          	lbu	a0,0(a5)
    80006fe8:	02d757bb          	divuw	a5,a4,a3
    80006fec:	f8a40123          	sb	a0,-126(s0)
    80006ff0:	48e5f263          	bgeu	a1,a4,80007474 <__printf+0x5fc>
    80006ff4:	06300513          	li	a0,99
    80006ff8:	02d7f5bb          	remuw	a1,a5,a3
    80006ffc:	02059593          	slli	a1,a1,0x20
    80007000:	0205d593          	srli	a1,a1,0x20
    80007004:	00bd85b3          	add	a1,s11,a1
    80007008:	0005c583          	lbu	a1,0(a1)
    8000700c:	02d7d7bb          	divuw	a5,a5,a3
    80007010:	f8b401a3          	sb	a1,-125(s0)
    80007014:	48e57263          	bgeu	a0,a4,80007498 <__printf+0x620>
    80007018:	3e700513          	li	a0,999
    8000701c:	02d7f5bb          	remuw	a1,a5,a3
    80007020:	02059593          	slli	a1,a1,0x20
    80007024:	0205d593          	srli	a1,a1,0x20
    80007028:	00bd85b3          	add	a1,s11,a1
    8000702c:	0005c583          	lbu	a1,0(a1)
    80007030:	02d7d7bb          	divuw	a5,a5,a3
    80007034:	f8b40223          	sb	a1,-124(s0)
    80007038:	46e57663          	bgeu	a0,a4,800074a4 <__printf+0x62c>
    8000703c:	02d7f5bb          	remuw	a1,a5,a3
    80007040:	02059593          	slli	a1,a1,0x20
    80007044:	0205d593          	srli	a1,a1,0x20
    80007048:	00bd85b3          	add	a1,s11,a1
    8000704c:	0005c583          	lbu	a1,0(a1)
    80007050:	02d7d7bb          	divuw	a5,a5,a3
    80007054:	f8b402a3          	sb	a1,-123(s0)
    80007058:	46ea7863          	bgeu	s4,a4,800074c8 <__printf+0x650>
    8000705c:	02d7f5bb          	remuw	a1,a5,a3
    80007060:	02059593          	slli	a1,a1,0x20
    80007064:	0205d593          	srli	a1,a1,0x20
    80007068:	00bd85b3          	add	a1,s11,a1
    8000706c:	0005c583          	lbu	a1,0(a1)
    80007070:	02d7d7bb          	divuw	a5,a5,a3
    80007074:	f8b40323          	sb	a1,-122(s0)
    80007078:	3eeaf863          	bgeu	s5,a4,80007468 <__printf+0x5f0>
    8000707c:	02d7f5bb          	remuw	a1,a5,a3
    80007080:	02059593          	slli	a1,a1,0x20
    80007084:	0205d593          	srli	a1,a1,0x20
    80007088:	00bd85b3          	add	a1,s11,a1
    8000708c:	0005c583          	lbu	a1,0(a1)
    80007090:	02d7d7bb          	divuw	a5,a5,a3
    80007094:	f8b403a3          	sb	a1,-121(s0)
    80007098:	42eb7e63          	bgeu	s6,a4,800074d4 <__printf+0x65c>
    8000709c:	02d7f5bb          	remuw	a1,a5,a3
    800070a0:	02059593          	slli	a1,a1,0x20
    800070a4:	0205d593          	srli	a1,a1,0x20
    800070a8:	00bd85b3          	add	a1,s11,a1
    800070ac:	0005c583          	lbu	a1,0(a1)
    800070b0:	02d7d7bb          	divuw	a5,a5,a3
    800070b4:	f8b40423          	sb	a1,-120(s0)
    800070b8:	42ebfc63          	bgeu	s7,a4,800074f0 <__printf+0x678>
    800070bc:	02079793          	slli	a5,a5,0x20
    800070c0:	0207d793          	srli	a5,a5,0x20
    800070c4:	00fd8db3          	add	s11,s11,a5
    800070c8:	000dc703          	lbu	a4,0(s11)
    800070cc:	00a00793          	li	a5,10
    800070d0:	00900c93          	li	s9,9
    800070d4:	f8e404a3          	sb	a4,-119(s0)
    800070d8:	00065c63          	bgez	a2,800070f0 <__printf+0x278>
    800070dc:	f9040713          	addi	a4,s0,-112
    800070e0:	00f70733          	add	a4,a4,a5
    800070e4:	02d00693          	li	a3,45
    800070e8:	fed70823          	sb	a3,-16(a4)
    800070ec:	00078c93          	mv	s9,a5
    800070f0:	f8040793          	addi	a5,s0,-128
    800070f4:	01978cb3          	add	s9,a5,s9
    800070f8:	f7f40d13          	addi	s10,s0,-129
    800070fc:	000cc503          	lbu	a0,0(s9)
    80007100:	fffc8c93          	addi	s9,s9,-1
    80007104:	00000097          	auipc	ra,0x0
    80007108:	b90080e7          	jalr	-1136(ra) # 80006c94 <consputc>
    8000710c:	ffac98e3          	bne	s9,s10,800070fc <__printf+0x284>
    80007110:	00094503          	lbu	a0,0(s2)
    80007114:	e00514e3          	bnez	a0,80006f1c <__printf+0xa4>
    80007118:	1a0c1663          	bnez	s8,800072c4 <__printf+0x44c>
    8000711c:	08813083          	ld	ra,136(sp)
    80007120:	08013403          	ld	s0,128(sp)
    80007124:	07813483          	ld	s1,120(sp)
    80007128:	07013903          	ld	s2,112(sp)
    8000712c:	06813983          	ld	s3,104(sp)
    80007130:	06013a03          	ld	s4,96(sp)
    80007134:	05813a83          	ld	s5,88(sp)
    80007138:	05013b03          	ld	s6,80(sp)
    8000713c:	04813b83          	ld	s7,72(sp)
    80007140:	04013c03          	ld	s8,64(sp)
    80007144:	03813c83          	ld	s9,56(sp)
    80007148:	03013d03          	ld	s10,48(sp)
    8000714c:	02813d83          	ld	s11,40(sp)
    80007150:	0d010113          	addi	sp,sp,208
    80007154:	00008067          	ret
    80007158:	07300713          	li	a4,115
    8000715c:	1ce78a63          	beq	a5,a4,80007330 <__printf+0x4b8>
    80007160:	07800713          	li	a4,120
    80007164:	1ee79e63          	bne	a5,a4,80007360 <__printf+0x4e8>
    80007168:	f7843783          	ld	a5,-136(s0)
    8000716c:	0007a703          	lw	a4,0(a5)
    80007170:	00878793          	addi	a5,a5,8
    80007174:	f6f43c23          	sd	a5,-136(s0)
    80007178:	28074263          	bltz	a4,800073fc <__printf+0x584>
    8000717c:	00002d97          	auipc	s11,0x2
    80007180:	514d8d93          	addi	s11,s11,1300 # 80009690 <digits>
    80007184:	00f77793          	andi	a5,a4,15
    80007188:	00fd87b3          	add	a5,s11,a5
    8000718c:	0007c683          	lbu	a3,0(a5)
    80007190:	00f00613          	li	a2,15
    80007194:	0007079b          	sext.w	a5,a4
    80007198:	f8d40023          	sb	a3,-128(s0)
    8000719c:	0047559b          	srliw	a1,a4,0x4
    800071a0:	0047569b          	srliw	a3,a4,0x4
    800071a4:	00000c93          	li	s9,0
    800071a8:	0ee65063          	bge	a2,a4,80007288 <__printf+0x410>
    800071ac:	00f6f693          	andi	a3,a3,15
    800071b0:	00dd86b3          	add	a3,s11,a3
    800071b4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800071b8:	0087d79b          	srliw	a5,a5,0x8
    800071bc:	00100c93          	li	s9,1
    800071c0:	f8d400a3          	sb	a3,-127(s0)
    800071c4:	0cb67263          	bgeu	a2,a1,80007288 <__printf+0x410>
    800071c8:	00f7f693          	andi	a3,a5,15
    800071cc:	00dd86b3          	add	a3,s11,a3
    800071d0:	0006c583          	lbu	a1,0(a3)
    800071d4:	00f00613          	li	a2,15
    800071d8:	0047d69b          	srliw	a3,a5,0x4
    800071dc:	f8b40123          	sb	a1,-126(s0)
    800071e0:	0047d593          	srli	a1,a5,0x4
    800071e4:	28f67e63          	bgeu	a2,a5,80007480 <__printf+0x608>
    800071e8:	00f6f693          	andi	a3,a3,15
    800071ec:	00dd86b3          	add	a3,s11,a3
    800071f0:	0006c503          	lbu	a0,0(a3)
    800071f4:	0087d813          	srli	a6,a5,0x8
    800071f8:	0087d69b          	srliw	a3,a5,0x8
    800071fc:	f8a401a3          	sb	a0,-125(s0)
    80007200:	28b67663          	bgeu	a2,a1,8000748c <__printf+0x614>
    80007204:	00f6f693          	andi	a3,a3,15
    80007208:	00dd86b3          	add	a3,s11,a3
    8000720c:	0006c583          	lbu	a1,0(a3)
    80007210:	00c7d513          	srli	a0,a5,0xc
    80007214:	00c7d69b          	srliw	a3,a5,0xc
    80007218:	f8b40223          	sb	a1,-124(s0)
    8000721c:	29067a63          	bgeu	a2,a6,800074b0 <__printf+0x638>
    80007220:	00f6f693          	andi	a3,a3,15
    80007224:	00dd86b3          	add	a3,s11,a3
    80007228:	0006c583          	lbu	a1,0(a3)
    8000722c:	0107d813          	srli	a6,a5,0x10
    80007230:	0107d69b          	srliw	a3,a5,0x10
    80007234:	f8b402a3          	sb	a1,-123(s0)
    80007238:	28a67263          	bgeu	a2,a0,800074bc <__printf+0x644>
    8000723c:	00f6f693          	andi	a3,a3,15
    80007240:	00dd86b3          	add	a3,s11,a3
    80007244:	0006c683          	lbu	a3,0(a3)
    80007248:	0147d79b          	srliw	a5,a5,0x14
    8000724c:	f8d40323          	sb	a3,-122(s0)
    80007250:	21067663          	bgeu	a2,a6,8000745c <__printf+0x5e4>
    80007254:	02079793          	slli	a5,a5,0x20
    80007258:	0207d793          	srli	a5,a5,0x20
    8000725c:	00fd8db3          	add	s11,s11,a5
    80007260:	000dc683          	lbu	a3,0(s11)
    80007264:	00800793          	li	a5,8
    80007268:	00700c93          	li	s9,7
    8000726c:	f8d403a3          	sb	a3,-121(s0)
    80007270:	00075c63          	bgez	a4,80007288 <__printf+0x410>
    80007274:	f9040713          	addi	a4,s0,-112
    80007278:	00f70733          	add	a4,a4,a5
    8000727c:	02d00693          	li	a3,45
    80007280:	fed70823          	sb	a3,-16(a4)
    80007284:	00078c93          	mv	s9,a5
    80007288:	f8040793          	addi	a5,s0,-128
    8000728c:	01978cb3          	add	s9,a5,s9
    80007290:	f7f40d13          	addi	s10,s0,-129
    80007294:	000cc503          	lbu	a0,0(s9)
    80007298:	fffc8c93          	addi	s9,s9,-1
    8000729c:	00000097          	auipc	ra,0x0
    800072a0:	9f8080e7          	jalr	-1544(ra) # 80006c94 <consputc>
    800072a4:	ff9d18e3          	bne	s10,s9,80007294 <__printf+0x41c>
    800072a8:	0100006f          	j	800072b8 <__printf+0x440>
    800072ac:	00000097          	auipc	ra,0x0
    800072b0:	9e8080e7          	jalr	-1560(ra) # 80006c94 <consputc>
    800072b4:	000c8493          	mv	s1,s9
    800072b8:	00094503          	lbu	a0,0(s2)
    800072bc:	c60510e3          	bnez	a0,80006f1c <__printf+0xa4>
    800072c0:	e40c0ee3          	beqz	s8,8000711c <__printf+0x2a4>
    800072c4:	00005517          	auipc	a0,0x5
    800072c8:	66c50513          	addi	a0,a0,1644 # 8000c930 <pr>
    800072cc:	00001097          	auipc	ra,0x1
    800072d0:	94c080e7          	jalr	-1716(ra) # 80007c18 <release>
    800072d4:	e49ff06f          	j	8000711c <__printf+0x2a4>
    800072d8:	f7843783          	ld	a5,-136(s0)
    800072dc:	03000513          	li	a0,48
    800072e0:	01000d13          	li	s10,16
    800072e4:	00878713          	addi	a4,a5,8
    800072e8:	0007bc83          	ld	s9,0(a5)
    800072ec:	f6e43c23          	sd	a4,-136(s0)
    800072f0:	00000097          	auipc	ra,0x0
    800072f4:	9a4080e7          	jalr	-1628(ra) # 80006c94 <consputc>
    800072f8:	07800513          	li	a0,120
    800072fc:	00000097          	auipc	ra,0x0
    80007300:	998080e7          	jalr	-1640(ra) # 80006c94 <consputc>
    80007304:	00002d97          	auipc	s11,0x2
    80007308:	38cd8d93          	addi	s11,s11,908 # 80009690 <digits>
    8000730c:	03ccd793          	srli	a5,s9,0x3c
    80007310:	00fd87b3          	add	a5,s11,a5
    80007314:	0007c503          	lbu	a0,0(a5)
    80007318:	fffd0d1b          	addiw	s10,s10,-1
    8000731c:	004c9c93          	slli	s9,s9,0x4
    80007320:	00000097          	auipc	ra,0x0
    80007324:	974080e7          	jalr	-1676(ra) # 80006c94 <consputc>
    80007328:	fe0d12e3          	bnez	s10,8000730c <__printf+0x494>
    8000732c:	f8dff06f          	j	800072b8 <__printf+0x440>
    80007330:	f7843783          	ld	a5,-136(s0)
    80007334:	0007bc83          	ld	s9,0(a5)
    80007338:	00878793          	addi	a5,a5,8
    8000733c:	f6f43c23          	sd	a5,-136(s0)
    80007340:	000c9a63          	bnez	s9,80007354 <__printf+0x4dc>
    80007344:	1080006f          	j	8000744c <__printf+0x5d4>
    80007348:	001c8c93          	addi	s9,s9,1
    8000734c:	00000097          	auipc	ra,0x0
    80007350:	948080e7          	jalr	-1720(ra) # 80006c94 <consputc>
    80007354:	000cc503          	lbu	a0,0(s9)
    80007358:	fe0518e3          	bnez	a0,80007348 <__printf+0x4d0>
    8000735c:	f5dff06f          	j	800072b8 <__printf+0x440>
    80007360:	02500513          	li	a0,37
    80007364:	00000097          	auipc	ra,0x0
    80007368:	930080e7          	jalr	-1744(ra) # 80006c94 <consputc>
    8000736c:	000c8513          	mv	a0,s9
    80007370:	00000097          	auipc	ra,0x0
    80007374:	924080e7          	jalr	-1756(ra) # 80006c94 <consputc>
    80007378:	f41ff06f          	j	800072b8 <__printf+0x440>
    8000737c:	02500513          	li	a0,37
    80007380:	00000097          	auipc	ra,0x0
    80007384:	914080e7          	jalr	-1772(ra) # 80006c94 <consputc>
    80007388:	f31ff06f          	j	800072b8 <__printf+0x440>
    8000738c:	00030513          	mv	a0,t1
    80007390:	00000097          	auipc	ra,0x0
    80007394:	7bc080e7          	jalr	1980(ra) # 80007b4c <acquire>
    80007398:	b4dff06f          	j	80006ee4 <__printf+0x6c>
    8000739c:	40c0053b          	negw	a0,a2
    800073a0:	00a00713          	li	a4,10
    800073a4:	02e576bb          	remuw	a3,a0,a4
    800073a8:	00002d97          	auipc	s11,0x2
    800073ac:	2e8d8d93          	addi	s11,s11,744 # 80009690 <digits>
    800073b0:	ff700593          	li	a1,-9
    800073b4:	02069693          	slli	a3,a3,0x20
    800073b8:	0206d693          	srli	a3,a3,0x20
    800073bc:	00dd86b3          	add	a3,s11,a3
    800073c0:	0006c683          	lbu	a3,0(a3)
    800073c4:	02e557bb          	divuw	a5,a0,a4
    800073c8:	f8d40023          	sb	a3,-128(s0)
    800073cc:	10b65e63          	bge	a2,a1,800074e8 <__printf+0x670>
    800073d0:	06300593          	li	a1,99
    800073d4:	02e7f6bb          	remuw	a3,a5,a4
    800073d8:	02069693          	slli	a3,a3,0x20
    800073dc:	0206d693          	srli	a3,a3,0x20
    800073e0:	00dd86b3          	add	a3,s11,a3
    800073e4:	0006c683          	lbu	a3,0(a3)
    800073e8:	02e7d73b          	divuw	a4,a5,a4
    800073ec:	00200793          	li	a5,2
    800073f0:	f8d400a3          	sb	a3,-127(s0)
    800073f4:	bca5ece3          	bltu	a1,a0,80006fcc <__printf+0x154>
    800073f8:	ce5ff06f          	j	800070dc <__printf+0x264>
    800073fc:	40e007bb          	negw	a5,a4
    80007400:	00002d97          	auipc	s11,0x2
    80007404:	290d8d93          	addi	s11,s11,656 # 80009690 <digits>
    80007408:	00f7f693          	andi	a3,a5,15
    8000740c:	00dd86b3          	add	a3,s11,a3
    80007410:	0006c583          	lbu	a1,0(a3)
    80007414:	ff100613          	li	a2,-15
    80007418:	0047d69b          	srliw	a3,a5,0x4
    8000741c:	f8b40023          	sb	a1,-128(s0)
    80007420:	0047d59b          	srliw	a1,a5,0x4
    80007424:	0ac75e63          	bge	a4,a2,800074e0 <__printf+0x668>
    80007428:	00f6f693          	andi	a3,a3,15
    8000742c:	00dd86b3          	add	a3,s11,a3
    80007430:	0006c603          	lbu	a2,0(a3)
    80007434:	00f00693          	li	a3,15
    80007438:	0087d79b          	srliw	a5,a5,0x8
    8000743c:	f8c400a3          	sb	a2,-127(s0)
    80007440:	d8b6e4e3          	bltu	a3,a1,800071c8 <__printf+0x350>
    80007444:	00200793          	li	a5,2
    80007448:	e2dff06f          	j	80007274 <__printf+0x3fc>
    8000744c:	00002c97          	auipc	s9,0x2
    80007450:	224c8c93          	addi	s9,s9,548 # 80009670 <_ZZ13print_integermE6digits+0x5b8>
    80007454:	02800513          	li	a0,40
    80007458:	ef1ff06f          	j	80007348 <__printf+0x4d0>
    8000745c:	00700793          	li	a5,7
    80007460:	00600c93          	li	s9,6
    80007464:	e0dff06f          	j	80007270 <__printf+0x3f8>
    80007468:	00700793          	li	a5,7
    8000746c:	00600c93          	li	s9,6
    80007470:	c69ff06f          	j	800070d8 <__printf+0x260>
    80007474:	00300793          	li	a5,3
    80007478:	00200c93          	li	s9,2
    8000747c:	c5dff06f          	j	800070d8 <__printf+0x260>
    80007480:	00300793          	li	a5,3
    80007484:	00200c93          	li	s9,2
    80007488:	de9ff06f          	j	80007270 <__printf+0x3f8>
    8000748c:	00400793          	li	a5,4
    80007490:	00300c93          	li	s9,3
    80007494:	dddff06f          	j	80007270 <__printf+0x3f8>
    80007498:	00400793          	li	a5,4
    8000749c:	00300c93          	li	s9,3
    800074a0:	c39ff06f          	j	800070d8 <__printf+0x260>
    800074a4:	00500793          	li	a5,5
    800074a8:	00400c93          	li	s9,4
    800074ac:	c2dff06f          	j	800070d8 <__printf+0x260>
    800074b0:	00500793          	li	a5,5
    800074b4:	00400c93          	li	s9,4
    800074b8:	db9ff06f          	j	80007270 <__printf+0x3f8>
    800074bc:	00600793          	li	a5,6
    800074c0:	00500c93          	li	s9,5
    800074c4:	dadff06f          	j	80007270 <__printf+0x3f8>
    800074c8:	00600793          	li	a5,6
    800074cc:	00500c93          	li	s9,5
    800074d0:	c09ff06f          	j	800070d8 <__printf+0x260>
    800074d4:	00800793          	li	a5,8
    800074d8:	00700c93          	li	s9,7
    800074dc:	bfdff06f          	j	800070d8 <__printf+0x260>
    800074e0:	00100793          	li	a5,1
    800074e4:	d91ff06f          	j	80007274 <__printf+0x3fc>
    800074e8:	00100793          	li	a5,1
    800074ec:	bf1ff06f          	j	800070dc <__printf+0x264>
    800074f0:	00900793          	li	a5,9
    800074f4:	00800c93          	li	s9,8
    800074f8:	be1ff06f          	j	800070d8 <__printf+0x260>
    800074fc:	00002517          	auipc	a0,0x2
    80007500:	17c50513          	addi	a0,a0,380 # 80009678 <_ZZ13print_integermE6digits+0x5c0>
    80007504:	00000097          	auipc	ra,0x0
    80007508:	918080e7          	jalr	-1768(ra) # 80006e1c <panic>

000000008000750c <printfinit>:
    8000750c:	fe010113          	addi	sp,sp,-32
    80007510:	00813823          	sd	s0,16(sp)
    80007514:	00913423          	sd	s1,8(sp)
    80007518:	00113c23          	sd	ra,24(sp)
    8000751c:	02010413          	addi	s0,sp,32
    80007520:	00005497          	auipc	s1,0x5
    80007524:	41048493          	addi	s1,s1,1040 # 8000c930 <pr>
    80007528:	00048513          	mv	a0,s1
    8000752c:	00002597          	auipc	a1,0x2
    80007530:	15c58593          	addi	a1,a1,348 # 80009688 <_ZZ13print_integermE6digits+0x5d0>
    80007534:	00000097          	auipc	ra,0x0
    80007538:	5f4080e7          	jalr	1524(ra) # 80007b28 <initlock>
    8000753c:	01813083          	ld	ra,24(sp)
    80007540:	01013403          	ld	s0,16(sp)
    80007544:	0004ac23          	sw	zero,24(s1)
    80007548:	00813483          	ld	s1,8(sp)
    8000754c:	02010113          	addi	sp,sp,32
    80007550:	00008067          	ret

0000000080007554 <uartinit>:
    80007554:	ff010113          	addi	sp,sp,-16
    80007558:	00813423          	sd	s0,8(sp)
    8000755c:	01010413          	addi	s0,sp,16
    80007560:	100007b7          	lui	a5,0x10000
    80007564:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007568:	f8000713          	li	a4,-128
    8000756c:	00e781a3          	sb	a4,3(a5)
    80007570:	00300713          	li	a4,3
    80007574:	00e78023          	sb	a4,0(a5)
    80007578:	000780a3          	sb	zero,1(a5)
    8000757c:	00e781a3          	sb	a4,3(a5)
    80007580:	00700693          	li	a3,7
    80007584:	00d78123          	sb	a3,2(a5)
    80007588:	00e780a3          	sb	a4,1(a5)
    8000758c:	00813403          	ld	s0,8(sp)
    80007590:	01010113          	addi	sp,sp,16
    80007594:	00008067          	ret

0000000080007598 <uartputc>:
    80007598:	00004797          	auipc	a5,0x4
    8000759c:	0d07a783          	lw	a5,208(a5) # 8000b668 <panicked>
    800075a0:	00078463          	beqz	a5,800075a8 <uartputc+0x10>
    800075a4:	0000006f          	j	800075a4 <uartputc+0xc>
    800075a8:	fd010113          	addi	sp,sp,-48
    800075ac:	02813023          	sd	s0,32(sp)
    800075b0:	00913c23          	sd	s1,24(sp)
    800075b4:	01213823          	sd	s2,16(sp)
    800075b8:	01313423          	sd	s3,8(sp)
    800075bc:	02113423          	sd	ra,40(sp)
    800075c0:	03010413          	addi	s0,sp,48
    800075c4:	00004917          	auipc	s2,0x4
    800075c8:	0ac90913          	addi	s2,s2,172 # 8000b670 <uart_tx_r>
    800075cc:	00093783          	ld	a5,0(s2)
    800075d0:	00004497          	auipc	s1,0x4
    800075d4:	0a848493          	addi	s1,s1,168 # 8000b678 <uart_tx_w>
    800075d8:	0004b703          	ld	a4,0(s1)
    800075dc:	02078693          	addi	a3,a5,32
    800075e0:	00050993          	mv	s3,a0
    800075e4:	02e69c63          	bne	a3,a4,8000761c <uartputc+0x84>
    800075e8:	00001097          	auipc	ra,0x1
    800075ec:	834080e7          	jalr	-1996(ra) # 80007e1c <push_on>
    800075f0:	00093783          	ld	a5,0(s2)
    800075f4:	0004b703          	ld	a4,0(s1)
    800075f8:	02078793          	addi	a5,a5,32
    800075fc:	00e79463          	bne	a5,a4,80007604 <uartputc+0x6c>
    80007600:	0000006f          	j	80007600 <uartputc+0x68>
    80007604:	00001097          	auipc	ra,0x1
    80007608:	88c080e7          	jalr	-1908(ra) # 80007e90 <pop_on>
    8000760c:	00093783          	ld	a5,0(s2)
    80007610:	0004b703          	ld	a4,0(s1)
    80007614:	02078693          	addi	a3,a5,32
    80007618:	fce688e3          	beq	a3,a4,800075e8 <uartputc+0x50>
    8000761c:	01f77693          	andi	a3,a4,31
    80007620:	00005597          	auipc	a1,0x5
    80007624:	33058593          	addi	a1,a1,816 # 8000c950 <uart_tx_buf>
    80007628:	00d586b3          	add	a3,a1,a3
    8000762c:	00170713          	addi	a4,a4,1
    80007630:	01368023          	sb	s3,0(a3)
    80007634:	00e4b023          	sd	a4,0(s1)
    80007638:	10000637          	lui	a2,0x10000
    8000763c:	02f71063          	bne	a4,a5,8000765c <uartputc+0xc4>
    80007640:	0340006f          	j	80007674 <uartputc+0xdc>
    80007644:	00074703          	lbu	a4,0(a4)
    80007648:	00f93023          	sd	a5,0(s2)
    8000764c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80007650:	00093783          	ld	a5,0(s2)
    80007654:	0004b703          	ld	a4,0(s1)
    80007658:	00f70e63          	beq	a4,a5,80007674 <uartputc+0xdc>
    8000765c:	00564683          	lbu	a3,5(a2)
    80007660:	01f7f713          	andi	a4,a5,31
    80007664:	00e58733          	add	a4,a1,a4
    80007668:	0206f693          	andi	a3,a3,32
    8000766c:	00178793          	addi	a5,a5,1
    80007670:	fc069ae3          	bnez	a3,80007644 <uartputc+0xac>
    80007674:	02813083          	ld	ra,40(sp)
    80007678:	02013403          	ld	s0,32(sp)
    8000767c:	01813483          	ld	s1,24(sp)
    80007680:	01013903          	ld	s2,16(sp)
    80007684:	00813983          	ld	s3,8(sp)
    80007688:	03010113          	addi	sp,sp,48
    8000768c:	00008067          	ret

0000000080007690 <uartputc_sync>:
    80007690:	ff010113          	addi	sp,sp,-16
    80007694:	00813423          	sd	s0,8(sp)
    80007698:	01010413          	addi	s0,sp,16
    8000769c:	00004717          	auipc	a4,0x4
    800076a0:	fcc72703          	lw	a4,-52(a4) # 8000b668 <panicked>
    800076a4:	02071663          	bnez	a4,800076d0 <uartputc_sync+0x40>
    800076a8:	00050793          	mv	a5,a0
    800076ac:	100006b7          	lui	a3,0x10000
    800076b0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800076b4:	02077713          	andi	a4,a4,32
    800076b8:	fe070ce3          	beqz	a4,800076b0 <uartputc_sync+0x20>
    800076bc:	0ff7f793          	andi	a5,a5,255
    800076c0:	00f68023          	sb	a5,0(a3)
    800076c4:	00813403          	ld	s0,8(sp)
    800076c8:	01010113          	addi	sp,sp,16
    800076cc:	00008067          	ret
    800076d0:	0000006f          	j	800076d0 <uartputc_sync+0x40>

00000000800076d4 <uartstart>:
    800076d4:	ff010113          	addi	sp,sp,-16
    800076d8:	00813423          	sd	s0,8(sp)
    800076dc:	01010413          	addi	s0,sp,16
    800076e0:	00004617          	auipc	a2,0x4
    800076e4:	f9060613          	addi	a2,a2,-112 # 8000b670 <uart_tx_r>
    800076e8:	00004517          	auipc	a0,0x4
    800076ec:	f9050513          	addi	a0,a0,-112 # 8000b678 <uart_tx_w>
    800076f0:	00063783          	ld	a5,0(a2)
    800076f4:	00053703          	ld	a4,0(a0)
    800076f8:	04f70263          	beq	a4,a5,8000773c <uartstart+0x68>
    800076fc:	100005b7          	lui	a1,0x10000
    80007700:	00005817          	auipc	a6,0x5
    80007704:	25080813          	addi	a6,a6,592 # 8000c950 <uart_tx_buf>
    80007708:	01c0006f          	j	80007724 <uartstart+0x50>
    8000770c:	0006c703          	lbu	a4,0(a3)
    80007710:	00f63023          	sd	a5,0(a2)
    80007714:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80007718:	00063783          	ld	a5,0(a2)
    8000771c:	00053703          	ld	a4,0(a0)
    80007720:	00f70e63          	beq	a4,a5,8000773c <uartstart+0x68>
    80007724:	01f7f713          	andi	a4,a5,31
    80007728:	00e806b3          	add	a3,a6,a4
    8000772c:	0055c703          	lbu	a4,5(a1)
    80007730:	00178793          	addi	a5,a5,1
    80007734:	02077713          	andi	a4,a4,32
    80007738:	fc071ae3          	bnez	a4,8000770c <uartstart+0x38>
    8000773c:	00813403          	ld	s0,8(sp)
    80007740:	01010113          	addi	sp,sp,16
    80007744:	00008067          	ret

0000000080007748 <uartgetc>:
    80007748:	ff010113          	addi	sp,sp,-16
    8000774c:	00813423          	sd	s0,8(sp)
    80007750:	01010413          	addi	s0,sp,16
    80007754:	10000737          	lui	a4,0x10000
    80007758:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000775c:	0017f793          	andi	a5,a5,1
    80007760:	00078c63          	beqz	a5,80007778 <uartgetc+0x30>
    80007764:	00074503          	lbu	a0,0(a4)
    80007768:	0ff57513          	andi	a0,a0,255
    8000776c:	00813403          	ld	s0,8(sp)
    80007770:	01010113          	addi	sp,sp,16
    80007774:	00008067          	ret
    80007778:	fff00513          	li	a0,-1
    8000777c:	ff1ff06f          	j	8000776c <uartgetc+0x24>

0000000080007780 <uartintr>:
    80007780:	100007b7          	lui	a5,0x10000
    80007784:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80007788:	0017f793          	andi	a5,a5,1
    8000778c:	0a078463          	beqz	a5,80007834 <uartintr+0xb4>
    80007790:	fe010113          	addi	sp,sp,-32
    80007794:	00813823          	sd	s0,16(sp)
    80007798:	00913423          	sd	s1,8(sp)
    8000779c:	00113c23          	sd	ra,24(sp)
    800077a0:	02010413          	addi	s0,sp,32
    800077a4:	100004b7          	lui	s1,0x10000
    800077a8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800077ac:	0ff57513          	andi	a0,a0,255
    800077b0:	fffff097          	auipc	ra,0xfffff
    800077b4:	534080e7          	jalr	1332(ra) # 80006ce4 <consoleintr>
    800077b8:	0054c783          	lbu	a5,5(s1)
    800077bc:	0017f793          	andi	a5,a5,1
    800077c0:	fe0794e3          	bnez	a5,800077a8 <uartintr+0x28>
    800077c4:	00004617          	auipc	a2,0x4
    800077c8:	eac60613          	addi	a2,a2,-340 # 8000b670 <uart_tx_r>
    800077cc:	00004517          	auipc	a0,0x4
    800077d0:	eac50513          	addi	a0,a0,-340 # 8000b678 <uart_tx_w>
    800077d4:	00063783          	ld	a5,0(a2)
    800077d8:	00053703          	ld	a4,0(a0)
    800077dc:	04f70263          	beq	a4,a5,80007820 <uartintr+0xa0>
    800077e0:	100005b7          	lui	a1,0x10000
    800077e4:	00005817          	auipc	a6,0x5
    800077e8:	16c80813          	addi	a6,a6,364 # 8000c950 <uart_tx_buf>
    800077ec:	01c0006f          	j	80007808 <uartintr+0x88>
    800077f0:	0006c703          	lbu	a4,0(a3)
    800077f4:	00f63023          	sd	a5,0(a2)
    800077f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800077fc:	00063783          	ld	a5,0(a2)
    80007800:	00053703          	ld	a4,0(a0)
    80007804:	00f70e63          	beq	a4,a5,80007820 <uartintr+0xa0>
    80007808:	01f7f713          	andi	a4,a5,31
    8000780c:	00e806b3          	add	a3,a6,a4
    80007810:	0055c703          	lbu	a4,5(a1)
    80007814:	00178793          	addi	a5,a5,1
    80007818:	02077713          	andi	a4,a4,32
    8000781c:	fc071ae3          	bnez	a4,800077f0 <uartintr+0x70>
    80007820:	01813083          	ld	ra,24(sp)
    80007824:	01013403          	ld	s0,16(sp)
    80007828:	00813483          	ld	s1,8(sp)
    8000782c:	02010113          	addi	sp,sp,32
    80007830:	00008067          	ret
    80007834:	00004617          	auipc	a2,0x4
    80007838:	e3c60613          	addi	a2,a2,-452 # 8000b670 <uart_tx_r>
    8000783c:	00004517          	auipc	a0,0x4
    80007840:	e3c50513          	addi	a0,a0,-452 # 8000b678 <uart_tx_w>
    80007844:	00063783          	ld	a5,0(a2)
    80007848:	00053703          	ld	a4,0(a0)
    8000784c:	04f70263          	beq	a4,a5,80007890 <uartintr+0x110>
    80007850:	100005b7          	lui	a1,0x10000
    80007854:	00005817          	auipc	a6,0x5
    80007858:	0fc80813          	addi	a6,a6,252 # 8000c950 <uart_tx_buf>
    8000785c:	01c0006f          	j	80007878 <uartintr+0xf8>
    80007860:	0006c703          	lbu	a4,0(a3)
    80007864:	00f63023          	sd	a5,0(a2)
    80007868:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000786c:	00063783          	ld	a5,0(a2)
    80007870:	00053703          	ld	a4,0(a0)
    80007874:	02f70063          	beq	a4,a5,80007894 <uartintr+0x114>
    80007878:	01f7f713          	andi	a4,a5,31
    8000787c:	00e806b3          	add	a3,a6,a4
    80007880:	0055c703          	lbu	a4,5(a1)
    80007884:	00178793          	addi	a5,a5,1
    80007888:	02077713          	andi	a4,a4,32
    8000788c:	fc071ae3          	bnez	a4,80007860 <uartintr+0xe0>
    80007890:	00008067          	ret
    80007894:	00008067          	ret

0000000080007898 <kinit>:
    80007898:	fc010113          	addi	sp,sp,-64
    8000789c:	02913423          	sd	s1,40(sp)
    800078a0:	fffff7b7          	lui	a5,0xfffff
    800078a4:	00006497          	auipc	s1,0x6
    800078a8:	0cb48493          	addi	s1,s1,203 # 8000d96f <end+0xfff>
    800078ac:	02813823          	sd	s0,48(sp)
    800078b0:	01313c23          	sd	s3,24(sp)
    800078b4:	00f4f4b3          	and	s1,s1,a5
    800078b8:	02113c23          	sd	ra,56(sp)
    800078bc:	03213023          	sd	s2,32(sp)
    800078c0:	01413823          	sd	s4,16(sp)
    800078c4:	01513423          	sd	s5,8(sp)
    800078c8:	04010413          	addi	s0,sp,64
    800078cc:	000017b7          	lui	a5,0x1
    800078d0:	01100993          	li	s3,17
    800078d4:	00f487b3          	add	a5,s1,a5
    800078d8:	01b99993          	slli	s3,s3,0x1b
    800078dc:	06f9e063          	bltu	s3,a5,8000793c <kinit+0xa4>
    800078e0:	00005a97          	auipc	s5,0x5
    800078e4:	090a8a93          	addi	s5,s5,144 # 8000c970 <end>
    800078e8:	0754ec63          	bltu	s1,s5,80007960 <kinit+0xc8>
    800078ec:	0734fa63          	bgeu	s1,s3,80007960 <kinit+0xc8>
    800078f0:	00088a37          	lui	s4,0x88
    800078f4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800078f8:	00004917          	auipc	s2,0x4
    800078fc:	d8890913          	addi	s2,s2,-632 # 8000b680 <kmem>
    80007900:	00ca1a13          	slli	s4,s4,0xc
    80007904:	0140006f          	j	80007918 <kinit+0x80>
    80007908:	000017b7          	lui	a5,0x1
    8000790c:	00f484b3          	add	s1,s1,a5
    80007910:	0554e863          	bltu	s1,s5,80007960 <kinit+0xc8>
    80007914:	0534f663          	bgeu	s1,s3,80007960 <kinit+0xc8>
    80007918:	00001637          	lui	a2,0x1
    8000791c:	00100593          	li	a1,1
    80007920:	00048513          	mv	a0,s1
    80007924:	00000097          	auipc	ra,0x0
    80007928:	5e4080e7          	jalr	1508(ra) # 80007f08 <__memset>
    8000792c:	00093783          	ld	a5,0(s2)
    80007930:	00f4b023          	sd	a5,0(s1)
    80007934:	00993023          	sd	s1,0(s2)
    80007938:	fd4498e3          	bne	s1,s4,80007908 <kinit+0x70>
    8000793c:	03813083          	ld	ra,56(sp)
    80007940:	03013403          	ld	s0,48(sp)
    80007944:	02813483          	ld	s1,40(sp)
    80007948:	02013903          	ld	s2,32(sp)
    8000794c:	01813983          	ld	s3,24(sp)
    80007950:	01013a03          	ld	s4,16(sp)
    80007954:	00813a83          	ld	s5,8(sp)
    80007958:	04010113          	addi	sp,sp,64
    8000795c:	00008067          	ret
    80007960:	00002517          	auipc	a0,0x2
    80007964:	d4850513          	addi	a0,a0,-696 # 800096a8 <digits+0x18>
    80007968:	fffff097          	auipc	ra,0xfffff
    8000796c:	4b4080e7          	jalr	1204(ra) # 80006e1c <panic>

0000000080007970 <freerange>:
    80007970:	fc010113          	addi	sp,sp,-64
    80007974:	000017b7          	lui	a5,0x1
    80007978:	02913423          	sd	s1,40(sp)
    8000797c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80007980:	009504b3          	add	s1,a0,s1
    80007984:	fffff537          	lui	a0,0xfffff
    80007988:	02813823          	sd	s0,48(sp)
    8000798c:	02113c23          	sd	ra,56(sp)
    80007990:	03213023          	sd	s2,32(sp)
    80007994:	01313c23          	sd	s3,24(sp)
    80007998:	01413823          	sd	s4,16(sp)
    8000799c:	01513423          	sd	s5,8(sp)
    800079a0:	01613023          	sd	s6,0(sp)
    800079a4:	04010413          	addi	s0,sp,64
    800079a8:	00a4f4b3          	and	s1,s1,a0
    800079ac:	00f487b3          	add	a5,s1,a5
    800079b0:	06f5e463          	bltu	a1,a5,80007a18 <freerange+0xa8>
    800079b4:	00005a97          	auipc	s5,0x5
    800079b8:	fbca8a93          	addi	s5,s5,-68 # 8000c970 <end>
    800079bc:	0954e263          	bltu	s1,s5,80007a40 <freerange+0xd0>
    800079c0:	01100993          	li	s3,17
    800079c4:	01b99993          	slli	s3,s3,0x1b
    800079c8:	0734fc63          	bgeu	s1,s3,80007a40 <freerange+0xd0>
    800079cc:	00058a13          	mv	s4,a1
    800079d0:	00004917          	auipc	s2,0x4
    800079d4:	cb090913          	addi	s2,s2,-848 # 8000b680 <kmem>
    800079d8:	00002b37          	lui	s6,0x2
    800079dc:	0140006f          	j	800079f0 <freerange+0x80>
    800079e0:	000017b7          	lui	a5,0x1
    800079e4:	00f484b3          	add	s1,s1,a5
    800079e8:	0554ec63          	bltu	s1,s5,80007a40 <freerange+0xd0>
    800079ec:	0534fa63          	bgeu	s1,s3,80007a40 <freerange+0xd0>
    800079f0:	00001637          	lui	a2,0x1
    800079f4:	00100593          	li	a1,1
    800079f8:	00048513          	mv	a0,s1
    800079fc:	00000097          	auipc	ra,0x0
    80007a00:	50c080e7          	jalr	1292(ra) # 80007f08 <__memset>
    80007a04:	00093703          	ld	a4,0(s2)
    80007a08:	016487b3          	add	a5,s1,s6
    80007a0c:	00e4b023          	sd	a4,0(s1)
    80007a10:	00993023          	sd	s1,0(s2)
    80007a14:	fcfa76e3          	bgeu	s4,a5,800079e0 <freerange+0x70>
    80007a18:	03813083          	ld	ra,56(sp)
    80007a1c:	03013403          	ld	s0,48(sp)
    80007a20:	02813483          	ld	s1,40(sp)
    80007a24:	02013903          	ld	s2,32(sp)
    80007a28:	01813983          	ld	s3,24(sp)
    80007a2c:	01013a03          	ld	s4,16(sp)
    80007a30:	00813a83          	ld	s5,8(sp)
    80007a34:	00013b03          	ld	s6,0(sp)
    80007a38:	04010113          	addi	sp,sp,64
    80007a3c:	00008067          	ret
    80007a40:	00002517          	auipc	a0,0x2
    80007a44:	c6850513          	addi	a0,a0,-920 # 800096a8 <digits+0x18>
    80007a48:	fffff097          	auipc	ra,0xfffff
    80007a4c:	3d4080e7          	jalr	980(ra) # 80006e1c <panic>

0000000080007a50 <kfree>:
    80007a50:	fe010113          	addi	sp,sp,-32
    80007a54:	00813823          	sd	s0,16(sp)
    80007a58:	00113c23          	sd	ra,24(sp)
    80007a5c:	00913423          	sd	s1,8(sp)
    80007a60:	02010413          	addi	s0,sp,32
    80007a64:	03451793          	slli	a5,a0,0x34
    80007a68:	04079c63          	bnez	a5,80007ac0 <kfree+0x70>
    80007a6c:	00005797          	auipc	a5,0x5
    80007a70:	f0478793          	addi	a5,a5,-252 # 8000c970 <end>
    80007a74:	00050493          	mv	s1,a0
    80007a78:	04f56463          	bltu	a0,a5,80007ac0 <kfree+0x70>
    80007a7c:	01100793          	li	a5,17
    80007a80:	01b79793          	slli	a5,a5,0x1b
    80007a84:	02f57e63          	bgeu	a0,a5,80007ac0 <kfree+0x70>
    80007a88:	00001637          	lui	a2,0x1
    80007a8c:	00100593          	li	a1,1
    80007a90:	00000097          	auipc	ra,0x0
    80007a94:	478080e7          	jalr	1144(ra) # 80007f08 <__memset>
    80007a98:	00004797          	auipc	a5,0x4
    80007a9c:	be878793          	addi	a5,a5,-1048 # 8000b680 <kmem>
    80007aa0:	0007b703          	ld	a4,0(a5)
    80007aa4:	01813083          	ld	ra,24(sp)
    80007aa8:	01013403          	ld	s0,16(sp)
    80007aac:	00e4b023          	sd	a4,0(s1)
    80007ab0:	0097b023          	sd	s1,0(a5)
    80007ab4:	00813483          	ld	s1,8(sp)
    80007ab8:	02010113          	addi	sp,sp,32
    80007abc:	00008067          	ret
    80007ac0:	00002517          	auipc	a0,0x2
    80007ac4:	be850513          	addi	a0,a0,-1048 # 800096a8 <digits+0x18>
    80007ac8:	fffff097          	auipc	ra,0xfffff
    80007acc:	354080e7          	jalr	852(ra) # 80006e1c <panic>

0000000080007ad0 <kalloc>:
    80007ad0:	fe010113          	addi	sp,sp,-32
    80007ad4:	00813823          	sd	s0,16(sp)
    80007ad8:	00913423          	sd	s1,8(sp)
    80007adc:	00113c23          	sd	ra,24(sp)
    80007ae0:	02010413          	addi	s0,sp,32
    80007ae4:	00004797          	auipc	a5,0x4
    80007ae8:	b9c78793          	addi	a5,a5,-1124 # 8000b680 <kmem>
    80007aec:	0007b483          	ld	s1,0(a5)
    80007af0:	02048063          	beqz	s1,80007b10 <kalloc+0x40>
    80007af4:	0004b703          	ld	a4,0(s1)
    80007af8:	00001637          	lui	a2,0x1
    80007afc:	00500593          	li	a1,5
    80007b00:	00048513          	mv	a0,s1
    80007b04:	00e7b023          	sd	a4,0(a5)
    80007b08:	00000097          	auipc	ra,0x0
    80007b0c:	400080e7          	jalr	1024(ra) # 80007f08 <__memset>
    80007b10:	01813083          	ld	ra,24(sp)
    80007b14:	01013403          	ld	s0,16(sp)
    80007b18:	00048513          	mv	a0,s1
    80007b1c:	00813483          	ld	s1,8(sp)
    80007b20:	02010113          	addi	sp,sp,32
    80007b24:	00008067          	ret

0000000080007b28 <initlock>:
    80007b28:	ff010113          	addi	sp,sp,-16
    80007b2c:	00813423          	sd	s0,8(sp)
    80007b30:	01010413          	addi	s0,sp,16
    80007b34:	00813403          	ld	s0,8(sp)
    80007b38:	00b53423          	sd	a1,8(a0)
    80007b3c:	00052023          	sw	zero,0(a0)
    80007b40:	00053823          	sd	zero,16(a0)
    80007b44:	01010113          	addi	sp,sp,16
    80007b48:	00008067          	ret

0000000080007b4c <acquire>:
    80007b4c:	fe010113          	addi	sp,sp,-32
    80007b50:	00813823          	sd	s0,16(sp)
    80007b54:	00913423          	sd	s1,8(sp)
    80007b58:	00113c23          	sd	ra,24(sp)
    80007b5c:	01213023          	sd	s2,0(sp)
    80007b60:	02010413          	addi	s0,sp,32
    80007b64:	00050493          	mv	s1,a0
    80007b68:	10002973          	csrr	s2,sstatus
    80007b6c:	100027f3          	csrr	a5,sstatus
    80007b70:	ffd7f793          	andi	a5,a5,-3
    80007b74:	10079073          	csrw	sstatus,a5
    80007b78:	fffff097          	auipc	ra,0xfffff
    80007b7c:	8ec080e7          	jalr	-1812(ra) # 80006464 <mycpu>
    80007b80:	07852783          	lw	a5,120(a0)
    80007b84:	06078e63          	beqz	a5,80007c00 <acquire+0xb4>
    80007b88:	fffff097          	auipc	ra,0xfffff
    80007b8c:	8dc080e7          	jalr	-1828(ra) # 80006464 <mycpu>
    80007b90:	07852783          	lw	a5,120(a0)
    80007b94:	0004a703          	lw	a4,0(s1)
    80007b98:	0017879b          	addiw	a5,a5,1
    80007b9c:	06f52c23          	sw	a5,120(a0)
    80007ba0:	04071063          	bnez	a4,80007be0 <acquire+0x94>
    80007ba4:	00100713          	li	a4,1
    80007ba8:	00070793          	mv	a5,a4
    80007bac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80007bb0:	0007879b          	sext.w	a5,a5
    80007bb4:	fe079ae3          	bnez	a5,80007ba8 <acquire+0x5c>
    80007bb8:	0ff0000f          	fence
    80007bbc:	fffff097          	auipc	ra,0xfffff
    80007bc0:	8a8080e7          	jalr	-1880(ra) # 80006464 <mycpu>
    80007bc4:	01813083          	ld	ra,24(sp)
    80007bc8:	01013403          	ld	s0,16(sp)
    80007bcc:	00a4b823          	sd	a0,16(s1)
    80007bd0:	00013903          	ld	s2,0(sp)
    80007bd4:	00813483          	ld	s1,8(sp)
    80007bd8:	02010113          	addi	sp,sp,32
    80007bdc:	00008067          	ret
    80007be0:	0104b903          	ld	s2,16(s1)
    80007be4:	fffff097          	auipc	ra,0xfffff
    80007be8:	880080e7          	jalr	-1920(ra) # 80006464 <mycpu>
    80007bec:	faa91ce3          	bne	s2,a0,80007ba4 <acquire+0x58>
    80007bf0:	00002517          	auipc	a0,0x2
    80007bf4:	ac050513          	addi	a0,a0,-1344 # 800096b0 <digits+0x20>
    80007bf8:	fffff097          	auipc	ra,0xfffff
    80007bfc:	224080e7          	jalr	548(ra) # 80006e1c <panic>
    80007c00:	00195913          	srli	s2,s2,0x1
    80007c04:	fffff097          	auipc	ra,0xfffff
    80007c08:	860080e7          	jalr	-1952(ra) # 80006464 <mycpu>
    80007c0c:	00197913          	andi	s2,s2,1
    80007c10:	07252e23          	sw	s2,124(a0)
    80007c14:	f75ff06f          	j	80007b88 <acquire+0x3c>

0000000080007c18 <release>:
    80007c18:	fe010113          	addi	sp,sp,-32
    80007c1c:	00813823          	sd	s0,16(sp)
    80007c20:	00113c23          	sd	ra,24(sp)
    80007c24:	00913423          	sd	s1,8(sp)
    80007c28:	01213023          	sd	s2,0(sp)
    80007c2c:	02010413          	addi	s0,sp,32
    80007c30:	00052783          	lw	a5,0(a0)
    80007c34:	00079a63          	bnez	a5,80007c48 <release+0x30>
    80007c38:	00002517          	auipc	a0,0x2
    80007c3c:	a8050513          	addi	a0,a0,-1408 # 800096b8 <digits+0x28>
    80007c40:	fffff097          	auipc	ra,0xfffff
    80007c44:	1dc080e7          	jalr	476(ra) # 80006e1c <panic>
    80007c48:	01053903          	ld	s2,16(a0)
    80007c4c:	00050493          	mv	s1,a0
    80007c50:	fffff097          	auipc	ra,0xfffff
    80007c54:	814080e7          	jalr	-2028(ra) # 80006464 <mycpu>
    80007c58:	fea910e3          	bne	s2,a0,80007c38 <release+0x20>
    80007c5c:	0004b823          	sd	zero,16(s1)
    80007c60:	0ff0000f          	fence
    80007c64:	0f50000f          	fence	iorw,ow
    80007c68:	0804a02f          	amoswap.w	zero,zero,(s1)
    80007c6c:	ffffe097          	auipc	ra,0xffffe
    80007c70:	7f8080e7          	jalr	2040(ra) # 80006464 <mycpu>
    80007c74:	100027f3          	csrr	a5,sstatus
    80007c78:	0027f793          	andi	a5,a5,2
    80007c7c:	04079a63          	bnez	a5,80007cd0 <release+0xb8>
    80007c80:	07852783          	lw	a5,120(a0)
    80007c84:	02f05e63          	blez	a5,80007cc0 <release+0xa8>
    80007c88:	fff7871b          	addiw	a4,a5,-1
    80007c8c:	06e52c23          	sw	a4,120(a0)
    80007c90:	00071c63          	bnez	a4,80007ca8 <release+0x90>
    80007c94:	07c52783          	lw	a5,124(a0)
    80007c98:	00078863          	beqz	a5,80007ca8 <release+0x90>
    80007c9c:	100027f3          	csrr	a5,sstatus
    80007ca0:	0027e793          	ori	a5,a5,2
    80007ca4:	10079073          	csrw	sstatus,a5
    80007ca8:	01813083          	ld	ra,24(sp)
    80007cac:	01013403          	ld	s0,16(sp)
    80007cb0:	00813483          	ld	s1,8(sp)
    80007cb4:	00013903          	ld	s2,0(sp)
    80007cb8:	02010113          	addi	sp,sp,32
    80007cbc:	00008067          	ret
    80007cc0:	00002517          	auipc	a0,0x2
    80007cc4:	a1850513          	addi	a0,a0,-1512 # 800096d8 <digits+0x48>
    80007cc8:	fffff097          	auipc	ra,0xfffff
    80007ccc:	154080e7          	jalr	340(ra) # 80006e1c <panic>
    80007cd0:	00002517          	auipc	a0,0x2
    80007cd4:	9f050513          	addi	a0,a0,-1552 # 800096c0 <digits+0x30>
    80007cd8:	fffff097          	auipc	ra,0xfffff
    80007cdc:	144080e7          	jalr	324(ra) # 80006e1c <panic>

0000000080007ce0 <holding>:
    80007ce0:	00052783          	lw	a5,0(a0)
    80007ce4:	00079663          	bnez	a5,80007cf0 <holding+0x10>
    80007ce8:	00000513          	li	a0,0
    80007cec:	00008067          	ret
    80007cf0:	fe010113          	addi	sp,sp,-32
    80007cf4:	00813823          	sd	s0,16(sp)
    80007cf8:	00913423          	sd	s1,8(sp)
    80007cfc:	00113c23          	sd	ra,24(sp)
    80007d00:	02010413          	addi	s0,sp,32
    80007d04:	01053483          	ld	s1,16(a0)
    80007d08:	ffffe097          	auipc	ra,0xffffe
    80007d0c:	75c080e7          	jalr	1884(ra) # 80006464 <mycpu>
    80007d10:	01813083          	ld	ra,24(sp)
    80007d14:	01013403          	ld	s0,16(sp)
    80007d18:	40a48533          	sub	a0,s1,a0
    80007d1c:	00153513          	seqz	a0,a0
    80007d20:	00813483          	ld	s1,8(sp)
    80007d24:	02010113          	addi	sp,sp,32
    80007d28:	00008067          	ret

0000000080007d2c <push_off>:
    80007d2c:	fe010113          	addi	sp,sp,-32
    80007d30:	00813823          	sd	s0,16(sp)
    80007d34:	00113c23          	sd	ra,24(sp)
    80007d38:	00913423          	sd	s1,8(sp)
    80007d3c:	02010413          	addi	s0,sp,32
    80007d40:	100024f3          	csrr	s1,sstatus
    80007d44:	100027f3          	csrr	a5,sstatus
    80007d48:	ffd7f793          	andi	a5,a5,-3
    80007d4c:	10079073          	csrw	sstatus,a5
    80007d50:	ffffe097          	auipc	ra,0xffffe
    80007d54:	714080e7          	jalr	1812(ra) # 80006464 <mycpu>
    80007d58:	07852783          	lw	a5,120(a0)
    80007d5c:	02078663          	beqz	a5,80007d88 <push_off+0x5c>
    80007d60:	ffffe097          	auipc	ra,0xffffe
    80007d64:	704080e7          	jalr	1796(ra) # 80006464 <mycpu>
    80007d68:	07852783          	lw	a5,120(a0)
    80007d6c:	01813083          	ld	ra,24(sp)
    80007d70:	01013403          	ld	s0,16(sp)
    80007d74:	0017879b          	addiw	a5,a5,1
    80007d78:	06f52c23          	sw	a5,120(a0)
    80007d7c:	00813483          	ld	s1,8(sp)
    80007d80:	02010113          	addi	sp,sp,32
    80007d84:	00008067          	ret
    80007d88:	0014d493          	srli	s1,s1,0x1
    80007d8c:	ffffe097          	auipc	ra,0xffffe
    80007d90:	6d8080e7          	jalr	1752(ra) # 80006464 <mycpu>
    80007d94:	0014f493          	andi	s1,s1,1
    80007d98:	06952e23          	sw	s1,124(a0)
    80007d9c:	fc5ff06f          	j	80007d60 <push_off+0x34>

0000000080007da0 <pop_off>:
    80007da0:	ff010113          	addi	sp,sp,-16
    80007da4:	00813023          	sd	s0,0(sp)
    80007da8:	00113423          	sd	ra,8(sp)
    80007dac:	01010413          	addi	s0,sp,16
    80007db0:	ffffe097          	auipc	ra,0xffffe
    80007db4:	6b4080e7          	jalr	1716(ra) # 80006464 <mycpu>
    80007db8:	100027f3          	csrr	a5,sstatus
    80007dbc:	0027f793          	andi	a5,a5,2
    80007dc0:	04079663          	bnez	a5,80007e0c <pop_off+0x6c>
    80007dc4:	07852783          	lw	a5,120(a0)
    80007dc8:	02f05a63          	blez	a5,80007dfc <pop_off+0x5c>
    80007dcc:	fff7871b          	addiw	a4,a5,-1
    80007dd0:	06e52c23          	sw	a4,120(a0)
    80007dd4:	00071c63          	bnez	a4,80007dec <pop_off+0x4c>
    80007dd8:	07c52783          	lw	a5,124(a0)
    80007ddc:	00078863          	beqz	a5,80007dec <pop_off+0x4c>
    80007de0:	100027f3          	csrr	a5,sstatus
    80007de4:	0027e793          	ori	a5,a5,2
    80007de8:	10079073          	csrw	sstatus,a5
    80007dec:	00813083          	ld	ra,8(sp)
    80007df0:	00013403          	ld	s0,0(sp)
    80007df4:	01010113          	addi	sp,sp,16
    80007df8:	00008067          	ret
    80007dfc:	00002517          	auipc	a0,0x2
    80007e00:	8dc50513          	addi	a0,a0,-1828 # 800096d8 <digits+0x48>
    80007e04:	fffff097          	auipc	ra,0xfffff
    80007e08:	018080e7          	jalr	24(ra) # 80006e1c <panic>
    80007e0c:	00002517          	auipc	a0,0x2
    80007e10:	8b450513          	addi	a0,a0,-1868 # 800096c0 <digits+0x30>
    80007e14:	fffff097          	auipc	ra,0xfffff
    80007e18:	008080e7          	jalr	8(ra) # 80006e1c <panic>

0000000080007e1c <push_on>:
    80007e1c:	fe010113          	addi	sp,sp,-32
    80007e20:	00813823          	sd	s0,16(sp)
    80007e24:	00113c23          	sd	ra,24(sp)
    80007e28:	00913423          	sd	s1,8(sp)
    80007e2c:	02010413          	addi	s0,sp,32
    80007e30:	100024f3          	csrr	s1,sstatus
    80007e34:	100027f3          	csrr	a5,sstatus
    80007e38:	0027e793          	ori	a5,a5,2
    80007e3c:	10079073          	csrw	sstatus,a5
    80007e40:	ffffe097          	auipc	ra,0xffffe
    80007e44:	624080e7          	jalr	1572(ra) # 80006464 <mycpu>
    80007e48:	07852783          	lw	a5,120(a0)
    80007e4c:	02078663          	beqz	a5,80007e78 <push_on+0x5c>
    80007e50:	ffffe097          	auipc	ra,0xffffe
    80007e54:	614080e7          	jalr	1556(ra) # 80006464 <mycpu>
    80007e58:	07852783          	lw	a5,120(a0)
    80007e5c:	01813083          	ld	ra,24(sp)
    80007e60:	01013403          	ld	s0,16(sp)
    80007e64:	0017879b          	addiw	a5,a5,1
    80007e68:	06f52c23          	sw	a5,120(a0)
    80007e6c:	00813483          	ld	s1,8(sp)
    80007e70:	02010113          	addi	sp,sp,32
    80007e74:	00008067          	ret
    80007e78:	0014d493          	srli	s1,s1,0x1
    80007e7c:	ffffe097          	auipc	ra,0xffffe
    80007e80:	5e8080e7          	jalr	1512(ra) # 80006464 <mycpu>
    80007e84:	0014f493          	andi	s1,s1,1
    80007e88:	06952e23          	sw	s1,124(a0)
    80007e8c:	fc5ff06f          	j	80007e50 <push_on+0x34>

0000000080007e90 <pop_on>:
    80007e90:	ff010113          	addi	sp,sp,-16
    80007e94:	00813023          	sd	s0,0(sp)
    80007e98:	00113423          	sd	ra,8(sp)
    80007e9c:	01010413          	addi	s0,sp,16
    80007ea0:	ffffe097          	auipc	ra,0xffffe
    80007ea4:	5c4080e7          	jalr	1476(ra) # 80006464 <mycpu>
    80007ea8:	100027f3          	csrr	a5,sstatus
    80007eac:	0027f793          	andi	a5,a5,2
    80007eb0:	04078463          	beqz	a5,80007ef8 <pop_on+0x68>
    80007eb4:	07852783          	lw	a5,120(a0)
    80007eb8:	02f05863          	blez	a5,80007ee8 <pop_on+0x58>
    80007ebc:	fff7879b          	addiw	a5,a5,-1
    80007ec0:	06f52c23          	sw	a5,120(a0)
    80007ec4:	07853783          	ld	a5,120(a0)
    80007ec8:	00079863          	bnez	a5,80007ed8 <pop_on+0x48>
    80007ecc:	100027f3          	csrr	a5,sstatus
    80007ed0:	ffd7f793          	andi	a5,a5,-3
    80007ed4:	10079073          	csrw	sstatus,a5
    80007ed8:	00813083          	ld	ra,8(sp)
    80007edc:	00013403          	ld	s0,0(sp)
    80007ee0:	01010113          	addi	sp,sp,16
    80007ee4:	00008067          	ret
    80007ee8:	00002517          	auipc	a0,0x2
    80007eec:	81850513          	addi	a0,a0,-2024 # 80009700 <digits+0x70>
    80007ef0:	fffff097          	auipc	ra,0xfffff
    80007ef4:	f2c080e7          	jalr	-212(ra) # 80006e1c <panic>
    80007ef8:	00001517          	auipc	a0,0x1
    80007efc:	7e850513          	addi	a0,a0,2024 # 800096e0 <digits+0x50>
    80007f00:	fffff097          	auipc	ra,0xfffff
    80007f04:	f1c080e7          	jalr	-228(ra) # 80006e1c <panic>

0000000080007f08 <__memset>:
    80007f08:	ff010113          	addi	sp,sp,-16
    80007f0c:	00813423          	sd	s0,8(sp)
    80007f10:	01010413          	addi	s0,sp,16
    80007f14:	1a060e63          	beqz	a2,800080d0 <__memset+0x1c8>
    80007f18:	40a007b3          	neg	a5,a0
    80007f1c:	0077f793          	andi	a5,a5,7
    80007f20:	00778693          	addi	a3,a5,7
    80007f24:	00b00813          	li	a6,11
    80007f28:	0ff5f593          	andi	a1,a1,255
    80007f2c:	fff6071b          	addiw	a4,a2,-1
    80007f30:	1b06e663          	bltu	a3,a6,800080dc <__memset+0x1d4>
    80007f34:	1cd76463          	bltu	a4,a3,800080fc <__memset+0x1f4>
    80007f38:	1a078e63          	beqz	a5,800080f4 <__memset+0x1ec>
    80007f3c:	00b50023          	sb	a1,0(a0)
    80007f40:	00100713          	li	a4,1
    80007f44:	1ae78463          	beq	a5,a4,800080ec <__memset+0x1e4>
    80007f48:	00b500a3          	sb	a1,1(a0)
    80007f4c:	00200713          	li	a4,2
    80007f50:	1ae78a63          	beq	a5,a4,80008104 <__memset+0x1fc>
    80007f54:	00b50123          	sb	a1,2(a0)
    80007f58:	00300713          	li	a4,3
    80007f5c:	18e78463          	beq	a5,a4,800080e4 <__memset+0x1dc>
    80007f60:	00b501a3          	sb	a1,3(a0)
    80007f64:	00400713          	li	a4,4
    80007f68:	1ae78263          	beq	a5,a4,8000810c <__memset+0x204>
    80007f6c:	00b50223          	sb	a1,4(a0)
    80007f70:	00500713          	li	a4,5
    80007f74:	1ae78063          	beq	a5,a4,80008114 <__memset+0x20c>
    80007f78:	00b502a3          	sb	a1,5(a0)
    80007f7c:	00700713          	li	a4,7
    80007f80:	18e79e63          	bne	a5,a4,8000811c <__memset+0x214>
    80007f84:	00b50323          	sb	a1,6(a0)
    80007f88:	00700e93          	li	t4,7
    80007f8c:	00859713          	slli	a4,a1,0x8
    80007f90:	00e5e733          	or	a4,a1,a4
    80007f94:	01059e13          	slli	t3,a1,0x10
    80007f98:	01c76e33          	or	t3,a4,t3
    80007f9c:	01859313          	slli	t1,a1,0x18
    80007fa0:	006e6333          	or	t1,t3,t1
    80007fa4:	02059893          	slli	a7,a1,0x20
    80007fa8:	40f60e3b          	subw	t3,a2,a5
    80007fac:	011368b3          	or	a7,t1,a7
    80007fb0:	02859813          	slli	a6,a1,0x28
    80007fb4:	0108e833          	or	a6,a7,a6
    80007fb8:	03059693          	slli	a3,a1,0x30
    80007fbc:	003e589b          	srliw	a7,t3,0x3
    80007fc0:	00d866b3          	or	a3,a6,a3
    80007fc4:	03859713          	slli	a4,a1,0x38
    80007fc8:	00389813          	slli	a6,a7,0x3
    80007fcc:	00f507b3          	add	a5,a0,a5
    80007fd0:	00e6e733          	or	a4,a3,a4
    80007fd4:	000e089b          	sext.w	a7,t3
    80007fd8:	00f806b3          	add	a3,a6,a5
    80007fdc:	00e7b023          	sd	a4,0(a5)
    80007fe0:	00878793          	addi	a5,a5,8
    80007fe4:	fed79ce3          	bne	a5,a3,80007fdc <__memset+0xd4>
    80007fe8:	ff8e7793          	andi	a5,t3,-8
    80007fec:	0007871b          	sext.w	a4,a5
    80007ff0:	01d787bb          	addw	a5,a5,t4
    80007ff4:	0ce88e63          	beq	a7,a4,800080d0 <__memset+0x1c8>
    80007ff8:	00f50733          	add	a4,a0,a5
    80007ffc:	00b70023          	sb	a1,0(a4)
    80008000:	0017871b          	addiw	a4,a5,1
    80008004:	0cc77663          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008008:	00e50733          	add	a4,a0,a4
    8000800c:	00b70023          	sb	a1,0(a4)
    80008010:	0027871b          	addiw	a4,a5,2
    80008014:	0ac77e63          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008018:	00e50733          	add	a4,a0,a4
    8000801c:	00b70023          	sb	a1,0(a4)
    80008020:	0037871b          	addiw	a4,a5,3
    80008024:	0ac77663          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008028:	00e50733          	add	a4,a0,a4
    8000802c:	00b70023          	sb	a1,0(a4)
    80008030:	0047871b          	addiw	a4,a5,4
    80008034:	08c77e63          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008038:	00e50733          	add	a4,a0,a4
    8000803c:	00b70023          	sb	a1,0(a4)
    80008040:	0057871b          	addiw	a4,a5,5
    80008044:	08c77663          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008048:	00e50733          	add	a4,a0,a4
    8000804c:	00b70023          	sb	a1,0(a4)
    80008050:	0067871b          	addiw	a4,a5,6
    80008054:	06c77e63          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008058:	00e50733          	add	a4,a0,a4
    8000805c:	00b70023          	sb	a1,0(a4)
    80008060:	0077871b          	addiw	a4,a5,7
    80008064:	06c77663          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008068:	00e50733          	add	a4,a0,a4
    8000806c:	00b70023          	sb	a1,0(a4)
    80008070:	0087871b          	addiw	a4,a5,8
    80008074:	04c77e63          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008078:	00e50733          	add	a4,a0,a4
    8000807c:	00b70023          	sb	a1,0(a4)
    80008080:	0097871b          	addiw	a4,a5,9
    80008084:	04c77663          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008088:	00e50733          	add	a4,a0,a4
    8000808c:	00b70023          	sb	a1,0(a4)
    80008090:	00a7871b          	addiw	a4,a5,10
    80008094:	02c77e63          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    80008098:	00e50733          	add	a4,a0,a4
    8000809c:	00b70023          	sb	a1,0(a4)
    800080a0:	00b7871b          	addiw	a4,a5,11
    800080a4:	02c77663          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    800080a8:	00e50733          	add	a4,a0,a4
    800080ac:	00b70023          	sb	a1,0(a4)
    800080b0:	00c7871b          	addiw	a4,a5,12
    800080b4:	00c77e63          	bgeu	a4,a2,800080d0 <__memset+0x1c8>
    800080b8:	00e50733          	add	a4,a0,a4
    800080bc:	00b70023          	sb	a1,0(a4)
    800080c0:	00d7879b          	addiw	a5,a5,13
    800080c4:	00c7f663          	bgeu	a5,a2,800080d0 <__memset+0x1c8>
    800080c8:	00f507b3          	add	a5,a0,a5
    800080cc:	00b78023          	sb	a1,0(a5)
    800080d0:	00813403          	ld	s0,8(sp)
    800080d4:	01010113          	addi	sp,sp,16
    800080d8:	00008067          	ret
    800080dc:	00b00693          	li	a3,11
    800080e0:	e55ff06f          	j	80007f34 <__memset+0x2c>
    800080e4:	00300e93          	li	t4,3
    800080e8:	ea5ff06f          	j	80007f8c <__memset+0x84>
    800080ec:	00100e93          	li	t4,1
    800080f0:	e9dff06f          	j	80007f8c <__memset+0x84>
    800080f4:	00000e93          	li	t4,0
    800080f8:	e95ff06f          	j	80007f8c <__memset+0x84>
    800080fc:	00000793          	li	a5,0
    80008100:	ef9ff06f          	j	80007ff8 <__memset+0xf0>
    80008104:	00200e93          	li	t4,2
    80008108:	e85ff06f          	j	80007f8c <__memset+0x84>
    8000810c:	00400e93          	li	t4,4
    80008110:	e7dff06f          	j	80007f8c <__memset+0x84>
    80008114:	00500e93          	li	t4,5
    80008118:	e75ff06f          	j	80007f8c <__memset+0x84>
    8000811c:	00600e93          	li	t4,6
    80008120:	e6dff06f          	j	80007f8c <__memset+0x84>

0000000080008124 <__memmove>:
    80008124:	ff010113          	addi	sp,sp,-16
    80008128:	00813423          	sd	s0,8(sp)
    8000812c:	01010413          	addi	s0,sp,16
    80008130:	0e060863          	beqz	a2,80008220 <__memmove+0xfc>
    80008134:	fff6069b          	addiw	a3,a2,-1
    80008138:	0006881b          	sext.w	a6,a3
    8000813c:	0ea5e863          	bltu	a1,a0,8000822c <__memmove+0x108>
    80008140:	00758713          	addi	a4,a1,7
    80008144:	00a5e7b3          	or	a5,a1,a0
    80008148:	40a70733          	sub	a4,a4,a0
    8000814c:	0077f793          	andi	a5,a5,7
    80008150:	00f73713          	sltiu	a4,a4,15
    80008154:	00174713          	xori	a4,a4,1
    80008158:	0017b793          	seqz	a5,a5
    8000815c:	00e7f7b3          	and	a5,a5,a4
    80008160:	10078863          	beqz	a5,80008270 <__memmove+0x14c>
    80008164:	00900793          	li	a5,9
    80008168:	1107f463          	bgeu	a5,a6,80008270 <__memmove+0x14c>
    8000816c:	0036581b          	srliw	a6,a2,0x3
    80008170:	fff8081b          	addiw	a6,a6,-1
    80008174:	02081813          	slli	a6,a6,0x20
    80008178:	01d85893          	srli	a7,a6,0x1d
    8000817c:	00858813          	addi	a6,a1,8
    80008180:	00058793          	mv	a5,a1
    80008184:	00050713          	mv	a4,a0
    80008188:	01088833          	add	a6,a7,a6
    8000818c:	0007b883          	ld	a7,0(a5)
    80008190:	00878793          	addi	a5,a5,8
    80008194:	00870713          	addi	a4,a4,8
    80008198:	ff173c23          	sd	a7,-8(a4)
    8000819c:	ff0798e3          	bne	a5,a6,8000818c <__memmove+0x68>
    800081a0:	ff867713          	andi	a4,a2,-8
    800081a4:	02071793          	slli	a5,a4,0x20
    800081a8:	0207d793          	srli	a5,a5,0x20
    800081ac:	00f585b3          	add	a1,a1,a5
    800081b0:	40e686bb          	subw	a3,a3,a4
    800081b4:	00f507b3          	add	a5,a0,a5
    800081b8:	06e60463          	beq	a2,a4,80008220 <__memmove+0xfc>
    800081bc:	0005c703          	lbu	a4,0(a1)
    800081c0:	00e78023          	sb	a4,0(a5)
    800081c4:	04068e63          	beqz	a3,80008220 <__memmove+0xfc>
    800081c8:	0015c603          	lbu	a2,1(a1)
    800081cc:	00100713          	li	a4,1
    800081d0:	00c780a3          	sb	a2,1(a5)
    800081d4:	04e68663          	beq	a3,a4,80008220 <__memmove+0xfc>
    800081d8:	0025c603          	lbu	a2,2(a1)
    800081dc:	00200713          	li	a4,2
    800081e0:	00c78123          	sb	a2,2(a5)
    800081e4:	02e68e63          	beq	a3,a4,80008220 <__memmove+0xfc>
    800081e8:	0035c603          	lbu	a2,3(a1)
    800081ec:	00300713          	li	a4,3
    800081f0:	00c781a3          	sb	a2,3(a5)
    800081f4:	02e68663          	beq	a3,a4,80008220 <__memmove+0xfc>
    800081f8:	0045c603          	lbu	a2,4(a1)
    800081fc:	00400713          	li	a4,4
    80008200:	00c78223          	sb	a2,4(a5)
    80008204:	00e68e63          	beq	a3,a4,80008220 <__memmove+0xfc>
    80008208:	0055c603          	lbu	a2,5(a1)
    8000820c:	00500713          	li	a4,5
    80008210:	00c782a3          	sb	a2,5(a5)
    80008214:	00e68663          	beq	a3,a4,80008220 <__memmove+0xfc>
    80008218:	0065c703          	lbu	a4,6(a1)
    8000821c:	00e78323          	sb	a4,6(a5)
    80008220:	00813403          	ld	s0,8(sp)
    80008224:	01010113          	addi	sp,sp,16
    80008228:	00008067          	ret
    8000822c:	02061713          	slli	a4,a2,0x20
    80008230:	02075713          	srli	a4,a4,0x20
    80008234:	00e587b3          	add	a5,a1,a4
    80008238:	f0f574e3          	bgeu	a0,a5,80008140 <__memmove+0x1c>
    8000823c:	02069613          	slli	a2,a3,0x20
    80008240:	02065613          	srli	a2,a2,0x20
    80008244:	fff64613          	not	a2,a2
    80008248:	00e50733          	add	a4,a0,a4
    8000824c:	00c78633          	add	a2,a5,a2
    80008250:	fff7c683          	lbu	a3,-1(a5)
    80008254:	fff78793          	addi	a5,a5,-1
    80008258:	fff70713          	addi	a4,a4,-1
    8000825c:	00d70023          	sb	a3,0(a4)
    80008260:	fec798e3          	bne	a5,a2,80008250 <__memmove+0x12c>
    80008264:	00813403          	ld	s0,8(sp)
    80008268:	01010113          	addi	sp,sp,16
    8000826c:	00008067          	ret
    80008270:	02069713          	slli	a4,a3,0x20
    80008274:	02075713          	srli	a4,a4,0x20
    80008278:	00170713          	addi	a4,a4,1
    8000827c:	00e50733          	add	a4,a0,a4
    80008280:	00050793          	mv	a5,a0
    80008284:	0005c683          	lbu	a3,0(a1)
    80008288:	00178793          	addi	a5,a5,1
    8000828c:	00158593          	addi	a1,a1,1
    80008290:	fed78fa3          	sb	a3,-1(a5)
    80008294:	fee798e3          	bne	a5,a4,80008284 <__memmove+0x160>
    80008298:	f89ff06f          	j	80008220 <__memmove+0xfc>

000000008000829c <__putc>:
    8000829c:	fe010113          	addi	sp,sp,-32
    800082a0:	00813823          	sd	s0,16(sp)
    800082a4:	00113c23          	sd	ra,24(sp)
    800082a8:	02010413          	addi	s0,sp,32
    800082ac:	00050793          	mv	a5,a0
    800082b0:	fef40593          	addi	a1,s0,-17
    800082b4:	00100613          	li	a2,1
    800082b8:	00000513          	li	a0,0
    800082bc:	fef407a3          	sb	a5,-17(s0)
    800082c0:	fffff097          	auipc	ra,0xfffff
    800082c4:	b3c080e7          	jalr	-1220(ra) # 80006dfc <console_write>
    800082c8:	01813083          	ld	ra,24(sp)
    800082cc:	01013403          	ld	s0,16(sp)
    800082d0:	02010113          	addi	sp,sp,32
    800082d4:	00008067          	ret

00000000800082d8 <__getc>:
    800082d8:	fe010113          	addi	sp,sp,-32
    800082dc:	00813823          	sd	s0,16(sp)
    800082e0:	00113c23          	sd	ra,24(sp)
    800082e4:	02010413          	addi	s0,sp,32
    800082e8:	fe840593          	addi	a1,s0,-24
    800082ec:	00100613          	li	a2,1
    800082f0:	00000513          	li	a0,0
    800082f4:	fffff097          	auipc	ra,0xfffff
    800082f8:	ae8080e7          	jalr	-1304(ra) # 80006ddc <console_read>
    800082fc:	fe844503          	lbu	a0,-24(s0)
    80008300:	01813083          	ld	ra,24(sp)
    80008304:	01013403          	ld	s0,16(sp)
    80008308:	02010113          	addi	sp,sp,32
    8000830c:	00008067          	ret

0000000080008310 <console_handler>:
    80008310:	fe010113          	addi	sp,sp,-32
    80008314:	00813823          	sd	s0,16(sp)
    80008318:	00113c23          	sd	ra,24(sp)
    8000831c:	00913423          	sd	s1,8(sp)
    80008320:	02010413          	addi	s0,sp,32
    80008324:	14202773          	csrr	a4,scause
    80008328:	100027f3          	csrr	a5,sstatus
    8000832c:	0027f793          	andi	a5,a5,2
    80008330:	06079e63          	bnez	a5,800083ac <console_handler+0x9c>
    80008334:	00074c63          	bltz	a4,8000834c <console_handler+0x3c>
    80008338:	01813083          	ld	ra,24(sp)
    8000833c:	01013403          	ld	s0,16(sp)
    80008340:	00813483          	ld	s1,8(sp)
    80008344:	02010113          	addi	sp,sp,32
    80008348:	00008067          	ret
    8000834c:	0ff77713          	andi	a4,a4,255
    80008350:	00900793          	li	a5,9
    80008354:	fef712e3          	bne	a4,a5,80008338 <console_handler+0x28>
    80008358:	ffffe097          	auipc	ra,0xffffe
    8000835c:	6dc080e7          	jalr	1756(ra) # 80006a34 <plic_claim>
    80008360:	00a00793          	li	a5,10
    80008364:	00050493          	mv	s1,a0
    80008368:	02f50c63          	beq	a0,a5,800083a0 <console_handler+0x90>
    8000836c:	fc0506e3          	beqz	a0,80008338 <console_handler+0x28>
    80008370:	00050593          	mv	a1,a0
    80008374:	00001517          	auipc	a0,0x1
    80008378:	29450513          	addi	a0,a0,660 # 80009608 <_ZZ13print_integermE6digits+0x550>
    8000837c:	fffff097          	auipc	ra,0xfffff
    80008380:	afc080e7          	jalr	-1284(ra) # 80006e78 <__printf>
    80008384:	01013403          	ld	s0,16(sp)
    80008388:	01813083          	ld	ra,24(sp)
    8000838c:	00048513          	mv	a0,s1
    80008390:	00813483          	ld	s1,8(sp)
    80008394:	02010113          	addi	sp,sp,32
    80008398:	ffffe317          	auipc	t1,0xffffe
    8000839c:	6d430067          	jr	1748(t1) # 80006a6c <plic_complete>
    800083a0:	fffff097          	auipc	ra,0xfffff
    800083a4:	3e0080e7          	jalr	992(ra) # 80007780 <uartintr>
    800083a8:	fddff06f          	j	80008384 <console_handler+0x74>
    800083ac:	00001517          	auipc	a0,0x1
    800083b0:	35c50513          	addi	a0,a0,860 # 80009708 <digits+0x78>
    800083b4:	fffff097          	auipc	ra,0xfffff
    800083b8:	a68080e7          	jalr	-1432(ra) # 80006e1c <panic>
	...

#ifndef __IRQ_H__
#define __IRQ_H__

/*some function related with interrupt*/
void init_idt(void);
void init_intr(void);

void set_timer_intr_handler( void (*ptr)(void) );
void set_keyboard_intr_handler( void (*ptr)(int) );

#endif

// test de suivi de ligne

// on commence par des tests de  mouvement ( avance, recule, rotation  )
// sans lire l'etat du robot



#include <avr/io.h> 
#undef F_CPU 
#define F_CPU 16000000UL 
#include <util/delay.h> 


#define UCSRB _SFR_IO8(0x01) 
#define UCSRA _SFR_IO8(0x02) 
#define UDR _SFR_IO8(0x03) 

// definition des port d'entree/sortie
#define PORTA 	_SFR_IO8(0x1B)
#define PINA	_SFR_IO8(0x19)
#define PORTB	_SFR_IO8(0x18)
#define PINB    _SFR_IO8(0x16) //peut-être bon

// UCSRA 
#define RXC 7 
#define TXC 6 
#define UDRE 5 
//UCSRB 
#define RXEN 4 
#define TXEN 3 

//void avance_bot(uint8_t cvg, uint8_t cvd, uint8_t dir);

//*********************************************************************** 
// main 
//*********************************************************************** 
 int main (void) { 
/*  PORTA : moteur droit
    PORTB : moteur gauche
    UCSRB : dir
    PINA : vg
    PINB : vd
*/
    //uint8_t dir,cvd,cvg ; // sorties à commander
    //uint8_t pos_bot,vmotg,vmotd; // entrées à lire
    
    // initialisation à l'arrêt
    
    PORTA = 0x00;
    PORTB = 0x00;
    _delay_ms(2000); // on devrait avoir le robot à l'arrêt
    UCSRB = 0b11;
    for(;;) { 
    for (int i = 180; i > 19; i-=5)
      {
         PORTB = i;
         PORTA = i;
         _delay_ms(1000);
      }  
	}
		
 return 0;
 }
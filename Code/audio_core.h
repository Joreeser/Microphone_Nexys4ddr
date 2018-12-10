/*****************************************************************//**
 * @file uart_core.h
 *
 * @brief Access MMIO timer core and
 *        display number/sting on a serial console
 *
 * @author p chu
 * @version v1.0: initial release
 ********************************************************************/

#ifndef _AUDIO_CORE_H_INCLUDED
#define _AUDIO_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"  
/**
 * SSEG core driver
 * - Set refresh rate for sseg display 
 * - Set data to be displayed
 */
class AudioCore {
public:
// Register map
   enum {
      DATA_REG = 0, // Display data register
	  POWER_REG = 1 // Refresh rate register
   };

   // Constructor
   AudioCore(uint32_t core_base_addr);
   ~AudioCore();
   
   void set_power(int power);
   
   void set_data(int data);

private:
   uint32_t base_addr;
};

#endif  // _AUDIO_CORE_H_INCLUDED

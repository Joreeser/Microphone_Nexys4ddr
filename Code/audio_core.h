/*****************************************************************//**
 * @file audio_core.h
 *
 * @brief Access audio output and 
 *        set power and data values
 *
 * @author p chu
 * @version v1.0: initial release
 ********************************************************************/

#ifndef _AUDIO_CORE_H_INCLUDED
#define _AUDIO_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"  
/**
 * Audio core driver
 * - Set power level 
 * - Set data to be played
 */
class AudioCore {
public:
// Register map
   enum {
      DATA_REG = 0, // Data register
	  POWER_REG = 1 // Power register
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

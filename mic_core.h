/*****************************************************************//**
 * @file mic_core.h
 *
 * @brief access microphone
 ********************************************************************/

#ifndef _MIC_CORE_H_INCLUDED
#define _MIC_CORE_H_INCLUDED

#include "chu_io_rw.h"
#include "chu_io_map.h"  
/**
 * Microphone core driver
 * - Take in data from microphone
 */
class MicCore {
public:
// Register map
   enum {
      DATA_REG = 0, // Display data register
   };

   // Constructor
   MicCore(uint32_t core_base_addr);
   ~MicCore();
   
   // Set display data
   // Data should be exactly 32-bit Hex to display on all digits of screen
   int load_mic_data();

private:
   uint32_t base_addr;
};

#endif  // _MIC_CORE_H_INCLUDED

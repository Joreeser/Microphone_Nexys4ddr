/*****************************************************************//**
 * @file sseg_core.cpp
 *
 * @brief implementation of SsegCore class
 ********************************************************************/

#include "audio_core.h"

AudioCore::AudioCore(uint32_t core_base_addr) {
   base_addr = core_base_addr;
   set_power(1); // Default value
}

AudioCore::~AudioCore() {
}

void AudioCore::set_power(int power) {
   io_write(base_addr, POWER_REG, power);
}

void AudioCore::set_data(int data) {
	io_write(base_addr, DATA_REG, data);
}







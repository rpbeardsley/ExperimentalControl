#pragma once

//
// This function calculates the 16 bit CCITT CRC for the given
// block of bytes and returns it.
//
// Note that all 16 bit CRC calculations are NOT the same.
//
WORD DoCRC_CCITT(const BYTE* pby,int iLen);

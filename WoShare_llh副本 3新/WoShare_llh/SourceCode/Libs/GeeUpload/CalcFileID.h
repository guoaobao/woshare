/*
 * CalcFileID.h
 *
 *  Created on: 2011-12-28
 *      Author: bluewind
 */

#ifndef CALCFILEID_H_
#define CALCFILEID_H_

#include <string>

int CalcFileID(const std::string & filePath, std::string& fileId);
int CaclFileSize(const std::string& filePath,long long& size);

#endif /* CALCFILEID_H_ */

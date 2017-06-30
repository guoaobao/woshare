/*
 * CalcFileID.cpp
 *
 *  Created on: 2011-12-28
 *      Author: bluewind
 */

#include "CalcFileID.h"
#include "md5.h"

int CalcFileID(const std::string & filePath, std::string& fileId)
{
	FILE * pFile = NULL;
	pFile = fopen(filePath.c_str(),"rb");
	if(pFile == NULL)
	{
		printf("CalcFileID fopen failed,filePath%s\n",filePath.c_str());
		return 0;
	}
	else
	{
        time_t start = time(0);
		MD5 md5;
		md5.reset();
		md5.update(pFile);
		fileId = md5.toString();
		printf("CalcFileID,fileId:%s\n",fileId.c_str());
		fclose(pFile);
        time_t end = time(0);
        printf("CalcFileID time:%ld\n",(end - start));
		return 1;
	}
}

int CaclFileSize(const std::string& filePath,long long& size)
{
	FILE * pFile = NULL;
	pFile = fopen(filePath.c_str(),"rb");
	if(pFile == NULL)
	{
		printf("CaclFileSize fopen failed,filePath%s\n",filePath.c_str());
		return 0;
	}
	else
	{
        fseek(pFile,0L,SEEK_END);
        size = ftell(pFile);//gebin-todo
        fseek(pFile,0L,SEEK_SET);
		fclose(pFile);
		return 1;
	}
}
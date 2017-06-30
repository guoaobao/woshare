/*
 * GeeUpload.h
 *
 *  Created on: 2013-4-1
 *      Author: eingbol
 */

#ifndef GEEUPLOAD_H_
#define GEEUPLOAD_H_

#include <string>

typedef void (*progressFunc)(long long total,long long upload);

#define SAFE_DELETE(p) {if(p){delete (p);(p)=NULL;}}

#define GU_OK 1
#define GU_ERROR_FOPEN  -10001
#define GU_ERROR_RECV   -10002
#define GU_ERROR_SEND   -10003
#define GU_ERROR_STOP   -10004

typedef int g_int32;

struct _ProgressCallbackData
{
    long long total;
    long long upload;
    double per;
};

typedef struct _ProgressCallbackData ProgressCallbackData;

class IGeeCallback
{
public:
    virtual void progressFunc(ProgressCallbackData* data) = 0;
};

class GeeUpload
{
public:
	GeeUpload();
	virtual ~GeeUpload();
public:
	int connect(const std::string& ip,int port);
	void close();
	int sendFile(const std::string& sid,const std::string& filePath,std::string& nsid);
	void setProgressFunc(progressFunc* func);
    void setCallback(IGeeCallback* cb);
    void stop();
private:
	int recvBuffer(int fd,void* buf,size_t size);
	int sendBuffer(int fd,void* buf,size_t size);
private:
	int buildHeader(g_int32 size,g_int32 mid,char** buffer,int& bsize);
	int buildTcpPack1(const std::string& sid,char** buffer,int& bsize);
	int buildTcpPack2(int value,char** buffer,int& bsize);
private:
	int _sockfd;
	progressFunc* _func;
    IGeeCallback* _callback;
	int _perSize;
	g_int32 _mid;
    int _isStop;
    double _lastPer;
};

#endif /* GEEUPLOAD_H_ */

/*
 * GeeUpload.cpp
 *
 *  Created on: 2013-4-1
 *      Author: eingbol
 */

#include "GeeUpload.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include "time.h"
#include "stdlib.h"
#include <unistd.h>

#define FC_REQUEST_UPLOADFILE		0x3000001
#define FC_REQUEST_UPLOADCOMPLETE	0x3000003
#define FC_REPLY_UPLOADFILE         0x4000001

#define GEE_PER_CALLBACK 0.01

#define ZLFS_HEADER_IDENTIFIER "<\\*ZL?/>"

#define DO_STOP if(_isStop == 1)\
                {\
                    return GU_ERROR_STOP;\
                }

GeeUpload::GeeUpload()
:_perSize(1024),
 _mid(0),
_isStop(0),
_lastPer(0.0)
{
    _sockfd = NULL;
    _func = NULL;
    _callback = NULL;
}

GeeUpload::~GeeUpload()
{
}

int GeeUpload::connect(const std::string& ip,int port)
{
	struct sockaddr_in servaddr;

	_sockfd = socket(AF_INET, SOCK_STREAM, 0);
	bzero(&servaddr,sizeof(servaddr));

	servaddr.sin_family = AF_INET;
	servaddr.sin_port = htons(port);
	inet_pton(AF_INET, ip.c_str(), &servaddr.sin_addr);

	int res = ::connect(_sockfd, (const struct sockaddr*)&servaddr, sizeof(servaddr));

	if(res == 0)
    {
        struct timeval timeout = {10,0};
        setsockopt(_sockfd, SOL_SOCKET, SO_SNDTIMEO, &timeout, sizeof(struct timeval));
        setsockopt(_sockfd, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(struct timeval));
		return 1;
    }

	return 0;
}

void GeeUpload::close()
{
    ::close(_sockfd);
}

void GeeUpload::stop()
{
    this->_isStop = 1;
}

void GeeUpload::setProgressFunc(progressFunc* func)
{
	_func = func;
}

void GeeUpload::setCallback(IGeeCallback* cb)
{
    _callback = cb;
}

int GeeUpload::buildHeader(g_int32 size,g_int32 mid,char** buffer,int& bsize)
{
	*buffer = new char[20];
	memset(*buffer,0,20);
	memcpy(*buffer,ZLFS_HEADER_IDENTIFIER,8);
	(*buffer)[8] = 1;
    memcpy(*buffer+12,(void*)&mid,4);
	memcpy(*buffer+16,(void*)&size,4);
	bsize = 20;
	return 1;
}

int GeeUpload::buildTcpPack1(const std::string& sid,char** buffer,int& bsize)
{
	char* headerBuffer = NULL;
	int headerSize = 0;
	_mid = random();
	if(buildHeader(45,_mid,&headerBuffer,headerSize) != 1)
	{
		return 0;
	}
	g_int32 commandId = FC_REQUEST_UPLOADFILE;
	*buffer = new char[headerSize + 45];
	memset(*buffer,0,headerSize + 45);
	memcpy(*buffer,headerBuffer,headerSize);
	SAFE_DELETE(headerBuffer);
	memcpy(*buffer + headerSize,(void*)&commandId,4);
    int sidSize = sid.length() + 1;
    memcpy(*buffer + headerSize + 4, (void*)&sidSize,4);
	memcpy(*buffer + headerSize + 8,(void*)sid.c_str(),36);
	bsize = headerSize + 4 + 4 + 36 + 1;
	return 1;
}

int GeeUpload::buildTcpPack2(int value,char** buffer,int& bsize)
{
	char* headerBuffer = NULL;
	int headerSize = 0;
	_mid = random();
	if(buildHeader(8,_mid,&headerBuffer,headerSize) != 1)
	{
		return 0;
	}
	g_int32 commandId = FC_REQUEST_UPLOADCOMPLETE;
	*buffer = new char[headerSize + 8];
	memset(*buffer,0,headerSize + 8);
	memcpy(*buffer,headerBuffer,headerSize);
	delete headerBuffer;
	memcpy(*buffer + headerSize,(void*)&commandId,4);
	memcpy(*buffer + headerSize + 4,(void*)&value,4);
	bsize = headerSize + 4 + 4;
	return 1;
}

int GeeUpload::recvBuffer(int fd,void* buf,size_t size)
{
	int rs = 0;
	while(rs < (int)size)
	{
		int r = recv(_sockfd,(char*)((char*)buf + rs),size - rs,0);
		if(r <= 0)
		{
			return GU_ERROR_RECV;
		}
		rs += r;
	}
	return GU_OK;
}

int GeeUpload::sendBuffer(int fd,void* buf,size_t size)
{
	int ss = 0;
	while(ss < (int)size)
	{
		int r = send(_sockfd,(char*)buf + ss,size - ss,0);
		if(r <= 0)
		{
			return GU_ERROR_SEND;
		}
		ss += r;
	}
	return GU_OK;
}

int GeeUpload::sendFile(const std::string& sid,const std::string& filePath,std::string& nsid)
{
	//part 1
	char* buffer = NULL;
	int size = 0;
	if(this->buildTcpPack1(sid,&buffer,size) != GU_OK)
	{
		return 0;
	}

	int res_s = this->sendBuffer(_sockfd,buffer,size);
	delete buffer;
	if(res_s != GU_OK)
	{
		return res_s;
	}
    
    DO_STOP;

	int rev_size = 36;
	char* rev_buffer = new char[rev_size];
	int res = this->recvBuffer(_sockfd,rev_buffer,rev_size);
	if(res != GU_OK)
	{
		SAFE_DELETE(rev_buffer);
		return res;
	}
	//read result,pos
	int result = 0;
	long long pos = 0;
	result = *((int*)(rev_buffer + 24));
	pos = *((long long*)(rev_buffer + 28));
	delete rev_buffer;
	if(result != GU_OK)
	{
		return result;
	}
	if(pos < 0)
	{
		return 0;
	}
    DO_STOP;

	//part 2
	FILE* file = fopen(filePath.c_str(),"rb");
	if(file != NULL)
	{
		fseek(file,0L,SEEK_END);
		long long fsize = ftell(file);
		fseek(file,0L,SEEK_SET);
		long long send_size = pos;
		char* send_buffer = new char[_perSize];
		while(fsize > send_size)
		{
			int read_size = fread(send_buffer,1,_perSize,file);
			int res_ss = this->sendBuffer(_sockfd,send_buffer,read_size);
			if(res_ss != GU_OK)
			{
                SAFE_DELETE(send_buffer);
				return GU_ERROR_SEND;
			}
			send_size += read_size;
            if(_func)
            {
                (*_func)(fsize,send_size);
            }
            if(_callback)
            {
                ProgressCallbackData pcd;
                pcd.total = fsize;
                pcd.upload = send_size;
                pcd.per = ((double)send_size)/fsize;
                if((pcd.per - _lastPer) > GEE_PER_CALLBACK)
                {
                    _lastPer = pcd.per;
                    _callback->progressFunc(&pcd);
                }
            }
            if(this->_isStop == 1)
            {
                SAFE_DELETE(send_buffer);
                return 0;
            }
		}
        {//100%
            if(_callback)
            {
                ProgressCallbackData pcd;
                pcd.total = fsize;
                pcd.upload = send_size;
                pcd.per = 1.0;
                _lastPer = pcd.per;
                _callback->progressFunc(&pcd);
            }
        }
        SAFE_DELETE(send_buffer);
        DO_STOP;
		//send complete OK
		char* send_buffer_ok = NULL;
		int nsize_ok = 0;
		if(buildTcpPack2(1,&send_buffer_ok,nsize_ok) != GU_OK)
		{
			return 0;
		}
		int rs_ok = this->sendBuffer(_sockfd,send_buffer_ok,nsize_ok);
		delete send_buffer_ok;
		if(rs_ok != GU_OK)
		{
			return GU_ERROR_SEND;
		}
        
        DO_STOP;

		int rev_size_ok = 28;
		char* rev_buffer_ok = new char[rev_size_ok];
		int rr_ok = this->recvBuffer(_sockfd,rev_buffer_ok,rev_size_ok);
		if(rr_ok != GU_OK)
		{
			SAFE_DELETE(rev_buffer_ok);
			return rr_ok;
		}
		//read result
		int result_ok = 0;
		result_ok = *((int*)(rev_buffer_ok + 24));
		SAFE_DELETE(rev_buffer_ok);
        if(result_ok == GU_OK)
        {
            int rev_size_nsid = 29;
            char* rev_buffer_nsid = new char[rev_size_nsid];
            int rr_nsid = this->recvBuffer(_sockfd,rev_buffer_nsid,rev_size_nsid);
            if(rr_nsid == GU_OK)
            {
                char* buffer_nsid = new char[25];
                memset(buffer_nsid, 0, 25);
                memcpy(buffer_nsid, rev_buffer_nsid + 4, 24);
                nsid = buffer_nsid;
                SAFE_DELETE(buffer_nsid);
            }
            SAFE_DELETE(rev_buffer_nsid);
        }
		return result_ok;
	}
	else
	{
		return GU_ERROR_FOPEN;
	}

	return GU_OK;
}

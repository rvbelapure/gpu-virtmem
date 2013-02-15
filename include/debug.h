/**
 * @file debug.h
 * @brief Contains debug utils
 * Copied from: remote_gpu/common/gvim_debug.h
 *
 * @date Feb 23, 2011
 * @author Modified by Magda Slawinska, magg@gatech.edu
 */

#ifndef DEBUG_H_
#define DEBUG_H_

#include <stdio.h>

#define DEBUG

//////////////////////////////////////
//
// Debug printing verbosity
//
#define DBG_LEVEL   DBG_DEBUG

// New debug messaging state. There is no sense of a "level" for debugging. Each of these define the
// purpose of the messages and is enabled/disabled per file
#define DBG_ERROR   0           // system cannot continue
#define DBG_CRITICAL 1
#define DBG_WARNING 2           // system is (may be?) consistent, stuff still works (e.g. accept no more domains)
#define DBG_MESSAGE 3
#define DBG_INFO    4           // messages about state or configuration; high-level flow
#define DBG_DEBUG   5           // func args, variable values, etc; full flow, may slow system down

#define DBG_ERROR_STR "ERROR"
#define DBG_CRITICAL_STR "CRITICAL"
#define DBG_WARNING_STR "WARNING"
#define DBG_MESSAGE_STR "MESSAGE"
#define DBG_INFO_STR	"INFO"
#define DBG_DEBUG_STR	"DEBUG"

#define printd(level, fmt, args...)                                     \
    do {                                                                \
        if((level) <= DBG_LEVEL) {                                      \
            printf("<%d> %s[%d]: ", (level), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);                                             \
        }                                                               \
    } while(0)

// @todo do something like that but smarter without unnecessary copying
#define p_error(fmt, args...)                             \
    do {                                                                \
        if((DBG_ERROR) <= DBG_LEVEL) {                                      \
            printf("%s <%d> %s[%d]: ", DBG_ERROR_STR, (DBG_ERROR), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);  											\
            exit(-1);													\
        }                                                               \
    } while(0)


#define p_critical(fmt, args...) \
	do {                                                                \
        if((DBG_CRITICAL) <= DBG_LEVEL) {                                      \
            printf("%s <%d> %s[%d]: ", DBG_CRITICAL_STR, (DBG_CRITICAL), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);												\
        }                                                               \
    } while(0)

#define p_warn(fmt, args...) \
	do {                                                                \
        if((DBG_WARNING) <= DBG_LEVEL) {                                      \
            printf("%s <%d> %s[%d]: ", DBG_WARNING_STR, (DBG_WARNING), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);												\
        }                                                               \
    } while(0)

#define p_mesg(fmt, args...) \
	do {                                                                \
        if((DBG_MESSAGE) <= DBG_LEVEL) {                                      \
            printf("%s <%d> %s[%d]: ", DBG_MESSAGE_STR, (DBG_MESSAGE), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);												\
        }                                                               \
    } while(0)

#define p_info(fmt, args...) \
	do {                                                                \
        if((DBG_INFO) <= DBG_LEVEL) {                                      \
            printf("%s <%d> %s[%d]: ", DBG_INFO_STR, (DBG_INFO), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);												\
        }                                                               \
    } while(0)

#define p_debug(fmt, args...) \
	do {                                                                \
        if((DBG_DEBUG) <= DBG_LEVEL) {                                      \
            printf("%s <%d> %s[%d]: ", DBG_DEBUG_STR, (DBG_DEBUG), __FUNCTION__, __LINE__);   \
            printf(fmt, ##args);                                        \
            fflush(stdout);												\
        }                                                               \
    } while(0)

//! return status when everything went ok
#define OK 0

//! return status when something went wrong
#define ERROR -1
#endif /* DEBUG_H_ */

#ifndef _OT_NNT
#define _OT_NNT

#include <stddef.h>
#include <malloc.h>

typedef char OT_NNT_DATA[];

typedef struct {
    OT_NNT_DATA *pointer;
    size_t length;
} OT_NNT;

#define OT_NNT_FREE(nnt) free(((OT_NNT)nnt).pointer)

#endif

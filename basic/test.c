#include "./algorithm.h"

int main() {
    OT_NNT n0 = {
        .pointer = (OT_NNT_DATA){255, 255}, 
        .length = 2
    };
    OT_NNT n1 = {
        .pointer = (OT_NNT_DATA){0}, 
        .length = 1
    };
    OT_NNT r;

    r = ot_nnt_add(n0, n1);
    OT_NNT_FREE(r);
    
    return 0;
}

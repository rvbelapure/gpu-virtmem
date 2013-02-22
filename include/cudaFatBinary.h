#define __cudaFatVERSION   0x00000004
#define __cudaFatMAGIC     0x1ee55a01
#define __cudaFatMAGIC2    0x466243b1
#define __cudaFatMAGIC3    0xba55ed50

typedef struct __cudaFatCudaBinary2HeaderRec {
    unsigned int            magic;
    unsigned int            version;
    unsigned long long int  length;
} __cudaFatCudaBinary2Header;

enum FatBin2EntryType {
    FATBIN_2_PTX = 0x1
};

typedef struct __cudaFatCudaBinary2EntryRec {
    unsigned int            type;
    unsigned int            binary;
    unsigned int            binarySize;
    unsigned int            unknown2;
    unsigned int            kindOffset;
    unsigned int            unknown3;
    unsigned int            unknown4;
    unsigned int            unknown5;
    unsigned int            name;
    unsigned int            nameSize;
    unsigned long long int  unknown6;
    unsigned long long int  unknown7;
} __cudaFatCudaBinary2Entry;

typedef struct __cudaFatCudaBinaryRec2 {
    int                         magic;
    int                         version;
    unsigned long long *  fatbinData;
    char *                      f;
} __cudaFatCudaBinary2;

#include <iostream>
struct __attribute__((packed)) CacheEntity
{
    // __uint64_t key;//0 , 1
    // union cachevalue{// 2
    //     int intvalue;
    //     float floatvalue;
    // };
    // int hasvalue;// 3
    int storage[4];
};
CacheEntity list[1023];
constexpr unsigned int m1 = 1023, m2 = 1021;
extern "C" CacheEntity* CacheLookUp(int param1, int param2) {
    // __uint64_t key = (static_cast<__uint64_t>(param1) & static_cast<__uint64_t>(param2)) << 32;
    // key |= (static_cast<__uint64_t>(param1) | static_cast<__uint64_t>(param2));

    // [high  ,low      ]
    // [param2,param1   ]
    __uint64_t key;
    *(int*)(&key)=param1;
    *(int*)((void*)&key+4)=param2;

    const auto hash = key % m1, step = 1 + key % m2;
    unsigned int cur = hash;
    constexpr unsigned int max = 5;
    unsigned int count = 0;
    while(true) {
        CacheEntity& entity = list[cur];
        if(entity.storage[3] == 0) {
            *(__uint64_t*)(entity.storage) = key;
            return &entity;
        }
        if(*(__uint64_t*)(entity.storage) == key) {
            return &entity;
        }
        if(++count >= max)
            break;
        cur += step;
        if(cur >= m1)
            cur -= m1;
    }
    CacheEntity& entity = list[hash];
    entity.storage[3] = 0;
    *(__uint64_t*)(entity.storage) = key;
    return &entity;
}


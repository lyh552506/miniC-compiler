#include <stdio.h>
struct __attribute__((packed)) CacheEntity
{
    int storage[6];
    // [0,1,2,3]
    // [4] value
    // [5] hasvalue
};
CacheEntity list[1023];
constexpr auto m1 = 1023, m2 = 1021;
extern "C" CacheEntity* CacheLookUp4(int param1, int param2,int param3,int param4) {
    __uint128_t key;
    *(int*)(&key)=param1;
    *(int*)((void*)&key+4)=param2;
    *(int*)((void*)&key+8)=param3;
    *(int*)((void*)&key+12)=param4;

    const auto hash = key % m1, step = 1 + key % m2;
    auto cur = hash;
    auto max = 5;
    auto count = 0;
    while(true) {
        CacheEntity& entity = list[cur];
        if(entity.storage[5] == 0) {
            *(__uint128_t*)(entity.storage) = key;
            return &entity;
        }
        if(*(__uint128_t*)(entity.storage) == key) {
            return &entity;
        }
        if(++count >= max)
            break;
        cur += step;
        if(cur >= m1)
            cur -= m1;
    }
    CacheEntity& entity = list[hash];
    entity.storage[5] = 0;
    *(__uint128_t*)(entity.storage) = key;
    return &entity;
}


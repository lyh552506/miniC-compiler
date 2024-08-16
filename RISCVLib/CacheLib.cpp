
struct CacheEntity
{
    unsigned long int key;
    int value;
    int hasvalue;
};
CacheEntity list[1023];
constexpr unsigned int m1 = 1023, m2 = 1021;
CacheEntity* CacheLookUp(int param1, int param2) {
    unsigned long int key = (static_cast<unsigned long int>(param1) & static_cast<unsigned long int>(param2)) << 32;
    key |= (static_cast<unsigned long int>(param1) | static_cast<unsigned long int>(param2));
    const auto hash = key % m1, step = 1 + key % m2;
    unsigned int cur = hash;
    constexpr unsigned int max = 5;
    unsigned int count = 0;
    while(true) {
        CacheEntity& entity = list[cur];
        if(entity.hasvalue == 0) {
            entity.key = key;
            return &entity;
        }
        if(entity.key == key) {
            return &entity;
        }
        if(++count >= max)
            break;
        cur += step;
        if(cur >= m1)
            cur -= m1;
    }
    CacheEntity& entity = list[cur];
    entity.hasvalue = 0;
    entity.key = key;
    return &entity;
}


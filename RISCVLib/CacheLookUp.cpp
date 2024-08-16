#define IMPOSSABLIE 4294967295
#define NOVALUE 4294967294
struct CacheEntity
{
    unsigned long int key;
    int value;
    int hasvalue;
};
CacheEntity list[1023];
constexpr unsigned int m1 = 1023, m2 = 1021;
int CacheLookUp(int writevalue, int param1, int param2) {
    unsigned long int key = static_cast<unsigned long int>(param1) << 32 | static_cast<unsigned long int>(param2);
    const auto hash = key % m1, step = 1 + key % m2;
    unsigned int cur = hash;
    constexpr unsigned int max = 5;
    unsigned int count = 0;
    while(true) {
        auto& ref = list[cur];
        if(ref.key == key) {
            if(writevalue == NOVALUE) {
                if(ref.hasvalue == 1) {
                    return ref.value;
                }
                else return IMPOSSABLIE;
            }
            else {
                ref.value = writevalue;
                ref.hasvalue = 1;
                return IMPOSSABLIE;
            }
        }

        if(++count >= max)
            break;
        cur += step;
        if(cur >= m1)
            cur -= m1;
    }
    return IMPOSSABLIE;
}


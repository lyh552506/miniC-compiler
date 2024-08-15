
#define IMPOSSABLIE 4294967295
#define NOVALUE 4294967294

struct CacheEntity
{
    uint64_t key;
    int value;
};
constexpr uint32_t m1 = 1021, m2 = 1019;
int CacheLookUp(int writevalue, int param1, int param2) {
    uint64_t key = static_cast<uint64_t>(param1) << 32 | static_cast<uint64_t>(param2);
    const auto ha = key % m1, hb = 1 + key % m2;
}


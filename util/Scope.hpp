#pragma once
#include <cassert>
#include <vector>
#include "CFG.hpp"
#include "List.hpp"


template <typename Key, typename Val>
class HashVal
{
    Key key;
    Val val;
public:
    const Key& GetKey() const { return key; }
    const Val& GetVal() const { return val; }
    Val& GetVal() { return val; }

};
template <typename Key, typename Val>
class ScopeIterator
{

};

template <typename Key, typename Val>
class HashScope
{
    std::vector<>
};
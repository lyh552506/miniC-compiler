#pragma once
#include <memory>
template<typename T>
class List_node{
    protected:
    std::unique_ptr<List_node> nxt;
    std::unique_ptr<T> data;
    public:
    List_node(unique_ptr<T> __data):{
        data=std::move(__data);
    }
};

/// @brief 只写了尾插和iterator的list
template<typename T>
class List{
    private:
    std::unique_ptr<List_node<T>> head;
    List_node<T>* tail;
    public:
    class iterator{
        private:
        List_node<T> *ptr;
        public:
        iterator(List_node<T>* p):ptr(p){}
        T& operator*(){return *(ptr->data);}
        iterator& operator++(){
            ptr=ptr->nxt.get();
            return *this;
        }
        bool operator!=(const iterator& other){
            return ptr!=other.ptr;
        }
    };
    iterator begin(){return iterator(head.get());}
    iterator end(){return iterator(nullptr);}
    void push_back(unique_ptr<T>& __data){
        if(head==nullptr){
            head.reset(new List_node<T>(__data));
            tail=head.get();
        }
        else{
            tail->nxt.reset(new List_node<T>(__data));
            tail=tail->nxt.get();
        }
    }
};
#pragma once
#include <memory>
/// @brief 一个list_node，要求对象的所有权移交给它，由它来管理
/// @tparam T 
template<typename T>
class List_node{
    using Next=std::shared_ptr<List_node>;
    using DataOwner=std::unique_ptr<T>;
    protected:
    Next nxt;
    DataOwner data;
    public:
    List_node(DataOwner __data):{
        data=std::move(__data);
    }
};

/// @brief 一个简单支持多态的外挂式链表
/// @tparam T 
template<typename T>
class List{
    using ListPtr=std::shared_ptr<List_node<T>>;
    using DataOwner=std::unique_ptr<T>;
    private:
    ListPtr head,tail;
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
    void push_front(std::unique_ptr<T> __data){
        ListPtr tmp=std::make_shared<List_node>(__data);
        tmp->nxt=head;
        head=tmp;
        if(tail==nullptr)tail=head;
    }
    void push_back(std::unique_ptr<T> __data){
        if(head==nullptr){
            head=std::make_shared<List_node>(__data);
            tail=head;
        }
        else{
            tail->nxt=std::make_shared<List_node>(__data);
            tail=tail->nxt;
        }
    }
};
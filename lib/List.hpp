#pragma once
#include <memory>

/// @brief 一个简单支持多态的外挂式链表
/// @tparam T 
template<typename T>
class List{
    /// @brief 一个list_node，要求对象的所有权移交给它，由它来管理
    /// @tparam T 
    class List_node{
        using Next=std::shared_ptr<List_node>;
        using DataOwner=std::unique_ptr<T>;
        public:
        Next nxt;
        DataOwner data;
        List_node(T* __data){
            data.reset(__data);
        }
    };
    using ListPtr=std::shared_ptr<List_node>;
    using DataOwner=std::unique_ptr<T>;
    ListPtr head,tail;
    int siz=0;
    public:
    class iterator{
        private:
        List_node *ptr;
        public:
        iterator(List_node* p):ptr(p){}
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
    void push_front(T* __data){
        ListPtr tmp=std::make_shared<List_node>(__data);
        tmp->nxt=head;
        head=tmp;
        if(tail==nullptr)tail=head;
        siz++;
    }
    void push_back(T* __data){
        if(head==nullptr){
            head=std::make_shared<List_node>(__data);
            tail=head;
        }
        else{
            tail->nxt=std::make_shared<List_node>(__data);
            tail=tail->nxt;
        }
        siz++;
    }
    int size(){return siz;}
    List(const List& other)=delete;
    List(List&& other)noexcept:head(std::move(other.head),tail(std::move(other.tail))){}
    List()=default;
};
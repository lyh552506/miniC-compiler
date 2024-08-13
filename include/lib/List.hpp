#pragma once
#include <list>
#include <memory>
#include <vector>
#include <algorithm>
#include <cassert>
/// @brief 设计的先发劣势，要写什么自己加，最简单的一集
/// @tparam T 
template<typename T>
class List:public std::list<std::unique_ptr<T>>
{
    using Father=std::list<std::unique_ptr<T>>;
    using DataType=std::unique_ptr<T>;
    public:
    void push_front(T* data){
        Father::push_front(DataType(data));
    }
    void push_back(T* data){
        Father::push_back(DataType(data));
    }
};

template<typename derived_mylist,typename derived_list_node>
class list_node;
template<typename derived_mylist,typename derived_list_node>
class mylist;

template<typename derived_mylist,typename derived_list_node>
class list_node
{
    friend class mylist<derived_mylist,derived_list_node>;
    
    derived_list_node* prev;
    derived_list_node* next;
    derived_mylist* fat=nullptr;
    public:
    void SetParent(derived_mylist* _fat){fat=_fat;}
    virtual ~list_node(){
        if(fat!=nullptr)EraseFromParent();
    }
    list_node(){
        this->prev=nullptr;
        this->next=nullptr;
    }
    virtual void EraseFromParent(){
        if(this->prev==nullptr)fat->head=this->next;
        if(this->next==nullptr)fat->tail=this->prev;
        if(this->prev!=nullptr)this->prev->next=this->next;
        if(this->next!=nullptr)this->next->prev=this->prev;
        fat->size--;
        fat=nullptr;
        this->prev=nullptr;
        this->next=nullptr;
    }
    virtual derived_mylist* GetParent(){return this->fat;};

    virtual void replace_list_node_with(derived_list_node* other){
        if(this->prev==nullptr)fat->head=other;
        if(this->next==nullptr)fat->tail=other;
        if(this->prev!=nullptr)this->prev->next=other;
        if(this->next!=nullptr)this->next->prev=other;
        other->prev=this->prev;
        other->next=this->next;
        other->fat=this->fat;
        this->prev=nullptr;
        this->next=nullptr;
        this->fat=nullptr;
    }

    derived_list_node* nextListNode(){
        return next;
    }

    derived_list_node* prevListNode(){
        return prev;
    }
};

template<typename derived_mylist,typename derived_list_node>
class mylist
{
    friend class list_node<derived_mylist,derived_list_node>;
    derived_list_node* head;
    derived_list_node* tail;
    int size=0;
    public:
    virtual ~mylist(){
        clear();
    }
    class iterator
    {
        using iterator_category = std::bidirectional_iterator_tag;
        using value_type = derived_list_node*;
        using difference_type = std::ptrdiff_t;
        using pointer = derived_list_node**;
        using reference = derived_list_node*&;
        derived_list_node* ptr;
        public:
        iterator():ptr(nullptr){}
        iterator(derived_list_node* _ptr):ptr(_ptr){}
        iterator& operator++(){
            ptr=ptr->next;
            return *this;
        }
        iterator& operator--(){
            ptr=ptr->prev;
            return *this;
        }
        value_type operator*(){return ptr;}
        iterator insert_before(derived_list_node* data){
            assert(ptr!=nullptr&&ptr->fat!=nullptr&&data!=nullptr&&"Invalid Iterator");
            if(ptr==ptr->fat->head)
                ptr->fat->push_front(data);
            else{
                data->SetParent(ptr->fat);
                data->prev=ptr->prev;
                data->next=ptr;
                ptr->prev=data;
                data->prev->next=data;
                ptr->fat->size++;
            }
            return iterator(data);
        }
        iterator insert_after(derived_list_node* data){
            assert(ptr!=nullptr&&ptr->fat!=nullptr&&data!=nullptr&&"Invalid Iterator");
            if(ptr==ptr->fat->tail)
                ptr->fat->push_back(data);
            else{
                data->SetParent(ptr->fat);
                data->next=ptr->next;
                data->prev=ptr;
                ptr->next=data;
                data->next->prev=data;
                ptr->fat->size++;
            }
            return iterator(data);
        }

        bool operator==(const iterator& other)const{return ptr==other.ptr;}
        bool operator!=(const iterator& other)const{return ptr!=other.ptr;}
    };
    mylist(){
        this->head=nullptr;
        this->tail=nullptr;
    }
    virtual iterator begin(){return iterator(this->head);}
    virtual iterator end(){return iterator(nullptr);}
    virtual iterator rbegin(){return iterator(this->tail);}
    virtual iterator rend(){return iterator(nullptr);}
    void collect(derived_list_node* _begin,derived_list_node* _end){
        assert(this->head==nullptr&&this->tail==nullptr&&"Used to Separte List");
        this->head=_begin;
        this->tail=_end;
        size=0;
        for(auto poi=head;poi!=nullptr;poi=poi->next){
            poi->SetParent(dynamic_cast<derived_mylist*>(this));
            size++;
        }
    }

    std::pair<derived_list_node*,derived_list_node*> split(derived_list_node* _begin,derived_list_node* _end){
        assert(_begin!=nullptr&&_end!=nullptr&&"Invalid Split");
        assert(_begin->fat==dynamic_cast<derived_mylist*>(this)&&_end->fat==dynamic_cast<derived_mylist*>(this)&&"Invalid Split");
        if(_begin==this->head)this->head=_end->next;
        if(_end==this->tail)this->tail=_begin->prev;
        if(_begin->prev!=nullptr)_begin->prev->next=_end->next;
        if(_end->next!=nullptr)_end->next->prev=_begin->prev;
        _begin->prev=nullptr;
        _end->next=nullptr;

        size=0;
        for(auto poi=head;poi!=nullptr;poi=poi->next){
            size++;
        }

        return std::make_pair(_begin,_end);
    }
    int Size(){
        return size;
    }
    // 以后再说
    // void merge(derived_mylist*& other){
    //     other=nullptr;
    // }

    void push_back(derived_list_node* data){
        data->SetParent(dynamic_cast<derived_mylist*>(this));
        if(this->head==nullptr){
            this->head=data;
            this->tail=data;
        }
        else{
            this->tail->next=data;
            data->prev=this->tail;
            this->tail=data;
        }
        size++;
    }
    void push_front(derived_list_node* data){
        data->SetParent(dynamic_cast<derived_mylist*>(this));
        if(this->head==nullptr){
            this->head=data;
            this->tail=data;
        }
        else{
            this->head->prev=data;
            data->next=this->head;
            this->head=data;
        }
        size++;
    }

    void swap_region(derived_list_node* begin, derived_list_node* end, std::list<derived_list_node*>& sequence) {
        assert(!sequence.empty()&&"sequence can't be empty");
        
        auto prev=begin->prev;
        auto next=end;
        // auto next=end->next;
        
        if(prev==nullptr)
            head=sequence.front();

        // if(next!=nullptr)
        //     next=sequence.back();

        for(auto ele:sequence)
            assert(ele->GetParent()==this&&"All elements inside the sequence must be in this list");

        for(auto ele:sequence){
            ele->prev=prev;
            if(prev!=nullptr)
                prev->next=ele;
            prev=ele;
        }
        
        sequence.back()->next=next;
        if(next!=nullptr)
            next->prev=sequence.back();
    }

    virtual void clear(){
        while(this->head!=nullptr){
            delete head;
        }
    }
    derived_list_node* front(){return this->head;}
    derived_list_node* back(){return this->tail;}
};
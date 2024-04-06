#pragma once
#include <list>
#include <memory>
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
    derived_mylist* fat;

    void SetParent(derived_mylist* _fat){fat=_fat;}
    public:
    list_node(){
        this->prev=nullptr;
        this->next=nullptr;
    };
    virtual void EraseFromParent(){
        if(fat->head==dynamic_cast<derived_list_node*>(this))fat->head=this->next;
        if(fat->tail==dynamic_cast<derived_list_node*>(this))fat->tail=this->prev;
        if(this->prev!=nullptr)this->prev->next=this->next;
        if(this->next!=nullptr)this->next->prev=this->prev;
    }
    virtual derived_mylist* GetParent(){return this->fat;};
    derived_mylist* Del_Pre(){};
    derived_mylist* Del_Succ(){};
    derived_mylist* Link_Pre(derived_list_node* ptr){};
    derived_mylist* Link_Succ(derived_list_node* ptr){};
};

template<typename derived_mylist,typename derived_list_node>
class mylist
{
    friend class list_node<derived_mylist,derived_list_node>;
    derived_list_node* head;
    derived_list_node* tail;
    public:
    class iterator
    {
        derived_list_node* ptr;
        public:
        iterator(derived_list_node* _ptr):ptr(_ptr){}
        iterator& operator++(){
            ptr=ptr->next;
            return *this;
        }
        iterator& operator--(){
            ptr=ptr->prev;
            return *this;
        }
        derived_list_node* operator*(){return ptr;}
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
            }
            return iterator(data);
        }
        bool operator==(const iterator& other){return ptr==other.ptr;}
        bool operator!=(const iterator& other){return ptr!=other.ptr;}
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
        for(auto poi=head;poi!=nullptr;poi=poi->next)poi->SetParent(dynamic_cast<derived_mylist*>(this));
    }

    std::pair<derived_list_node*,derived_list_node*> split(derived_list_node* _begin,derived_list_node* _end){
        assert(_begin!=nullptr&&_end!=nullptr&&"Invalid Split");
        assert(_begin->fat==this&&_end->fat==this&&"Invalid Split");
        if(_begin==this->head)this->head=_end->next;
        if(_end==this->tail)this->tail=_begin->prev;
        if(_begin->prev!=nullptr)_begin->prev->next=_end->next;
        if(_end->next!=nullptr)_end->next->prev=_begin->prev;
        _begin->prev=nullptr;
        _end->next=nullptr;
        return std::make_pair(_begin,_end);
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
    }
    derived_list_node* front(){return this->head;}
    derived_list_node* back(){return this->tail;}
};
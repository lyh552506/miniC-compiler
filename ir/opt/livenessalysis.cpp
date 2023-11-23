// #ifndef _Intrusive_List_H_
// #define _Intrusive_List_H_
#include"livenessalysis.hpp"



// // 侵入式链表
// template<class T>
// class intrusive_list {
// public:
//     struct Node;
//     // 迭代器
//     class iterator {
//     public:
//         iterator(Node* node) : m_node(node) {}

//         iterator& operator ++() {
//             if (m_node)
//                 m_node = m_node->m_next;
//             return *this;
//         }
//         iterator& operator --() {
//             if (m_node)
//                 m_node = m_node->m_prev;
//             return *this;
//         }

//         bool operator == (const iterator& iter) { return m_node == iter.m_node; }
//         bool operator != (const iterator& iter) { return !operator ==(iter); }

//         T& operator *() { return *m_node; }
//         T* operator ->() { return m_node; }

//     private:
//         Node* m_node;
//     };

//     intrusive_list() : m_head(nullptr), m_tail(nullptr) {}

//     ~intrusive_list() {
//         Node* node = m_head;
//         while (node) {
//             Node* next = node->m_next;
//             delete node;
//             node = next;
//         }
//     }

//     // 添加对象
//     template<class... Args>
//     T* add(Args... args) {
//         Node* node = new Node(args...);

//         if (m_head && m_tail) {
//             node->m_prev = m_tail;
//             m_tail->m_next = node;
//             m_tail = node;
//         }
//         else {
//             m_head = node;
//             m_tail = node;
//         }
//         return node;
//     }

//     // 移除对象
//     void remove(T* ptr) {
//         Node* node = (Node*)ptr;
//         assert(node->m_valid);
//         if (m_head == node) {
//             m_head = m_head->m_next;
//         }
//         if (m_tail == node) {
//             m_tail = m_tail->m_prev;
//         }
//         if (node->m_prev)
//             node->m_prev->m_next = node->m_next;
//         if (node->m_next)
//             node->m_next->m_prev = node->m_prev;
//         delete node;
//     }

//     iterator begin() { return iterator(m_head); }
//     iterator end() { return iterator(nullptr); }

// private:
//     struct Node : public T {
//         template<class... Args>
//         Node(Args... args) : T(args...), m_valid(true), m_prev(nullptr), m_next(nullptr) {}

//         bool m_valid;
//         Node* m_prev;
//         Node* m_next;
//     };

//     Node* m_head;
//     Node* m_tail;
// };

// #endif
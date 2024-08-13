#include <pthread.h>
#include <atomic>
#include <iostream>
#include <stdio.h>
#include <cmath>
#include "parallel_lib.hpp"

#define NumThreads 4

class Spinlock{
    std::atomic_flag _lock = ATOMIC_FLAG_INIT;
    public:
    void lock(){
        while(atomic_flag_test_and_set(&_lock)){}
    }
    void unlock(){
        atomic_flag_clear(&_lock);
    }
};

unsigned char buildin_parallel_arg_storage[512];
void (*buildin_funcptr)(void);

static Spinlock empty;
static Spinlock full;

static std::atomic_int32_t tasks;
static std::atomic_int32_t task_done;

// tell the main thread that the buffer is empty again
void buildin_FenceArgLoaded(){
    empty.unlock();
}

void WaitTasksCompleted(){
    while(task_done.load() != tasks.load()){}
}

void WaitBufferRead(){
    // wait the buffer to be full
    full.lock();
    // inside the function, the FenceArgLoaded will be called
    buildin_funcptr();
    // printf("task %d done\n",task_done.load());
    // fflush(stdout);
    task_done++;
}

void WaitBufferWrite(){
    // wait the buffer to be empty
    empty.lock();
}

void buildin_NotifyWorker(int begin,int end){
    // tell the worker that the buffer is full
    int64_t _begin=begin;
    int64_t _end=end;
    int64_t step=(_end-_begin)/4;
    
    for(_begin;_begin<_end;_begin+=step){
        int64_t limi=std::min(_begin+step,_end);
        int st=_begin,ed=limi;
        WaitBufferWrite();
        *(int*)(buildin_parallel_arg_storage)=st;
        *(int*)(buildin_parallel_arg_storage+4)=ed;
        tasks++;
        full.unlock();
    }
    
    WaitTasksCompleted();
}

void* WorkerThread(void *arg){
    // std::cerr<<"work thread created\n";
    printf("work thread created\n");
    fflush(stdout);
    while(true)
        WaitBufferRead();
}

// [[constructor]]
void CreateThread() {
    // create four threads using pthread_create, and detach them
    full.lock();
    pthread_t threads[NumThreads];
    for (int i = 0; i < NumThreads; i++) {
        pthread_create(&threads[i], NULL, WorkerThread, NULL);
        pthread_detach(threads[i]);
        // pthread_setaffinity_np
    }
}

/*
parallel_call translation: [done]
    parallel_call func, arg0, arg1, ...
    ->
    store all of them, except %begin and %end in the buffer
    mv a0 <- %begin
    mv a1 <- %end
    call Notify Worker

func translation: [done]
    1. translate it to a void(void)
    DURING FUNC LOWERING
    2. all arguments load from the buffer
    3. call FenceArgLoaded
    DURING FUNC LOWERING
    4. excute the function

IR:
    parallel_call func l r ...

USED_OUTSIDE TAGS:
    buildin_parallel_arg_storage
    func
    FenceArgLoaded
    Notify Worker
*/
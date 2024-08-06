#include <pthread.h>
#include <atomic>
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

unsigned char parallel_arg_storage[512];
void (*func)(void);
Spinlock empty;
Spinlock full;

std::atomic_int32_t tasks;
std::atomic_int32_t task_done;

// tell the main thread that the buffer is empty again
[[always_inline]]
void FenceArgLoaded(){
    empty.unlock();
}

[[always_inline]]
void WaitTasksCompleted(){
    while(task_done.load() != tasks.load()){}
}

[[always_inline]]
void WaitBufferRead(){
    // wait the buffer to be full
    full.lock();
    // inside the function, the FenceArgLoaded will be called
    func();
    task_done++;
}

[[always_inline]]
void WaitBufferWrite(){
    // wait the buffer to be empty
    empty.lock();
}

[[always_inline]]
void NotifyWorker(){
    // tell the worker that the buffer is full
    tasks++;
    full.unlock();    
}

void* WorkerThread(void *arg){
    while(true)
        WaitBufferRead();
}

[[constructor]]
void CreateThread() {
    // create four threads using pthread_create, and detach them
    full.lock();
    pthread_t threads[NumThreads];
    for (int i = 0; i < NumThreads; i++) {
        pthread_create(&threads[i], NULL, WorkerThread, NULL);
        pthread_detach(threads[i]);
    }
}

/*
parallel_call translation:

    parallel_call func, arg0, arg1, ...
    ->
    call WaitBufferWrite
    store all of them in the buffer
    call TellWorker

func translation:

    1. translate it to a void(void)
    DURING FUNC LOWERING
    2. all arguments load from the buffer
    3. call FenceArgLoaded
    DURING FUNC LOWERING
    4. excute the function

IR:
    PIECE THE LOOP AREAS
    parallel_call func 1 2 3 4
    parallel_call func 2 3 4 5
    parallel_call func 4 5 6 7
    parallel_call func 5 6 7 8
    call WaitTasksCompleted

Usage Case:
    1. Parallel Loops
    2. Functions With Heavy workloads but return value used very much latter
*/
void CreateThread()__attribute__((constructor)); 

static void WaitBufferWrite()__attribute((always_inline));

static void WaitBufferRead()__attribute((always_inline));

static void WaitTasksCompleted()__attribute((always_inline));

extern "C"{

void buildin_NotifyWorker(int,int)__attribute((always_inline));

void buildin_FenceArgLoaded()__attribute((always_inline));

}
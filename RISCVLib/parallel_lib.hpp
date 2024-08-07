void CreateThread()__attribute__((constructor)); 

void NotifyWorker()__attribute((always_inline));

static void WaitBufferWrite()__attribute((always_inline));

static void WaitBufferRead()__attribute((always_inline));

static void WaitTasksCompleted()__attribute((always_inline));

void FenceArgLoaded()__attribute((always_inline));

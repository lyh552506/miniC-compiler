void CreateThread()__attribute__((constructor)); 

void NotifyWorker()__attribute((always_inline));

void WaitBufferWrite()__attribute((always_inline));

void WaitBufferRead()__attribute((always_inline));

void WaitTasksCompleted()__attribute((always_inline));

void FenceArgLoaded()__attribute((always_inline));

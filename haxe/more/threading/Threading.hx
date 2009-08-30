package haxe.more.threading;

/**
 * @param #Int The time the thread is allowed to run.
 * @return Returns true if the thread has finished his job and wants to be unscheduled.
 */
typedef ThreadRunnerDelegate = Int -> Bool;
typedef AdjustThreadShareDelegate = ThreadRunnerDelegate -> Int -> Bool;
typedef AddThreadDelegate = ThreadRunnerDelegate -> Int -> AdjustThreadShareDelegate;
typedef RemoveThreadDelegate = ThreadRunnerDelegate -> Bool;

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// This is class that describes you smart contract.
contract ToDoList {
    //Create structure of single task
    struct Task {
        string taskName;        
        uint32 taskAddedTime;
        bool taskCheckBox;
    }
    //Create key, which will be incremented after every task added
    int8 public lastKey = 0;
    //Array of keys, shows that this task exist (not deleted)
    bool[] public keys;
    //Create list of tasks
    mapping(int8 => Task) public myToDoList;
    //Create number of uncompleted tasks
    int8 public numOpenedTasks = 0;


    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    //Add task to list
    function addTask(string _TaskName) public checkOwnerAndAccept {
         myToDoList[lastKey] = Task(_TaskName, now, false);
         lastKey++;
         keys.push(true);
         numOpenedTasks++;

    }

    //Get number of unfinished tasks
    function getNumOpenedTasks() public view checkOwnerAndAccept returns(int8) {
        return numOpenedTasks;
    }

    //Delete task by key from to do list
    function deleteTask(int8 _taskKey) public checkOwnerAndAccept {
        //uint _taskKey = uint(taskKey);
        require( keys[uint(_taskKey)] == true , 101, "Error: Already deleted");
        require( _taskKey <= lastKey, 101, "Error: Task not created yet");
        if (myToDoList[_taskKey].taskCheckBox == false) {
            numOpenedTasks--;
        }
        keys[uint(_taskKey)] = false;
        delete myToDoList[_taskKey];
    }

    //Get tasks from list
    function getTasks() public view checkOwnerAndAccept returns(string[]) {
        string[] tasksArray;
        for (uint i = 0; i < keys.length; i++) {
            if (keys[i] == true) {
                tasksArray.push(myToDoList[int8(i)].taskName);
            }
        }
        return tasksArray;
    }

    //Get task description by key
    function getTaskDescription(int8 _taskKey) public view checkOwnerAndAccept returns(string, uint32, bool) {
        require(keys[uint(_taskKey)] == true, 101, "Error: Task doesn't exist");
        return (myToDoList[_taskKey].taskName, myToDoList[_taskKey].taskAddedTime, myToDoList[_taskKey].taskCheckBox);
    }

    //Check task as finished by key
    function finishTask(int8 _taskKey) public checkOwnerAndAccept {
        require(keys[uint(_taskKey)] == true, 101, "Error: Task doesn't exist");
        require(myToDoList[_taskKey].taskCheckBox == false, 101, "Error: Task already finished");
        myToDoList[_taskKey].taskCheckBox == true;
        numOpenedTasks--;
    }

    
}    
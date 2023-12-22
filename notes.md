# :h stdpath

stdpath({what})                                                *stdpath()* *E6100*
		Returns |standard-path| locations of various default files and
		directories.

		{what}       Type    Description  
		cache        String  Cache directory: arbitrary temporary
		                     storage for plugins, etc.
		config       String  User configuration directory. |init.vim|
		                     is stored here.
		config_dirs  List    Other configuration directories.
		data         String  User data directory.
		data_dirs    List    Other data directories.
		log          String  Logs directory (for use by plugins too).
		run          String  Run directory: temporary, local storage
				     for sockets, named pipes, etc.
		state        String  Session state directory: storage for file
				     drafts, swap, undo, |shada|.

		Example: >vim
			echo stdpath("config")

# :h opt

